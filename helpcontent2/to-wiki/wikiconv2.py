#!/usr/bin/env python

import sys, signal
import xml.parsers.expat

root="source/"

titles = [[]]

start_eles = [
        ["emph","'''"]
        ]

end_eles = [
        ["emph","'''"]
        ]

replace_text_list = [
        ["$[officename]","{{ProductName}}"],
        ["%PRODUCTNAME","{{ProductName}}"]
        ]

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
        if name == 'section':
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
        if name == 'embed':
            link=attrs['href'].replace('"','')
            fname=link
            section=""
            if link.find("#") >= 0:
                fname = link[:link.find("#")]
                section = link[link.find("#")+1:]
            #print "Parsing: "+fname+" Section: "+section
            if fname.find("border") >= 0 or \
               fname.find("background") >= 0:
                print "Ignoring: "+fname
            else:
                self.child_parsing = True
                child_xml = cxml(section)
                child_xml.depth = self.depth +1
                self.objects.append(child_xml)
                parsexhp(root+fname)
                self.child_parsing = False

        if name == 'table':
            child = ctable(attrs, self)
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
            #try:
            #    raise self.objects[len(self.objects)-1]
            #except cxml:
            return self.objects[len(self.objects)-1].get_curobj()
            #except:
            #    return self.objects[len(self.objects)-1]
        else:
            return self

    def print_all(self):
        for i in self.objects:
            i.print_all()


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

    def print_all(self):
        print self.get_all()

    def get_curobj(self):
        return self

class ctext:
    def __init__(self, text):
        self.wikitext = replace_text(text)

    def print_all(self):
        print self.wikitext

class ctabcell:
    def __init__(self, attrs, parent):
        # TODO: colspan rowspan
        self.objects = []
        self.child_parsing = False
        self.parent = parent
        self.header = False
        pass

    def start_element(self, name, attrs):
        if name == 'paragraph':
            if attrs['role'] == 'tablehead':
                self.header = True
            para=cparagraph(attrs, self, '', 0)
            self.child_parsing=True
            self.objects.append(para)
        pass

    def end_element(self, name):
        if name == 'tablecell':
            self.parent.child_parsing = False
        pass

    def char_data(self, data):
        pass

    def print_all(self):
        for i in self.objects:
            i.print_all()

    def get_all(self):
        text = ""
        for i in self.objects:
            text = text + i.get_all()
        return text

    def get_curobj(self):
        if self.child_parsing:
            return self.objects[len(self.objects)-1].get_curobj()
        return self


class ctable:
    def __init__(self, attrs, parent):
        # TODO/Check: Might Require filtering too...
        try:
            self.tableid    = attrs['id']
        except:
            self.tableid    = 0
        self.header         = []
        self.crow           = []
        self.content        = [[]]
        self.child_parsing  = False
        self.child          = None
        self.parent         = parent

    def check_add_cell(self):
        if self.child:
            self.crow.append(self.child)
            self.child = None

    def check_add_row(self):
        if len(self.crow):
            if self.crow[0].header:
                self.header = self.crow
            else:
                self.content.append(self.crow)
            self.crow = []

    def start_element(self, name, attrs):
        if name == 'tablecell':
            self.check_add_cell()
            self.child = ctabcell(attrs, self)
            self.child_parsing = True
        if name == 'tablerow':
            self.check_add_cell()
            self.check_add_row()

    def end_element(self, name):
        if name == 'table':
            # the following checks may be unnecessary
            self.check_add_cell()
            self.check_add_row()
            self.parent.child_parsing = False

    def char_data(self, data):
        pass

    def get_all(self):
        text = '{| border="1"' # + ' align="left"'
        if len(self.header):
            # text = text + "\n|+ caption"
            text = text +"\n|-"
            for i in self.header:
                text = text + '\n! scope="col" | ' + i.get_all()
        for i in self.content:
            text = text + "\n|-"
            for j in i:
                text = text + "\n| "+j.get_all()
        text = text + "\n|}"
        return text

    def print_all(self):
        print self.get_all().encode('ascii','replace')

    def get_curobj(self):
        if self.child_parsing:
            return self.child.get_curobj()
        return self

