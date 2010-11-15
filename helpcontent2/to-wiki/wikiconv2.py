#!/usr/bin/env python

import sys, signal
import xml.parsers.expat

root="source/"

titles = []

# list of elements that we can directly convert to wiki text
replace_element = \
    {'start':{'emph': "'''",
              'comment': "<!-- "
             },
     'end':  {'emph': "'''",
              'comment': " -->"
             }
    }

replace_paragraph_role = \
    {'start':{'code': '<code>',
              'codeintip': '<code>',
              'example': '<code>',
              'heading1': '= ',
              'heading2': '== ',
              'heading3': '=== ',
              'heading4': '==== ',
              'heading5': '===== ',
              'heading6': '====== ',
              'head1': '= ', # used only in one file, probably in error?
              'head2': '== ', # used only in one file, probably in error?
              'listitem': '',
              'note': '{{Note|',
              'paragraph': '',
              'related': '', # used only in one file, probably in error?
              'relatedtopics': '', # used only in one file, probably in error?
              'tablecontent': '| ',
              'tablehead': '! scope="col" | ',
              'variable': '',
              'tip': '{{Tip|',
              'warning': '{{Warning|',
             },
     'end':{'code': '</code>\n\n',
            'codeintip': '</code>\n\n',
            'example': '</code>\n\n',
            'heading1': ' =\n\n',
            'heading2': ' ==\n\n',
            'heading3': ' ===\n\n',
            'heading4': ' ====\n\n',
            'heading5': ' =====\n\n',
            'heading6': ' ======\n\n',
            'head1': ' =\n\n', # used only in one file, probably in error?
            'head2': ' ==\n\n', # used only in one file, probably in error?
            'listitem': '\n',
            'note': '}}\n\n',
            'paragraph': '\n\n',
            'related': '\n\n', # used only in one file, probably in error?
            'relatedtopics': '\n\n', # used only in one file, probably in error?
            'tablecontent': '\n\n',
            'tablehead': '\n\n',
            'variable': '',
            'tip': '}}\n\n',
            'warning': '}}\n\n',
           }
    }

# text snippets that we need to convert
replace_text_list = \
    [["$[officename]", "{{ProductName}}"],
     ["%PRODUCTNAME", "{{ProductName}}"]
    ]

help_id_patterns = [
        "HID",
        "SID",
        "FID",
        "RID",
        "TP_",
        "MD_",
        "FN_",
        "DLG_",
        "SW_",
        "UID",
        "basctl_",
        "basic_",
        "chart2_",
        "dbaccess_",
        "extensions_",
        "filter_",
        "formula_",
        "fpicker_",
        "framework_",
        "goodies_"
        ]

help_file_name = ""

all_help_id_mappings = [[]]

def load_all_help_ids():
    file = open("helpers/help_hid.lst")
    for line in file:
        ids = line.strip().upper().split(",")
        if len(ids) >= 2:
            all_help_id_mappings.append(ids)

def get_help_id_res2(name):
    file = open("helpers/hid.lst")
    for line in file:
        ids = line.strip().upper().split(" ")
        if len(ids) >= 2:
            if ids[0] == name:
                return ids[1]
    # if none found
    return "0"

def get_help_id(name):
    name = name.strip().replace("cui_","svx_").upper()
    for i in all_help_id_mappings:
        if len(i) >= 2 and i[0].strip() == name:
            return i[1].strip()
    return get_help_id_res2(name)

def get_link_filename(link, name):
    text = link
    if link.find("http") >= 0:
        text = name
    for title in titles:
        try:
            if title[0].find(text) >= 0:
                return title[1].strip()
        except:
            pass
    return link

def get_link_name(link):
    for title in titles:
        if title[0].find(link) >= 0:
            return title[2].strip()
    return link

def replace_text(text):
    for i in replace_text_list:
        if text.find(i[0]) >= 0:
            text = text.replace(i[0],i[1])
    return text

