#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: vg $ $Date: 2007-08-27 14:25:30 $
#*
#*    $Revision: 1.8 $
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
PACKAGE = text/sbasic/guide
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = text_sbasic_guide
# edit to match the current module
MODULE  = sbasic

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

# this list matches the *.xhp files to process
XHPFILES = \
   control_properties.xhp \
   create_dialog.xhp \
   insert_control.xhp \
   sample_code.xhp \
   show_dialog.xhp \
   translation.xhp 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
