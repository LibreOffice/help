#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: rt $ $Date: 2004-11-26 16:24:13 $
#*
#*    $Revision: 1.4 $
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

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xhp files to process
HZIPFILES = \
   02130000.hzip \
   02140000.hzip \
   02150000.hzip \
   02160000.hzip \
   02170000.hzip \
   06010000.hzip \
   06030000.hzip \
   06040000.hzip \
   06050000.hzip \
   06060000.hzip \
   06070000.hzip \
   06080000.hzip \
   08010000.hzip \
   08080000.hzip \
   10050000.hzip \
   10060000.hzip \
   18010000.hzip \
   18020000.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
