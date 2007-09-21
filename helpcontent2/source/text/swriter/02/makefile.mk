#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: vg $ $Date: 2007-09-21 10:17:36 $
#*
#*    $Revision: 1.9 $
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
PACKAGE = text/swriter/02
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = text_swriter_02
# edit to match the current module
MODULE  = swriter

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

# this list matches the *.xhp files to process
XHPFILES = \
   02110000.xhp \
   03210000.xhp \
   03220000.xhp \
   04090000.xhp \
   04100000.xhp \
   04210000.xhp \
   04220000.xhp \
   04230000.xhp \
   04240000.xhp \
   04250000.xhp \
   06040000.xhp \
   06070000.xhp \
   06080000.xhp \
   06090000.xhp \
   06120000.xhp \
   06130000.xhp \
   06140000.xhp \
   08010000.xhp \
   08080000.xhp \
   10010000.xhp \
   10020000.xhp \
   10030000.xhp \
   10050000.xhp \
   10070000.xhp \
   10080000.xhp \
   10090000.xhp \
   10110000.xhp \
   14010000.xhp \
   14020000.xhp \
   14030000.xhp \
   14040000.xhp \
   14050000.xhp \
   18010000.xhp \
   18030000.xhp \
   18030100.xhp \
   18030200.xhp \
   18030300.xhp \
   18030400.xhp \
   18030500.xhp \
   18030600.xhp \
   18030700.xhp \
   18120000.xhp \
   18130000.xhp \
   19010000.xhp \
   19020000.xhp \
   19030000.xhp \
   19040000.xhp \
   19050000.xhp 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
