#/bin/bash

# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

stub1='<ul class="indexlink">'
stub2='</ul>'
ffile=bookmark_calc.html
ffile2=temp.html
rm -f $ffile $ffile2
find text/scalc -type f -name "*.xhp" -exec xsltproc get_bookmark.xsl {} + >> $ffile2
echo $stub1 > $ffile
awk 'NF' $ffile2 >> $ffile
sort -k3b -t\> -s -o $ffile $ffile
echo $stub2 >> $ffile

ffile=bookmark_writer.html
rm -f $ffile $ffile2
touch $ffile2
find text/swriter -type f -name "*.xhp" -exec xsltproc get_bookmark.xsl {} + >> $ffile2
echo $stub1 > $ffile
awk 'NF' $ffile2 >> $ffile
sort -k3b -t\> -s -o $ffile $ffile
echo $stub2 >> $ffile

ffile=bookmark_draw.html
rm -f $ffile $ffile2
touch $ffile2
find text/sdraw -type f -name "*.xhp" -exec xsltproc get_bookmark.xsl {} + >> $ffile2
echo $stub1 > $ffile
awk 'NF' $ffile2 >> $ffile
sort -k3b -t\> -s -o $ffile $ffile
echo $stub2 >> $ffile

ffile=bookmark_impress.html
rm -f $ffile $ffile2
touch $ffile2
find text/simpress -type f -name "*.xhp" -exec xsltproc get_bookmark.xsl {} + >> $ffile2
echo $stub1 > $ffile
awk 'NF' $ffile2 >> $ffile
sort -k3b -t\> -s -o $ffile $ffile
echo $stub2 >> $ffile

ffile=bookmark_shared.html
rm -f $ffile $ffile2
touch $ffile2
find text/shared -type f -name "*.xhp" -exec xsltproc get_bookmark.xsl {} + >> $ffile2
echo $stub1 > $ffile
awk 'NF' $ffile2 >> $ffile
sort -k3b -t\> -s -o $ffile $ffile
echo $stub2 >> $ffile

ffile=bookmark_chart.html
rm -f $ffile $ffile2
touch $ffile2
find text/schart -type f -name "*.xhp" -exec xsltproc get_bookmark.xsl {} + >> $ffile2
echo $stub1 > $ffile
awk 'NF' $ffile2 >> $ffile
sort -k3b -t\> -s -o $ffile $ffile
echo $stub2 >> $ffile

ffile=bookmark_math.html
rm -f $ffile $ffile2
touch $ffile2
find text/smath -type f -name "*.xhp" -exec xsltproc get_bookmark.xsl {} + >> $ffile2
echo $stub1 > $ffile
awk 'NF' $ffile2 >> $ffile
sort -k3b -t\> -s -o $ffile $ffile
echo $stub2 >> $ffile

ffile=bookmark_basic.html
rm -f $ffile $ffile2
touch $ffile2
find text/sbasic -type f -name "*.xhp" -exec xsltproc get_bookmark.xsl {} + >> $ffile2
echo $stub1 > $ffile
awk 'NF' $ffile2 >> $ffile
sort -k3b -t\> -s -o $ffile $ffile
echo $stub2 >> $ffile

ffile=bookmark_base.html
rm -f $ffile $ffile2
touch $ffile2
find text/shared/explorer/database -type f -name "*.xhp" -exec xsltproc get_bookmark.xsl {} + >> $ffile2
echo $stub1 > $ffile
awk 'NF' $ffile2 >> $ffile
sort -k3b -t\> -s -o $ffile $ffile
echo $stub2 >> $ffile
rm -f $ffile2
