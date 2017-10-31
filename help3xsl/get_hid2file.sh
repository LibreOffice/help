#/bin/bash

# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# $1 is Product Version
# $2 is location of $(WORKDIR)

###########################################
#
# Create the bookmark2file map (from help source files)
#
# will be put in $WORKDIR/HelpTargetHTML/$productversion/
#
###########################################

workDir=$(realpath $2)
productversion=$1

helpFiles=$(realpath $workDir/../helpcontent2/source/text)

outDir=$(realpath $workDir/HelpTargetHTML/$productversion)
mkdir -p $outDir

bookmarkFile=$outDir'/hid2file.js'

tempFile=$(mktemp)
rm -f $bookmarkFile
touch $bookmarkFile

find $helpFiles -type f -name "*.xhp" -exec xsltproc get_url.xsl {} + > $tempFile

echo 'var map={' >> $bookmarkFile
awk 'NF' $tempFile >> $bookmarkFile
echo '};' >> $bookmarkFile
rm -f $tempFile
exit
