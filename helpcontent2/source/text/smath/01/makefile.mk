#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: rt $ $Date: 2005-01-27 10:01:44 $
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
PACKAGE = text/smath/01
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = text_smath_01
# edit to match the current module
MODULE  = smath

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

# this list matches the *.xhp files to process
XHPFILES = \
   02080000.xhp \
   02090000.xhp \
   02100000.xhp \
   02110000.xhp \
   03040000.xhp \
   03050000.xhp \
   03060000.xhp \
   03070000.xhp \
   03080000.xhp \
   03090000.xhp \
   03090100.xhp \
   03090200.xhp \
   03090300.xhp \
   03090400.xhp \
   03090500.xhp \
   03090600.xhp \
   03090700.xhp \
   03090800.xhp \
   03090900.xhp \
   03090901.xhp \
   03090902.xhp \
   03090903.xhp \
   03090904.xhp \
   03090905.xhp \
   03090906.xhp \
   03090907.xhp \
   03090908.xhp \
   03090909.xhp \
   03090910.xhp \
   03091100.xhp \
   03091200.xhp \
   03091300.xhp \
   03091400.xhp \
   03091500.xhp \
   03091600.xhp \
   05010000.xhp \
   05010100.xhp \
   05020000.xhp \
   05030000.xhp \
   05040000.xhp \
   05050000.xhp \
   06010000.xhp \
   06010100.xhp \
   06020000.xhp 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
