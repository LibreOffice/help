#!/usr/bin/env python

import sys
import thread, threading, time
import xml.parsers.expat
import codecs
from threading import Thread

root="source/"
max_threads = 25

titles = [[]]

localization_data = [[]]

# content of the hid.lst file for easier searching
hid_lst = {}

# to collect a list of pages that will be redirections to the pages with nice
# names
redirects = []

# to collect images that we will up-load later
images = set()

# various types of paragraphs
replace_paragraph_role = \
    {'start':{'code': '<code>',
              'codeintip': '<code>',
              'emph' : '', # must be empty to be able to strip empty <emph/>
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
              'tablecontentcode': '| <code>',
              'tablehead': '! scope="col" | ',
              'tablenextpara': '\n',
              'tablenextparacode': '\n<code>',
              'tip': '{{Tip|',
              'variable': '',
              'warning': '{{Warning|',
             },
     'end':{'code': '</code>\n\n',
            'codeintip': '</code>\n\n',
            'emph' : '',
            'example': '</code>\n\n',
            'heading1': ' =\n\n',
            'heading2': ' ==\n\n',
            'heading3': ' ===\n\n',
            'heading4': ' ====\n\n',
            'heading5': ' =====\n\n',
            'heading6': ' ======\n\n',
            'head1': ' =\n\n', # used only in one file, probably in error?
            'head2': ' ==\n\n', # used only in one file, probably in error?
            'listitem': '',
            'note': '}}\n\n',
            'null': '', # special paragraph for Variable, CaseInline, etc.
            'paragraph': '\n\n',
            'related': '\n\n', # used only in one file, probably in error?
            'relatedtopics': '\n\n', # used only in one file, probably in error?
            'tablecontent': '\n',
            'tablecontentcode': '</code>\n',
            'tablehead': '\n',
            'tablenextpara': '\n',
            'tablenextparacode': '</code>\n',
            'tip': '}}\n\n',
            'variable': '',
            'warning': '}}\n\n',
           },
     'templ':{'code': False,
              'codeintip': False,
              'emph' : False,
              'example': False,
              'heading1': False,
              'heading2': False,
              'heading3': False,
              'heading4': False,
              'heading5': False,
              'heading6': False,
              'head1': False,
              'head2': False,
              'listitem': False,
              'note': True,
              'null': False,
              'paragraph': False,
              'related': False,
              'relatedtopics': False,
              'tablecontent': False,
              'tablecontentcode': False,
              'tablehead': False,
              'tablenextpara': False,
              'tablenextparacode': False,
              'tip': True,
              'variable': False,
              'warning': True,
           }
    }

section_id_mapping = \
    {'relatedtopics': 'RelatedTopics'}

# text snippets that we need to convert
replace_text_list = \
    [["$[officename]", "{{ProductName}}"],
     ["%PRODUCTNAME", "{{ProductName}}"]
    ]

def load_hid_lst():
    file = codecs.open("helpers/hid.lst", "r", "utf-8")
    for line in file:
        ids = line.strip().split(" ")
        if len(ids) == 2:
            hid_lst[ids[0].upper()] = ids[1]
    file.close()

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

# modify the text so that in templates like {{Name|something}}, the 'something'
# does not look like template params
def escape_equals_sign(text):
    depth = 0
    t = ''
    for i in text:
        if i == '=':
            if depth == 0:
                t = t + '&#61;'
            else:
                t = t + '='
        else:
            t = t + i
            if i == '{' or i == '[' or i == '<':
                depth = depth + 1
            elif i == '}' or i == ']' or i == '>':
                depth = depth - 1
                if depth < 0:
                    depth = 0

    return t

def load_localization_data(sdf_file):
    try:
        file = codecs.open(sdf_file, "r", "utf-8")
        for line in file:
            line = line.strip()
            # TODO: Check if multiple \t needs to be merged
            if line.find("#") == 0:
                continue
            localization_data.append(line.split("\t"))
        file.close()
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
    def embed_href(self, parent_parser, fname, id):
        # parse another xhp
        parser = XhpParser('source/' + fname, False, parent_parser.current_app, parent_parser.wiki_page_name)
        var = parser.get_variable(id)

        if var != None:
            try:
                if var.role == 'variable':
                    var.role = 'paragraph'
            except:
                pass
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

# Base class for trivial elements that operate on char_data
#
# Like <comment>, or <title>
class TextElementBase(ElementBase):
    def __init__(self, attrs, parent, element_name, start, end, templ):
        ElementBase.__init__(self, element_name, parent)
        self.text = u''
        self.start = start
        self.end = end
        self.templ = templ

    def char_data(self, parser, data):
        self.text = self.text + data

    def get_all(self):
        if self.templ:
            return self.start + escape_equals_sign(replace_text(self.text)) + self.end
        else:
            return self.start + replace_text(self.text) + self.end

class XhpFile(ElementBase):
    def __init__(self):
        ElementBase.__init__(self, None, None)

    def start_element(self, parser, name, attrs):
        if name == 'body':
            # ignored, we flatten the structure
            pass
        elif name == 'bookmark':
            self.parse_child(Bookmark(attrs, self, 'div', parser))
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
            parser.parse_paragraph(attrs, self)
        elif name == 'section':
            self.parse_child(Section(attrs, self))
        elif name == 'sort':
            self.parse_child(Sort(attrs, self))
        elif name == 'switch':
            self.parse_child(Switch(attrs, self, parser.embedding_app))
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
            self.parse_child(Paragraph(self.attrs, self))
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
    def __init__(self, attrs, parent, type, parser):
        ElementBase.__init__(self, 'bookmark', parent)

        self.type = type

        self.id = attrs['id']
        self.app = ''
        self.redirect = ''
        self.target = ''
        self.authoritative = False

        # let's construct the name of the redirect, so that we can point
        # to the wikihelp directly from the LO code; wiki then takes care of
        # the correct redirect
        branch = attrs['branch']
        if branch.find('hid/') == 0 and (parser.current_app_raw != '' or parser.follow_embed):
            name = branch[branch.find('/') + 1:]

            self.app = parser.current_app_raw
            self.target = parser.wiki_page_name
            self.authoritative = parser.follow_embed
            if name.find('.uno:') == 0 or name.find('.HelpId:') == 0:
                self.redirect = name
            elif name.upper() in hid_lst:
                self.redirect = hid_lst[name.upper()]
            #else:
            #    sys.stderr.write('Unhandled redirect "%s"\n'% name)

    def get_all(self):
        global redirects
        # first of all, we need to create a redirect page for this one
        if self.redirect != '' and self.target != '':
            redirects.append([self.app, self.redirect, self.target, \
                self.authoritative])

        # then we also have to setup ID inside the page
        if self.type == 'div':
            return '<div id="%s"></div>\n'% self.id
        elif self.type == 'span':
            return '<span id="%s"></span>'% self.id
        else:
            sys.stderr.write('Unknown bookmark type "%s"'% self.type)

        return ''

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
        global images
        images.add(self.src)

        name = self.src[self.src.rfind('/') + 1:]
        wikitext = "[[Image:"+name+"|border|"+self.align+"|"
        if len(self.width):
            wikitext = wikitext + self.width+"x"+self.height+"|"
        wikitext = wikitext + self.alttext+"]]"
        return wikitext

    def get_curobj(self):
        return self

class Br(TextElementBase):
    def __init__(self, attrs, parent):
        TextElementBase.__init__(self, attrs, parent, 'br', '<br/>', '', False)

class Comment(TextElementBase):
    def __init__(self, attrs, parent):
        TextElementBase.__init__(self, attrs, parent, 'comment', '<!-- ', ' -->', False)

