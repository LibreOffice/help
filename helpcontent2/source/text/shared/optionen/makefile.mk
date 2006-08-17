#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: vg $ $Date: 2006-08-17 14:06:56 $
#*
#*    $Revision: 1.11 $
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
PACKAGE = text/shared/optionen
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = text_shared_optionen
# edit to match the current module
MODULE  = shared

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

# this list matches the *.xhp files to process
XHPFILES = \
   01000000.xhp \
   01010000.xhp \
   01010100.xhp \
   01010200.xhp \
   01010300.xhp \
   01010301.xhp \
   01010400.xhp \
   01010401.xhp \
   01010500.xhp \
   01010501.xhp \
   01010600.xhp \
   01010700.xhp \
   01010800.xhp \
   01010900.xhp \
   01011000.xhp \
   01012000.xhp \
   01013000.xhp \
   01014000.xhp \
   01020000.xhp \
   01020100.xhp \
   01020200.xhp \
   01020300.xhp \
   01020400.xhp \
   01030000.xhp \
   01030300.xhp \
   01030500.xhp \
   01040000.xhp \
   01040200.xhp \
   01040300.xhp \
   01040301.xhp \
   01040400.xhp \
   01040500.xhp \
   01040600.xhp \
   01040700.xhp \
   01040900.xhp \
   01041000.xhp \
   01041100.xhp \
   01050000.xhp \
   01050100.xhp \
   01050300.xhp \
   01060000.xhp \
   01060100.xhp \
   01060300.xhp \
   01060400.xhp \
   01060401.xhp \
   01060500.xhp \
   01060600.xhp \
   01060700.xhp \
   01070000.xhp \
   01070100.xhp \
   01070300.xhp \
   01070400.xhp \
   01070500.xhp \
   01080000.xhp \
   01090000.xhp \
   01090100.xhp \
   01110000.xhp \
   01110100.xhp \
   01130100.xhp \
   01130200.xhp \
   01140000.xhp \
   01150000.xhp \
   01150100.xhp \
   01150200.xhp \
   01150300.xhp \
   01160000.xhp \
   01160100.xhp \
   01160200.xhp \
   01160201.xhp \
   java.xhp \
   javaclasspath.xhp \
   javaparameters.xhp \
   macrosecurity.xhp \
   macrosecurity_sl.xhp \
   macrosecurity_ts.xhp \
   mailmerge.xhp \
   serverauthentication.xhp \
   testaccount.xhp \
   viewcertificate.xhp \
   viewcertificate_c.xhp \
   viewcertificate_d.xhp \
   viewcertificate_g.xhp 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
