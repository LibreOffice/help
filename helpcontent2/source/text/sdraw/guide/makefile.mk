#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: rt $ $Date: 2005-01-28 10:05:47 $
#*
#*    $Revision: 1.7 $
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
.INCLUDE : $(PRJ)$/makefile.pmk
