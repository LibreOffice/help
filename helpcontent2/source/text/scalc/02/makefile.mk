#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: rt $ $Date: 2005-01-27 09:52:59 $
#*
#*    $Revision: 1.6 $
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
PACKAGE = text/scalc/02
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = text_scalc_02
# edit to match the current module
MODULE  = scalc

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

# this list matches the *.xhp files to process
XHPFILES = \
   02130000.xhp \
   02140000.xhp \
   02150000.xhp \
   02160000.xhp \
   02170000.xhp \
   06010000.xhp \
   06030000.xhp \
   06040000.xhp \
   06050000.xhp \
   06060000.xhp \
   06070000.xhp \
   06080000.xhp \
   08010000.xhp \
   08080000.xhp \
   10050000.xhp \
   10060000.xhp \
   18010000.xhp \
   18020000.xhp 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
