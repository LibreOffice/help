#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: rt $ $Date: 2005-01-27 09:54:31 $
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
XHPFILES = \
   03010000.xhp \
   04010000.xhp \
   04020000.xhp \
   04030000.xhp \
   04040000.xhp \
   04050000.xhp \
   04060000.xhp \
   04070000.xhp \
   05010000.xhp \
   05010100.xhp \
   05010200.xhp \
   05020000.xhp \
   05020100.xhp \
   05020101.xhp \
   05020200.xhp \
   05020201.xhp \
   05030000.xhp \
   05040000.xhp \
   05040100.xhp \
   05040200.xhp \
   05040201.xhp \
   05050000.xhp \
   05050100.xhp \
   05060000.xhp \
   05070000.xhp \
   05080000.xhp \
   05090000.xhp \
   05100000.xhp \
   05110000.xhp \
   05120000.xhp 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
