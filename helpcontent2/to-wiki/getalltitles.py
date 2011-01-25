#!/usr/bin/env python

import sys
import os
import xml.parsers.expat

alltitles=[]

def is_present(title):
    for i in alltitles:
        try:
            if i.strip() == title.strip():
                return True
        except:
            return False
    return False

def make_unique(title):
    n=0
    t = title
    while is_present(t):
        n=n+1
        t = title+"_%d"%(n)
    return t

replace_text_list = [
        ["$[officename]",""], # to fit both LibreOffice and BrOffice
        ["%PRODUCTNAME",""], # to fit both LibreOffice and BrOffice
        ["$PRODUCTNAME",""], # to fit both LibreOffice and BrOffice
        ['"+"',"Plus"],
        ['"*"',"Star"],
        ['"-"',"Minus"],
        ['"/"',"Slash"],
        ['"^"',"Cap"],
        ['#',"No"],
        [')','_'],
        ['(','_'],
        [']','_'],
        ['[','_'],
        ['\\','_'],
        ['/','_'],
        ['&',"and"],
        [';','_']
        ]

replace_readable_list = [
        ["$[officename]","{{ProductName}}"],
        ["%PRODUCTNAME","{{ProductName}}"],
        ["$PRODUCTNAME","{{ProductName}}"]
        ]

modules_list = [
        ["sbasic","Basic"],
        ["scalc","Calc"],
        ["schart","Chart"],
        ["sdraw","Draw"],
        ["simpress","Impress"],
        ["smath","Math"],
        ["swriter","Writer"],
        ["shared","Common"]
        ]

def get_module(text):
    for i in modules_list:
        if text.find('/' + i[0] + '/') >=0:
            return i[1]
    return ""

def replace_text(text, replace_list):
    for i in replace_list:
        if text.find(i[0]) >= 0:
            text = text.replace(i[0],i[1])
    return text

def wiki_text(text):
    t = replace_text(text, replace_text_list)
    if t == '':
        t = 'LibreOffice' # hardcoded fallback
    return t.strip()

def readable_text(text):
    return replace_text(text, replace_readable_list)

class TitleParser:
    title = ''
    is_title = False

    def start_element(self, name, attrs):
        if name == 'title':
            self.is_title = True

    def end_element(self, name):
        if name == 'title':
            self.is_title = False

    def char_data(self, data):
        if self.is_title:
            self.title = self.title + data

    def get_title(self):
        return self.title.strip()

def parsexhp(filename):
    module = get_module(filename)
    if module == '':
        return

    parsing = True
    file=open(filename,"r")
    p = xml.parsers.expat.ParserCreate()
    tp = TitleParser()
    p.StartElementHandler = tp.start_element
    p.EndElementHandler = tp.end_element
    p.CharacterDataHandler = tp.char_data
    buf = file.read()
    try:
        p.Parse(buf)
    except:
        sys.stderr.write('Cannot parse %s, skipping it\n'% filename)
        file.close()
        return
    file.close()
    title = tp.get_title()
    if len(title) > 0:
        readable_title = readable_text(title)
        title = module + '/' + wiki_text(title)
        title = title.replace(' ', '_')
        title = title.replace('___', '_')
        title = title.replace('__', '_')
        title = title.strip('_')
        title = make_unique(title)
        alltitles.append(title)
        print filename + ';' + title + ';' + readable_title

if len(sys.argv) < 2:
    print "getalltitles.py <directory>"
    print "e.g. getalltitles.py source/text/scalc"
    sys.exit(1)

pattern = "xhp"

for root, dirs, files in os.walk(sys.argv[1]):
    for i in files:
        if i.find(pattern) >= 0:
            parsexhp(root+"/"+i)

# vim:set shiftwidth=4 softtabstop=4 expandtab:
