#/bin/bash

# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

#
#Languages are merged in XHP files in
# workdir/HelpTranslatePartTarget/
#

#
# location of the script is in core/helpcontent2/source/ = sourceDir
#
sourceDir=`pwd`
#
# Localtion of the merget l10n help files deom sourceDir
#
langDirSource=../../workdir/HelpTranslatePartTarget/

# Uggly hack: link en-US from sourcedir to HelpTranslatePartTarget...
rm -rf $langDirSource/en-US
mkdir -p $langDirSource/en-US
ln -s  $sourceDir/../ $langDirSource/en-US/helpcontent2

#
# Location of the resulting html
#
outDir=$sourceDir/html/

filter=$sourceDir/online_transform.xsl

#clean and recreate the resulting html
rm -rf $outDir
mkdir $outDir

#copy some service files
cp default.css help.js jquery-3.1.1.min.js $outDir
cp -rap media $outDir

# Change to the merged l10 root folder
cd $langDirSource

# get absolute path of merged l10n files
langDirSource=`pwd`

# iterate existing languages
for lang in `ls $langDirSource`
do
        echo $lang
        cd $lang/helpcontent2/source
        ln -s $filter .
        ln -s $sourceDir/get_bookmark.sh .
        mkdir -p  $outDir/$lang
        ./get_bookmark.sh $outDir $lang
        xsltparm='--stringparam Language '$lang

        # iterate all xhp files
        for filep in `find text/ -name *.xhp`
        do
               DIR=${filep##*text/}
               name=${DIR:0:-3}
               outFile=$outDir$lang'/text/'$name'html'
               xsltproc $xsltparm -o $outFile online_transform.xsl $filep
        done
        # housekeeping
        # some service links
        ln -s text/shared/main0108.html $outDir/$lang/index.html
        ln -s ../media $outDir/$lang/media
        # back to l10n root folder
        cd $langDirSource

done
# Should copy core/icon-themes/galaxy/ to the media folder as icon-theme/
        #mkdir $outDir'media/icon-theme'
        # cp -rap ../../../../../icon-themes/galaxy/* $outDir/media/icon-theme/
exit
