#!/usr/bin/env python3
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# This script is used to generate the convertfilters.xhp file located
# in helpcontent2/source/text/shared/guide.
#
# Run this script followed by the path of instdir/share/registry/
# i.e.: ./convertfilters.py /path/to/source/core/instdir/share/registry
#
# Requires Python 3.6 or greater.

import os
import sys
import random
import time
from math import floor
from lxml import etree

output_file_path = os.path.join(os.path.dirname(sys.argv[0]), "convertfilters.xhp")
try:
    registry_dir = sys.argv[1]
except IndexError:
    print("Usage: ./convertfilters.py /path/to/source/core/instdir/share/registry")
    sys.exit(1)

if not os.path.exists(registry_dir):
    print(f"{registry_dir} does not exist. Make sure you have built the core repo before running this script")
    sys.exit(1)

modules = ["writer.xcd","calc.xcd","impress.xcd","draw.xcd","math.xcd","base.xcd","graphicfilter.xcd"]

def gen_id(apiname):
    '''This function accepts module name and an API Name of the filter, and then generate
    a unique ID. API Names are used since they are unique within the page.

    Do not use random numbers or sequence-count numbers here since it will cause all words to be "fuzzy" in PO files
    when the xhp file is regenerated.
    '''
    apiname = apiname.replace(" ", "_")
    apiname = apiname.replace("(", "_")
    apiname = apiname.replace(")", "_")
    apiname = apiname.replace("/", "_")

    return apiname

output = '''<?xml version="1.0" encoding="UTF-8"?>
<helpdocument version="1.0">
<!--
    * This file is part of the LibreOffice project.
    *
    * This Source Code Form is subject to the terms of the Mozilla Public
    * License, v. 2.0. If a copy of the MPL was not distributed with this
    * file, You can obtain one at http://mozilla.org/MPL/2.0/.
    *
-->
<meta>
    <topic id="convertfilters" indexer="include" status="PUBLISH">
        <title id="tit" xml-lang="en-US">File Conversion Filters Tables</title>
        <filename>/text/shared/guide/convertfilters.xhp</filename>
    </topic>
</meta>
<body>
<section id="convertfilters01">
    <bookmark xml-lang="en-US" branch="index" id="bm_id541554406270299">
        <bookmark_value>filters;document conversion</bookmark_value>
        <bookmark_value>document conversion;filters</bookmark_value>
        <bookmark_value>convert-to;filters</bookmark_value>
        <bookmark_value>command line document conversion;filters</bookmark_value>
        <bookmark_value>module file filters</bookmark_value>
    </bookmark>
    <h1 id="hd_id771554399002497">
        <variable id="convertfilters_h1"><link href="text/shared/guide/convertfilters.xhp" name="conversion filter names">File Conversion Filter Names</link></variable>
    </h1>
    <paragraph id="par_id581554399002498" role="paragraph" xml-lang="en-US">
        <variable id="variable name">
            <ahelp hid=".">Tables with filter names for <link href="text/shared/guide/start_parameters.xhp" name="commandline">command line</link> document conversion.</ahelp>
        </variable>
    </paragraph>
</section>
<h2 id="hd_id531633524464103">Usage</h2>
<paragraph role="paragraph" id="par_id801633524474460">Filter names are used when importing and exporting files in alien formats and converting files formats through the <link href="text/shared/guide/start_parameters.xhp" name="commandline">command line</link>.</paragraph>
<paragraph role="paragraph" id="par_id314959p" localize="false" xml-lang="en-US"><emph>soffice --convert-to OutputFileExtension[:OutputFilterName[:OutputFilterParams[,param]]] [--outdir output_dir]</emph></paragraph>
<embed href="text/shared/guide/start_parameters.xhp#convertto"/>
<paragraph role="tablecontent" id="par_id314959o" localize="false" xml-lang="en-US"><emph>soffice --infilter=&quot;InputFilterName[:InputFilterParams[,param]]&quot;</emph></paragraph>
<paragraph role="paragraph" id="par_id501550934647297" localize="false"><input>--infilter="Text (encoded):UTF8,LF,Liberation Mono,en-US"</input>.</paragraph>
'''

