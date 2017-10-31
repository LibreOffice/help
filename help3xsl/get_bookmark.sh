#/bin/bash

# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
###########################################
#
#   Create the file bookmarks.js containing the links between the
#   keywords found in <bookmark_value> and the html help page.
#   The file is used in the Index tab of the html help page
#
###########################################
#
# $1 is Language
# $2 is productversion
# $3 is location of $(WORKDIR)

lang=$1
productversion=$2
workDir=$(realpath $3)

outDir=$(realpath $workDir/HelpTargetHTML/$productversion/$lang)
sourceDir=$(realpath $workDir/HelpTranslatePartTarget/$lang/helpcontent2/source)

bookmarkFile=$outDir/bookmarks.js
mkdir -p $outDir

rm -f $bookmarkFile
touch $bookmarkFile

stub2=\'

xslfile=get_bookmark.xsl

param1=' --stringparam Language '$lang' --stringparam productversion '$productversion

# bookmarks for modules

for i in CALC CHART WRITER DRAW IMPRESS MATH BASIC
do
stub1='document.getElementById("bookmark'$i'").innerHTML='\'\\
sfind=$sourceDir'/'$(echo 'text/s'$i | tr '[:upper:]' '[:lower:]')
param=$param1' --stringparam app '$i
tempFile=$(mktemp)
find $sfind -type f -name "*.xhp" -exec xsltproc $param $xslfile {} + >> $tempFile
echo $stub1 >> $bookmarkFile
sort -k3b -t\> -s -o $tempFile $tempFile
awk 'NF' $tempFile >> $bookmarkFile
echo $stub2 >> $bookmarkFile
rm -f $tempFile
done

# Case of SHARED

stub1='document.getElementById("bookmarkSHARED").innerHTML='\'\\
tempFile=$(mktemp)
param=$param1' --stringparam app SHARED'
find $sourceDir'/text/shared' -type f -name "*.xhp" -exec xsltproc $param $xslfile {} + >> $tempFile
echo $stub1 >> $bookmarkFile
sort -k3b -t\> -s -o $tempFile $tempFile
awk 'NF' $tempFile >> $bookmarkFile
echo $stub2 >> $bookmarkFile
rm -f $tempFile

# Case of Explorer (BASE)

stub1='document.getElementById("bookmarkBASE").innerHTML='\'\\
tempFile=$(mktemp)
param=$param1' --stringparam app BASE'
find $sourceDir'/text/shared/explorer/database' -type f -name "*.xhp" -exec xsltproc $param $xslfile {} + >> $tempFile
echo $stub1 >> $bookmarkFile
sort -k3b -t\> -s -o $tempFile $tempFile
awk 'NF' $tempFile >> $bookmarkFile
echo $stub2 >> $bookmarkFile
rm -f $tempFile
exit