class HelpIdMissing(TextElementBase):
    def __init__(self, attrs, parent):
        TextElementBase.__init__(self, attrs, parent, 'help-id-missing', '{{MissingHelpId}}', '', False)

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
            self.parse_child(Bookmark(attrs, self, 'div', parser))
        elif name == 'comment':
            self.parse_child(Comment(attrs, self))
        elif name == 'embed' or name == 'embedvar':
            (fname, id) = href_to_fname_id(attrs['href'])
            if parser.follow_embed:
                self.embed_href(parser, fname, id)
        elif name == 'paragraph':
            self.parse_child(TableContentParagraph(attrs, self))
        elif name == 'section':
            self.parse_child(Section(attrs, self))
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
            self.parse_child(Bookmark(attrs, self, 'span', parser))
        elif name == 'embed' or name == 'embedvar':
            (fname, id) = href_to_fname_id(attrs['href'])
            if parser.follow_embed:
                self.embed_href(parser, fname, id)
        elif name == 'paragraph':
            self.parse_child(ListItemParagraph(attrs, self))
        else:
            self.unhandled_element(parser, name)

    def get_all(self):
        text = '*'
        postfix = '\n'
        if self.parent.startwith > 0:
            text = '<li>'
            postfix = '</li>'
        elif self.parent.type == 'ordered':
            text = '#'

        # add the text itself
        linebreak = False
        for i in self.objects:
            if linebreak:
                text = text + '<br/>'
            text = text + i.get_all()
            linebreak = True

        return text + postfix

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
            text = text + '\n</ol>\n'
        else:
            text = text + '\n'
        return text

# To handle elements that should be completely ignored
class Ignore(ElementBase):
    def __init__(self, attrs, parent, element_name):
        ElementBase.__init__(self, element_name, parent)

class Title(TextElementBase):
    def __init__(self, attrs, parent):
        TextElementBase.__init__(self, attrs, parent, 'title', '{{Lang|', '}}\n\n', True)

class Topic(ElementBase):
    def __init__(self, attrs, parent):
        ElementBase.__init__(self, 'topic', parent)

    def start_element(self, parser, name, attrs):
        if name == 'title':
            self.parse_child(Title(attrs, self))
        elif name == 'filename':
            self.parse_child(Ignore(attrs, self, name))
        else:
            self.unhandled_element(parser, name)

class Meta(ElementBase):
    def __init__(self, attrs, parent):
        ElementBase.__init__(self, 'meta', parent)

    def start_element(self, parser, name, attrs):
        if name == 'topic':
            self.parse_child(Topic(attrs, self))
        elif name == 'history' or name == 'lastedited':
            self.parse_child(Ignore(attrs, self, name))
        else:
            self.unhandled_element(parser, name)