output += '''
<paragraph role="paragraph" id="par_id00tablehead">
    <ahelp hid="." visibility="hidden">
        <variable visibility="hidden" id="filtername">Filter Name</variable>
        <variable visibility="hidden" id="apiname">API Name</variable>
        <variable visibility="hidden" id="mediatype">Media Type (Extension)</variable>
    </ahelp>
</paragraph>
'''

for module in modules:
    print("\n-------" + module + "----------")
    module_path = os.path.join(registry_dir, module)
    tree = etree.parse(module_path)
    namespaces = tree.getroot().nsmap
    filternodes = tree.findall(
        'oor:component-data[@oor:name="Filter"]/node',
        namespaces)[-1]
    filters = []

    for filter_node in filternodes:
        uiname = str(filter_node.findtext('prop[@oor:name="UIName"]/value', namespaces=namespaces))
        apiname = filter_node.attrib['{' + namespaces['oor'] + '}name']

        filter_type = str(filter_node.findtext('prop[@oor:name="Type"]/value', namespaces=namespaces))
        type_node = tree.find(
            f'oor:component-data[@oor:name="Types"]/node/node[@oor:name="{filter_type}"]',
            namespaces)
        try:
            mediatype = str(type_node.findtext('prop[@oor:name="MediaType"]/value', namespaces=namespaces))
            extensions = str(type_node.findtext('prop[@oor:name="Extensions"]/value', namespaces=namespaces))
        except AttributeError:
            continue

        filter_data = [uiname, apiname, mediatype, extensions]
        print(filter_data)
        filters.append(filter_data)

    output += f'\
<section id="filters{module[:-4]}">\n\
    <bookmark xml-lang="en-US" branch="index" id="bm_000{module[:-4]}">\n\
        <bookmark_value>command line document conversion; filters for {module[:-4].upper()}</bookmark_value>\n\
    </bookmark>\n\
    <h2 id="hd_000{module[:-4]}">Filters for {module[:-4].upper()}</h2>\n\
    <table id="filternames_tbl_{module[:-4]}">\n\
        <tablerow>\n\
            <tablecell>\n\
                <paragraph role="tablehead" localize="false" id="hd_111{module[:-4]}">\n\
                    <embedvar href="text/shared/guide/convertfilters.xhp#filtername" markup="ignore"/>\n\
                </paragraph>\n\
            </tablecell>\n\
            <tablecell>\n\
                <paragraph role="tablehead" localize="false" id="hd_apiname_{module[:-4]}">\n\
                    <embedvar href="text/shared/guide/convertfilters.xhp#apiname" markup="ignore"/>\n\
                </paragraph>\n\
            </tablecell>\n\
            <tablecell>\n\
                <paragraph role="tablehead" localize="false" id="hd_222{module[:-4]}">\n\
                    <embedvar href="text/shared/guide/convertfilters.xhp#mediatype" markup="ignore"/>\n\
                </paragraph>\n\
            </tablecell>\n\
        </tablerow>\n\
'

    for item in filters:
        uid = gen_id(item[1])
        output += f'\
        <tablerow>\n\
            <tablecell>\n\
                <paragraph role="table_font_small paragraph" id="FilterName_{uid}">{item[0]}</paragraph>\n\
            </tablecell>\n\
            <tablecell>\n\
                <paragraph role="table_font_small paragraph" id="APIName_{uid}" localize="false">&quot;{item[1]}&quot;</paragraph>\n\
            </tablecell>\n\
            <tablecell>\n\
                <paragraph role="table_font_small paragraph" id="MediaType_{uid}" localize="false">{item[2]} ({item[3]})</paragraph>\n\
            </tablecell>\n\
        </tablerow>\n'

    output += f'\
    </table>\n\
</section>\n'

output += f'\
</body>\n\
</helpdocument>'

with open(output_file_path, "w") as f:
    f.write(output)

print(f'\nDone. File saved at: {output_file_path}.')
print(f'Please move this file into helpcontent2/source/text/shared/guide.')
