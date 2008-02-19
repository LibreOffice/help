#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: rt $ $Date: 2008-02-19 22:54:15 $
#*
#*    $Revision: 1.8 $
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
PACKAGE = text/shared/00
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = text_shared_00
# edit to match the current module
MODULE  = shared

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

# this list matches the *.xhp files to process
XHPFILES = \
   00000001.xhp \
   00000002.xhp \
   00000003.xhp \
   00000004.xhp \
   00000005.xhp \
   00000007.xhp \
   00000010.xhp \
   00000011.xhp \
   00000020.xhp \
   00000021.xhp \
   00000099.xhp \
   00000202.xhp \
   00000203.xhp \
   00000204.xhp \
   00000205.xhp \
   00000206.xhp \
   00000207.xhp \
   00000208.xhp \
   00000210.xhp \
   00000212.xhp \
   00000213.xhp \
   00000214.xhp \
   00000215.xhp \
   00000401.xhp \
   00000402.xhp \
   00000403.xhp \
   00000404.xhp \
   00000406.xhp \
   00000407.xhp \
   00000408.xhp \
   00000409.xhp \
   00000450.xhp \
   00040500.xhp \
   00040501.xhp \
   00040502.xhp \
   00040503.xhp \
   01000000.xhp \
   01010000.xhp \
   01020000.xhp \
   01050000.xhp \
   icon_alt.xhp 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
