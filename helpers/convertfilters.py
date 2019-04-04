#!/usr/bin/env python3
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Run this in instdir/share/registry/
# Requires Python 3.6 or greater.

import sys
import random
import time
from math import floor
from lxml import etree

modules = ["writer.xcd","calc.xcd","impress.xcd","draw.xcd","math.xcd","base.xcd","graphicfilter.xcd"]

def rdm(prefix):
    return prefix + "_id" + str(floor(random.random() * 1000) + 1) + str(int(time.time()))

output = ""
output += f'<?xml version="1.0" encoding="UTF-8"?>\n'
output += f'<helpdocument version="1.0">\n'
output += f'<!--\n'
output += f'    * This file is part of the LibreOffice project.\n    *\n'
output += f'    * This Source Code Form is subject to the terms of the Mozilla Public\n'
output += f'    * License, v. 2.0. If a copy of the MPL was not distributed with this\n'
output += f'    * file, You can obtain one at http://mozilla.org/MPL/2.0/.\n'
output += f'    *\n'
output += f'    -->\n'
output += f'<meta>\n'
output += f'<topic id="convertfilters" indexer="include" status="PUBLISH">\n'
output += f'<title id="tit" xml-lang="en-US">File Conversion Filters Tables</title>\n'
output += f'<filename>/text/shared/guide/convertfilterstable.xhp</filename>\n'
output += f'</topic>\n</meta>\n<body>\n'
output += f'<section id="convertfilters01">\n'
output += f'<bookmark xml-lang="en-US" branch="index" id="bm_id541554406270299">\n'
output += f'<bookmark_value>filters;document conversion</bookmark_value>\n'
output += f'<bookmark_value>document conversion;filters</bookmark_value>\n'
output += f'<bookmark_value>convert-to;filters</bookmark_value>\n'
output += f'<bookmark_value>command line document conversion;filters</bookmark_value>\n'
output += f'<bookmark_value>module file filters</bookmark_value>\n'
output += f'</bookmark>\n'
output += f'<h1 id="hd_id771554399002497"><link href="text/shared/guide/convertfilters.xhp" name="conversion filter names">File Conversion Filter Names</link></h1>\n'
output += f'<paragraph id="par_id581554399002498" role="paragraph" xml-lang="en-US"><variable id="variable name"><ahelp hid=".">Tables with filter names for document conversion.</ahelp></variable></paragraph>\n'
output += f'</section>\n'


for module in modules:
    tree = etree.parse(module)
    namespaces = tree.getroot().nsmap
    typenodes = tree.findall('oor:component-data/node[@oor:name="Types"]/node', namespaces)
    filters = []

    for type in typenodes:
        uiname = str(type.findtext('prop[@oor:name="UIName"]/value', namespaces=namespaces))
        mediatype = str(type.findtext('prop[@oor:name="MediaType"]/value', namespaces=namespaces))
        extensions = str(type.findtext('prop[@oor:name="Extensions"]/value', namespaces=namespaces))
        filters.append([uiname,mediatype,extensions])

    st = sorted(filters, key=lambda x: x[0])
    output += f'<section id="filters{module[:-4]}">\n'
    output += f'<bookmark xml-lang="en-US" branch="index" id="bm_000{module[:-4]}">\n'
    output += f'<bookmark_value>command line document conversion; filters for {module[:-4]}</bookmark_value>\n'
    output += f'</bookmark>\n'
    output += f'<h2 id="hd_000{module[:-4]}">{module[:-4]}</h2>\n'
    output += f'    <table id="{rdm("tbl")}">\n'
    output += '        <tablerow>\n'
    output += '            <tablecell>\n'
    output += f'                <paragraph role="tablehead" id="hd_111{module[:-4]}">'
    output += 'Filter name'
    output += '</paragraph>\n'
    output += '            </tablecell>\n'
    output += '            <tablecell>\n'
    output += f'                <paragraph role="tablehead" id="hd_222{module[:-4]}">'
    output += 'Media type'
    output += '</paragraph>\n'
    output += '            </tablecell>\n'
    output += '            <tablecell>\n'
    output += f'                <paragraph role="tablehead" id="hd_333{module[:-4]}">'
    output += 'Extensions'
    output += '</paragraph>\n'
    output += '            </tablecell>\n'
    output += '        </tablerow>\n'

    for item in st:
        output += '        <tablerow>\n'
        output += '            <tablecell>\n'
        output += f'                <paragraph role="paragraph" id="{rdm("par")}" localize="false">'
        output += f'{item[0]}'
        output += '</paragraph>\n'
        output += '            </tablecell>\n'
        output += '            <tablecell>\n'
        output += f'                <paragraph role="paragraph" id="{rdm("par")}" localize="false">'
        output += f'{item[1]}'
        output += '</paragraph>\n'
        output += '            </tablecell>\n'
        output += '            <tablecell>\n'
        output += f'                <paragraph role="paragraph" id="{rdm("par")}" localize="false">'
        output += f'{item[2]}'
        output += '</paragraph>\n'
        output += '            </tablecell>\n'
        output += '        </tablerow>\n'

    output += '    </table>\n'
    output += '</section>\n'

output += f'</body>\n</helpdocument>'
print(output)
