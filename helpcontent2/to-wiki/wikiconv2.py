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

def heading(level):
    str=""
    for i in range(0,level):
        str = str+"="
    return str

class cxml:
    def __init__(self, sectionid):
        self.filter_section=sectionid
        self.objects=[]
        self.child_parsing=False
        self.parser_state=True
        self.depth=1
        if sectionid != "":
            self.parser_state=False

    def start_element(self, name, attrs):
        # TODO: Take care of nested sections
        if name == 'section':
            if attrs['id'] == "relatedtopics":
                self.objects.append(ctext("{{RelatedTopics}}\n"))
            if self.filter_section != "" and attrs['id'] == self.filter_section:
                self.parser_state=True
        if name == 'paragraph':
            if not self.parser_state:
                para=cparagraph(attrs, self, self.filter_section, self.depth)
            else:
                para=cparagraph(attrs, self, '', self.depth)
            self.depth = para.depth
            self.child_parsing=True
            self.objects.append(para)
        if not self.parser_state:
            return
        #if name == 'embed':
        #    link=attrs['href'].replace('"','')
        #    fname=link
        #    section=""
        #    if link.find("#") >= 0:
        #        fname = link[:link.find("#")]
        #        section = link[link.find("#")+1:]

        #    my_attrs = {}
        #    my_attrs['href'] = fname
        #    my_attrs['name'] = get_link_name(fname)
        #    self.objects.append(clink(my_attrs, self))
        #    # add a '\n' after each of the links
        #    self.objects.append(ctext(""))

        if name == 'table':
            child = ctable(attrs, self)
            self.child_parsing = True
            self.objects.append(child)

        if name == 'list':
            child = clist(attrs, self)
            self.child_parsing = True
            self.objects.append(child)

        if name == 'bookmark':
            child = cbookmark(attrs, self)
            self.child_parsing = True
            self.objects.append(child)

    def end_element(self, name):
        if not self.parser_state:
            return
        if self.filter_section != "" and name == 'section':
            self.parser_state=False

    def char_data(self, data):
        pass

    def get_curobj(self):
        if self.child_parsing:
            return self.objects[len(self.objects)-1].get_curobj()
        return self

    def get_all(self):
        text = ""
        for i in self.objects:
            text = text + i.get_all()
        return text

class cbookmark:
    bookmarks_list   = []
    current_bookmark = ""

    def __init__(self, attrs, parent):
        self.parent = parent
        self.bookmark = ""
        text = attrs['branch'].encode('ascii','replace')
        # text = text.upper()
        for i in help_id_patterns:
            if text.find(i) >= 0:
               self.bookmark = text[text.rfind("/")+1:].replace(":","_")
               break

    def start_element(self, name, attrs):
        pass

    def end_element(self, name):
        # Assumes no nested bookmark entries
        if name == "bookmark":
            self.parent.child_parsing = False

    def char_data(self, data):
        pass

    def get_all(self):
        cbookmark.current_bookmark = self.bookmark
        return ""

    def get_curobj(self):
        return self

    @staticmethod
    def set_heading(data):
        global help_file_name
        if len(cbookmark.current_bookmark) > 0:
            if data.find("]]") >= 0:
                try:
                    data = data[data.find("|")+1:data.find("]]")]
                except:
                    pass
            help_id = get_help_id(cbookmark.current_bookmark)
            bookmark = "    { "+help_id+", \""+help_file_name+"#"+data.replace("\"","\\\"")+"\" },"
            bookmark = bookmark.encode('ascii','replace')
            cbookmark.bookmarks_list.append(bookmark)
            cbookmark.current_bookmark = ""

    @staticmethod
    def save_bookmarks():
        file = open("bookmarks.h","a")
        for i in cbookmark.bookmarks_list:
            file.write(i.encode('ascii','replace')+"\n")
        file.close()

class cimage:
    def __init__(self, attrs, parent):
        self.src     = attrs['src']
        try:
            self.width   = attrs['width']
            self.height  = attrs['height']
        except:
            self.width = self.height = ""
        self.align   = 'left'
        self.alt     = False
        self.alttext = ""
        self.parent  = parent

    def start_element(self, name, attrs):
        if name == 'alt':
            self.alt = True

    def end_element(self, name):
        if name == 'alt':
            self.alt = False

        if name == 'image':
            self.parent.child_parsing = False

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

class ctext:
    def __init__(self, text):
        self.wikitext = replace_text(text)

    def get_all(self):
        return self.wikitext

class ctabcell:
    def __init__(self, attrs, parent):
        # TODO: colspan rowspan
        self.objects = []
        self.child_parsing = False
        self.parent = parent

    def start_element(self, name, attrs):
        if name == 'paragraph':
            para = cparagraph(attrs, self, '', 0)
            self.child_parsing = True
            self.objects.append(para)

    def end_element(self, name):
        if name == 'tablecell':
            self.parent.child_parsing = False

    def char_data(self, data):
        return

    def get_all(self):
        text = ""
        for i in self.objects:
            text = text + i.get_all()
        return text

    def get_curobj(self):
        if self.child_parsing:
            return self.objects[len(self.objects)-1].get_curobj()
        return self

class ctabrow:
    def __init__(self, attrs, parent):
        self.objects = []
        self.child_parsing = False
        self.parent = parent

    def start_element(self, name, attrs):
        if name == 'tablecell':
            tabcell = ctabcell(attrs, self)
            self.child_parsing = True
            self.objects.append(tabcell)

    def end_element(self, name):
        if name == 'tablerow':
            self.parent.child_parsing = False

    def char_data(self, data):
        return

    def get_all(self):
        text = '|-\n'
        for i in self.objects:
            text = text + i.get_all()
        return text

    def get_curobj(self):
        if self.child_parsing:
            return self.objects[len(self.objects)-1].get_curobj()
        return self

class ctable:
    def __init__(self, attrs, parent):
        self.objects = []
        self.child_parsing = False
        self.parent = parent

    def start_element(self, name, attrs):
        if name == 'tablerow':
            tabrow = ctabrow(attrs, self)
            self.child_parsing = True
            self.objects.append(tabrow)

    def end_element(self, name):
        if name == 'table':
            self.parent.child_parsing = False

    def char_data(self, data):
        return

    def get_all(self):
        text = '{| border="1"\n' # + ' align="left"'
        for i in self.objects:
            text = text + i.get_all()
        text = text + '|}\n\n'
        return text

    def get_curobj(self):
        if self.child_parsing:
            return self.objects[len(self.objects)-1].get_curobj()
        return self

class clistitem:
    def __init__(self, attrs, parent):
        # TODO: colspan rowspan
        self.objects = []
        self.child_parsing = False
        self.parent = parent

    def start_element(self, name, attrs):
        if name == 'paragraph':
            para = cparagraph(attrs, self, '', 0)
            self.child_parsing = True
            self.objects.append(para)

    def end_element(self, name):
        if name == 'listitem':
            self.parent.child_parsing = False

    def char_data(self, data):
        return

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
            text = text + prefix + i.get_all() + postfix

        return text

    def get_curobj(self):
        if self.child_parsing:
            return self.objects[len(self.objects)-1].get_curobj()
        return self

class clist:
    def __init__(self, attrs, parent):
        self.objects = []
        self.child_parsing = False
        self.parent = parent
        self.type = attrs['type']
        try:
            self.startwith = int(attrs['startwith'])
        except:
            self.startwith = 0

    def start_element(self, name, attrs):
        if name == 'listitem':
            listitem = clistitem(attrs, self)
            self.child_parsing = True
            self.objects.append(listitem)

    def end_element(self, name):
        if name == 'list':
            self.parent.child_parsing = False

    def char_data(self, data):
        return

    def get_all(self):
        text = ""
        if self.startwith > 0:
            text = text + '<ol start="%d">\n'% self.startwith

        for i in self.objects:
            text = text + i.get_all()

        if self.startwith > 0:
            text = text + '</ol>\n'
        else:
            text = text + '\n'
        return text

    def get_curobj(self):
        if self.child_parsing:
            return self.objects[len(self.objects)-1].get_curobj()
        return self

class clink:
    def __init__(self, attrs, parent):
        self.link = attrs['href']
        try:
            self.lname = attrs['name']
        except:
            self.lname = self.link[self.link.rfind("/")+1:]
        # Override lname
        self.default_name = self.lname
        self.lname = get_link_filename(self.link, self.lname)
        self.wikitext = ""
        self.parent = parent

    def start_element(self, name, attrs):
        pass

    def end_element(self, name):
        if name == "link":
            self.parent.child_parsing = False

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

    def get_curobj(self):
        return self

# Not used yet - cparagraph itself handles it (as of now)
class cvariable:
    def __init__(self, sectionid, parent):
        self.parser_state=True
        self.wikitext=""
        if sectionid != "" and attrs['id']==sectionid:
            self.parser_state=False
        self.parent = parent

    def start_element(self, name, attrs):
        pass

    def end_element(self,name):
        if name == 'variable':
            parent.child_parsing = False

class cparagraph:
    def __init__(self, attrs, parent, sectionid, depth):
        self.child_parsing = False
        try:
            self.role = attrs['role']
        except:
            self.role = 'paragraph'

        #try:
        #    self.level=parent.level+1
        #except:
        try:
            self.level=int(attrs['level'])
        except:
            self.level=0
        self.filter_section=sectionid
        self.parent = parent
        self.objects=[]
        self.parser_state=True
        if depth > self.level:
            self.depth = depth
        else:
            self.depth = self.level
        self.wikitext=""
        if sectionid != "":
            self.parser_state = False
        self.is_first = (len(self.parent.objects) == 0)

    def __del__(self):
        pass

    def start_element(self, name, attrs):
        if name == 'variable':
            if attrs['id'] == self.filter_section:
                self.parser_state=True

        if not self.parser_state:
            return
        if name == 'embed':
            # This shouldn't occur
            print "Warning: Skipped Embedded content!!!"
        if name == 'image':
            child = cimage(attrs, self)
            self.child_parsing = True
            self.objects.append(child)
        if name == 'link':
            child = clink(attrs, self)
            self.child_parsing = True
            self.objects.append(child)
        if name == 'bookmark':
            # This shouldn't occur
            print "Warning: Unhandled bookmark content!!!"

        try:
            global replace_element
            self.objects.append(ctext(replace_element['start'][name]))
        except:
            pass

    def end_element(self, name):
        if name == 'paragraph':
            self.parent.child_parsing = False
        if not self.parser_state:
            return
        if self.filter_section != "" and name == 'variable':
            self.parser_state = False

        try:
            global replace_element
            self.objects.append(ctext(replace_element['end'][name]))
        except:
            pass

    def char_data(self, data):
        if not self.parser_state or not len(data.strip()):
            return
        self.objects.append(ctext(data))
        #self.wikitext = self.wikitext + text

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
        if len(self.objects) > 0:
            try:
                self.wikitext = self.wikitext + replace_paragraph_role['start'][role]
            except:
                sys.stderr.write( "Unknown paragraph role start: " + role + "\n" )

        # the text itself
        text = ""
        for i in self.objects:
            text = text + i.get_all()
        self.wikitext = self.wikitext + text

        # set bookmark info
        if self.role == "heading":
            cbookmark.set_heading(text)

        # append the markup according to the role
        if len(self.objects) > 0:
            try:
                self.wikitext = self.wikitext + replace_paragraph_role['end'][role]
            except:
                sys.stderr.write( "Unknown paragraph role end: " + role + "\n" )

        return self.wikitext

    def get_curobj(self):
        if self.child_parsing:
            return self.objects[len(self.objects)-1].get_curobj()
        return self

head_obj=cxml("")
def start_element(name, attrs):
    head_obj.get_curobj().start_element(name,attrs)

def end_element(name):
    head_obj.get_curobj().end_element(name)

def char_data(data):
    head_obj.get_curobj().char_data(data)

def parsexhp(filename):
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
cbookmark.save_bookmarks()
