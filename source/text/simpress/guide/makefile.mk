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
PACKAGE = text/simpress/guide
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = text_simpress_guide
# edit to match the current module
MODULE  = simpress

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

# this list matches the *.xhp files to process
XHPFILES = \
   3d_create.xhp \
   animated_gif_create.xhp \
   animated_gif_save.xhp \
   animated_objects.xhp \
   animated_slidechange.xhp \
   arrange_slides.xhp \
   background.xhp \
   change_scale.xhp \
   footer.xhp \
   gluepoints.xhp \
   html_export.xhp \
   html_import.xhp \
   individual.xhp \
   keyboard.xhp \
   layer_move.xhp \
   layer_new.xhp \
   layer_tipps.xhp \
   layers.xhp \
   line_arrow_styles.xhp \
   line_draw.xhp \
   line_edit.xhp \
   main.xhp \
   masterpage.xhp \
   move_object.xhp \
   orgchart.xhp \
   page_copy.xhp \
   palette_files.xhp \
   print_tofit.xhp \
   printing.xhp \
   rehearse_timings.xhp \
   select_object.xhp \
   show.xhp \
   table_insert.xhp \
   text2curve.xhp \
   vectorize.xhp 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : tg_help.mk
