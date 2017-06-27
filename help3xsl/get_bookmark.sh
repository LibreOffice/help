#/bin/bash

# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# $1 is Language
# $2 is productversion

outdir=`pwd`'/html/'$2'/'$1

# mkdir -p $outdir
sourcedir=`pwd`'/l10n/'$2'/'$1
ffile=$outdir'/bookmarks.js'
rm -f $ffile
ffile2=/tmp/temp.html
stub2=\'
xslfile=get_bookmark.xsl

param1=' --stringparam Language '$1' --stringparam productversion '$2

# bookmarks for modules

for i in CALC CHART WRITER DRAW IMPRESS MATH BASIC
do
stub1='document.getElementById("bookmark'$i'").innerHTML='\'\\
sfind=$sourcedir'/'`echo 'text/s'$i | tr '[:upper:]' '[:lower:]'`
param=$param1' --stringparam app '$i
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
param=$param1' --stringparam app SHARED'
find $sourcedir'/text/shared' -type f -name "*.xhp" -exec xsltproc $param $xslfile {} + >> $ffile2
echo $stub1 >> $ffile
sort -k3b -t\> -s -o $ffile2 $ffile2
awk 'NF' $ffile2 >> $ffile
echo $stub2 >> $ffile

# Case of Explorer (BASE)

stub1='document.getElementById("bookmarkBASE").innerHTML='\'\\
rm -f $ffile2
param=$param1' --stringparam app BASE'
find $sourcedir'/text/shared/explorer/database' -type f -name "*.xhp" -exec xsltproc $param $xslfile {} + >> $ffile2
echo $stub1 >> $ffile
sort -k3b -t\> -s -o $ffile2 $ffile2
awk 'NF' $ffile2 >> $ffile
echo $stub2 >> $ffile
rm -f $ffile2
