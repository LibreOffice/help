#/bin/bash

# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# $1 is html/productversion/
# $2 is Language
# $3 is productversion

outdir=$1$2
mkdir -p $outdir
sourcedir=`pwd`/
ffile=$outdir'/bookmarks.js'
rm -f $ffile
ffile2=temp.html
stub2=\'
xslfile=$outdir/../../../get_bookmark.xsl

# bookmarks for modules

for i in CALC CHART WRITER DRAW IMPRESS MATH BASIC
do
stub1='document.getElementById("bookmark'$i'").innerHTML='\'\\
sfind=$sourcedir`echo 'text/s'$i | tr '[:upper:]' '[:lower:]'`
param='--stringparam app '$i
param=$param' --stringparam Language '$2
param=$param' --stringparam productversion '$3
rm -f $ffile2
find $sfind -type f -name "*.xhp" -exec xsltproc $param $xslfile {} + >> $ffile2
echo $stub1 >> $ffile
sort -k3b -t\> -s -o $ffile2 $ffile2
awk 'NF' $ffile2 >> $ffile
echo $stub2 >> $ffile
done

# Case of SHARED

stub1='document.getElementById("bookmarkSHARED").innerHTML='\'\\
rm -f $ffile2
param='--stringparam app SHARED'
param=$param' --stringparam Language '$2
param=$param' --stringparam productversion '$3
find $sourcedir'text/shared' -type f -name "*.xhp" -exec xsltproc $param $xslfile {} + >> $ffile2
echo $stub1 >> $ffile
sort -k3b -t\> -s -o $ffile2 $ffile2
awk 'NF' $ffile2 >> $ffile
echo $stub2 >> $ffile

# Case of Explorer (BASE)

stub1='document.getElementById("bookmarkBASE").innerHTML='\'\\
rm -f $ffile2
param='--stringparam app BASE'
param=$param' --stringparam Language '$2
param=$param' --stringparam productversion '$3
find $sourcedir'text/shared/explorer/database' -type f -name "*.xhp" -exec xsltproc $param $xslfile {} + >> $ffile2
echo $stub1 >> $ffile
sort -k3b -t\> -s -o $ffile2 $ffile2
awk 'NF' $ffile2 >> $ffile
echo $stub2 >> $ffile
rm -f $ffile2
