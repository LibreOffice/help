#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: fpe $ $Date: 2004-08-18 11:51:54 $
#*
#*    $Revision: 1.2 $
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
PACKAGE = text/scalc/01
# uniqe name (module wide);
# using a modified forme of package should do here
TARGET  = text_scalc_01
# edit to match the current module
MODULE  = scalc

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xhp files to process
HZIPFILES = \
    02110000.hzip \
    02120000.hzip \
    02120100.hzip \
    02140000.hzip \
    02140100.hzip \
    02140200.hzip \
    02140300.hzip \
    02140400.hzip \
    02140500.hzip \
    02140600.hzip \
    02150000.hzip \
    02160000.hzip \
    02170000.hzip \
    02180000.hzip \
    02190000.hzip \
    02190100.hzip \
    02190200.hzip \
    02200000.hzip \
    02210000.hzip \
    03070000.hzip \
    03080000.hzip \
    03090000.hzip \
    03100000.hzip \
    04010000.hzip \
    04010100.hzip \
    04010200.hzip \
    04020000.hzip \
    04030000.hzip \
    04040000.hzip \
    04050000.hzip \
    04050100.hzip \
    04060000.hzip \
    04060100.hzip \
    04060101.hzip \
    04060103.hzip \
    04060104.hzip \
    04060105.hzip \
    04060106.hzip \
    04060107.hzip \
    04060108.hzip \
    04060109.hzip \
    04060110.hzip \
    04060111.hzip \
    04060112.hzip \
    04060115.hzip \
    04060116.hzip \
    04060118.hzip \
    04060119.hzip \
    04060181.hzip \
    04060182.hzip \
    04060183.hzip \
    04060184.hzip \
    04060185.hzip \
    04060199.hzip \
    04070000.hzip \
    04070100.hzip \
    04070200.hzip \
    04070300.hzip \
    04070400.hzip \
    04080000.hzip \
    04090000.hzip \
    05020000.hzip \
    05020600.hzip \
    05030000.hzip \
    05030200.hzip \
    05030300.hzip \
    05030400.hzip \
    05040000.hzip \
    05040200.hzip \
    05050000.hzip \
    05050100.hzip \
    05050300.hzip \
    05060000.hzip \
    05060100.hzip \
    05060200.hzip \
    05070000.hzip \
    05070500.hzip \
    05080000.hzip \
    05080100.hzip \
    05080200.hzip \
    05080300.hzip \
    05080400.hzip \
    05090000.hzip \
    05100000.hzip \
    05110000.hzip \
    05120000.hzip \
    05130005.hzip \
    06020000.hzip \
    06030000.hzip \
    06030100.hzip \
    06030200.hzip \
    06030300.hzip \
    06030400.hzip \
    06030500.hzip \
    06030600.hzip \
    06030700.hzip \
    06030800.hzip \
    06030900.hzip \
    06031000.hzip \
    06040000.hzip \
    06050000.hzip \
    06060000.hzip \
    06060100.hzip \
    06060200.hzip \
    06070000.hzip \
    06080000.hzip \
    06130000.hzip \
    06990000.hzip \
    07080000.hzip \
    07090000.hzip \
    12010000.hzip \
    12010100.hzip \
    12020000.hzip \
    12030000.hzip \
    12030100.hzip \
    12030200.hzip \
    12040000.hzip \
    12040100.hzip \
    12040201.hzip \
    12040300.hzip \
    12040400.hzip \
    12040500.hzip \
    12050000.hzip \
    12050100.hzip \
    12050200.hzip \
    12060000.hzip \
    12070000.hzip \
    12070100.hzip \
    12080000.hzip \
    12080100.hzip \
    12080200.hzip \
    12080300.hzip \
    12080400.hzip \
    12080500.hzip \
    12080600.hzip \
    12090000.hzip \
    12090100.hzip \
    12090101.hzip \
    12090102.hzip \
    12090103.hzip \
    12090104.hzip \
    12090200.hzip \
    12090300.hzip \
    12100000.hzip \
    12120000.hzip \
    12120100.hzip \
    12120200.hzip \
    12120300.hzip \
    func_date.hzip \
    func_datevalue.hzip \
    func_day.hzip \
    func_days.hzip \
    func_days360.hzip \
    func_eastersunday.hzip \
    func_edate.hzip \
    func_eomonth.hzip \
    func_hour.hzip \
    func_minute.hzip \
    func_month.hzip \
    func_networkdays.hzip \
    func_now.hzip \
    func_second.hzip \
    func_time.hzip \
    func_timevalue.hzip \
    func_today.hzip \
    func_weeknum.hzip \
    func_weeknumadd.hzip \
    func_workday.hzip \
    func_year.hzip \
    func_yearfrac.hzip \
    taskpanel.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
