#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: fpe $ $Date: 2004-08-19 19:54:14 $
#*
#*    $Revision: 1.3 $
#*
#*    $Logfile:$
#*
#*    Copyright 2000 Sun Microsystems, Inc. All Rights Reserved.
#*
#*************************************************************************

# edit to match directory level 
PRJ		= ..$/..$/..
# same for all makefiles in "help2"
PRJNAME = help2
# edit to match the current package
PACKAGE = text/shared
# uniqe name (module wide);
# using a modified forme of package should do here
TARGET  = text_shared
# edit to match the current module
MODULE  = shared

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xhp files to process
HZIPFILES = \
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
