#/bin/bash

# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# $1 is html/productversion/
# $2 is Language
# $3 is productversion

outdir=html/
# mkdir -p $outdir
sourcedir=`pwd`/
ffile=$outdir'filemap.js'
rm -f $ffile
ffile2=temp.html
stub2='};'
xslfile=get_url.xsl

# bookmarks branch -> path/to/helpfile.html

stub1='var map={'
sfind=$sourcedir'text/'
rm -f $ffile2
find $sfind -type f -name "*.xhp" -exec xsltproc $xslfile {} + > $ffile2
echo $stub1 >> $ffile
# sort -k3b -t\> -s -o $ffile2 $ffile2
awk 'NF' $ffile2 >> $ffile
echo $stub2 >> $ffile

