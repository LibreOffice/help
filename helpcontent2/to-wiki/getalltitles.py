#!/usr/bin/env python

import sys
import os
import xml.parsers.expat

title=""
parsing=True
istitle=False
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
        ["$[officename]","LibreOffice"],
        ["%PRODUCTNAME","LibreOffice"],
        ['"+"',"Plus"],
        ['"*"',"Star"],
        ['"-"',"Minus"],
        ['"/"',"Slash"],
        ['"^"',"Cap"],
        [')','_'],
        ['(','_'],
        ['\\','_'],
        ['/','_'],
        ['&',"and"],
        [';','_']
        ]

replace_readable_list = [
        ["$[officename]","{{ProductName}}"],
        ["%PRODUCTNAME","{{ProductName}}"]
        ]

modules_list = [
        ["sbasic","Basic"],
        ["scalc","Calc"],
        ["schart","Chart"],
        ["sdraw","Draw"],
        ["shared","All"],
        ["simpress","Impress"],
        ["smath","Math"],
        ["swriter","Writer"]
        ]

def get_module(text):
    for i in modules_list:
        if text.find(i[0]) >=0:
            return i[1]
    return ""

def replace_text(text, replace_list):
    for i in replace_list:
        if text.find(i[0]) >= 0:
            text = text.replace(i[0],i[1])
    return text

def wiki_text(text):
    return replace_text(text, replace_text_list)

def readable_text(text):
    return replace_text(text, replace_readable_list)

def start_element(name, attrs):
    global parsing, istitle, title
    if not parsing:
        return
    if name == 'title':
        istitle=True
        title = ""

def end_element(name):
    global parsing, istitle
    if not parsing:
        return
    if name == 'title':
        parsing = False
        istitle = False

def char_data(data):
    global title, parsing
    if not istitle:
        return
    title = title + data

def parsexhp(filename):
    global parsing, title
    parsing = True
    file=open(filename,"r")
    p = xml.parsers.expat.ParserCreate()
    p.StartElementHandler = start_element
    p.EndElementHandler = end_element
    p.CharacterDataHandler = char_data
    buf = file.read()
    try:
        p.Parse(buf)
    except:
        sys.stderr.write('Cannot parse %s, skipping it\n'% filename)
        file.close()
        return
    file.close()
    if len(title):
        readable_title = readable_text(title)
        title = get_module(filename) + "/" + wiki_text(title)
        title = title.replace(" ", "_")
        title = make_unique(title)
        alltitles.append(title)
        print filename + ";" + title + ";" + readable_title

if len(sys.argv) < 2:
    print "getalltitles.py <directory>"
    print "e.g. getalltitles.py helcontent2/source/text/scalc"
    sys.exit(1)

pattern = "xhp"

for root, dirs, files in os.walk(sys.argv[1]):
    for i in files:
        if i.find(pattern) >= 0:
            parsexhp(root+"/"+i)