# Base class for all the elements
#
# self.name - name of the element, to drop the self.child_parsing flag
# self.objects - collects the child objects that are constructed during
#                parsing of the child elements
# self.child_parsing - flag whether we are parsing a child, or the object
#                      itself
# self.parent - parent object
class ElementBase:
    def __init__(self, name, parent):
        self.name = name
        self.objects = []
        self.child_parsing = False
        self.parent = parent

    def start_element(self, name, attrs):
        pass

    def end_element(self, name):
        if name == self.name:
            self.parent.child_parsing = False

    def char_data(self, data):
        pass

    def get_curobj(self):
        if self.child_parsing:
            return self.objects[len(self.objects)-1].get_curobj()
        return self

    # start parsing a child element
    def parse_child(self, child):
        self.child_parsing = True
        self.objects.append(child)

    # construct the wiki representation of this object, including the objects
    # held in self.objects (here only the text of the objects)
    def get_all(self):
        text = ''
        for i in self.objects:
            text = text + i.get_all()
        return text

    # for handling variables, and embedding in general
    # id - the variable name we want to get
    def get_variable(self, id):
        for i in self.objects:
            if i != None:
                var = i.get_variable(id)
                if var != None:
                    return var
        return None

class XhpFile(ElementBase):
    def __init__(self, follow_embed):
        ElementBase.__init__(self, None, None)
        self.follow_embed = follow_embed

        self.depth=1

    def start_element(self, name, attrs):
        # TODO: Take care of nested sections
        if name == 'section':
            if attrs['id'] == "relatedtopics":
                self.objects.append(Text("{{RelatedTopics}}\n"))
        elif name == 'paragraph':
            para = Paragraph(attrs, self, self.depth)
            self.depth = para.depth
            self.parse_child(para)
        elif name == 'table':
            self.parse_child(Table(attrs, self))
        elif name == 'list':
            self.parse_child(List(attrs, self))
        elif name == 'bookmark':
            self.parse_child(Bookmark(attrs, self))
        if name == 'embed' and self.follow_embed:
            link = attrs['href'].replace('"', '')
            fname = link
            id = ''
            if link.find("#") >= 0:
                fname = link[:link.find("#")]
                id = link[link.find("#")+1:]
            else:
                sys.stderr.write('Reference without a "#" in "%s".'% link)

            # parse another xhp
            global head_obj
            save_head_obj = head_obj
            head_obj = XhpFile(False)
            parsexhp('source/' + fname)
            parsed = head_obj
            head_obj = save_head_obj

            var = parsed.get_variable(id)
            if var != None:
                self.objects.append(var)
            else:
                sys.stderr.write('Cannot find reference "#%s" in "%s".\n'% \
                        (id, fname))

class Bookmark(ElementBase):
    bookmarks_list   = []
    current_bookmark = ""

    def __init__(self, attrs, parent):
        ElementBase.__init__(self, 'bookmark', parent)
        self.bookmark = ""
        text = attrs['branch'].encode('ascii','replace')
        # text = text.upper()
        for i in help_id_patterns:
            if text.find(i) >= 0:
               self.bookmark = text[text.rfind("/")+1:].replace(":","_")
               break

    def get_all(self):
        Bookmark.current_bookmark = self.bookmark
        return ""

    @staticmethod
    def set_heading(data):
        global help_file_name
        if len(Bookmark.current_bookmark) > 0:
            if data.find("]]") >= 0:
                try:
                    data = data[data.find("|")+1:data.find("]]")]
                except:
                    pass
            help_id = get_help_id(Bookmark.current_bookmark)
            bookmark = "    { "+help_id+", \""+help_file_name+"#"+data.replace("\"","\\\"")+"\" },"
            bookmark = bookmark.encode('ascii','replace')
            Bookmark.bookmarks_list.append(bookmark)
            Bookmark.current_bookmark = ""

    @staticmethod
    def save_bookmarks():
        file = open("bookmarks.h","a")
        for i in Bookmark.bookmarks_list:
            file.write(i.encode('ascii','replace')+"\n")
        file.close()

