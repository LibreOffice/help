#/bin/bash

# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

productVersion=6.0
workDir=$(realpath '../../workdir')
langDirSource=$workDir'/HelpTranslatePartTarget'

./get_hid2file.sh $productVersion $workDir

for lang in $(ls $langDirSource)
do
./get_bookmark.sh $lang $productVersion $workDir
./get_html.sh $lang $productVersion $workDir 'yes' '/'
./get_tree.sh $lang $productVersion $workDir
done

./get_media.sh 'dummy' $productVersion $workDir

exit
