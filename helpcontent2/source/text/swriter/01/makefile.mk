#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: fpe $ $Date: 2004-08-18 10:59:12 $
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
PACKAGE = text/swriter/01
# uniqe name (module wide);
# using a modified forme of package should do here
TARGET  = text_swriter_01
# edit to match the current module
MODULE  = swriter

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xml files to process
HZIPFILES = \
    01150000.hzip \
    01160100.hzip \
    01160200.hzip \
    01160300.hzip \
    01160400.hzip \
    01160500.hzip \
    02110000.hzip \
    02110100.hzip \
    02120000.hzip \
    02120100.hzip \
    02130000.hzip \
    02140000.hzip \
    02150000.hzip \
    02160000.hzip \
    02170000.hzip \
    03050000.hzip \
    03070000.hzip \
    03080000.hzip \
    03090000.hzip \
    03100000.hzip \
    03120000.hzip \
    03130000.hzip \
    03140000.hzip \
    04010000.hzip \
    04020000.hzip \
    04020100.hzip \
    04020200.hzip \
    04030000.hzip \
    04040000.hzip \
    04060000.hzip \
    04060100.hzip \
    04070000.hzip \
    04070100.hzip \
    04070200.hzip \
    04070300.hzip \
    04090000.hzip \
    04090001.hzip \
    04090002.hzip \
    04090003.hzip \
    04090004.hzip \
    04090005.hzip \
    04090006.hzip \
    04090007.hzip \
    04090100.hzip \
    04090200.hzip \
    04120000.hzip \
    04120100.hzip \
    04120200.hzip \
    04120201.hzip \
    04120210.hzip \
    04120211.hzip \
    04120212.hzip \
    04120213.hzip \
    04120214.hzip \
    04120215.hzip \
    04120216.hzip \
    04120217.hzip \
    04120219.hzip \
    04120220.hzip \
    04120221.hzip \
    04120222.hzip \
    04120223.hzip \
    04120224.hzip \
    04120225.hzip \
    04120226.hzip \
    04120227.hzip \
    04120229.hzip \
    04120250.hzip \
    04120300.hzip \
    04130000.hzip \
    04130100.hzip \
    04150000.hzip \
    04180400.hzip \
    04190000.hzip \
    04200000.hzip \
    04210000.hzip \
    04220000.hzip \
    04230000.hzip \
    04990000.hzip \
    05030200.hzip \
    05030400.hzip \
    05030800.hzip \
    05040000.hzip \
    05040500.hzip \
    05040501.hzip \
    05040600.hzip \
    05040700.hzip \
    05040800.hzip \
    05060000.hzip \
    05060100.hzip \
    05060200.hzip \
    05060201.hzip \
    05060300.hzip \
    05060700.hzip \
    05060800.hzip \
    05060900.hzip \
    05080000.hzip \
    05090000.hzip \
    05090100.hzip \
    05090200.hzip \
    05090201.hzip \
    05090300.hzip \
    05100000.hzip \
    05100100.hzip \
    05100200.hzip \
    05100300.hzip \
    05100400.hzip \
    05100500.hzip \
    05100600.hzip \
    05100700.hzip \
    05110000.hzip \
    05110100.hzip \
    05110200.hzip \
    05110300.hzip \
    05110500.hzip \
    05110600.hzip \
    05120000.hzip \
    05120100.hzip \
    05120200.hzip \
    05120300.hzip \
    05120400.hzip \
    05120500.hzip \
    05120600.hzip \
    05130000.hzip \
    05130001.hzip \
    05130002.hzip \
    05130003.hzip \
    05130004.hzip \
    05130100.hzip \
    05140000.hzip \
    05150000.hzip \
    05150100.hzip \
    05150101.hzip \
    05150104.hzip \
    05150200.hzip \
    05150300.hzip \
    05170000.hzip \
    05180000.hzip \
    05190000.hzip \
    05200000.hzip \
    05990000.hzip \
    06030000.hzip \
    06040000.hzip \
    06060000.hzip \
    06060100.hzip \
    06080000.hzip \
    06080100.hzip \
    06080200.hzip \
    06090000.hzip \
    06100000.hzip \
    06110000.hzip \
    06120000.hzip \
    06160000.hzip \
    06170000.hzip \
    06180000.hzip \
    06190000.hzip \
    06200000.hzip \
    06210000.hzip \
    06220000.hzip \
    06990000.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
