#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: fpe $ $Date: 2004-08-18 10:59:23 $
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
PACKAGE = text/swriter/02
# uniqe name (module wide);
# using a modified forme of package should do here
TARGET  = text_swriter_02
# edit to match the current module
MODULE  = swriter

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xml files to process
HZIPFILES = \
    02110000.hzip \
    03210000.hzip \
    03220000.hzip \
    04090000.hzip \
    04100000.hzip \
    04210000.hzip \
    04220000.hzip \
    04230000.hzip \
    04240000.hzip \
    04250000.hzip \
    06040000.hzip \
    06070000.hzip \
    06080000.hzip \
    06090000.hzip \
    06120000.hzip \
    06130000.hzip \
    06140000.hzip \
    08010000.hzip \
    08080000.hzip \
    08090000.hzip \
    10010000.hzip \
    10020000.hzip \
    10030000.hzip \
    10050000.hzip \
    10070000.hzip \
    10080000.hzip \
    10090000.hzip \
    10110000.hzip \
    14010000.hzip \
    14020000.hzip \
    14030000.hzip \
    14040000.hzip \
    14050000.hzip \
    18010000.hzip \
    18030000.hzip \
    18030100.hzip \
    18030200.hzip \
    18030300.hzip \
    18030400.hzip \
    18030500.hzip \
    18030600.hzip \
    18030700.hzip \
    18120000.hzip \
    18130000.hzip \
    19010000.hzip \
    19020000.hzip \
    19030000.hzip \
    19040000.hzip \
    19050000.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
