#!/usr/bin/env python

import os, sys

titles = [[]]
localization = ""

def loadallfiles(filename):
    global titles
    file=open(filename,"r")
    for line in file:
        title = line.split(";", 2)
        titles.append(title)

loadallfiles("alltitles.csv")
if len(sys.argv) > 1:
    localization = sys.argv[1]

for title in titles:
    command = ""
    outfile = ""
    infile  = ""
    if len(title) > 1:
        outfile = "wiki/"+title[1].strip()
        infile  = title[0].strip()
        command = "python to-wiki/wikiconv2.py "+infile+" "+title[1].strip()+" "+localization+" > "+outfile

    try:
        file = open(outfile,"r")
    except:
        #print "Processing: "+infile
        if os.system(command) != 0:
            print "Failed: "+command
            sys.exit(1)
        continue
    print "Warning: Skipping: "+command
    file.close()
    sys.exit(1)
