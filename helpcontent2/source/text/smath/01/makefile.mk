#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: rt $ $Date: 2004-12-16 12:57:50 $
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
HZIPFILES = \
   02080000.hzip \
   02090000.hzip \
   02100000.hzip \
   02110000.hzip \
   03040000.hzip \
   03050000.hzip \
   03060000.hzip \
   03070000.hzip \
   03080000.hzip \
   03090000.hzip \
   03090100.hzip \
   03090200.hzip \
   03090300.hzip \
   03090400.hzip \
   03090500.hzip \
   03090600.hzip \
   03090700.hzip \
   03090800.hzip \
   03090900.hzip \
   03090901.hzip \
   03090902.hzip \
   03090903.hzip \
   03090904.hzip \
   03090905.hzip \
   03090906.hzip \
   03090907.hzip \
   03090908.hzip \
   03090909.hzip \
   03090910.hzip \
   03091100.hzip \
   03091200.hzip \
   03091300.hzip \
   03091400.hzip \
   03091500.hzip \
   03091600.hzip \
   05010000.hzip \
   05010100.hzip \
   05020000.hzip \
   05030000.hzip \
   05040000.hzip \
   05050000.hzip \
   06010000.hzip \
   06010100.hzip \
   06020000.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
