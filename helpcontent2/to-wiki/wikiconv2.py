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
              'null': '', # special paragraph for Variable, CaseInline, etc.
              'paragraph': '',
              'related': '', # used only in one file, probably in error?
              'relatedtopics': '', # used only in one file, probably in error?
              'tablecontent': '| ',
              'tablehead': '! scope="col" | ',
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
            'null': '', # special paragraph for Variable, CaseInline, etc.
            'paragraph': '\n\n',
            'related': '\n\n', # used only in one file, probably in error?
            'relatedtopics': '\n\n', # used only in one file, probably in error?
            'tablecontent': '\n\n',
            'tablehead': '\n\n',
            'tip': '}}\n\n',
            'warning': '}}\n\n',
           }
    }

section_id_mapping = \
    {'relatedtopics': 'RelatedTopics'}

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

def href_to_fname_id(href):
    link = href.replace('"', '')
    fname = link
    id = ''
    if link.find("#") >= 0:
        fname = link[:link.find("#")]
        id = link[link.find("#")+1:]
    else:
        sys.stderr.write('Reference without a "#" in "%s".'% link)

    return [fname, id]

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

    def start_element(self, parser, name, attrs):
        pass

    def end_element(self, parser, name):
        if name == self.name:
            self.parent.child_parsing = False

    def char_data(self, parser, data):
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

    # embed part of another file into current structure
    def embed_href(self, fname, id):
        # parse another xhp
        parser = XhpParser('source/' + fname, False)
        var = parser.get_variable(id)

        if var != None:
            self.objects.append(var)
        elif parser.follow_embed:
            sys.stderr.write('Cannot find reference "#%s" in "%s".\n'% \
                    (id, fname))

    def unhandled_element(self, name):
        sys.stderr.write('Warning: Unhandled element "%s" in "%s"\n'% \
                (name, self.name))

class XhpFile(ElementBase):
    def __init__(self):
        ElementBase.__init__(self, None, None)
        self.depth=1

    def start_element(self, parser, name, attrs):
        if name == 'body':
            # ignored, we flatten the structure
            pass
        elif name == 'bookmark':
            self.parse_child(Bookmark(attrs, self))
        elif name == 'embed':
            if parser.follow_embed:
                (fname, id) = href_to_fname_id(attrs['href'])
                self.embed_href(fname, id)
        elif name == 'helpdocument':
            # ignored, we flatten the structure
            pass
        elif name == 'list':
            self.parse_child(List(attrs, self))
        elif name == 'meta':
            self.parse_child(Meta(attrs, self))
        elif name == 'paragraph':
            para = Paragraph(attrs, self, self.depth)
            self.depth = para.depth
            self.parse_child(para)
        elif name == 'section':
            self.parse_child(Section(attrs, self, self.depth))
        elif name == 'table':
            self.parse_child(Table(attrs, self))
        else:
            self.unhandled_element(name)

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

    def start_element(self, parser, name, attrs):
        if name == 'alt':
            self.alt = True
        else:
            self.unhandled_element(name)

    def end_element(self, parser, name):
        ElementBase.end_element(self, parser, name)

        if name == 'alt':
            self.alt = False

    def char_data(self, parser, data):
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

    def start_element(self, parser, name, attrs):
        if name == 'paragraph':
            self.parse_child(Paragraph(attrs, self, 0))
        else:
            self.unhandled_element(name)

class TableRow(ElementBase):
    def __init__(self, attrs, parent):
        ElementBase.__init__(self, 'tablerow', parent)

    def start_element(self, parser, name, attrs):
        if name == 'tablecell':
            self.parse_child(TableCell(attrs, self))
        else:
            self.unhandled_element(name)

    def get_all(self):
        text = '|-\n' + ElementBase.get_all(self)
        return text

class Table(ElementBase):
    def __init__(self, attrs, parent):
        ElementBase.__init__(self, 'table', parent)

    def start_element(self, parser, name, attrs):
        if name == 'tablerow':
            self.parse_child(TableRow(attrs, self))
        else:
            self.unhandled_element(name)

    def get_all(self):
        # + ' align="left"' etc.?
        text = '{| border="1"\n' + \
            ElementBase.get_all(self) + \
            '|}\n\n'
        return text

class ListItem(ElementBase):
    def __init__(self, attrs, parent):
        ElementBase.__init__(self, 'listitem', parent)

    def start_element(self, parser, name, attrs):
        if name == 'paragraph':
            self.parse_child(Paragraph(attrs, self, 0))
        else:
            self.unhandled_element(name)

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

    def start_element(self, parser, name, attrs):
        if name == 'listitem':
            self.parse_child(ListItem(attrs, self))
        else:
            self.unhandled_element(name)

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

# we ignore the entire <meta> part of xhp
# TODO - do we need it for something?
class Meta(ElementBase):
    def __init__(self, attrs, parent):
        ElementBase.__init__(self, 'meta', parent)