class Image(ElementBase):
    def __init__(self, attrs, parent):
        ElementBase.__init__(self, 'image', parent)
        self.src     = attrs['src']
        try:
            self.width   = attrs['width']
            self.height  = attrs['height']
        except:
            self.width = self.height = ""
        self.align   = 'left'
        self.alt     = False
        self.alttext = ""

    def start_element(self, name, attrs):
        if name == 'alt':
            self.alt = True

    def end_element(self, name):
        ElementBase.end_element(self, name)

        if name == 'alt':
            self.alt = False

    def char_data(self, data):
        if self.alt:
            self.alttext = self.alttext + data

    def get_all(self):
        wikitext = "[[Image:"+self.src+"|border|"+self.align+"|"
        if len(self.width):
            wikitext = wikitext + self.width+"x"+self.height+"|"
        wikitext = wikitext + self.alttext+"]]"
        return wikitext

    def get_curobj(self):
        return self

class Text:
    def __init__(self, text):
        self.wikitext = replace_text(text)

    def get_all(self):
        return self.wikitext

    def get_variable(self, id):
        return None

class TableCell(ElementBase):
    def __init__(self, attrs, parent):
        ElementBase.__init__(self, 'tablecell', parent)

    def start_element(self, name, attrs):
        if name == 'paragraph':
            self.parse_child(Paragraph(attrs, self, 0))

class TableRow(ElementBase):
    def __init__(self, attrs, parent):
        ElementBase.__init__(self, 'tablerow', parent)

    def start_element(self, name, attrs):
        if name == 'tablecell':
            self.parse_child(TableCell(attrs, self))

    def get_all(self):
        text = '|-\n' + ElementBase.get_all(self)
        return text

class Table(ElementBase):
    def __init__(self, attrs, parent):
        ElementBase.__init__(self, 'table', parent)

    def start_element(self, name, attrs):
        if name == 'tablerow':
            self.parse_child(TableRow(attrs, self))

    def get_all(self):
        # + ' align="left"' etc.?
        text = '{| border="1"\n' + \
            ElementBase.get_all(self) + \
            '|}\n\n'
        return text

class ListItem(ElementBase):
    def __init__(self, attrs, parent):
        ElementBase.__init__(self, 'listitem', parent)

    def start_element(self, name, attrs):
        if name == 'paragraph':
            self.parse_child(Paragraph(attrs, self, 0))

    def get_all(self):
        text = ""
        prefix = '*'
        postfix = ''
        if self.parent.startwith > 0:
            prefix = '<li>'
            postfix = '</li>'
        elif self.parent.type == 'ordered':
            prefix = '#'

        # add the text itself
        for i in self.objects:
            text = text + prefix + ElementBase.get_all(self)

        return text

class List(ElementBase):
    def __init__(self, attrs, parent):
        ElementBase.__init__(self, 'list', parent)

        self.type = attrs['type']
        try:
            self.startwith = int(attrs['startwith'])
        except:
            self.startwith = 0

    def start_element(self, name, attrs):
        if name == 'listitem':
            self.parse_child(ListItem(attrs, self))

    def get_all(self):
        text = ""
        if self.startwith > 0:
            text = text + '<ol start="%d">\n'% self.startwith

        text = text + ElementBase.get_all(self)

        if self.startwith > 0:
            text = text + '</ol>\n'
        else:
            text = text + '\n'
        return text

class Link(ElementBase):
    def __init__(self, attrs, parent):
        ElementBase.__init__(self, 'link', parent)

        self.link = attrs['href']
        try:
            self.lname = attrs['name']
        except:
            self.lname = self.link[self.link.rfind("/")+1:]
        # Override lname
        self.default_name = self.lname
        self.lname = get_link_filename(self.link, self.lname)
        self.wikitext = ""

    def char_data(self, data):
        self.wikitext = self.wikitext + data

    def get_all(self):
        if self.wikitext == "":
            self.wikitext = self.default_name

        self.wikitext = replace_text(self.wikitext)
        if self.link.find("http") >= 0:
            text = "["+self.link+" "+self.wikitext+"]"
        else:
            text = "[["+self.lname+"|"+self.wikitext+"]]"
        return text