class clink:
    def __init__(self, attrs, parent):
        self.link       = attrs['href']
        try:
            self.lname      = attrs['name']
        except:
            self.lname      = self.link[self.link.rfind("/")+1:]
        # Override lname
        self.lname = get_link_filename(self.link, self.lname)
        self.wikitext   = ""
        self.parent     = parent

    def start_element(self, name, attrs):
        pass

    def end_element(self, name):
        if name == "link":
            self.parent.child_parsing = False

    def char_data(self, data):
        self.wikitext = self.wikitext + data

    def get_all(self):
        if self.link.find("http") >= 0:
            text = "["+self.link+" "+self.wikitext+"]"
        else:
            text = "[["+self.lname+"|"+self.wikitext+"]]"
        if self.parent.heading:
            text = heading(self.parent.depth) + " " + text + " "+heading(self.parent.depth)
        text = replace_text(text)
        return text

    def print_all(self):
        print self.get_all()

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

    def print_all(self):
        print self.wikitext

class cparagraph:
    def __init__(self, attrs, parent, sectionid, depth):
        self.child_parsing = False
        self.heading=False
        try:
            if attrs['role'] == "heading":
                self.heading = True
        except:
            pass

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

    def __del__(self):
        pass

    def start_element(self, name, attrs):
        if name == 'variable':
            if attrs['id'] == self.filter_section:
                self.parser_state=True
        if name == 'paragraph':
            if not self.parser_state:
                child = cparagraph(attrs, self, self.filter_section, self.depth+1)
            else:
                child = cparagraph(attrs, self, "", self.depth+1)
            self.child_parsing = True
            self.objects.append(child)

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


        global start_eles
        for n in start_eles:
            if n[0] == name:
                #self.wikitext=self.wikitext+n[1]
                self.objects.append(ctext(n[1]))
            break

    def end_element(self, name):
        if name == 'paragraph':
            self.parent.child_parsing = False
        if not self.parser_state:
            return
        if self.filter_section != "" and name == 'varable':
            self.parser_state = False

        global end_eles
        for n in end_eles:
            if n[0] == name:
                #self.wikitext=self.wikitext+n[1]
                self.objects.append(ctext(n[1]))
            break

    def char_data(self, data):
        if not self.parser_state or not len(data.strip()):
            return
        self.objects.append(ctext(data))
        #self.wikitext = self.wikitext + text

    def print_all(self):
        #if self.wikitext != "":
        #    print self.wikitext
        text = self.get_all()
        if len(text):
            print text.encode('ascii','replace')
        return

        # mark this as the heading
        if self.objects.len() > 0 and self.heading:
            print heading(self.depth)

        for i in self.objects:
            try:
                raise i
            except ctext:
                self.wikitext = self.wikitext + i.wikitext
            except clink:
                self.wikitext = self.wikitext + i.get_all() + " "
            except:
                if len(self.wikitext):
                    print self.wikitext
                    self.wikitext=""
                i.print_all()
        if len(self.wikitext):
            print self.wikitext

        # end of the heading mark
        if self.objects.len() > 0 and self.heading:
            print heading(self.depth)

    def get_all(self):
        for i in self.objects:
            try:
                raise i
            except ctext:
                self.wikitext = self.wikitext + i.wikitext
            except clink:
                self.wikitext = self.wikitext + i.get_all() + " "
            except:
                if len(self.wikitext):
                    self.wikitext = self.wikitext + "\n"
                self.wikitext = self.wikitext + "\n" + i.get_all()
        return self.wikitext

    def get_curobj(self):
        if self.child_parsing:
            return self.objects[len(self.objects)-1].get_curobj()
        else:
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
    file=open(filename,"r")
    for line in file:
        title = line.split(";")
        titles.append(title)

def signal_handler(signal, frame):
    sys.snderr.write( "You pressed Ctrl+C!" )
    sys.exit(1)
signal.signal(signal.SIGINT, signal_handler)

if len(sys.argv) < 2:
    print "wikiconv2.py <inputfile.xph>"
    sys.exit(1)

loadallfiles("alltitles.csv")
parsexhp(sys.argv[1])
head_obj.print_all()
