#/bin/bash

# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# This script builds translated XHP file with helpex excutable
# and thes transform it to html pages
# 1) generates redirection from LibreOffice Help URL to right html page
#    in index.html with bookmark2file.js
# 2) generates bookmark_<APP>.js for index search
# 3) generates HTML pages with online_transform.xs
# 4) copy service files (css, js, media) to right place.
#
# Note: change rootHelpex variable to your local git build
#

function convert2HTML() {
#outDirLang =1
#outDirHTML =2

xsltparm='--stringparam Language '$lang' --stringparam productversion '$productversion' --stringparam root '$outDirLang'/'
echo 'Converting to HTML started'
for filep in `find $1/text -name "*.xhp"`
do
DIR=${filep##*text/}
name=${DIR:0:-3}
outFile=$2'/text/'$name'html'
xsltproc $xsltparm -o $outFile online_transform.xsl $filep
done
echo 'Conversion to HTML finished'
}

productversion='6.0'
rootHelpex=/home/tdf/git/core

ALL_LANGS='en-US am ar ast bg bn bn-IN bo bs ca ca-valencia cs da de dz el en-GB en-ZA eo es et eu fi fr gl gu he hi hr hu id is it ja ka km ko lo lt lv mk nb ne nl nn om pl pt-BR pt ro ru sid si sk sl sq sv ta tg tr ug uk vi zh-CN zh-TW'

here=`pwd`
root=$(realpath "$here/../..")


rm -rf $here/l10n
rm -rf $here/html

helpfiles=$root/helpcontent2/source/text

pofiles=/tmp/pofiles.txt
xhpfiles=/tmp/xhpfiles.txt
# mkdir -p $here/html
mkdir -p $here'/html/'$productversion

echo 'copy global service files'
cp index.html $here'/html/'
cp help.js $here'/html/'$productversion'/'
cp jquery-3.1.1.min.js $here'/html/'$productversion'/'
cp tabs.js $here'/html/'$productversion'/'
cp default.css $here'/html/'$productversion'/'

cp -rap ../source/media $here'/html/'$productversion'/'
mkdir -p $here'/html/'$productversion'/media/icon-themes'
cp -rap ../../icon-themes/galaxy/* $here'/html/'$productversion'/media/icon-themes/'
ln -s $productversion html/latest

# Set helpex utilty and environment

while test ! -d "${rootHelpex}/instdir/program" ; do
if test "${dir}" = "/"; then
echo "error: cannot find \"program\" dir from \"$(pwd)\""
exit 1
fi
rootHelpex=$(readlink -f "${rootHelpex}/..")
done

exedir="${rootHelpex}"/workdir/LinkTarget/Executable
echo $exedir

export URE_BOOTSTRAP=file://"${rootHelpex}"/instdir/program/fundamentalrc123
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}"${rootHelpex}"/instdir/program

echo "setting URE_BOOTSTRAP to: ${URE_BOOTSTRAP}"
echo "setting search path to: ${LD_LIBRARY_PATH}"
echo "execing: ${exedir}/helpex"

# Create the bookmark2file map
stub1='var map={'
stub2='};'
ffile='html/bookmark2file.js'
ffile2=/tmp/tmpbkm.txt
rm -f $ffile2 $ffile
find $helpfiles -type f -name "*.xhp" -exec xsltproc get_url.xsl {} + > $ffile2
echo $stub1 >> $ffile
awk 'NF' $ffile2 >> $ffile
echo $stub2 >> $ffile

# ALL_LANGS="en-US fr"
for lang in $ALL_LANGS
do

echo 'lang = '$lang

echo 'LIB -> '${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}

mkdir -p $here'/l10n/'$productversion'/'$lang
outDirLang=$here'/l10n/'$productversion'/'$lang

mkdir -p $here'/html/'$productversion'/'$lang
outDirHTML=$here'/html/'$productversion'/'$lang

xsltparm='--stringparam Language '$lang' --stringparam productversion '$productversion' --stringparam root '$outDirLang'/'

if [ "$lang" == en-US ];
then
cp -rap $helpfiles $outDirLang
else
# Create first all translations of xhp
translations=$root/translations/source/$lang/helpcontent2/source/text/

rm -f $pofiles
touch $pofiles
rm -f $xhpfiles
touch $xhpfiles

find $translations -type f >$pofiles

for ff in `cat $pofiles`
do
    echo 'Processing po file: '$ff
    potemp=`mktemp`
    echo $ff>$potemp
    name=${ff:0:-3}
    stub=${name##*text/}
    hlpFileDir=$helpfiles'/'$stub
    outDir=$outDirLang'/text/'$stub
    mkdir -p $outDir
    ls $hlpFileDir/*.xhp >$xhpfiles
    "${exedir}/helpex" -l $lang -mi $xhpfiles -m $potemp -o $outDir
    rm $potemp
done
fi

#extracting bookmarks
echo 'Extracting bookmarks'
./get_bookmark.sh $lang $productversion &

convert2HTML $outDirLang $outDirHTML &

done
exit





