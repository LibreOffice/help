#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: rt $ $Date: 2004-12-16 12:54:57 $
#*
#*    $Revision: 1.5 $
#*
#*    $Logfile:$
#*
#*    Copyright 2000 Sun Microsystems, Inc. All Rights Reserved.
#*
#*************************************************************************

# edit to match directory level 
PRJ		= ..$/..$/..$/..
# same for all makefiles in "helpcontent2"
PRJNAME = helpcontent2
# edit to match the current package
PACKAGE = text/shared/autopi
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = text_shared_autopi
# edit to match the current module
MODULE  = shared

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

# this list matches the *.xhp files to process
HZIPFILES = \
   01000000.hzip \
   01010000.hzip \
   01010100.hzip \
   01010200.hzip \
   01010300.hzip \
   01010400.hzip \
   01010500.hzip \
   01010600.hzip \
   01020000.hzip \
   01020100.hzip \
   01020200.hzip \
   01020300.hzip \
   01020400.hzip \
   01020500.hzip \
   01040000.hzip \
   01040100.hzip \
   01040200.hzip \
   01040300.hzip \
   01040400.hzip \
   01040500.hzip \
   01040600.hzip \
   01050000.hzip \
   01050100.hzip \
   01050200.hzip \
   01050300.hzip \
   01050400.hzip \
   01050500.hzip \
   01090000.hzip \
   01090100.hzip \
   01090200.hzip \
   01090210.hzip \
   01090220.hzip \
   01090300.hzip \
   01090400.hzip \
   01090500.hzip \
   01090600.hzip \
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
   01170400.hzip \
   01170500.hzip \
   purchase.hzip \
   startup.hzip \
   webwizard00.hzip \
   webwizard01.hzip \
   webwizard02.hzip \
   webwizard03.hzip \
   webwizard04.hzip \
   webwizard05.hzip \
   webwizard05bi.hzip \
   webwizard05is.hzip \
   webwizard06.hzip \
   webwizard07.hzip \
   webwizard07fc.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
