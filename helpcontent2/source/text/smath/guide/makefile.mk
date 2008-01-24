#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: vg $ $Date: 2008-01-24 14:14:18 $
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
PACKAGE = text/smath/guide
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = text_smath_guide
# edit to match the current module
MODULE  = smath

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

# this list matches the *.xhp files to process
XHPFILES = \
   align.xhp \
   attributes.xhp \
   brackets.xhp \
   comment.xhp \
   keyboard.xhp \
   limits.xhp \
   main.xhp \
   newline.xhp \
   parentheses.xhp \
   text.xhp 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
