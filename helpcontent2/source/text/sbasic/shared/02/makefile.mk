#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: vg $ $Date: 2007-08-27 14:28:20 $
#*
#*    $Revision: 1.8 $
#*
#*    $Logfile:$
#*
#*    Copyright 2000 Sun Microsystems, Inc. All Rights Reserved.
#*
#*************************************************************************

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
   20000000.xhp 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
