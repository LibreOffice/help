#!/bin/bash
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

# This script zips the various help files and moves them into the help folder so they can be properly tested in the help viewer

cd ../source/
zip -r sbasic.jar text/sbasic/
zip -r scalc.jar text/scalc/
zip -r schart.jar text/schart/
zip -r sdraw.jar text/sdraw/
zip -r shared.jar text/shared/
zip -r simpress.jar text/simpress/
zip -r smath.jar text/smath/
zip -r swriter.jar text/swriter/

# default location of help files for libreoffice on ubuntu
# uncomment this and change the location accordingly
#sudo mv -f *.jar /usr/share/libreoffice/help/en-US/

