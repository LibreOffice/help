#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: fpe $ $Date: 2004-08-18 10:56:32 $
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
PACKAGE = text/shared/02
# uniqe name (module wide);
# using a modified forme of package should do here
TARGET  = text_shared_02
# edit to match the current module
MODULE  = shared

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xml files to process
HZIPFILES = \
    01110000.hzip \
    01140000.hzip \
    01170000.hzip \
    01170001.hzip \
    01170002.hzip \
    01170003.hzip \
    01170004.hzip \
    01170100.hzip \
    01170101.hzip \
    01170103.hzip \
    01170200.hzip \
    01170201.hzip \
    01170202.hzip \
    01170203.hzip \
    01170300.hzip \
    01170400.hzip \
    01170500.hzip \
    01170600.hzip \
    01170700.hzip \
    01170800.hzip \
    01170801.hzip \
    01170802.hzip \
    01170900.hzip \
    01170901.hzip \
    01170902.hzip \
    01170903.hzip \
    01170904.hzip \
    01171000.hzip \
    01171100.hzip \
    01171200.hzip \
    01171300.hzip \
    01171400.hzip \
    01220000.hzip \
    01230000.hzip \
    02010000.hzip \
    02020000.hzip \
    02030000.hzip \
    02040000.hzip \
    02050000.hzip \
    02130000.hzip \
    02140000.hzip \
    02160000.hzip \
    02170000.hzip \
    02210000.hzip \
    03110000.hzip \
    03120000.hzip \
    03130000.hzip \
    03140000.hzip \
    03150000.hzip \
    03200000.hzip \
    05020000.hzip \
    05090000.hzip \
    05110000.hzip \
    06050000.hzip \
    06060000.hzip \
    06100000.hzip \
    06110000.hzip \
    06120000.hzip \
    07010000.hzip \
    07060000.hzip \
    07070000.hzip \
    07070100.hzip \
    07070200.hzip \
    07080000.hzip \
    07090000.hzip \
    08010000.hzip \
    08020000.hzip \
    09010000.hzip \
    09020000.hzip \
    09030000.hzip \
    09050000.hzip \
    09060000.hzip \
    09070000.hzip \
    09070100.hzip \
    09070200.hzip \
    09070300.hzip \
    09070400.hzip \
    10010000.hzip \
    10020000.hzip \
    10030000.hzip \
    10040000.hzip \
    10100000.hzip \
    12000000.hzip \
    12010000.hzip \
    12020000.hzip \
    12030000.hzip \
    12040000.hzip \
    12050000.hzip \
    12070000.hzip \
    12070100.hzip \
    12070200.hzip \
    12070300.hzip \
    12080000.hzip \
    12090000.hzip \
    12090100.hzip \
    12090101.hzip \
    12100000.hzip \
    12100100.hzip \
    12100200.hzip \
    12110000.hzip \
    12120000.hzip \
    12130000.hzip \
    12140000.hzip \
    13010000.hzip \
    13020000.hzip \
    14010000.hzip \
    14020000.hzip \
    14020100.hzip \
    14020200.hzip \
    14030000.hzip \
    14040000.hzip \
    14050000.hzip \
    14060000.hzip \
    14070000.hzip \
    18010000.hzip \
    18020000.hzip \
    18030000.hzip \
    19090000.hzip \
    20020000.hzip \
    20030000.hzip \
    20040000.hzip \
    20050000.hzip \
    20060000.hzip \
    20080000.hzip \
    20090000.hzip \
    20100000.hzip \
    20110000.hzip \
    20120000.hzip \
    24010000.hzip \
    24020000.hzip \
    24030000.hzip \
    24040000.hzip \
    24050000.hzip \
    24060000.hzip \
    24070000.hzip \
    24080000.hzip \
    24090000.hzip \
    24100000.hzip \
    paintbrush.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
