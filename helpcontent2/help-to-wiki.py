#!/usr/bin/env python

import sys, os, getopt

sys.path.append(sys.path[0]+"/to-wiki")
import wikiconv2

# FIXME do proper modules from getalltitles & wikiconv2
# [so far this is in fact just a shell thing]

def usage():
    print '''
help-to-wiki.py - converts .xhp files into a wiki

-h, --help      - this help
-r, --redirects - generate also redirect pages

Most probably, you want to generate the redirects only once when you initially
populate the wiki, and then only update the ones that broke.\n'''

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

# Argument handling
try:
    opts, args = getopt.getopt(sys.argv[1:], 'hr', ['help', 'redirects'])
except getopt.GetoptError:
    usage()
    sys.exit(1)

generate_redirects = False
for opt, arg in opts:
    if opt in ('-h', '--help'):
        usage()
        sys.exit()
    elif opt in ('-r', '--redirects'):
        generate_redirects = True

# Do the work
create_wiki_dirs()

print "Generating the titles..."
os.system( "python to-wiki/getalltitles.py source/text > alltitles.csv" )

wikiconv2.convert(generate_redirects, args)

# vim:set shiftwidth=4 softtabstop=4 expandtab:
