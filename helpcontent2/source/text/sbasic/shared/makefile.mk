#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: fpe $ $Date: 2004-08-18 10:53:45 $
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
PACKAGE = text/sbasic/shared
# uniqe name (module wide);
# using a modified forme of package should do here
TARGET  = text_sbasic_shared
# edit to match the current module
MODULE  = sbasic

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xml files to process
HZIPFILES = \
    00000002.hzip \
    00000003.hzip \
    01000000.hzip \
    01010210.hzip \
    01020000.hzip \
    01020100.hzip \
    01020200.hzip \
    01020300.hzip \
    01020500.hzip \
    01030000.hzip \
    01030100.hzip \
    01030200.hzip \
    01030300.hzip \
    01030400.hzip \
    01040000.hzip \
    01050000.hzip \
    01050100.hzip \
    01050200.hzip \
    01050300.hzip \
    01170100.hzip \
    01170101.hzip \
    01170103.hzip \
    03000000.hzip \
    03010000.hzip \
    03010100.hzip \
    03010101.hzip \
    03010102.hzip \
    03010103.hzip \
    03010200.hzip \
    03010201.hzip \
    03010300.hzip \
    03010301.hzip \
    03010302.hzip \
    03010303.hzip \
    03010304.hzip \
    03010305.hzip \
    03020000.hzip \
    03020100.hzip \
    03020101.hzip \
    03020102.hzip \
    03020103.hzip \
    03020104.hzip \
    03020200.hzip \
    03020201.hzip \
    03020202.hzip \
    03020203.hzip \
    03020204.hzip \
    03020205.hzip \
    03020300.hzip \
    03020301.hzip \
    03020302.hzip \
    03020303.hzip \
    03020304.hzip \
    03020305.hzip \
    03020400.hzip \
    03020401.hzip \
    03020402.hzip \
    03020403.hzip \
    03020404.hzip \
    03020405.hzip \
    03020406.hzip \
    03020407.hzip \
    03020408.hzip \
    03020409.hzip \
    03020410.hzip \
    03020411.hzip \
    03020412.hzip \
    03020413.hzip \
    03020414.hzip \
    03020415.hzip \
    03030000.hzip \
    03030100.hzip \
    03030101.hzip \
    03030102.hzip \
    03030103.hzip \
    03030104.hzip \
    03030105.hzip \
    03030106.hzip \
    03030107.hzip \
    03030108.hzip \
    03030200.hzip \
    03030201.hzip \
    03030202.hzip \
    03030203.hzip \
    03030204.hzip \
    03030205.hzip \
    03030206.hzip \
    03030300.hzip \
    03030301.hzip \
    03030302.hzip \
    03030303.hzip \
    03050000.hzip \
    03050100.hzip \
    03050200.hzip \
    03050300.hzip \
    03050500.hzip \
    03060000.hzip \
    03060100.hzip \
    03060200.hzip \
    03060300.hzip \
    03060400.hzip \
    03060500.hzip \
    03060600.hzip \
    03070000.hzip \
    03070100.hzip \
    03070200.hzip \
    03070300.hzip \
    03070400.hzip \
    03070500.hzip \
    03070600.hzip \
    03080000.hzip \
    03080100.hzip \
    03080101.hzip \
    03080102.hzip \
    03080103.hzip \
    03080104.hzip \
    03080200.hzip \
    03080201.hzip \
    03080202.hzip \
    03080300.hzip \
    03080301.hzip \
    03080302.hzip \
    03080400.hzip \
    03080401.hzip \
    03080500.hzip \
    03080501.hzip \
    03080502.hzip \
    03080600.hzip \
    03080601.hzip \
    03080700.hzip \
    03080701.hzip \
    03080800.hzip \
    03080801.hzip \
    03080802.hzip \
    03090000.hzip \
    03090100.hzip \
    03090101.hzip \
    03090102.hzip \
    03090103.hzip \
    03090200.hzip \
    03090201.hzip \
    03090202.hzip \
    03090203.hzip \
    03090300.hzip \
    03090301.hzip \
    03090302.hzip \
    03090303.hzip \
    03090400.hzip \
    03090401.hzip \
    03090402.hzip \
    03090403.hzip \
    03090404.hzip \
    03090405.hzip \
    03090406.hzip \
    03090407.hzip \
    03090408.hzip \
    03090409.hzip \
    03090410.hzip \
    03090411.hzip \
    03090412.hzip \
    03100000.hzip \
    03100100.hzip \
    03100300.hzip \
    03100400.hzip \
    03100500.hzip \
    03100600.hzip \
    03100700.hzip \
    03100900.hzip \
    03101000.hzip \
    03101100.hzip \
    03101300.hzip \
    03101400.hzip \
    03101500.hzip \
    03101600.hzip \
    03101700.hzip \
    03102000.hzip \
    03102100.hzip \
    03102101.hzip \
    03102200.hzip \
    03102300.hzip \
    03102400.hzip \
    03102600.hzip \
    03102700.hzip \
    03102800.hzip \
    03102900.hzip \
    03103000.hzip \
    03103100.hzip \
    03103200.hzip \
    03103300.hzip \
    03103400.hzip \
    03103450.hzip \
    03103500.hzip \
    03103600.hzip \
    03103700.hzip \
    03103800.hzip \
    03103900.hzip \
    03104000.hzip \
    03104100.hzip \
    03104200.hzip \
    03104300.hzip \
    03104400.hzip \
    03104500.hzip \
    03104600.hzip \
    03110000.hzip \
    03110100.hzip \
    03120000.hzip \
    03120100.hzip \
    03120101.hzip \
    03120102.hzip \
    03120103.hzip \
    03120104.hzip \
    03120105.hzip \
    03120200.hzip \
    03120201.hzip \
    03120202.hzip \
    03120300.hzip \
    03120301.hzip \
    03120302.hzip \
    03120303.hzip \
    03120304.hzip \
    03120305.hzip \
    03120306.hzip \
    03120307.hzip \
    03120308.hzip \
    03120309.hzip \
    03120310.hzip \
    03120311.hzip \
    03120312.hzip \
    03120313.hzip \
    03120314.hzip \
    03120315.hzip \
    03120400.hzip \
    03120401.hzip \
    03120402.hzip \
    03120403.hzip \
    03130000.hzip \
    03130100.hzip \
    03130500.hzip \
    03130600.hzip \
    03130700.hzip \
    03130800.hzip \
    03131000.hzip \
    03131300.hzip \
    03131400.hzip \
    03131500.hzip \
    03131600.hzip \
    03131700.hzip \
    03131800.hzip \
    03131900.hzip \
    03132000.hzip \
    03132100.hzip \
    03132200.hzip \
    03132300.hzip \
    05060700.hzip \
    keys.hzip \
    main0211.hzip \
    main0601.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
