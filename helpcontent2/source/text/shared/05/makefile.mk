#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: rt $ $Date: 2004-11-26 21:29:22 $
#*
#*    $Revision: 1.4 $
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
PACKAGE = text/shared/05
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = text_shared_05
# edit to match the current module
MODULE  = shared

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xhp files to process
HZIPFILES = \
   00000001.hzip \
   00000002.hzip \
   00000100.hzip \
   00000110.hzip \
   00000120.hzip \
   00000130.hzip \
   00000140.hzip \
   00000150.hzip \
   00000160.hzip \
   err_html.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
