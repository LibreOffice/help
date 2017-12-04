#/bin/bash

# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
###########################################
#
# Create the tree file named contents.js
#
# will be located in $WORKDIR/HelpTargetHTML/$productversion/$lang
#
#
###########################################

# $1 is Language
# $2 is productversion
# $3 is location of $(WORKDIR)

lang=$1
productversion=$2
workDir=$(realpath $3)

outDir=$(realpath $workDir/HelpTargetHTML/$productversion/$lang)
sourceDir=$(realpath $workDir/HelpTreeTarget)

treeFileHTML=$outDir/contents.js
rm -f $treeFileHTML
touch $treeFileHTML

echo 'document.getElementById("Contents").innerHTML='$'\047''\'>$treeFileHTML

xsltparm='--stringparam lang '$lang' --stringparam productversion '$productversion

for module in sbasic  scalc  schart  shared  simpress  smath  swriter
do

treeSourceFile=$sourceDir'/'$module'/'$lang'.tree'

treeTemp2=$(mktemp)

xsltproc $xsltparm -o $treeTemp2 get_tree.xsl $treeSourceFile

awk 'NF' $treeTemp2>>$treeFileHTML

rm -f $treeTemp2
done

echo $'\047'';'>>$treeFileHTML
exit

ALL_LANGS='en-US am ar ast bg bn bn-IN bo bs ca ca-valencia cs da de dz el en-GB en-ZA eo es et eu fi fr gl gu he hi hr hu id is it ja ka km ko lo lt lv mk nb ne nl nn om pl pt-BR pt ro ru sid si sk sl sq sv ta tg tr ug uk vi zh-CN zh-TW'

here=$(pwd)
root=$(realpath "$here/../..")

rootTreex=$root
exedir="${rootTreex}"/workdir/LinkTarget/Executable
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}"${rootTreex}"/instdir/program


# rm -rf $here/l10n
rm -rf $here/html


ALL_LANGS='fr pt-BR'
ALL_TREE='sbasic.tree  scalc.tree  schart.tree  shared.tree  simpress.tree  smath.tree  swriter.tree'
for lang in $ALL_LANGS
do
treePOFile=`mktemp`
echo $root/translations/source/$lang/helpcontent2/source/auxiliary.po > $treePOFile
outDirLang=$here/html/$productversion/$lang
mkdir -p $outDirLang

for tree in $ALL_TREE
do
treeSourceFile=$root'/helpcontent2/source/auxiliary/'$tree

outDirLang=$here/html/$productversion/$lang/$tree

"${exedir}/treex" -l $lang -i $treeSourceFile -m $treePOFile -o $outDirLang
done
# rm -f $treePOFile
done
exit
rm -f $treeSourceFiles

exit
pofiles=/tmp/pofiles.txt
xhpfiles=/tmp/xhpfiles.txt
# mkdir -p $here/html
# mkdir -p $here'/html/'$productversion
