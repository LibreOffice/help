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
# $1 is product version ( 6.0, 5.3, 5.2, ...)
#
# location of the script is in core/helpcontent2/source/help3xsl = sourceDir
#
sourceDir=`pwd`

#
# Location of the merged l10n help files from sourceDir
#
langDirSource=../../workdir/HelpTranslatePartTarget/

# Uggly hack: copy en-US from sourcedir to HelpTranslatePartTarget...
rm -rf $langDirSource/en-US
mkdir -p $langDirSource/en-US/helpcontent2/source
cp -r $sourceDir/../source/text/ $langDirSource/en-US/helpcontent2/source/

#
# Location of the resulting html
#
productversion=$1
outDir=$sourceDir/html/$productversion/

filter=$sourceDir/online_transform.xsl

#clean and recreate the resulting html
rm -rf html
mkdir -p html/$productversion

#copy some service files
cp index.html html/
cp default.css help.js jquery-3.1.1.min.js tabs.css tree.css $outDir
cp -a ../source/media $outDir
mkdir -p $outDir'media/icon-themes'
cp -a ../../icon-themes/galaxy/* $outDir/media/icon-themes/
ln -s $productversion html/latest

# Create the bookmark2file map
stub1='var map={'
stub2='};'
sfind='../source/text/'
ffile='html/bookmark2file.js'
ffile2=tmp.txt
rm -f $ffile2 $ffile
find $sfind -type f -name "*.xhp" -exec xsltproc get_url.xsl {} + > $ffile2
echo $stub1 >> $ffile
awk 'NF' $ffile2 >> $ffile
echo $stub2 >> $ffile

# Change to the merged l10 root folder
cd $langDirSource

# get absolute path of merged l10n files
langDirSource=`pwd`

# iterate existing languages
for lang in `ls $langDirSource`
# for lang in en-US pt-BR
do
        echo $lang
        cd $langDirSource/$lang/helpcontent2/source
        ln -sf $filter .
        ln -sf $sourceDir/get_bookmark.sh .
        mkdir -p  $outDir/$lang
        ./get_bookmark.sh $outDir $lang $productversion
        xsltparm='--stringparam Language '$lang' --stringparam productversion '$productversion
        # iterate all xhp files
        for filep in `find text/ -name *.xhp`
        do
               DIR=${filep##*text/}
               name=${DIR:0:-3}
               outFile=$outDir$lang'/text/'$name'html'
               xsltproc $xsltparm -o $outFile online_transform.xsl $filep
        done

        # some service links

#         ln -s text/shared/main0108.html $outDir/$lang/index.html
        ln -s ../media $outDir/$lang/media
        # back to l10n root folder
        cd $langDirSource

done

# Should copy core/icon-themes/galaxy/ to the media folder as icon-theme/
        #mkdir $outDir'media/icon-theme'
        # cp -a ../../../../../icon-themes/galaxy/* $outDir/media/icon-theme/
exit
