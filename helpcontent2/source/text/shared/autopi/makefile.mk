#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: fpe $ $Date: 2004-08-18 10:56:50 $
#*
#*    $Revision: 1.1 $
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
PACKAGE = text/shared/autopi
# uniqe name (module wide);
# using a modified forme of package should do here
TARGET  = text_shared_autopi
# edit to match the current module
MODULE  = shared

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xml files to process
HZIPFILES = \
    01000000.hzip \
    01020600.hzip \
    01020700.hzip \
    01020800.hzip \
    01030000.hzip \
    01030100.hzip \
    01030200.hzip \
    01030300.hzip \
    01030400.hzip \
    01030500.hzip \
    01050000.hzip \
    01050100.hzip \
    01050200.hzip \
    01050300.hzip \
    01050400.hzip \
    01050500.hzip \
    01060000.hzip \
    01090000.hzip \
    01100000.hzip \
    01100100.hzip \
    01100150.hzip \
    01100200.hzip \
    01100300.hzip \
    01100400.hzip \
    01100500.hzip \
    01110000.hzip \
    01110100.hzip \
    01110200.hzip \
    01110300.hzip \
    01110400.hzip \
    01110500.hzip \
    01110600.hzip \
    01120000.hzip \
    01120100.hzip \
    01120200.hzip \
    01120300.hzip \
    01120400.hzip \
    01120500.hzip \
    01130000.hzip \
    01130100.hzip \
    01130200.hzip \
    01150000.hzip \
    01170000.hzip \
    01170200.hzip \
    01170300.hzip \
    01170500.hzip \
    webwizard00.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
