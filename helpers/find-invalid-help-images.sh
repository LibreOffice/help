#!/bin/bash
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# This script looks up <image ...> tags in helpcontent, checks whether the
# referenced file exist in the colibre theme or in source/ and prints a warning if it does not.
# Execute from the root directory of the helpcontent2 repository.
# No parameters are used.

images=$(git grep \<image source/);

while read nextline ; do

    # Source file is before the first :
    sourcefile=${nextline%%:*};

    # There is only one image tag per line, let's extract the src path
    img2=${nextline#*src=\"};
    img3=${img2%%\"*};

    # Check the images existence
    if [ ! -f "../icon-themes/colibre/$img3" ] ; then
        # Not present in colibre, but it may be under source/
        if [ ! -f "source/$img3" ] ; then
            # Not even there, we have an error!
            echo "$img3 included in file $sourcefile is not found in the colibre theme or the help media!";
        fi
     fi
done <<< "$images"
