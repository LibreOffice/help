#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: rt $ $Date: 2004-12-16 12:52:21 $
#*
#*    $Revision: 1.5 $
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
HZIPFILES = \
   align_arrange.hzip \
   color_define.hzip \
   combine_etc.hzip \
   cross_fading.hzip \
   draw_sector.hzip \
   duplicate_object.hzip \
   eyedropper.hzip \
   gradient.hzip \
   graphic_insert.hzip \
   groups.hzip \
   join_objects.hzip \
   join_objects3d.hzip \
   keyboard.hzip \
   main.hzip \
   rotate_object.hzip \
   text_3d.hzip \
   text_enter.hzip \
   text_to_bitmap.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
