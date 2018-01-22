#/bin/bash

# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
###########################################
#
# add auxiliary javascript and html files
# add media files
# will be located in $WORKDIR/HelpTargetHTML/$productversion/
#
#
###########################################

# $1 is Language
# $2 is productversion
# $3 is location of $(WORKDIR)

lang=$1
productVersion=$2
workDir=$(realpath $3)

# copy files

echo 'copy global service files'

outDir=$workDir'/HelpTargetHTML/'

cp index.html $outDir
cp help.html $outDir
cp index2.html $outDir'/'$productVersion'/index.html'
cp help.js $outDir'/'$productVersion'/'
cp jquery-3.1.1.min.js $outDir'/'$productVersion'/'
cp list.min.js $outDir'/'$productVersion'/'
cp normalize.css $outDir'/'$productVersion'/'
cp default.css $outDir'/'$productVersion'/'

cp -a ../source/media $outDir'/'$productVersion'/'

galaxy=$(realpath $workDir'/../icon-themes/galaxy')
cp -a $galaxy $outDir'/'$productVersion'/media/icon-themes'
