#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: rt $ $Date: 2004-11-26 20:20:50 $
#*
#*    $Revision: 1.4 $
#*
#*    $Logfile:$
#*
#*    Copyright 2000 Sun Microsystems, Inc. All Rights Reserved.
#*
#*************************************************************************

# edit to match directory level 
PRJ		= ..$/..$/..
# same for all makefiles in "helpcontent2"
PRJNAME = helpcontent2
# edit to match the current package
PACKAGE = text/shared
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = text_shared
# edit to match the current module
MODULE  = shared

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xhp files to process
HZIPFILES = \
   3dsettings_toolbar.hzip \
   fontwork_toolbar.hzip \
   main0108.hzip \
   main0201.hzip \
   main0208.hzip \
   main0209.hzip \
   main0212.hzip \
   main0213.hzip \
   main0214.hzip \
   main0226.hzip \
   main0227.hzip \
   main0300.hzip \
   main0302.hzip \
   main0400.hzip \
   main0500.hzip \
   main0600.hzip \
   main0650.hzip \
   main0800.hzip \
   tree_strings.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
