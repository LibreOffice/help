#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: rt $ $Date: 2005-01-27 10:02:48 $
#*
#*    $Revision: 1.6 $
#*
#*    $Logfile:$
#*
#*    Copyright 2000 Sun Microsystems, Inc. All Rights Reserved.
#*
#*************************************************************************

# edit to match directory level 
PRJ		= ..$/..$/..
# same for all makefiles in "helpcontent2"
PRJNAME = helpcontent2
# edit to match the current package
PACKAGE = text/swriter
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = text_swriter
# edit to match the current module
MODULE  = swriter

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

# this list matches the *.xhp files to process
XHPFILES = \
   main0000.xhp \
   main0100.xhp \
   main0101.xhp \
   main0102.xhp \
   main0103.xhp \
   main0104.xhp \
   main0105.xhp \
   main0106.xhp \
   main0107.xhp \
   main0110.xhp \
   main0200.xhp \
   main0202.xhp \
   main0203.xhp \
   main0204.xhp \
   main0205.xhp \
   main0206.xhp \
   main0208.xhp \
   main0210.xhp \
   main0213.xhp \
   main0214.xhp \
   main0215.xhp \
   main0216.xhp \
   main0218.xhp \
   main0219.xhp \
   main0220.xhp \
   main0503.xhp 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
