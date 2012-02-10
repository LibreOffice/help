#!/usr/bin/env python

import sys, os, getopt, signal

sys.path.append(sys.path[0]+"/to-wiki")
import wikiconv2

# FIXME do proper modules from getalltitles & wikiconv2
# [so far this is in fact just a shell thing]

def usage():
    print '''
help-to-wiki.py - converts .xhp files into a wiki

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
# [16:26:45] <kendy> sophi, timar: Obviously, I am testing with Czech ;-)
# [16:27:05] <timar> kendy: HUngarian :)
# [16:27:25] <kendy> timar: :-)
# [16:27:26] <timar> kendy: Slovenian for Martin
# [16:28:00] <timar> kendy: and German, Italian, French, Spanish (with large user base)
# [16:28:13] <sophi> kendy: catalan
# [16:28:38] <sophi> kendy: also japanese and russian
# [16:29:48] <sophi> kendy: ans I would say vi too, so you have all kind of script/language and good communities behind ;)
langs = ['', 'ca', 'cs', 'de', 'es', 'fr', 'hu', 'it', 'ja', 'pt', 'pt-BR', 'ru', 'sl', 'vi']

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
    sdf_path = '../../translations/unxlngx6.pro/misc/sdf-l10n'
    sys.stderr.write('Path to the .sdf files not provided, using "%s"\n'% sdf_path)

# do the work
for lang in langs:
    wikiconv2.convert(generate_redirects, lang, '%s/%s.sdf'% (sdf_path, lang))

# vim:set shiftwidth=4 softtabstop=4 expandtab:
