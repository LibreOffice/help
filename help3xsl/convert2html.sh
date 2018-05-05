#/bin/bash
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Convert localized XHP files and TREE files to HTML.
#
# Syntax: convert2html tarball productversion source
#
# Example
# ./convert2html.sh buildtargets_5403.tar.gz 5.4 libreoffice-help-5.4.0.3.tar.xz
#
# This script convert localized XHP and TREE files available as tarballs into
# a set of html pages.
#
# Conversion is done by listing the available languages in the tarball and
# execting the XSLT transformations on each XHP and tree files.
#
# Note: tarball, source and productversion must match.
#
# Special case for converting en-US XHP files to HTML. The en-US source is
# taken from the published helpcontent2 source tarball.
#
# companion files are moved to the right position in the html folder
# Media files are added too.
#

function getBookmark() {
###########################################
# Extract <bookmarks_value> from each XHP file and build a <ul> list
# in a javascript file
#
# Function called by main routine
#
# $1 is Language
# $2 is productversion
# $3 is the tarname folder
###########################################

local outdir=$(pwd)'/html/'$2'/'$1

local sourcedir=$3/HelpTranslatePartTarget/$1/helpcontent2/source
local ffile=$outdir/bookmarks.js
rm -f $ffile
local ffile2=$(mktemp)
local stub2=\'
local xslfile=get_bookmark.xsl

local param1=' --stringparam Language '$1' --stringparam productversion '$2

###########################################
# bookmarks for modules
###########################################
for i in CALC CHART WRITER DRAW IMPRESS MATH BASIC
do
local stub1='document.getElementById("bookmark'$i'").innerHTML='\'\\
sfind=$sourcedir'/'$(echo 'text/s'$i | tr '[:upper:]' '[:lower:]')
param=$param1' --stringparam app '$i
rm -f $ffile2
find $sfind -type f -name "*.xhp" -exec xsltproc $param $xslfile {} + >> $ffile2
echo $stub1 >> $ffile
sort -k3b -t\> -s -o $ffile2 $ffile2
awk 'NF' $ffile2 >> $ffile
echo $stub2 >> $ffile
done

###########################################
# Case of SHARED
###########################################
stub1='document.getElementById("bookmarkSHARED").innerHTML='\'\\
rm -f $ffile2
param=$param1' --stringparam app SHARED'
find $sourcedir'/text/shared' -type f -name "*.xhp" -exec xsltproc $param $xslfile {} + >> $ffile2
echo $stub1 >> $ffile
sort -k3b -t\> -s -o $ffile2 $ffile2
awk 'NF' $ffile2 >> $ffile
echo $stub2 >> $ffile

###########################################
# Case of Explorer (BASE)
###########################################
stub1='document.getElementById("bookmarkBASE").innerHTML='\'\\
rm -f $ffile2
param=$param1' --stringparam app BASE'
find $sourcedir'/text/shared/explorer/database' -type f -name "*.xhp" -exec xsltproc $param $xslfile {} + >> $ffile2
echo $stub1 >> $ffile
sort -k3b -t\> -s -o $ffile2 $ffile2
awk 'NF' $ffile2 >> $ffile
echo $stub2 >> $ffile
rm -f $ffile2
}

###########################################
# Main routine
###########################################

tarname=$1
productversion=$2
source=$3

sourceDir=$(pwd)

###########################################
# Un-tar localized XHP and TREE files
###########################################
#tarname=${tarball:0:17}
rm -rf $tarname
#tar -zxf $tarball
cp -r /var/tmp/$tarname .
###########################################
# Un-tar source en-US XHP and TREE files
###########################################

sourceName=$(tar -tf $source | head -1 | cut -f1 -d"/")
rm -rf $sourceName
tar -xf $source

###########################################
# Location of the merged l10n help files from sourceDir
###########################################
langDirSource=$tarname/HelpTranslatePartTarget/
enSource=$sourceName/helpcontent2

###########################################
#
# Hack: copy en-US from source help tarball to HelpTranslatePartTarget and HelpTreeTarget
#
###########################################
rm -rf $langDirSource/en-US
mkdir -p $langDirSource/en-US/helpcontent2
cp -r $enSource/* $langDirSource/en-US/helpcontent2

###########################################
#
# Process the en-US tree files
#
###########################################
ALL_TREE='sbasic  scalc  schart  shared  simpress  smath  swriter'
for i in $ALL_TREE
do
cp -r $sourceDir'/'$enSource'/source/auxiliary/'$i.tree $tarname/HelpTreeTarget/$i'/en-US.tree'
done
###########################################
#
# Location of the resulting html
#
###########################################
outDir=$sourceDir/html/$productversion/

filter=$sourceDir/online_transform.xsl

###########################################
#
# clean and recreate the target html folder
#
###########################################

rm -rf $sourceDir/html
mkdir -p $sourceDir/html/$productversion

###########################################
#
# Create the bookmark2file.js map.
#
# This file contains a map that convert bookmarks from LibreOffice apps into
# an URL of the corresponding page.
# The URL arriving is converted inside index.html and redirected
#
###########################################
stub1='var map={'
stub2='};'
sfind=$langDirSource'en-US/helpcontent2/source/text/'
ffile=$outDir/bookmark2file.js
ffile2=$(mktemp)
rm -f $ffile2 $ffile
find $sfind -type f -name "*.xhp" -exec xsltproc get_url.xsl {} + > $ffile2
echo $stub1 >> $ffile
awk 'NF' $ffile2 >> $ffile
echo $stub2 >> $ffile
rm -f $ffile2

for lang in $(ls $langDirSource)
#for lang in pt-BR fr
do
        echo 'Processing language '$lang
        mkdir -p  $outDir/$lang
        getBookmark $lang $productversion $tarname &

        pPath=$langDirSource$lang'/helpcontent2/source'
        xsltparm='--stringparam Language '$lang' --stringparam local no --stringparam productversion '$productversion' --stringparam root '$pPath'/'

        # iterate all xhp files

        for filep in $(find $pPath -name *.xhp)
        do
#         echo $filep
               DIR=${filep##*/source}
               name=${DIR:0:-3}
               outFile=$outDir$lang$name'html'
               xsltproc $xsltparm -o $outFile online_transform.xsl $filep
        done

###########################################
#
# Process tree files
#
###########################################

treeFileHTML=html/$productversion/$lang/contents.js

touch $treeFileHTML
echo 'document.getElementById("Contents").innerHTML='$'\047''\'>$treeFileHTML

xsltparm='--stringparam lang '$lang' --stringparam productversion '$productversion
for tree in $ALL_TREE
do
treeSourceFile=$tarname/HelpTreeTarget/$tree/$lang.tree
treeTemp2=$(mktemp)

xsltproc $xsltparm -o $treeTemp2 get_tree.xsl $treeSourceFile

awk 'NF' $treeTemp2>>$treeFileHTML

rm -f $treeTemp2
done

echo $'\047'';'>>$treeFileHTML
echo 'Conversion to HTML finished for '$lang
done
###########################################
# Process sitemap index for productversion
###########################################
url='https://help.libreoffice.org'

ALL_LANGS=$(ls $outDir | sed 's/media//')
ALL_LANGS=$(echo $ALL_LANGS | sed 's/bookmark2file.js//')
echo $ALL_LANGS
sitemap=$outDir/sitemap.xml

rm -f $sitemap
touch $sitemap

echo '<?xml version="1.0" encoding="UTF-8"?>' > $sitemap
echo '<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'>>$sitemap

for lang1 in $ALL_LANGS
do
echo '<sitemap>' >>$sitemap
echo '<loc>'$url'/'$productversion'/sitemap-'$lang1'.xml</loc>' >>$sitemap
echo '<lastmod>'$(date -I)'</lastmod>'>>$sitemap
echo '</sitemap>'>>$sitemap

###########################################
#
# Process sitemap for productversion-lang
#
###########################################
f=$outDir'/sitemap-'$lang1'.xml'

rm -f $f
touch $f

echo '<?xml version="1.0" encoding="UTF-8"?>' > $f
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' >> $f


dd=./html/$productversion/$lang1

for ff in $(find $dd -name "*.html")
do
echo '<url><loc>'$url'/'${ff:7}'</loc></url>' >>$f
done
echo '</urlset>'>>$f

done
echo '</sitemapindex>'>>$sitemap

###########################################
#
# copy some service files
#
###########################################

#cp help.html index.html html/
cp normalize.css default.css help.js fuse.js paginathing.js $outDir
cp -r $enSource/source/media $outDir
mkdir -p $outDir/media/icon-themes
#cp -a ../../icon-themes/colibre/* $outDir/media/icon-themes/
#ln -s $productversion html/latest

exit
