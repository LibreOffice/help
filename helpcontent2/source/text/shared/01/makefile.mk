#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: fpe $ $Date: 2004-08-18 10:56:09 $
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
PACKAGE = text/shared/01
# uniqe name (module wide);
# using a modified forme of package should do here
TARGET  = text_shared_01
# edit to match the current module
MODULE  = shared

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xml files to process
HZIPFILES = \
    01010000.hzip \
    01010001.hzip \
    01010100.hzip \
    01010200.hzip \
    01010201.hzip \
    01010202.hzip \
    01010203.hzip \
    01010300.hzip \
    01010301.hzip \
    01010302.hzip \
    01010303.hzip \
    01010304.hzip \
    01020000.hzip \
    01020101.hzip \
    01020103.hzip \
    01050000.hzip \
    01060000.hzip \
    01070000.hzip \
    01070001.hzip \
    01100000.hzip \
    01100100.hzip \
    01100200.hzip \
    01100300.hzip \
    01100400.hzip \
    01100500.hzip \
    01110000.hzip \
    01110100.hzip \
    01110101.hzip \
    01110300.hzip \
    01110400.hzip \
    01120000.hzip \
    01130000.hzip \
    01140000.hzip \
    01160000.hzip \
    01160200.hzip \
    01160300.hzip \
    01170000.hzip \
    01180000.hzip \
    01190000.hzip \
    01990000.hzip \
    02010000.hzip \
    02020000.hzip \
    02030000.hzip \
    02040000.hzip \
    02050000.hzip \
    02060000.hzip \
    02070000.hzip \
    02090000.hzip \
    02100000.hzip \
    02100001.hzip \
    02100100.hzip \
    02100200.hzip \
    02100300.hzip \
    02110000.hzip \
    02180000.hzip \
    02180100.hzip \
    02190000.hzip \
    02200000.hzip \
    02200100.hzip \
    02200200.hzip \
    02210101.hzip \
    02220000.hzip \
    02220100.hzip \
    02230000.hzip \
    02230100.hzip \
    02230150.hzip \
    02230200.hzip \
    02230300.hzip \
    02230400.hzip \
    02230401.hzip \
    02230402.hzip \
    02230500.hzip \
    02240000.hzip \
    02250000.hzip \
    03010000.hzip \
    03020000.hzip \
    03030000.hzip \
    03040000.hzip \
    03050000.hzip \
    03060000.hzip \
    03110000.hzip \
    03150100.hzip \
    03170000.hzip \
    03990000.hzip \
    04050000.hzip \
    04060000.hzip \
    04060100.hzip \
    04060200.hzip \
    04100000.hzip \
    04110000.hzip \
    04140000.hzip \
    04150000.hzip \
    04150100.hzip \
    04150200.hzip \
    04150300.hzip \
    04150400.hzip \
    04150500.hzip \
    04160100.hzip \
    04160101.hzip \
    04160102.hzip \
    04160103.hzip \
    04160109.hzip \
    04160300.hzip \
    04160500.hzip \
    04180100.hzip \
    04990000.hzip \
    05010000.hzip \
    05020000.hzip \
    05020100.hzip \
    05020200.hzip \
    05020300.hzip \
    05020301.hzip \
    05020400.hzip \
    05020500.hzip \
    05020600.hzip \
    05020700.hzip \
    05030000.hzip \
    05030100.hzip \
    05030300.hzip \
    05030500.hzip \
    05030600.hzip \
    05030700.hzip \
    05030800.hzip \
    05040100.hzip \
    05040200.hzip \
    05040300.hzip \
    05040400.hzip \
    05050000.hzip \
    05060000.hzip \
    05070000.hzip \
    05070100.hzip \
    05070200.hzip \
    05070300.hzip \
    05070400.hzip \
    05070500.hzip \
    05070600.hzip \
    05080000.hzip \
    05080100.hzip \
    05080200.hzip \
    05080300.hzip \
    05080400.hzip \
    05090000.hzip \
    05100000.hzip \
    05110000.hzip \
    05110100.hzip \
    05110200.hzip \
    05110300.hzip \
    05110400.hzip \
    05110500.hzip \
    05110600.hzip \
    05110700.hzip \
    05110800.hzip \
    05120000.hzip \
    05120100.hzip \
    05120200.hzip \
    05120300.hzip \
    05140100.hzip \
    05150101.hzip \
    05190000.hzip \
    05200000.hzip \
    05200100.hzip \
    05200200.hzip \
    05200300.hzip \
    05210000.hzip \
    05210100.hzip \
    05210200.hzip \
    05210300.hzip \
    05210400.hzip \
    05210500.hzip \
    05210600.hzip \
    05210700.hzip \
    05220000.hzip \
    05230000.hzip \
    05230100.hzip \
    05230300.hzip \
    05230400.hzip \
    05230500.hzip \
    05240000.hzip \
    05240100.hzip \
    05240200.hzip \
    05250000.hzip \
    05250100.hzip \
    05250200.hzip \
    05250300.hzip \
    05250400.hzip \
    05250500.hzip \
    05250600.hzip \
    05260000.hzip \
    05260100.hzip \
    05260200.hzip \
    05260300.hzip \
    05260400.hzip \
    05260500.hzip \
    05260600.hzip \
    05270000.hzip \
    05280000.hzip \
    05290000.hzip \
    05290100.hzip \
    05290200.hzip \
    05290300.hzip \
    05290400.hzip \
    05320000.hzip \
    05340100.hzip \
    05340200.hzip \
    05340400.hzip \
    05340402.hzip \
    05340404.hzip \
    05340405.hzip \
    05340500.hzip \
    05340600.hzip \
    05350000.hzip \
    05350100.hzip \
    05350200.hzip \
    05350300.hzip \
    05350400.hzip \
    05350500.hzip \
    05350600.hzip \
    05360000.hzip \
    05990000.hzip \
    06010000.hzip \
    06010101.hzip \
    06010500.hzip \
    06020000.hzip \
    06030000.hzip \
    06040000.hzip \
    06040100.hzip \
    06040200.hzip \
    06040300.hzip \
    06040400.hzip \
    06040500.hzip \
    06040600.hzip \
    06050000.hzip \
    06050100.hzip \
    06050200.hzip \
    06050300.hzip \
    06050400.hzip \
    06050500.hzip \
    06050600.hzip \
    06130000.hzip \
    06130001.hzip \
    06130010.hzip \
    06130100.hzip \
    06130500.hzip \
    06140000.hzip \
    06140101.hzip \
    06140102.hzip \
    06140200.hzip \
    06140300.hzip \
    06140400.hzip \
    06140401.hzip \
    06140402.hzip \
    06140500.hzip \
    06150000.hzip \
    06150100.hzip \
    06150110.hzip \
    06150120.hzip \
    06150200.hzip \
    06150210.hzip \
    06200000.hzip \
    06201000.hzip \
    06202000.hzip \
    06990000.hzip \
    07010000.hzip \
    07080000.hzip \
    08060100.hzip \
    about_meta_tags.hzip \
    gallery.hzip \
    gallery_files.hzip \
    mediaplayer.hzip \
    packagemanager.hzip \
    password_dlg.hzip \
    password_main.hzip \
    ref_pdf_export.hzip \
    ref_pdf_send_as.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