class Section(ElementBase):
    def __init__(self, attrs, parent):
        ElementBase.__init__(self, 'section', parent)
        self.id = attrs['id']

    def start_element(self, parser, name, attrs):
        if name == 'bookmark':
            self.parse_child(Bookmark(attrs, self, 'div', parser))
        elif name == 'comment':
            self.parse_child(Comment(attrs, self))
        elif name == 'embed' or name == 'embedvar':
            (fname, id) = href_to_fname_id(attrs['href'])
            if parser.follow_embed:
                self.embed_href(parser, fname, id)
        elif name == 'list':
            self.parse_child(List(attrs, self))
        elif name == 'paragraph':
            parser.parse_paragraph(attrs, self)
        elif name == 'section':
            # sections can be nested
            self.parse_child(Section(attrs, self))
        elif name == 'switch':
            self.parse_child(Switch(attrs, self, parser.embedding_app))
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
            text = '{{%s|%s}}\n\n'% (mapping, \
                    escape_equals_sign(ElementBase.get_all(self)))
        else:
            text = ElementBase.get_all(self)

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
            self.parse_child(Section(attrs, self))
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
    def __init__(self, attrs, parent, app):
        ElementBase.__init__(self, 'switchinline', parent)
        self.switch = attrs['select']
        self.embedding_app = app

    def start_element(self, parser, name, attrs):
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
                default = ''
                for i in self.objects:
                    appls = {'BASIC':'Basic', 'CALC':'Calc', \
                             'CHART':'Chart', 'DRAW':'Draw', \
                             'IMAGE':'Draw', 'IMPRESS': 'Impress', \
                             'MATH':'Math', 'WRITER':'Writer', \
                             'OFFICE':'', 'default':''}
                    try:
                        app = appls[i.case]
                        all = i.get_all()
                        if all == '':
                            pass
                        elif app == '':
                            default = all
                        else:
                            text = text + '{{WhenIn%s|%s}}'% (app, escape_equals_sign(all))
                    except:
                        sys.stderr.write('Unhandled "%s" case in "appl" switchinline.\n'% \
                                i.case)

                if text == '':
                    text = default
                elif default != '':
                    text = text + '{{WhenDefault|%s}}'% escape_equals_sign(default)

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
            self.parse_child(Bookmark(attrs, self, 'div', parser))
        elif name == 'comment':
            self.parse_child(Comment(attrs, self))
        elif name == 'embed' or name == 'embedvar':
            if parser.follow_embed:
                (fname, id) = href_to_fname_id(attrs['href'])
                self.embed_href(parser, fname, id)
        elif name == 'list':
            self.parse_child(List(attrs, self))
        elif name == 'paragraph':
            parser.parse_paragraph(attrs, self)
        elif name == 'section':
            self.parse_child(Section(attrs, self))
        elif name == 'table':
            self.parse_child(Table(attrs, self))
        else:
            self.unhandled_element(parser, name)

class Switch(SwitchInline):
    def __init__(self, attrs, parent, app):
        SwitchInline.__init__(self, attrs, parent, app)
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
                   },
             'templ':{'input': False,
                      'keycode': True,
                      'literal': False,
                      'menuitem': True,
                      'productname': False
                     }}

    def __init__(self, attrs, parent):
        ElementBase.__init__(self, 'item', parent)

        self.type = attrs['type']
        self.text = ''

    def char_data(self, parser, data):
        self.text = self.text + data

    def get_all(self):
        try:
            text = ''
            if self.replace_type['templ'][self.type]:
                text = escape_equals_sign(replace_text(self.text))
            else:
                text = replace_text(self.text)
            return self.replace_type['start'][self.type] + \
                   text + \
                   self.replace_type['end'][self.type]
        except:
            sys.stderr.write('Unhandled item type "%s".\n'% self.type)

        return replace_text(self.text)


