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
# Create the hid2file map that mapd HIDs into
# HTML pages. Language independent.
# will be put in $WORKDIR/HelpTargetHTML/$productversion/
#
###########################################

workDir=$2
productversion=$1

helpFiles=$(realpath $workDir/../helpcontent2/source/text)

mkdir -p $workDir/HelpTargetHTML/$productversion
outDir=$(realpath $workDir/HelpTargetHTML/$productversion)

bookmarkFile=$outDir'/hid2file.js'

tempFile=$(mktemp)
rm -f $bookmarkFile
touch $bookmarkFile

find $helpFiles -type f -name "*.xhp" -exec xsltproc get_url.xsl {} + > $tempFile

echo 'var map={' >> $bookmarkFile
awk 'NF' $tempFile >> $bookmarkFile
echo '};' >> $bookmarkFile
rm -f $tempFile