class Section(ElementBase):
    def __init__(self, attrs, parent, depth):
        ElementBase.__init__(self, 'section', parent)
        self.depth = depth
        self.id = attrs['id']

    def start_element(self, parser, name, attrs):
        if name == 'bookmark':
            self.parse_child(Bookmark(attrs, self))
        elif name == 'embed':
            (fname, id) = href_to_fname_id(attrs['href'])
            if parser.follow_embed:
                self.embed_href(fname, id)
        elif name == 'paragraph':
            para = Paragraph(attrs, self, self.depth)
            self.depth = para.depth
            self.parse_child(para)
        elif name == 'section':
            # sections can be nested
            self.parse_child(Section(attrs, self, self.depth))
        elif name == 'table':
            self.parse_child(Table(attrs, self))
        else:
            self.unhandled_element(name)

    def get_all(self):
        mapping = ''
        try:
            mapping = section_id_mapping[self.id]
        except:
            pass

        # some of the section ids are used as real id's, some of them have
        # function (like relatetopics), and have to be templatized
        text = ''
        if mapping != '':
            text = text + '{{%s|'% mapping
        text = text + ElementBase.get_all(self)
        if mapping != '':
            text = text + '}}\n\n'

        return text

    def get_variable(self, id):
        var = ElementBase.get_variable(self, id)
        if var != None:
            return var
        if id == self.id:
            return self
        return None

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

    def char_data(self, parser, data):
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

class SwitchInline(ElementBase):
    def __init__(self, attrs, parent):
        ElementBase.__init__(self, 'switchinline', parent)
        self.switch = attrs['select']

    def start_element(self, parser, name, attrs):
        if name == 'caseinline':
            self.parse_child(CaseInline(attrs, self, False))
        elif name == 'defaultinline':
            self.parse_child(CaseInline(attrs, self, True))
        else:
            self.unhandled_element(name)

    def get_all(self):
        if self.switch == 'sys':
            system = {'MAC':'', 'UNIX':'', 'WIN':'', 'default':''}
            for i in self.objects:
                if i.case == 'MAC' or i.case == 'UNIX' or \
                   i.case == 'WIN' or i.case == 'default':
                    system[i.case] = i.get_all()
                else:
                    sys.stderr.write('Unhandled "%s" case in "sys" switchinline.\n'% \
                            i.case )
            return '{{System|%s|%s|%s|%s}}'% (system['default'], \
                    system['MAC'], system['UNIX'], system['WIN'])
        elif self.switch == 'appl':
            if len(self.objects) == 1:
                appls = {'CALC':'Calc', 'CHART':'Chart', 'DRAW':'Draw', \
                         'MATH':'Math', 'WRITER':'Writer'}
                obj = self.objects[0]
                try:
                    app = appls[obj.case]
                    return '{{OnlyIn%s|%s}}'% (app, obj.get_all())
                except:
                    sys.stderr.write('Unhandled "%s" (%s) case in "appl" switchinline.\n'% \
                            (obj.case, obj.get_all()))
            else:
                sys.stderr.write('Can handle only 1 condition in "appl" switchinline.\n')

        return ''

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

    def start_element(self, parser, name, attrs):
        if name == 'ahelp':
            # TODO extended tips are ignored for now, just the text is used
            # verbatim
            pass
        elif name == 'image':
            self.parse_child(Image(attrs, self))
        elif name == 'link':
            self.parse_child(Link(attrs, self))
        elif name == 'switchinline':
            self.parse_child(SwitchInline(attrs, self))
        elif name == 'variable':
            self.parse_child(Variable(attrs, self, self.depth))
        else:
            try:
                global replace_element
                self.objects.append(Text(replace_element['start'][name]))
            except:
                self.unhandled_element(name)

    def end_element(self, parser, name):
        ElementBase.end_element(self, parser, name)

        try:
            global replace_element
            self.objects.append(Text(replace_element['end'][name]))
        except:
            pass

    def char_data(self, parser, data):
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
        self.role = 'null'
        self.id = attrs['id']

    def get_variable(self, id):
        if id == self.id:
            return self
        return None

class CaseInline(Paragraph):
    def __init__(self, attrs, parent, is_default):
        Paragraph.__init__(self, attrs, parent, 0)

        self.role = 'null'
        if is_default:
            self.name = 'defaultinline'
            self.case = 'default'
        else:
            self.name = 'caseinline'
            self.case = attrs['select']

class XhpParser:
    def __init__(self, filename, follow_embed):
        self.head_obj = XhpFile()
        self.filename = filename
        self.follow_embed = follow_embed

        file = open(filename, "r")
        p = xml.parsers.expat.ParserCreate()

        p.StartElementHandler = self.start_element
        p.EndElementHandler = self.end_element
        p.CharacterDataHandler = self.char_data

        buf = file.read()
        p.Parse(buf)
        file.close()

    def start_element(self, name, attrs):
        self.head_obj.get_curobj().start_element(self, name, attrs)

    def end_element(self, name):
        self.head_obj.get_curobj().end_element(self, name)

    def char_data(self, data):
        self.head_obj.get_curobj().char_data(self, data)

    def get_all(self):
        return self.head_obj.get_all()

    def get_variable(self, id):
        return self.head_obj.get_variable(id)

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

parser = XhpParser(sys.argv[1], True)
print parser.get_all().encode('ascii','replace')

Bookmark.save_bookmarks()
