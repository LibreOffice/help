#/bin/bash

# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
###########################################
#
# Takes all translated xhp files and convert into HTML files
#
###########################################
#
# $1 is Language
# $2 is productversion
# $3 is location of $(WORKDIR)
# $4 is local or website
#     If local, the filetree should be $(installDir)
#     If website, filetree should be '/'
# $5 is filetree for local


lang=$1
productversion=$2
workDir=$(realpath $3)
offline=$4
fileTree=$5

outDir=$(realpath $workDir/HelpTargetHTML/$productversion/$lang)
sourceDir=$(realpath $workDir/HelpTranslatePartTarget/$lang/helpcontent2/source)

###########################################
#
# Process translated XHP files
#
###########################################

xsltparm='--stringparam fileTree '$fileTree' --stringparam local '$offline' --stringparam Language '$lang' --stringparam productversion '$productversion' --stringparam root '$sourceDir'/'

echo 'Conversion to HTML started for '$lang
for filep in $(find $sourceDir/text -name "*.xhp")
do
DIR=${filep##*text/}
name=${DIR:0:-3}
outFile=$outDir'/text/'$name'html'
xsltproc $xsltparm -o $outFile online_transform.xsl $filep
done
exit
