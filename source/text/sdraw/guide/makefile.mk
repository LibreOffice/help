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
PRJ		= ..$/..$/..$/..
# same for all makefiles in "helpcontent2"
PRJNAME = helpcontent2
# edit to match the current package
PACKAGE = text/sdraw/guide
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = text_sdraw_guide
# edit to match the current module
MODULE  = sdraw

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

# this list matches the *.xhp files to process
XHPFILES = \
   align_arrange.xhp \
   color_define.xhp \
   combine_etc.xhp \
   cross_fading.xhp \
   draw_sector.xhp \
   duplicate_object.xhp \
   eyedropper.xhp \
   gradient.xhp \
   graphic_insert.xhp \
   groups.xhp \
   join_objects.xhp \
   join_objects3d.xhp \
   keyboard.xhp \
   main.xhp \
   rotate_object.xhp \
   text_enter.xhp 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : tg_help.mk
