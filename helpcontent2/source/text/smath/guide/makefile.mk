#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: rt $ $Date: 2004-12-16 12:58:37 $
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
HZIPFILES = \
   align.hzip \
   attributes.hzip \
   brackets.hzip \
   comment.hzip \
   keyboard.hzip \
   main.hzip \
   newline.hzip \
   parentheses.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
