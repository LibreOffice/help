#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# This file incorporates work covered by the following license notice:
#
#   Licensed to the Apache Software Foundation (ASF) under one or more
#   contributor license agreements. See the NOTICE file distributed
#   with this work for additional information regarding copyright
#   ownership. The ASF licenses this file to you under the Apache
#   License, Version 2.0 (the "License"); you may not use this file
#   except in compliance with the License. You may obtain a copy of
#   the License at http://www.apache.org/licenses/LICENSE-2.0 .
#

# edit to match directory level 
PRJ		= ..$/..$/..$/..$/..
# same for all makefiles in "helpcontent2"
PRJNAME = helpcontent2
# edit to match the current package
PACKAGE = text/sbasic/shared/02
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = text_sbasic_shared_02
# edit to match the current module
MODULE  = sbasic

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

# this list matches the *.xhp files to process
XHPFILES = \
   11010000.xhp \
   11020000.xhp \
   11030000.xhp \
   11040000.xhp \
   11050000.xhp \
   11060000.xhp \
   11070000.xhp \
   11080000.xhp \
   11090000.xhp \
   11100000.xhp \
   11110000.xhp \
   11120000.xhp \
   11140000.xhp \
   11150000.xhp \
   11160000.xhp \
   11170000.xhp \
   11180000.xhp \
   11190000.xhp \
   20000000.xhp 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : tg_help.mk
