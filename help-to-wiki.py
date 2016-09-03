#!/usr/bin/env python
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

import sys, os, getopt, signal

sys.path.append(sys.path[0]+"/to-wiki")
import wikiconv2
import getalltitles

def usage():
    print '''
help-to-wiki.py [params] [path to l10n]

Converts .xhp files into a wiki

-h, --help            - this help
-n, --no-translations - generate only English pages
-r, --redirects       - generate also redirect pages
-t, --title-savefile  - save the title file

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

# Langs to handle (fully translated or otherwise important)
langs = ['', 'ast', 'bg', 'bn', 'bn-IN', 'ca', 'cs', 'da', 'de', \
         'el', 'es', 'eu', 'fi', 'fr', 'hu', 'it', 'ja', 'km', \
         'ko', 'nb', 'nl', 'om', 'pl', 'pt', 'pt-BR', 'ru', \
         'sl', 'sv', 'tr', 'vi', 'zh-CN', 'zh-TW' ]

# Argument handling
try:
    opts, args = getopt.getopt(sys.argv[1:], 'hnrt', ['help', 'no-translations', 'redirects', 'title-savefile'])
except getopt.GetoptError:
    usage()
    sys.exit(1)

generate_redirects = False
title_savefile = False
for opt, arg in opts:
    if opt in ('-h', '--help'):
        usage()
        sys.exit()
    elif opt in ('-n', '--no-translations'):
        langs = ['']
    elif opt in ('-r', '--redirects'):
        generate_redirects = True
    elif opt in ('-t', '--title-savefile'):
        title_savefile = True

def signal_handler(signal, frame):
    sys.stderr.write( 'Exiting...\n' )
    sys.exit(1)

# Do the work
signal.signal(signal.SIGINT, signal_handler)

create_wiki_dirs()

print "Generating the titles..."
title_data = getalltitles.gettitles("source/text")
if title_savefile:
    with open ('alltitles.csv', 'w') as f:
        for d in title_data:
            f.write('%s;%s;%s\n' % (d[0], d[1], d[2]))

try:
    po_path = args[0]
except:
    po_path = '../translations/source'
    sys.stderr.write('Path to the .po files not provided, using "%s"\n'% po_path)

# do the work
for lang in langs:
    wikiconv2.convert(title_data, generate_redirects, lang, '%s/%s/helpcontent2/source'% (po_path, lang))

# vim:set shiftwidth=4 softtabstop=4 expandtab:
