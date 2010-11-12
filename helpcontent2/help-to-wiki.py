#!/usr/bin/env python

import sys, os

header_template = "\n\
// This file is generated using the Wiki Converter \n\
// Please exercise caution while modifying this file directly \n\
#ifndef __BOOKMARKS_H__\n\
#define __BOOKMARKS_H__\n\
\n\
typedef struct WIKI_LINKS_MAP {\n\
    ULONG           id;         // HELP ID\n\
    const char      *link;      // Mapped Wiki Link\n\
} WikiLinksMap;\n\
\n\
static WikiLinksMap aWikiMaps[] = {\n\
"

footer_template = "\
    { 0, \"\" }\n\
};\n\
\n\
#endif\n\
"

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

def create_wiki_header():
    try:
        file = open( "bookmarks.h", "r" )
        file.close()
        sys.stdout.write( "bookmarks.h already exists! Ignoring...\n" )
    except:
        file = open( "bookmarks.h", "w" )
        file.write( header_template )
        file.close()

def create_wiki_footer():
    file = open( "bookmarks.h", "a" )
    file.write( footer_template )
    file.close()

# do the work
create_wiki_dirs()

# create bookmarks.h template
create_wiki_header()

print "Generating the titles..."
os.system( "python to-wiki/getalltitles.py source/text > alltitles.csv" )

print "Generating the wiki itself..."
os.system( "python to-wiki/convall.py source/text" )

# close the bookmarks.h template
create_wiki_footer()
