#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: fpe $ $Date: 2004-08-18 10:53:49 $
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
PACKAGE = text/sbasic/shared/02
# uniqe name (module wide);
# using a modified forme of package should do here
TARGET  = text_sbasic_shared_02
# edit to match the current module
MODULE  = sbasic

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xml files to process
HZIPFILES = \
    11010000.hzip \
    11020000.hzip \
    11030000.hzip \
    11040000.hzip \
    11050000.hzip \
    11060000.hzip \
    11070000.hzip \
    11080000.hzip \
    11090000.hzip \
    11090100.hzip \
    11100000.hzip \
    11110000.hzip \
    11120000.hzip \
    11140000.hzip \
    11150000.hzip \
    11160000.hzip \
    11170000.hzip \
    20000000.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
