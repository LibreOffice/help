#!/usr/bin/env python

import sys, os

# FIXME do proper modules from getalltitles & wikiconv2
# [so far this is in fact just a shell thing]

def create_wiki_dirs():
    dirs = [
            "Common",
            "Basic",
            "Calc",
            "Chart",
            "Draw",
            "Impress",
            "Math",
            "Writer",
            "swriter",
            "scalc",
            "simpress",
            "sdraw",
            "smath",
            "schart",
            "sbasic",
            "sdatabase"
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

print "Generating the titles..."
os.system( "python to-wiki/getalltitles.py source/text > alltitles.csv" )

print "Generating the wiki itself..."
localization = ""
if len(sys.argv) > 1:
    localization = sys.argv[1]
os.system( "python to-wiki/wikiconv2.py "+localization )

# vim:set shiftwidth=4 softtabstop=4 expandtab:
