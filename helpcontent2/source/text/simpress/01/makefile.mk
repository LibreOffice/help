#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: fpe $ $Date: 2004-08-19 19:54:17 $
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
PACKAGE = text/simpress/01
# uniqe name (module wide);
# using a modified forme of package should do here
TARGET  = text_simpress_01
# edit to match the current module
MODULE  = simpress

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xhp files to process
HZIPFILES = \
    01170000.hzip \
    01180000.hzip \
    01180001.hzip \
    01180002.hzip \
    02110000.hzip \
    02120000.hzip \
    02130000.hzip \
    02140000.hzip \
    02150000.hzip \
    02160000.hzip \
    03050000.hzip \
    03060000.hzip \
    03070000.hzip \
    03080000.hzip \
    03090000.hzip \
    03100000.hzip \
    03110000.hzip \
    03120000.hzip \
    03130000.hzip \
    03140000.hzip \
    03150000.hzip \
    03150100.hzip \
    03150200.hzip \
    03150300.hzip \
    03150400.hzip \
    03151000.hzip \
    03151100.hzip \
    03151200.hzip \
    03151300.hzip \
    03152000.hzip \
    03160000.hzip \
    03170000.hzip \
    03180000.hzip \
    03190000.hzip \
    03990000.hzip \
    04010000.hzip \
    04020000.hzip \
    04030000.hzip \
    04030100.hzip \
    04080100.hzip \
    04110000.hzip \
    04110100.hzip \
    04110200.hzip \
    04120000.hzip \
    04130000.hzip \
    04140000.hzip \
    04990000.hzip \
    04990100.hzip \
    04990200.hzip \
    04990300.hzip \
    04990400.hzip \
    04990500.hzip \
    04990600.hzip \
    04990700.hzip \
    05090000.hzip \
    05100000.hzip \
    05120000.hzip \
    05120100.hzip \
    05130000.hzip \
    05130005.hzip \
    05130006.hzip \
    05130007.hzip \
    05130008.hzip \
    05130009.hzip \
    05140000.hzip \
    05150000.hzip \
    05170000.hzip \
    05250000.hzip \
    05250500.hzip \
    05250600.hzip \
    05250700.hzip \
    05990000.hzip \
    06030000.hzip \
    06040000.hzip \
    06050000.hzip \
    06060000.hzip \
    06070000.hzip \
    06080000.hzip \
    06100000.hzip \
    06100100.hzip \
    13050000.hzip \
    13050100.hzip \
    13050200.hzip \
    13050300.hzip \
    13050400.hzip \
    13050500.hzip \
    13050600.hzip \
    13050700.hzip \
    13140000.hzip \
    13150000.hzip \
    13160000.hzip \
    13170000.hzip \
    13180000.hzip \
    13180100.hzip \
    13180200.hzip \
    13180300.hzip \
    slidesorter.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
