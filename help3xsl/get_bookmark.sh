#/bin/bash
<!--
 * This file is part of the LibreOffice project.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
-->

stub1='<html><head><link rel="stylesheet" type="text/css" href="/default.css"/></head><body><ul class="indexlink">'
stub2='</ul></body></html>'
ffile=bookmark_calc.html
rm -f $ffile
echo $stub1 > $ffile
find ../source/text/scalc -type f -name "*.xhp" -exec xsltproc get_bookmark.xsl {} + >> $ffile
echo $stub2 >> $ffile

ffile=bookmark_writer.html
rm -f $ffile
echo $stub1 > $ffile
find ../source/text/swriter -type f -name "*.xhp" -exec xsltproc get_bookmark.xsl {} + >> $ffile
echo $stub2 >> $ffile

ffile=bookmark_draw.html
rm -f $ffile
echo $stub1 > $ffile
find ../source/text/sdraw -type f -name "*.xhp" -exec xsltproc get_bookmark.xsl {} + >> $ffile
echo $stub2 >> $ffile

ffile=bookmark_impress.html
rm -f $ffile
echo $stub1 > $ffile
find ../source/text/simpress -type f -name "*.xhp" -exec xsltproc get_bookmark.xsl {} + >> $ffile
echo $stub2 >> $ffile

ffile=bookmark_shared.html
rm -f $ffile
echo $stub1 > $ffile
find ../source/text/shared -type f -name "*.xhp" -exec xsltproc get_bookmark.xsl {} + >> $ffile
echo $stub2 >> $ffile

ffile=bookmark_chart.html
rm -f $ffile
echo $stub1 > $ffile
find ../source/text/schart -type f -name "*.xhp" -exec xsltproc get_bookmark.xsl {} + >> $ffile
echo $stub2 >> $ffile

ffile=bookmark_math.html
rm -f $ffile
echo $stub1 > $ffile
find ../source/text/smath -type f -name "*.xhp" -exec xsltproc get_bookmark.xsl {} + >> $ffile
echo $stub2 >> $ffile

ffile=bookmark_basic.html
rm -f $ffile
echo $stub1 > $ffile
find ../source/text/sbasic -type f -name "*.xhp" -exec xsltproc get_bookmark.xsl {} + >> $ffile
echo $stub2 >> $ffile

ffile=bookmark_base.html
rm -f $ffile
echo $stub1 > $ffile
find ../source/text/shared/explorer/database -type f -name "*.xhp" -exec xsltproc get_bookmark.xsl {} + >> $ffile
echo $stub2 >> $ffile

