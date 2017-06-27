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
# in index.html with bookmark2file.js
# 2) generates bookmark_<APP>.js for indes search
# 3) generates HTML pahes with online_transform.xs
# 4) copy service files (css, js, media) to right place.
#
# Note: change root variable to your local git build
#

productversion='6.0'
root=/home/tdf/git/core

ALL_LANGS='en-US af am ar as ast be bg bn bn-IN bo br brx bs ca ca-valencia cs cy da de dgo dz el en-GB en-ZA eo es et eu fa fi fr ga gd gl gu gug he hsb hi hr hu id is it ja ka kk km kmr-Latn kn ko kok ks lb lo lt lv mai mk ml mn mni mr my nb ne nl nn nr nso oc om or pa-IN pl pt pt-BR ro ru rw sa-IN sat sd sr-Latn si sid sk sl sq sr ss st sv sw-TZ ta te tg th tn tr ts tt ug uk uz ve vec vi xh zh-CN zh-TW zu'

here=`pwd`
rm -rf $here/l10n
rm -rf $here/html

helpfiles=$root/helpcontent2/source/text

pofiles=/tmp/pofiles.txt
xhpfiles=/tmp/xhpfiles.txt
mkdir -p $here/ html

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

ALL_LANGS="pt-BR fr en-US"
for lang in $ALL_LANGS
do

echo 'lang = '$lang

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
    $root/bin/run helpex -l $lang -mi $xhpfiles -m $potemp -o $outDir
    rm $potemp
done
fi
#extracting bookmarks
echo 'Extracting bookmarks'
./get_bookmark.sh $lang $productversion

echo 'Converting to HTML'
for filep in `find $outDirLang/text -name "*.xhp"`
        do
               DIR=${filep##*text/}
               name=${DIR:0:-3}
               outFile=$outDirHTML'/text/'$name'html'
               xsltproc $xsltparm -o $outFile online_transform.xsl $filep
        done
echo 'copy some service files'
cp default.css tabs.css tree.css $outDirHTML

done
echo 'copy global service files'
cp index.html html/
cp help.js jquery-3.1.1.min.js $here'/html/'$productversion'/'
cp -rap ../source/media $here'/html/'$productversion'/'
mkdir -p $here'/html/'$productversion'/media/icon-themes'
cp -rap ../../icon-themes/galaxy/* $here'/html/'$productversion'/media/icon-themes/'
ln -s $productversion html/latest