class Paragraph(ElementBase):
    def __init__(self, attrs, parent):
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
            self.level = int(attrs['level'])
        except:
            self.level = 0

        self.is_first = (len(self.parent.objects) == 0)
        self.localized_objects = []

    def start_element(self, parser, name, attrs):
        if name == 'ahelp':
            # TODO extended tips are ignored for now, just the text is used
            # verbatim
            pass
        elif name == 'br':
            self.parse_child(Br(attrs, self))
        elif name == 'comment':
            self.parse_child(Comment(attrs, self))
        elif name == 'emph':
            self.parse_child(Emph(attrs, self))
        elif name == 'embedvar':
            if parser.follow_embed:
                (fname, id) = href_to_fname_id(attrs['href'])
                self.embed_href(parser, fname, id)
        elif name == 'help-id-missing':
            self.parse_child(HelpIdMissing(attrs, self))
        elif name == 'image':
            self.parse_child(Image(attrs, self))
        elif name == 'item':
            self.parse_child(Item(attrs, self))
        elif name == 'link':
            self.parse_child(Link(attrs, self))
        elif name == 'switchinline':
            self.parse_child(SwitchInline(attrs, self, parser.embedding_app))
        elif name == 'variable':
            self.parse_child(Variable(attrs, self))
        else:
            self.unhandled_element(parser, name)

    def end_element(self, parser, name):
        ElementBase.end_element(self, parser, name)

    def char_data(self, parser, data):
        if self.role == 'paragraph' or self.role == 'heading' or \
                self.role == 'listitem' or self.role == 'variable':
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
        elif len(data):
            self.objects.append(Text(data))

    def get_all(self):
        # Localization objects present, drop the other objects
        if len(self.localized_objects):
            self.objects = self.localized_objects

        role = self.role
        if role == 'heading':
            if self.level <= 0:
                sys.stderr.write('Heading, but the level is %d.\n'% self.level)
            elif self.level < 6:
                role = 'heading%d'% self.level
            else:
                role = 'heading6'

        # if we are not the first para in the table, we need special handling
        if not self.is_first and role.find('table') == 0:
            if role == 'tablecontentcode':
                role = 'tablenextparacode'
            else:
                role = 'tablenextpara'

        # prepend the markup according to the role
        text = ''
        if len(self.objects) > 0:
            try:
                text = text + replace_paragraph_role['start'][role]
            except:
                sys.stderr.write( "Unknown paragraph role start: " + role + "\n" )

        # the text itself
        children = ElementBase.get_all(self)
        if self.role != 'emph':
            children = children.strip()

        if replace_paragraph_role['templ'][role]:
            text = text + escape_equals_sign(children)
        else:
            text = text + children

        # append the markup according to the role
        if len(self.objects) > 0:
            try:
                text = text + replace_paragraph_role['end'][role]
            except:
                sys.stderr.write( "Unknown paragraph role end: " + role + "\n" )

        return text

class Variable(Paragraph):
    def __init__(self, attrs, parent):
        Paragraph.__init__(self, attrs, parent)
        self.name = 'variable'
        self.role = 'variable'
        self.id = attrs['id']

    def get_variable(self, id):
        if id == self.id:
            return self
        return None

class CaseInline(Paragraph):
    def __init__(self, attrs, parent, is_default):
        Paragraph.__init__(self, attrs, parent)

        self.role = 'null'
        if is_default:
            self.name = 'defaultinline'
            self.case = 'default'
        else:
            self.name = 'caseinline'
            self.case = attrs['select']

class Emph(Paragraph):
    def __init__(self, attrs, parent):
        Paragraph.__init__(self, attrs, parent)
        self.name = 'emph'
        self.role = 'emph'

    def get_all(self):
        text = Paragraph.get_all(self)
        if len(text):
            return "'''" + text + "'''"
        return ''

class ListItemParagraph(Paragraph):
    def __init__(self, attrs, parent):
        Paragraph.__init__(self, attrs, parent)
        self.role = 'listitem'

class TableContentParagraph(Paragraph):
    def __init__(self, attrs, parent):
        Paragraph.__init__(self, attrs, parent)
        if self.role != 'tablehead' and self.role != 'tablecontent':
            if self.role == 'code':
                self.role = 'tablecontentcode'
            else:
                self.role = 'tablecontent'

class XhpParser:
    def __init__(self, filename, follow_embed, embedding_app, wiki_page_name):
        self.head_obj = XhpFile()
        self.filename = filename
        self.follow_embed = follow_embed
        self.wiki_page_name = wiki_page_name

        # we want to ignore the 1st level="1" heading, because in most of the
        # cases, it is the only level="1" heading in the file, and it is the
        # same as the page title
        self.ignore_heading = True

        self.current_app = ''
        self.current_app_raw = ''
        for i in [['sbasic', 'BASIC'], ['scalc', 'CALC'], \
                  ['sdatabase', 'DATABASE'], ['sdraw', 'DRAW'], \
                  ['schart', 'CHART'], ['simpress', 'IMPRESS'], \
                  ['smath', 'MATH'], ['swriter', 'WRITER']]:
            if filename.find('/%s/'% i[0]) >= 0:
                self.current_app_raw = i[0]
                self.current_app = i[1]
                break

        if embedding_app != '':
            self.embedding_app = embedding_app
        else:
            self.embedding_app = self.current_app

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

    def parse_paragraph(self, attrs, obj):
        ignore_this = False
        try:
            if attrs['role'] == 'heading' and int(attrs['level']) == 1 \
                    and self.ignore_heading and self.follow_embed:
                self.ignore_heading = False
                ignore_this = True
        except:
            pass
        if ignore_this:
            obj.parse_child(Ignore(attrs, obj, 'paragraph'))
        else:
            obj.parse_child(Paragraph(attrs, obj))

