#!/usr/bin/env python

import sys, os

# FIXME do proper modules from getalltitles & wikiconv2
# [so far this is in fact just a shell thing]

def create_wiki_dirs():
    dirs = [
            "Basic",
            "Calc",
            "Chart",
            "Draw",
            "All",
            "Impress",
            "Math",
            "Writer"
           ]

    try:
        os.mkdir( "wiki" )
    except:
        sys.stdout.write( "wiki already generated - the wiki/ subdir exists\n" )
        sys.exit( 1 )

    for i in dirs:
        try:
            os.mkdir( "wiki/" + i )
        except:
            pass

# do the work
create_wiki_dirs()

os.system( "python to-wiki/getalltitles.py source/text > alltitles.csv" )
os.system( "python to-wiki/convall.py source/text" )
