#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: fpe $ $Date: 2004-08-19 19:54:15 $
#*
#*    $Revision: 1.3 $
#*
#*    $Logfile:$
#*
#*    Copyright 2000 Sun Microsystems, Inc. All Rights Reserved.
#*
#*************************************************************************

# edit to match directory level 
PRJ		= ..$/..$/..$/..
# same for all makefiles in "help2"
PRJNAME = help2
# edit to match the current package
PACKAGE = text/shared/autokorr
# uniqe name (module wide);
# using a modified forme of package should do here
TARGET  = text_shared_autokorr
# edit to match the current module
MODULE  = shared

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xhp files to process
HZIPFILES = \
    01000000.hzip \
    02000000.hzip \
    03000000.hzip \
    04000000.hzip \
    05000000.hzip \
    06000000.hzip \
    07000000.hzip \
    08000000.hzip \
    09000000.hzip \
    10000000.hzip \
    11000000.hzip \
    12000000.hzip \
    13000000.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
