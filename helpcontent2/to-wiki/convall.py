#!/usr/bin/env python

import os, sys

titles = [[]]

def loadallfiles(filename):
    global titles
    file=open(filename,"r")
    for line in file:
        title = line.split(";")
        titles.append(title)

loadallfiles("alltitles.csv")

for title in titles:
    command = ""
    outfile = ""
    infile  = ""
    try:
        outfile = "wiki/"+title[1].strip()
        infile  = title[0].strip()
        command = "python wikiconv2.py "+infile+" > "+outfile
    except:
        continue

    try:
        file = open(outfile,"r")
    except:
        print "Processing: "+infile
        if not os.system(command):
        #    print "Failed: "+command
        #    sys.exit(1)
            pass
        continue
    print "Warning: Skipping: "+command
    file.close()
    sys.exit(1)
