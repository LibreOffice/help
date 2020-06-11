#!/bin/bash
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# This script looks up <embed ...> tags in helpcontent, checks whether the
# referenced file and id exist, and prints a warning if either one does not.
# Execute from the root directory of the helpcontent2 repository.
# No parameters are used.

# Example output of this git grep:
# source/text/sbasic/shared/03010000.xhp:  <embed href="text/sbasic/shared/03010300.xhp#color"/>
lines=$(git grep "embed href=" source/);

while read nextline ; do
    # source file is before the first :
    sourcefile=${nextline%%:*};
    # There may be more than one <embed ...> in one line, split it up,
    # but first cut off everything before the first <embed
    # and anything after the last >
    processline="<embed${nextline#*<embed}";
    processline="${processline%>*}>";
    while [ -n "$processline" ] ; do
        # Start processing the first xml tag
        target=$(expr "$processline" : '\(<[^>]*>\)');
        # Check if there is an <embed at the beginning
        if [ $(expr "$target" : "<embed") -ne "0" ] ; then
            # Get the embedded filename#section part
            target=${target#*\"};
            target=${target%\"*};
            # target file is before the #
            targetfile=${target%#*};
            # target section is after the #
            targetsection=${target#*#};
            # does the target file exist?
            if [ -f "source/$targetfile" ] ; then
                # The target file exist, does the section inside the target file too?
                grep -q "id=\"$targetsection\">" source/"$targetfile";
                if [ "$?" -ne "0" ] ; then
                    echo "$sourcefile: In 'source/$targetfile' there is no section called '$targetsection'";
                fi
            else
                # target file does not exist
                echo "$sourcefile: Embedded target file 'source/$targetfile' does not exist!" ;
            fi
        fi
        # Remove the first xml tag from the parts still to be processed
        processline=${processline#<*>};
        # There may be characters after this, i.e. "foo <embed ...>"
        if [ -n "$processline" ] ; then
            processline="<${processline#*<}";
        fi
    done
done <<< "$lines"
