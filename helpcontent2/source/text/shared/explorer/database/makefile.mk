#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: fpe $ $Date: 2004-08-18 10:57:05 $
#*
#*    $Revision: 1.1 $
#*
#*    $Logfile:$
#*
#*    Copyright 2000 Sun Microsystems, Inc. All Rights Reserved.
#*
#*************************************************************************

# edit to match directory level 
PRJ		= ..$/..$/..$/..$/..
# same for all makefiles in "help2"
PRJNAME = help2
# edit to match the current package
PACKAGE = text/shared/explorer/database
# uniqe name (module wide);
# using a modified forme of package should do here
TARGET  = text_shared_explorer_database
# edit to match the current module
MODULE  = shared

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xml files to process
HZIPFILES = \
    02000000.hzip \
    02000002.hzip \
    02010100.hzip \
    02010101.hzip \
    04000000.hzip \
    04000001.hzip \
    04010000.hzip \
    04030000.hzip \
    05000000.hzip \
    05000001.hzip \
    05000002.hzip \
    05000003.hzip \
    05010000.hzip \
    05010100.hzip \
    05020000.hzip \
    05020100.hzip \
    05030000.hzip \
    05030100.hzip \
    05030200.hzip \
    05030300.hzip \
    05030400.hzip \
    05040000.hzip \
    05040100.hzip \
    05040200.hzip \
    11000000.hzip \
    11000002.hzip \
    11010000.hzip \
    11010100.hzip \
    11020000.hzip \
    11030000.hzip \
    11030100.hzip \
    11040000.hzip \
    11060000.hzip \
    11080000.hzip \
    11090000.hzip \
    11110000.hzip \
    11120000.hzip \
    11150000.hzip \
    11150200.hzip \
    11160000.hzip \
    11170000.hzip \
    11170100.hzip \
    11180000.hzip \
    11180500.hzip \
    11190000.hzip \
    30000000.hzip \
    30100000.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
