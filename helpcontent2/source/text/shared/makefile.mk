#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: hr $ $Date: 2006-08-14 15:05:42 $
#*
#*    $Revision: 1.10 $
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

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

# this list matches the *.xhp files to process
XHPFILES = \
   3dsettings_toolbar.xhp \
   fontwork_toolbar.xhp \
   main0108.xhp \
   main0201.xhp \
   main0208.xhp \
   main0209.xhp \
   main0212.xhp \
   main0213.xhp \
   main0214.xhp \
   main0226.xhp \
   main0227.xhp \
   main0400.xhp \
   main0500.xhp \
   main0600.xhp \
   main0650.xhp \
   main0800.xhp \
   tree_strings.xhp 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
