#!/usr/bin/env python

import sys, os, getopt, signal

sys.path.append(sys.path[0]+"/to-wiki")
import wikiconv2

# FIXME do proper modules from getalltitles & wikiconv2
# [so far this is in fact just a shell thing]

def usage():
    print '''
help-to-wiki.py [params] [path to l10n]

Converts .xhp files into a wiki

-h, --help            - this help
-n, --no-translations - generate only English pages
-r, --redirects       - generate also redirect pages

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

# Langs to handle
langs = ['', 'ca', 'cs', 'da', 'de', 'es', 'fr', 'hu', \
         'it', 'ja', 'ko', 'nl', 'pl', 'pt', 'pt-BR', 'ru', \
         'sl', 'sv', 'vi', 'zh-CN', 'zh-TW' ]

# Argument handling
try:
    opts, args = getopt.getopt(sys.argv[1:], 'hnr', ['help', 'no-translations', 'redirects'])
except getopt.GetoptError:
    usage()
    sys.exit(1)

generate_redirects = False
for opt, arg in opts:
    if opt in ('-h', '--help'):
        usage()
        sys.exit()
    elif opt in ('-n', '--no-translations'):
        langs = ['']
    elif opt in ('-r', '--redirects'):
        generate_redirects = True

def signal_handler(signal, frame):
    sys.stderr.write( 'Exiting...\n' )
    sys.exit(1)

# Do the work
signal.signal(signal.SIGINT, signal_handler)

create_wiki_dirs()

print "Generating the titles..."
os.system( "python to-wiki/getalltitles.py source/text > alltitles.csv" )

try:
    sdf_path = args[0]
except:
    sdf_path = '../../l10n/l10n/source'
    sys.stderr.write('Path to the .sdf files not provided, using "%s"\n'% sdf_path)

# do the work
for lang in langs:
    wikiconv2.convert(generate_redirects, lang, '%s/%s/localize.sdf'% (sdf_path, lang))

# vim:set shiftwidth=4 softtabstop=4 expandtab:
