#!/usr/bin/env python

import sys, signal
import thread, threading, time
import xml.parsers.expat
import codecs
from threading import Thread

root="source/"
max_threads = 4

titles = [[]]

localization_data = [[]]

bookmarks_lock = threading.Lock()

# list of elements that we can directly convert to wiki text
replace_element = \
    {'start':{'br': '<br/>',
              'emph': "'''",
              'help-id-missing': "'''Missing help ID.'''"
             },
     'end':  {'br': '',
              'emph': "'''",
              'help-id-missing': ""
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

all_help_id_mappings = [[]]

def load_all_help_ids():
    file = codecs.open("helpers/help_hid.lst", "r", "utf-8")
    for line in file:
        ids = line.strip().upper().split(",")
        if len(ids) >= 2:
            all_help_id_mappings.append(ids)

def get_help_id_res2(name):
    file = codecs.open("helpers/hid.lst", "r", "utf-8")
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

def load_localization_data(sdf_file):
    try:
        file = codecs.open(sdf_file, "r", "utf-8")
        for line in file:
            line = line.strip()
            # TODO: Check if multiple \t needs to be merged
            if line.find("#") == 0:
                continue
            localization_data.append(line.split("\t"))
    except:
        return

def replace_gt_lt(str,char,replace):
    # Add additional space to catch strings starting with <=
    str = " "+str
    index = -1
    while True:
        index = str.find(char, index+1)
        if index < 0:
            break
        if str[index-1] != '\\':
            str = str[:index]+replace+str[index+1:]
    return str[1:]


def get_localized_text(id, text):
    # Note: The order is important
    replace_localized_strs = [
            ["\\\"","\""],
            ["& Chr(13)&","<br>"],
            ["& Chr(13) &","<br>"],
            ["&","&amp;"],
            ["\\n","\n"],
            ["\\t","\t"],
            ["\\\\<","&lt;"],
            ["\\\\>","&gt;"],
            ]
    for line in localization_data:
        if len(line) > 10 and line[4].strip() == id.strip():
            str = line[10]
            for i in replace_localized_strs:
                str = str.replace(i[0],i[1])
            str = replace_gt_lt(str,"<","&lt;")
            str = replace_gt_lt(str,">","&gt;")
            # Finally replace the \< and \> tokens
            str = str.replace("\\<","<").replace("\\>",">")
            return str
    return ""

def get_localized_objects(parser, loc_text, attrs):
    p = LocalizedText(parser, loc_text, attrs)
    return p.parse()

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

    def get_bookmark_obj(self):
        l = len(self.objects)
        if l > 0:
            for i in range(0,l):
                try:
                    raise self.objects[l-i]
                except Bookmark:
                    return self.objects[l-i]
                except:
                    pass
        return None


    # start parsing a child element
    def parse_child(self, child):
        self.child_parsing = True
        self.objects.append(child)

    # construct the wiki representation of this object, including the objects
    # held in self.objects (here only the text of the objects)
    def get_all(self):
        text = u''
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
    def embed_href(self, parser, fname, id):
        # parse another xhp
        parser = XhpParser('source/' + fname, False, parser.current_app, parser.help_file_name)
        var = parser.get_variable(id)

        if var != None:
            self.objects.append(var)
        elif parser.follow_embed:
            sys.stderr.write('Cannot find reference "#%s" in "%s".\n'% \
                    (id, fname))

    def unhandled_element(self, parser, name):
        filename = "Localization File"
        if parser:
            filename = parser.filename
        sys.stderr.write('Warning: Unhandled element "%s" in "%s" (%s)\n'% \
                        (name, self.name, filename))

class XhpFile(ElementBase):
    def __init__(self):
        ElementBase.__init__(self, None, None)
        self.depth=1

    def start_element(self, parser, name, attrs):
        if name == 'body':
            # ignored, we flatten the structure
            pass
        elif name == 'bookmark':
            self.parse_child(Bookmark(attrs, self, parser))
        elif name == 'comment':
            self.parse_child(Comment(attrs, self))
        elif name == 'embed' or name == 'embedvar':
            if parser.follow_embed:
                (fname, id) = href_to_fname_id(attrs['href'])
                self.embed_href(parser, fname, id)
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
        elif name == 'sort':
            self.parse_child(Sort(attrs, self))
        elif name == 'switch':
            self.parse_child(Switch(attrs, self))
        elif name == 'table':
            self.parse_child(Table(attrs, self))
        else:
            self.unhandled_element(parser, name)

class LocalizedText(ElementBase):
    def __init__(self, parser, data, attrs):
        # Initialized with some 'tag' such that the parser
        # never needs to access the parent (which in this 
        # case is null)
        ElementBase.__init__(self, 'localizedtext', None)
        header = u'<?xml version="1.0" encoding="UTF-8"?><paragraph>'
        self.data = header + data #+ '</paragraph>'
        self.xml = self.data.encode('utf-8')
        self.follow_embed = True
        self.head_obj = None
        self.attrs = attrs
        self.parser = parser
        #print self.data.encode('utf-8')

    def parse(self):
        p = xml.parsers.expat.ParserCreate()
        p.StartElementHandler = self.start_element
        p.EndElementHandler = self.end_element
        p.CharacterDataHandler = self.char_data
        try:
            p.Parse(self.xml)
        except:
            # TODO: Check different exceptions
            sys.stderr.write('Trying to parse: '+self.xml+'\n')
            print self.xml
            raise
        return self.objects[0].objects

    def start_element(self, name, attrs):
        if name == 'paragraph':
            self.parse_child(Paragraph(self.attrs, self, 0))
        else:
            if self.child_parsing:
                self.get_curobj().start_element(self.parser, name, attrs)
            else:
                self.unhandled_element(None, name)

    def char_data(self, data):
        if self.child_parsing:
            self.get_curobj().char_data(self, data)
        else:
            # Should never occur
            self.unhandled_element(None,"Unhandled Data:"+data)

    def end_element(self, name):
        if self.child_parsing:
            self.get_curobj().end_element(self, name)

class Bookmark(ElementBase):
    def __init__(self, attrs, parent, parser):
        ElementBase.__init__(self, 'bookmark', parent)
        self.bookmark = ""
        text = attrs['branch'] #.encode('ascii','replace')
        # text = text.upper()
        for i in help_id_patterns:
            if text.find(i) >= 0:
               self.bookmark = text[text.rfind("/")+1:].replace(":","_")
               break
        self.help_file_name = parser.help_file_name
        self.parser = parser

    def get_all(self):
        return ""

    def get_bookmark(self):
        return self.bookmark

    def set_heading(self, data):
        help_file_name = self.help_file_name
        if data.find("= ") >= 0:
            data = data[data.find("= ")+2:]
        if data.find(" =") >= 0:
            data = data[:data.find(" =")]
        data = data.strip()
        if len(self.bookmark) > 0:
            if data.find("]]") >= 0:
                try:
                    data = data[data.find("|")+1:data.find("]]")]
                except:
                    pass
            if data.find("}}") >= 0:
                try:
                    index = data.find("|")
                    if index < 0:
                        index = data.find("{{")+1
                    index = index + 1
                    data = data[index:data.find("}}")]
                except:
                    pass
            help_id = get_help_id(self.bookmark)
            bookmark = "    { "+help_id+", \""+help_file_name+"#"+data.replace("\"","\\\"")+"\" },"
            self.parser.add_bookmark(bookmark)


    @staticmethod
    def save_bookmarks():
        file = codecs.open("bookmarks.h", "a", "utf-8")
        for i in Bookmark.bookmarks_list:
            file.write(i+"\n")
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
            self.unhandled_element(parser, name)

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

class Comment(ElementBase):
    def __init__(self, attrs, parent):
        ElementBase.__init__(self, 'comment', parent)
        self.text = ''

    def char_data(self, parser, data):
        self.text = self.text + data

    def get_all(self):
        return '<!-- ' + self.text + ' -->'

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
        if name == 'bookmark':
            self.parse_child(Bookmark(attrs, self, parser))
        elif name == 'comment':
            self.parse_child(Comment(attrs, self))
        elif name == 'embed' or name == 'embedvar':
            (fname, id) = href_to_fname_id(attrs['href'])
            if parser.follow_embed:
                self.embed_href(parser, fname, id)
        elif name == 'paragraph':
            self.parse_child(Paragraph(attrs, self, 0))
        elif name == 'section':
            # FIXME depth, should we use something better than 0?
            self.parse_child(Section(attrs, self, 0))
        else:
            self.unhandled_element(parser, name)

class TableRow(ElementBase):
    def __init__(self, attrs, parent):
        ElementBase.__init__(self, 'tablerow', parent)

    def start_element(self, parser, name, attrs):
        if name == 'tablecell':
            self.parse_child(TableCell(attrs, self))
        else:
            self.unhandled_element(parser, name)

    def get_all(self):
        text = '|-\n' + ElementBase.get_all(self)
        return text

class Table(ElementBase):
    def __init__(self, attrs, parent):
        ElementBase.__init__(self, 'table', parent)

    def start_element(self, parser, name, attrs):
        if name == 'comment':
            self.parse_child(Comment(attrs, self))
        elif name == 'tablerow':
            self.parse_child(TableRow(attrs, self))
        else:
            self.unhandled_element(parser, name)

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
        if name == 'bookmark':
            self.parse_child(Bookmark(attrs, self, parser))
        elif name == 'embed' or name == 'embedvar':
            (fname, id) = href_to_fname_id(attrs['href'])
            if parser.follow_embed:
                self.embed_href(parser, fname, id)
        elif name == 'paragraph':
            self.parse_child(Paragraph(attrs, self, 0))
        else:
            self.unhandled_element(parser, name)

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
            self.unhandled_element(parser, name)

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
            self.parse_child(Bookmark(attrs, self, parser))
        elif name == 'comment':
            self.parse_child(Comment(attrs, self))
        elif name == 'embed' or name == 'embedvar':
            (fname, id) = href_to_fname_id(attrs['href'])
            if parser.follow_embed:
                self.embed_href(parser, fname, id)
        elif name == 'list':
            self.parse_child(List(attrs, self))
        elif name == 'paragraph':
            para = Paragraph(attrs, self, self.depth)
            self.depth = para.depth
            self.parse_child(para)
        elif name == 'section':
            # sections can be nested
            self.parse_child(Section(attrs, self, self.depth))
        elif name == 'switch':
            self.parse_child(Switch(attrs, self))
        elif name == 'table':
            self.parse_child(Table(attrs, self))
        else:
            self.unhandled_element(parser, name)

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

class Sort(ElementBase):
    def __init__(self, attrs, parent):
        ElementBase.__init__(self, 'sort', parent)

        try:
            self.order = attrs['order']
        except:
            self.order = 'asc'

    def start_element(self, parser, name, attrs):
        if name == 'section':
            # FIXME depth, should we use something better than 0?
            self.parse_child(Section(attrs, self, 0))
        else:
            self.unhandled_element(parser, name)

    def get_all(self):
        rev = False
        if self.order == 'asc':
            rev = True
        self.objects = sorted(self.objects, key=lambda obj: obj.id, reverse=rev)

        return ElementBase.get_all(self)

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
        self.embedding_app = ''

    def start_element(self, parser, name, attrs):
        self.embedding_app = parser.embedding_app
        if name == 'caseinline':
            self.parse_child(CaseInline(attrs, self, False))
        elif name == 'defaultinline':
            self.parse_child(CaseInline(attrs, self, True))
        else:
            self.unhandled_element(parser, name)

    def get_all(self):
        if len(self.objects) == 0:
            return ''
        elif self.switch == 'sys':
            system = {'MAC':'', 'UNIX':'', 'WIN':'', 'default':''}
            for i in self.objects:
                if i.case == 'MAC' or i.case == 'UNIX' or \
                   i.case == 'WIN' or i.case == 'default':
                    system[i.case] = i.get_all()
                elif i.case == 'OS2':
                    # ignore, there is only one mention of OS2, which is a
                    # 'note to translators', and no meat
                    pass
                elif i.case == 'HIDE_HERE':
                    # do what the name suggest ;-)
                    pass
                else:
                    sys.stderr.write('Unhandled "%s" case in "sys" switchinline.\n'% \
                            i.case )
            text = '{{System'
            for i in [['default', 'default'], ['MAC', 'mac'], \
                      ['UNIX', 'unx'], ['WIN', 'win']]:
                if system[i[0]] != '':
                    text = '%s|%s=%s'% (text, i[1], system[i[0]])
            return text + '}}'
        elif self.switch == 'appl':
            # we want directly use the right text, when inlining something
            # 'shared' into an 'app'
            if self.embedding_app == '':
                text = ''
                for i in self.objects:
                    appls = {'CALC':'Calc', 'CHART':'Chart', 'DRAW':'Draw', \
                             'IMPRESS': 'Impress', 'MATH':'Math', \
                             'WRITER':'Writer', 'default':''}
                    try:
                        app = appls[i.case]
                        all = i.get_all()
                        if all == '':
                            pass
                        elif app == '':
                            text = text + all
                        else:
                            text = text + '{{OnlyIn%s|%s}}'% (app, all)
                    except:
                        sys.stderr.write('Unhandled "%s" case in "appl" switchinline.\n'% \
                                i.case)
                return text
            else:
                for i in self.objects:
                    if i.case == self.embedding_app:
                        return i.get_all()

        return ''

class Case(ElementBase):
    def __init__(self, attrs, parent, is_default):
        ElementBase.__init__(self, 'case', parent)

        if is_default:
            self.name = 'default'
            self.case = 'default'
        else:
            self.case = attrs['select']

    def start_element(self, parser, name, attrs):
        if name == 'bookmark':
            self.parse_child(Bookmark(attrs, self, parser))
        elif name == 'comment':
            self.parse_child(Comment(attrs, self))
        elif name == 'embed' or name == 'embedvar':
            if parser.follow_embed:
                (fname, id) = href_to_fname_id(attrs['href'])
                self.embed_href(parser, fname, id)
        elif name == 'list':
            self.parse_child(List(attrs, self))
        elif name == 'paragraph':
            # FIXME depth, should we use something better than 0?
            self.parse_child(Paragraph(attrs, self, 0))
        elif name == 'section':
            # FIXME depth, should we use something better than 0?
            self.parse_child(Section(attrs, self, 0))
        elif name == 'table':
            self.parse_child(Table(attrs, self))
        else:
            self.unhandled_element(parser, name)

class Switch(SwitchInline):
    def __init__(self, attrs, parent):
        SwitchInline.__init__(self, attrs, parent)
        self.name = 'switch'

    def start_element(self, parser, name, attrs):
        self.embedding_app = parser.embedding_app
        if name == 'case':
            self.parse_child(Case(attrs, self, False))
        elif name == 'default':
            self.parse_child(Case(attrs, self, True))
        else:
            self.unhandled_element(parser, name)

class Item(ElementBase):
    replace_type = \
            {'start':{'input': '<code>',
                      'keycode': '{{KeyCode|',
                      'literal': '<code>',
                      'menuitem': '{{MenuItem|',
                      'productname': ''
                     },
             'end':{'input': '</code>',
                    'keycode': '}}',
                    'literal': '</code>',
                    'menuitem': '}}',
                    'productname': ''
                   }}

    def __init__(self, attrs, parent):
        ElementBase.__init__(self, 'item', parent)

        self.type = attrs['type']
        self.text = ''

    def char_data(self, parser, data):
        self.text = self.text + data

    def get_all(self):
        try:
            return self.replace_type['start'][self.type] + \
                   replace_text(self.text) + \
                   self.replace_type['end'][self.type]
        except:
            sys.stderr.write('Unhandled item type "%s".\n'% self.type)

        return replace_text(self.text)


class Paragraph(ElementBase):
    def __init__(self, attrs, parent, depth):
        ElementBase.__init__(self, 'paragraph', parent)

        try:
            self.role = attrs['role']
        except:
            self.role = 'paragraph'

        try: 
            self.id = attrs['id']
        except:
            self.id = ""

        try:
            self.level=int(attrs['level'])
        except:
            self.level=0
        if depth > self.level:
            self.depth = depth
        else:
            self.depth = self.level
        self.is_first = (len(self.parent.objects) == 0)
        self.localized_objects = []
        self.bookmark = parent.get_bookmark_obj()

    def start_element(self, parser, name, attrs):
        if name == 'ahelp':
            # TODO extended tips are ignored for now, just the text is used
            # verbatim
            pass
        elif name == 'comment':
            self.parse_child(Comment(attrs, self))
        elif name == 'embedvar':
            if parser.follow_embed:
                (fname, id) = href_to_fname_id(attrs['href'])
                self.embed_href(parser, fname, id)
        elif name == 'image':
            self.parse_child(Image(attrs, self))
        elif name == 'item':
            self.parse_child(Item(attrs, self))
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
                self.unhandled_element(parser, name)

    def end_element(self, parser, name):
        ElementBase.end_element(self, parser, name)

        try:
            global replace_element
            self.objects.append(Text(replace_element['end'][name]))
        except:
            pass

    def char_data(self, parser, data):
        if self.role == 'paragraph' or self.role == 'heading':
            if data != '' and data[0] == ' ':
                data = ' ' + data.lstrip()
            data = data.replace('\n', ' ')

        if len(self.localized_objects):
            return
        loc_text = u''
        if len(self.id):
            loc_text = get_localized_text(self.id, data)
        if len(loc_text):
            attrs = {'role':self.role,
                     'level':self.level}
            self.localized_objects = get_localized_objects(parser, loc_text, attrs)
        else:
            self.objects.append(Text(data))

    def get_all(self):
        # Localization objects present, drop the other objects
        if len(self.localized_objects):
            self.objects = self.localized_objects

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
        text = text + ElementBase.get_all(self).strip()

        # append the markup according to the role
        if len(self.objects) > 0:
            try:
                text = text + replace_paragraph_role['end'][role]
            except:
                sys.stderr.write( "Unknown paragraph role end: " + role + "\n" )

        # set bookmark info
        try:
            if self.role.find("heading") >= 0:
                self.bookmark.set_heading(text)
        except:
            pass

        return text

class Variable(Paragraph):
    def __init__(self, attrs, parent, depth):
        Paragraph.__init__(self, attrs, parent, depth)
        self.name = 'variable'
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
    def __init__(self, filename, follow_embed, embedding_app, help_file_name):
        self.head_obj = XhpFile()
        self.filename = filename
        self.follow_embed = follow_embed
        self.embedding_app = embedding_app
        self.help_file_name = help_file_name
        self.bookmarks = []

        self.current_app = ''
        for i in [['scalc', 'CALC'], ['sdraw', 'DRAW'], \
                  ['schart', 'CHART'], ['simpress', 'IMPRESS'], \
                  ['smath', 'MATH'], ['swriter', 'WRITER']]:
            if filename.find('/%s/'% i[0]) >= 0:
                self.current_app = i[1]
                break

        file = codecs.open(filename, "r", "utf-8")
        p = xml.parsers.expat.ParserCreate()

        p.StartElementHandler = self.start_element
        p.EndElementHandler = self.end_element
        p.CharacterDataHandler = self.char_data

        buf = file.read()
        p.Parse(buf.encode('utf-8'))
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

    def add_bookmark(self, bookmark):
        self.bookmarks.append(bookmark)

    def save_bookmarks(self):
        global bookmarks_lock
        bookmarks_lock.acquire()
        file = codecs.open("bookmarks.h", "a", "utf-8")
        for i in self.bookmarks:
            file.write(i+"\n")
        file.close() 
        bookmarks_lock.release()

def loadallfiles(filename):
    global titles
    file = codecs.open(filename, "r", "utf-8")
    for line in file:
        title = line.split(";", 2)
        titles.append(title)

def signal_handler(signal, frame):
    sys.stderr.write( 'Exiting...\n' )
    sys.exit(1)
signal.signal(signal.SIGINT, signal_handler)

class WikiConv2(Thread):
    def __init__(self, inputfile, help_file_name, outputfile):
        Thread.__init__(self)
        self.inputfile = inputfile
        self.help_file_name = help_file_name
        self.outputfile = outputfile

    def run(self):
        parser = XhpParser(self.inputfile, True, '', self.help_file_name)
        file = codecs.open(self.outputfile, "wb", "utf-8")
        file.write(parser.get_all())
        file.close()
        parser.save_bookmarks()

# Main Function
load_all_help_ids()
loadallfiles("alltitles.csv")
if len(sys.argv) > 1:
    load_localization_data(sys.argv[1])

for title in titles:
    while threading.active_count() > max_threads:
        time.sleep(0.1)

    outfile = ""
    infile  = ""
    if len(title) > 1:
        outfile = "wiki/"+title[1].strip()
        infile  = title[0].strip()
        try:
            file = open(outfile,"r")
        except:    
            try:
                wiki = WikiConv2(infile,title[1].strip(),outfile)
                wiki.start()
                continue
            except:
                print 'Failed to convert "%s" into "%s".\n'% \
                        (title[1].strip(), outfile)
        print "Warning: Skipping: "+infile+" > "+outfile
        file.close()

time.sleep(0.1)
#Bookmark.save_bookmarks()

# vim:set shiftwidth=4 softtabstop=4 expandtab:
