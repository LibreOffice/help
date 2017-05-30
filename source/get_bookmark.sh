#/bin/bash

# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

outdir=$1

stub1='<ul class="indexlink">'
stub2='</ul>'
ffile=$outdir'bookmark_CALC.html'
ffile2=temp.html
param='--stringparam app CALC'
rm -f $ffile $ffile2
find text/scalc -type f -name "*.xhp" -exec xsltproc $param  get_bookmark.xsl {} + >> $ffile2
echo $stub1 > $ffile
awk 'NF' $ffile2 >> $ffile
sort -k3b -t\> -s -o $ffile $ffile
echo $stub2 >> $ffile

ffile=$outdir'bookmark_WRITER.html'
rm -f $ffile $ffile2
touch $ffile2
param='--stringparam app WRITER'
find text/swriter -type f -name "*.xhp" -exec xsltproc $param get_bookmark.xsl {} + >> $ffile2
echo $stub1 > $ffile
awk 'NF' $ffile2 >> $ffile
sort -k3b -t\> -s -o $ffile $ffile
echo $stub2 >> $ffile

ffile=$outdir'bookmark_DRAW.html'
rm -f $ffile $ffile2
touch $ffile2
param='--stringparam app DRAW'
find text/sdraw -type f -name "*.xhp" -exec xsltproc $param get_bookmark.xsl {} + >> $ffile2
echo $stub1 > $ffile
awk 'NF' $ffile2 >> $ffile
sort -k3b -t\> -s -o $ffile $ffile
echo $stub2 >> $ffile

ffile=$outdir'bookmark_IMPRESS.html'
rm -f $ffile $ffile2
touch $ffile2
param='--stringparam app IMPRESS'
find text/simpress -type f -name "*.xhp" -exec xsltproc $param get_bookmark.xsl {} + >> $ffile2
echo $stub1 > $ffile
awk 'NF' $ffile2 >> $ffile
sort -k3b -t\> -s -o $ffile $ffile
echo $stub2 >> $ffile

ffile=$outdir'bookmark_SHARED.html'
rm -f $ffile $ffile2
touch $ffile2
param='--stringparam app SHARED'
find text/shared -type f -name "*.xhp" -exec xsltproc $param get_bookmark.xsl {} + >> $ffile2
echo $stub1 > $ffile
awk 'NF' $ffile2 >> $ffile
sort -k3b -t\> -s -o $ffile $ffile
echo $stub2 >> $ffile

ffile=$outdir'bookmark_CHART.html'
rm -f $ffile $ffile2
touch $ffile2
param='--stringparam app CHART'
find text/schart -type f -name "*.xhp" -exec xsltproc $param get_bookmark.xsl {} + >> $ffile2
echo $stub1 > $ffile
awk 'NF' $ffile2 >> $ffile
sort -k3b -t\> -s -o $ffile $ffile
echo $stub2 >> $ffile

ffile=$outdir'bookmark_MATH.html'
rm -f $ffile $ffile2
touch $ffile2
param='--stringparam app MATH'
find text/smath -type f -name "*.xhp" -exec xsltproc $param get_bookmark.xsl {} + >> $ffile2
echo $stub1 > $ffile
awk 'NF' $ffile2 >> $ffile
sort -k3b -t\> -s -o $ffile $ffile
echo $stub2 >> $ffile

ffile=$outdir'bookmark_BASIC.html'
rm -f $ffile $ffile2
touch $ffile2
param='--stringparam app BASIC'
find text/sbasic -type f -name "*.xhp" -exec xsltproc $param get_bookmark.xsl {} + >> $ffile2
echo $stub1 > $ffile
awk 'NF' $ffile2 >> $ffile
sort -k3b -t\> -s -o $ffile $ffile
echo $stub2 >> $ffile

ffile=$outdir'bookmark_BASE.html'
rm -f $ffile $ffile2
touch $ffile2
param='--stringparam app BASE'
find text/shared/explorer/database -type f -name "*.xhp" -exec xsltproc $param get_bookmark.xsl {} + >> $ffile2
echo $stub1 > $ffile
awk 'NF' $ffile2 >> $ffile
sort -k3b -t\> -s -o $ffile $ffile
echo $stub2 >> $ffile
rm -f $ffile2