def loadallfiles(filename):
    global titles
    file = codecs.open(filename, "r", "utf-8")
    for line in file:
        title = line.split(";", 2)
        titles.append(title)
    file.close()

class WikiConverter(Thread):
    def __init__(self, inputfile, wiki_page_name, outputfile):
        Thread.__init__(self)
        self.inputfile = inputfile
        self.wiki_page_name = wiki_page_name
        self.outputfile = outputfile

    def run(self):
        parser = XhpParser(self.inputfile, True, '', self.wiki_page_name)
        file = codecs.open(self.outputfile, "wb", "utf-8")
        file.write(parser.get_all())
        file.close()

def write_link(r, target):
    fname = 'wiki/%s'% r
    try:
        file = open(fname, "w")
        file.write('#REDIRECT [[%s]]\n'% target)
        file.close()
    except:
        sys.stderr.write('Unable to write "%s".\n'%'wiki/%s'% fname)

def write_redirects():
    print 'Generating the redirects...'
    written = {}
    # in the first pass, immediately writte the links that are embedded, so that
    # we can always point to that source versions
    for redir in redirects:
        app = redir[0]
        redirect = redir[1]
        target = redir[2]
        authoritative = redir[3]
    
        if app != '':
            r = '%s/%s'% (app, redirect)
            if authoritative:
                write_link(r, target)
                written[r] = True
            else:
                try:
                    written[r]
                except:
                    written[r] = False
    
    # in the second pass, output the wiki links
    for redir in redirects:
        app = redir[0]
        redirect = redir[1]
        target = redir[2]
    
        if app == '':
            for i in ['swriter', 'scalc', 'simpress', 'sdraw', 'smath', \
                      'schart', 'sbasic', 'sdatabase']:
                write_link('%s/%s'% (i, redirect), target)
        else:
            r = '%s/%s'% (app, redirect)
            if not written[r]:
                write_link(r, target)

# Main Function
def convert(generate_redirects, localizations):
    print "Generating the wiki itself..."
    load_hid_lst()
    loadallfiles("alltitles.csv")

    if len(localizations) > 1:
        load_localization_data(localizations[1])

    for title in titles:
        while threading.active_count() > max_threads:
            time.sleep(0.001)
    
        outfile = ""
        infile  = ""
        if len(title) > 1:
            outfile = "wiki/"+title[1].strip()
            infile  = title[0].strip()
            try:
                file = open(outfile,"r")
            except:
                try:
                    wiki = WikiConverter(infile,title[1].strip(),outfile)
                    wiki.start()
                    continue
                except:
                    print 'Failed to convert "%s" into "%s".\n'% \
                            (title[1].strip(), outfile)
            print "Warning: Skipping: "+infile+" > "+outfile
            file.close()
    
    # wait for everyone to finish
    while threading.active_count() > 1:
        time.sleep(0.001)

    # set of the images used here
    print 'Generating "images.txt", the list of used images...'
    file = open('images.txt', "w")
    for image in images:
        file.write('%s\n'% image)
    file.close()

    # generate the redirects
    if generate_redirects:
        write_redirects()

# vim:set shiftwidth=4 softtabstop=4 expandtab:
