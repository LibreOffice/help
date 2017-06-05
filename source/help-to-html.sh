#/bin/bash

# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

outdir=html/
filter=online_transform.xsl
rm -rf $outdir
mkdir $outdir
cp default.css help.js jquery-3.1.1.min.js $outdir
cp -rap media $outdir'media'
./get_bookmark.sh $outdir
for filep in `find text/ -name *.xhp`
do
DIR=${filep%/*}
FILEN=${filep##*/}
name=${FILEN:0:-3}
outfile=$outdir$DIR/$name'html'
xsltproc -o $outfile $filter $filep
done
ln -s text/shared/main0108.html $outdir'index.html'
mkdir $outdir'media/icon-theme'
# cp -rap ../../../../../icon-themes/galaxy/* $outdir/media/icon-theme/

