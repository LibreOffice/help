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
# convert2HTML $outDirLang $outDirHTML $lang $productversion $online $fileTree &

function get_bookmark(){
lang=$1
productversion=$2
#workDir=$(realpath $3)
workDir=$(pwd)

outDir=$(realpath $workDir/html/$productversion/$lang)
#sourceDir=$(realpath $workDir/l10n/$lang/helpcontent2/source)
sourceDir=$(realpath $workDir/l10n/$productversion/$lang)

bookmarkFile=$outDir/bookmarks.js
mkdir -p $outDir

rm -f $bookmarkFile
touch $bookmarkFile

stub2=\'
stub1='document.getElementsByClassName( "list" )[0].innerHTML='\'\\
echo $stub1 >> $bookmarkFile

xslfile=get_bookmark.xsl

param1=' --stringparam Language '$lang' --stringparam productversion '$productversion

# bookmarks for modules

for i in WRITER CALC DRAW IMPRESS CHART MATH BASIC
do
sfind=$sourceDir'/'$(echo 'text/s'$i | tr '[:upper:]' '[:lower:]')
param=$param1' --stringparam app '$i
tempFile=$(mktemp)
find $sfind -type f -name "*.xhp" -exec xsltproc $param $xslfile {} + >> $tempFile
sort -k3b -t\> -s -o $tempFile $tempFile
awk 'NF' $tempFile >> $bookmarkFile
rm -f $tempFile
done

# Case of SHARED

tempFile=$(mktemp)
param=$param1' --stringparam app SHARED'
find $sourceDir'/text/shared' -type f -name "*.xhp" -exec xsltproc $param $xslfile {} + >> $tempFile
sort -k3b -t\> -s -o $tempFile $tempFile
awk 'NF' $tempFile >> $bookmarkFile
rm -f $tempFile

# Case of Explorer (BASE)

tempFile=$(mktemp)
param=$param1' --stringparam app BASE'
find $sourceDir'/text/shared/explorer/database' -type f -name "*.xhp" -exec xsltproc $param $xslfile {} + >> $tempFile
sort -k3b -t\> -s -o $tempFile $tempFile
awk 'NF' $tempFile >> $bookmarkFile
rm -f $tempFile
echo $stub2 >> $bookmarkFile
}


function convert2HTML() {
#outDirLang =1
#outDirHTML =2
#lang =3
#productversion =4
#online=5
#filetree=6

###########################################
#
# Process translated XHP files
#
###########################################

xsltparm='--stringparam fileTree '$6' --stringparam local '$5' --stringparam Language '$3' --stringparam productversion '$4' --stringparam root '$1'/'

echo 'Conversion to HTML started for '$3
for filep in $(find $1/text -name "*.xhp")
do
DIR=${filep##*text/}
name=${DIR:0:-3}
outFile=$2'/text/'$name'html'
xsltproc $xsltparm -o $outFile online_transform.xsl $filep
done

###########################################
#
# Process tree files
#
###########################################

treePOFile=$(mktemp)
echo $root/translations/source/$3/helpcontent2/source/auxiliary.po > $treePOFile

ALL_TREE='sbasic.tree  scalc.tree  schart.tree  shared.tree  simpress.tree  smath.tree  swriter.tree'

xhpFiles=$here/l10n/$productversion/$3/text

treeFileHTML=$outDirHTML/contents.js
rm -f $treeFileHTML
touch $treeFileHTML
echo 'document.getElementById("Contents").innerHTML='$'\047''\'>$treeFileHTML

xsltparm='--stringparam lang '$3' --stringparam productversion '$4
for tree in $ALL_TREE
do
treeSourceFile=$root'/helpcontent2/source/auxiliary/'$tree
treeTemp1=$(mktemp)
treeTemp2=$(mktemp)

"${exedir}/treex" -l $3 -i $treeSourceFile -m $treePOFile -o $treeTemp1 -r $xhpFiles

xsltproc $xsltparm -o $treeTemp2 get_tree.xsl $treeTemp1

awk 'NF' $treeTemp2>>$treeFileHTML

rm -f $treeTemp1 $treeTemp2
done
echo $'\047'';'>>$treeFileHTML

rm -f $treePOFile

echo 'Conversion to HTML finished for '$3
}

###########################################
#
# Start Main Process
#
###########################################

# Change root of git core
productversion='6.0'
local='no'
fileTree='/'

rootHelpex=/home/tdf/git/core

ALL_LANGS='en-US am ar ast bg bn bn-IN bo bs ca ca-valencia cs da de dz el en-GB en-ZA eo es et eu fi fr gl gu he hi hr hu id is it ja ka km ko lo lt lv mk nb ne nl nn om pl pt-BR pt ro ru sid si sk sl sq sv ta tg tr ug uk vi zh-CN zh-TW'

here=$(pwd)
root=$(realpath "$here/../..")

rm -rf $here/l10n
rm -rf $here/html

helpfiles=$root/helpcontent2/source/text

mkdir -p $here'/html/'$productversion

echo 'copy global service files'
cp index.html $here'/html/'
cp help.html $here'/html/'
cp index2.html $here'/html/'$productversion'/index.html'
cp help.js $here'/html/'$productversion'/'
cp fuse.js $here'/html/'$productversion'/'
cp paginathing.js $here'/html/'$productversion'/'
cp normalize.css $here'/html/'$productversion'/'
cp default.css $here'/html/'$productversion'/'

cp -a ../source/media $here'/html/'$productversion'/'
mkdir -p $here'/html/'$productversion'/media/icon-themes'
cp -a ../../icon-themes/galaxy/* $here'/html/'$productversion'/media/icon-themes/'
ln -s $productversion html/latest

# Set helpex utilty and environment

while test ! -d "${rootHelpex}/instdir/program" ; do
if test "${dir}" = "/"; then
echo "error: cannot find \"program\" dir from \"$(pwd)\""
exit 1
fi
rootHelpex=$(realpath "${rootHelpex}/..")
done

exedir="${rootHelpex}"/workdir/LinkTarget/Executable
echo $exedir

export URE_BOOTSTRAP=file://"${rootHelpex}"/instdir/program/fundamentalrc123
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}"${rootHelpex}"/instdir/program

echo "setting URE_BOOTSTRAP to: ${URE_BOOTSTRAP}"
echo "setting search path to: ${LD_LIBRARY_PATH}"
echo "execing: ${exedir}/helpex"

###########################################
#
# Create the hid2file map
#
###########################################
stub1='var map={'
stub2='};'
ffile='html/'$productversion'/hid2file.js'
ffile2=/tmp/tmpbkm.txt
rm -f $ffile2 $ffile
find $helpfiles -type f -name "*.xhp" -exec xsltproc get_url.xsl {} + > $ffile2
echo $stub1 >> $ffile
awk 'NF' $ffile2 >> $ffile
echo $stub2 >> $ffile

###########################################
#
# Process languages
#
###########################################

for lang in $ALL_LANGS
do

echo 'Processing Language '$lang

outDirLang=$here'/l10n/'$productversion'/'$lang
mkdir -p $outDirLang

outDirHTML=$here'/html/'$productversion'/'$lang
mkdir -p $outDirHTML

# Special case of en-US, tehre is no translation to do

if [ "$lang" == en-US ];
then

cp -a $helpfiles $outDirLang

else
# Create first all translations of xhp
translations=$root/translations/source/$lang/helpcontent2/source/text/

pofiles=`mktemp`
xhpfiles=`mktemp`

# gather all po files of dir
find $translations -type f >$pofiles

# For each po file
for ff in $(cat $pofiles)
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
    rm -f $potemp
done
fi

#extracting bookmarks
echo 'Extracting bookmarks'
get_bookmark $lang $productversion $(pwd)/html &

# converting to HTML
convert2HTML $outDirLang $outDirHTML $lang $productversion $local $fileTree &

rm -f $pofiles $xhpfiles
done
exit
