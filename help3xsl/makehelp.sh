#/bin/bash

# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# Arguments

# $1 build local or webroot help [default=yes]
# values: yes no
# $2 build english help [default=no]
# values: yes no

productVersion=6.0
workDir=$(realpath '../../workdir')
langDirSource=$workDir'/HelpTranslatePartTarget'
offline="yes"

if [ "$1" == "no" ]
then
offline="no"
fi

if [ "$2" == "yes" ]
then
mkdir -p $langDirSource/en-US/helpcontent2/source
cp -r ../source/text $langDirSource/en-US/helpcontent2/source/
for i in sbasic  scalc  schart  shared  simpress  smath  swriter
do
cp "../source/auxiliary/$i.tree" "$workDir/HelpTreeTarget/$i/en-US.tree"
done
fi

./get_hid2file.sh $productVersion $workDir

for lang in $(ls $langDirSource)
do
./get_bookmark.sh $lang $productVersion $workDir
./get_html.sh $lang $productVersion $workDir $offline '/'
./get_tree.sh $lang $productVersion $workDir
done

./get_media.sh 'dummy' $productVersion $workDir

exit
