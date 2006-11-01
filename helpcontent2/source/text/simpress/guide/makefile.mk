#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: vg $ $Date: 2006-11-01 17:20:17 $
#*
#*    $Revision: 1.9 $
#*
#*    $Logfile:$
#*
#*    Copyright 2000 Sun Microsystems, Inc. All Rights Reserved.
#*
#*************************************************************************

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
.INCLUDE : $(PRJ)$/makefile.pmk
