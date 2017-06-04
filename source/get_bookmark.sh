#/bin/bash

# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

outdir=$1

ffile=$outdir'bookmarks.js'
rm -f $ffile
ffile2=temp.html
stub2=\'

for i in CALC CHART WRITER DRAW IMPRESS MATH BASIC
do
stub1='document.getElementById("bookmark'$i'").innerHTML='\'\\
sfind=`echo 'text/s'$i | tr '[:upper:]' '[:lower:]'`
param='--stringparam app '$i
rm -f $ffile2
find $sfind -type f -name "*.xhp" -exec xsltproc $param  get_bookmark.xsl {} + >> $ffile2
echo $stub1 >> $ffile
sort -k3b -t\> -s -o $ffile2 $ffile2
awk 'NF' $ffile2 >> $ffile
echo $stub2 >> $ffile
done

stub1='document.getElementById("bookmarkSHARED").innerHTML='\'\\
rm -f $ffile2
param='--stringparam app SHARED'
find text/shared -type f -name "*.xhp" -exec xsltproc $param get_bookmark.xsl {} + >> $ffile2
echo $stub1 >> $ffile
sort -k3b -t\> -s -o $ffile2 $ffile2
awk 'NF' $ffile2 >> $ffile
echo $stub2 >> $ffile

stub1='document.getElementById("bookmarkBASE").innerHTML='\'\\
rm -f $ffile2
param='--stringparam app BASE'
find text/shared/explorer/database -type f -name "*.xhp" -exec xsltproc $param get_bookmark.xsl {} + >> $ffile2
echo $stub1 >> $ffile
sort -k3b -t\> -s -o $ffile2 $ffile2
awk 'NF' $ffile2 >> $ffile
echo $stub2 >> $ffile
rm -f $ffile2
