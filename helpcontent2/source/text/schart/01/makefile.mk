#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: rt $ $Date: 2004-12-16 12:50:47 $
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
PACKAGE = text/schart/01
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = text_schart_01
# edit to match the current module
MODULE  = schart

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

# this list matches the *.xhp files to process
HZIPFILES = \
   03010000.hzip \
   04010000.hzip \
   04020000.hzip \
   04030000.hzip \
   04040000.hzip \
   04050000.hzip \
   04060000.hzip \
   04070000.hzip \
   05010000.hzip \
   05010100.hzip \
   05010200.hzip \
   05020000.hzip \
   05020100.hzip \
   05020101.hzip \
   05020200.hzip \
   05020201.hzip \
   05030000.hzip \
   05040000.hzip \
   05040100.hzip \
   05040200.hzip \
   05040201.hzip \
   05050000.hzip \
   05050100.hzip \
   05060000.hzip \
   05070000.hzip \
   05080000.hzip \
   05090000.hzip \
   05100000.hzip \
   05110000.hzip \
   05120000.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