class Paragraph(ElementBase):
    def __init__(self, attrs, parent, depth):
        ElementBase.__init__(self, 'paragraph', parent)

        try:
            self.role = attrs['role']
        except:
            self.role = 'paragraph'

        try:
            self.level=int(attrs['level'])
        except:
            self.level=0
        if depth > self.level:
            self.depth = depth
        else:
            self.depth = self.level
        self.is_first = (len(self.parent.objects) == 0)

    def start_element(self, name, attrs):
        if name == 'variable':
            self.parse_child(Variable(attrs, self, self.depth))
        elif name == 'image':
            self.parse_child(Image(attrs, self))
        elif name == 'link':
            self.parse_child(Link(attrs, self))
        elif name == 'bookmark':
            # This shouldn't occur
            print "Warning: Unhandled bookmark content!!!"

        try:
            global replace_element
            self.objects.append(Text(replace_element['start'][name]))
        except:
            pass

    def end_element(self, name):
        ElementBase.end_element(self, name)

        try:
            global replace_element
            self.objects.append(Text(replace_element['end'][name]))
        except:
            pass

    def char_data(self, data):
        self.objects.append(Text(data))

    def get_all(self):
        role = self.role
        if role == 'heading':
            if self.depth < 6:
                role = 'heading%d'% self.depth
            else:
                role = 'heading6'
        if ( role == 'tablecontent' or role == 'tablehead' ) and not self.is_first:
            role = 'paragraph'

        # prepend the markup according to the role
        text = ''
        if len(self.objects) > 0:
            try:
                text = text + replace_paragraph_role['start'][role]
            except:
                sys.stderr.write( "Unknown paragraph role start: " + role + "\n" )

        # the text itself
        text = text + ElementBase.get_all(self)

        # set bookmark info
        if self.role == "heading":
            Bookmark.set_heading(text)

        # append the markup according to the role
        if len(self.objects) > 0:
            try:
                text = text + replace_paragraph_role['end'][role]
            except:
                sys.stderr.write( "Unknown paragraph role end: " + role + "\n" )

        return text

class Variable(Paragraph):
    def __init__(self, attrs, parent, depth):
        Paragraph.__init__(self, attrs, parent, depth)
        self.name = 'variable'
        self.role = 'variable'
        self.id = attrs['id']

    def get_variable(self, id):
        if id == self.id:
            return self
        return None

head_obj = XhpFile(True)

def start_element(name, attrs):
    head_obj.get_curobj().start_element(name,attrs)

def end_element(name):
    head_obj.get_curobj().end_element(name)

def char_data(data):
    head_obj.get_curobj().char_data(data)

def parsexhp(filename):
    #sys.stderr.write('Parsing: %s\n'% filename)
    file=open(filename,"r")
    p = xml.parsers.expat.ParserCreate()
    p.StartElementHandler = start_element
    p.EndElementHandler = end_element
    p.CharacterDataHandler = char_data
    buf = file.read()
    p.Parse(buf)
    file.close()

def loadallfiles(filename):
    global titles
    file = open(filename, "r")
    for line in file:
        title = line.split(";", 2)
        titles.append(title)

def signal_handler(signal, frame):
    sys.stderr.write( "Exiting..." )
    sys.exit(1)
signal.signal(signal.SIGINT, signal_handler)

if len(sys.argv) < 2:
    print "wikiconv2.py <inputfile.xph>"
    sys.exit(1)

if len(sys.argv) > 2:
    help_file_name = sys.argv[2]

# TODO: Currently the following files are loaded for every
# file which is converted. Combine the batch converter with
# this file to generate quicker help files.
load_all_help_ids()
loadallfiles("alltitles.csv")
parsexhp(sys.argv[1])
print head_obj.get_all().encode('ascii','replace')
Bookmark.save_bookmarks()
