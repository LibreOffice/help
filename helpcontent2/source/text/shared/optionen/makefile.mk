#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: fpe $ $Date: 2004-08-19 19:54:16 $
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
PACKAGE = text/shared/optionen
# uniqe name (module wide);
# using a modified forme of package should do here
TARGET  = text_shared_optionen
# edit to match the current module
MODULE  = shared

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xhp files to process
HZIPFILES = \
    01000000.hzip \
    01010000.hzip \
    01010100.hzip \
    01010200.hzip \
    01010300.hzip \
    01010301.hzip \
    01010400.hzip \
    01010401.hzip \
    01010500.hzip \
    01010501.hzip \
    01010600.hzip \
    01010700.hzip \
    01010800.hzip \
    01010900.hzip \
    01010950.hzip \
    01011000.hzip \
    01012000.hzip \
    01013000.hzip \
    01014000.hzip \
    01020000.hzip \
    01020100.hzip \
    01020200.hzip \
    01030000.hzip \
    01030300.hzip \
    01030500.hzip \
    01040000.hzip \
    01040200.hzip \
    01040300.hzip \
    01040301.hzip \
    01040400.hzip \
    01040500.hzip \
    01040600.hzip \
    01040700.hzip \
    01040801.hzip \
    01040900.hzip \
    01041000.hzip \
    01050000.hzip \
    01050100.hzip \
    01050300.hzip \
    01060000.hzip \
    01060100.hzip \
    01060200.hzip \
    01060300.hzip \
    01060400.hzip \
    01060401.hzip \
    01060500.hzip \
    01060600.hzip \
    01060700.hzip \
    01070000.hzip \
    01070100.hzip \
    01070300.hzip \
    01070400.hzip \
    01070500.hzip \
    01080000.hzip \
    01090000.hzip \
    01090100.hzip \
    01110000.hzip \
    01110100.hzip \
    01130100.hzip \
    01130200.hzip \
    01140000.hzip \
    01150000.hzip \
    01150100.hzip \
    01150200.hzip \
    01150300.hzip \
    01160000.hzip \
    01160100.hzip \
    java.hzip \
    javaclasspath.hzip \
    javaparameters.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
