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
        ['"+"',"plus"],
        ['"*"',"star"],
        ['"-"',"minus"],
        ['"/"',"slash"],
        ['"^"',"cap"],
        [')','_'],
        ['(','_'],
        ['\\','_'],
        ['/','_']
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

def replace_text(text):
    for i in replace_text_list:
        while text.find(i[0]) >= 0:
            text = text.replace(i[0],i[1])
    return text

def start_element(name, attrs):
    global parsing, istitle
    if not parsing:
        return
    if name == 'title':
        istitle=True

def end_element(name):
    global parsing, istitle
    if not parsing:
        return
    if name == 'title':
        parsign = False
        istitle = False

def char_data(data):
    global title, parsing
    if not istitle:
        return
    title = replace_text(data)

def parsexhp(filename):
    global parsing, title
    parsing = True
    file=open(filename,"r")
    p = xml.parsers.expat.ParserCreate()
    p.StartElementHandler = start_element
    p.EndElementHandler = end_element
    p.CharacterDataHandler = char_data
    buf = file.read()
    p.Parse(buf)
    file.close()
    title=get_module(filename)+"/"+title
    title = title.replace(" ","_")
    title = make_unique(title)
    alltitles.append(title)
    print filename+";"+title

if len(sys.argv) < 2:
    print "getalltitles.py <directory>"
    print "e.g. getalltitles.py helcontent2/source/text/scalc"
    sys.exit(1)

pattern = "xhp"

for root, dirs, files in os.walk(sys.argv[1]):
    for i in files:
        if i.find(pattern) >= 0:
            parsexhp(root+"/"+i)
