#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: fpe $ $Date: 2004-08-18 11:52:03 $
#*
#*    $Revision: 1.2 $
#*
#*    $Logfile:$
#*
#*    Copyright 2000 Sun Microsystems, Inc. All Rights Reserved.
#*
#*************************************************************************

# edit to match directory level 
PRJ		= ..$/..$/..$/..
# same for all makefiles in "help2"
PRJNAME = help2
# edit to match the current package
PACKAGE = text/shared/00
# uniqe name (module wide);
# using a modified forme of package should do here
TARGET  = text_shared_00
# edit to match the current module
MODULE  = shared

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xhp files to process
HZIPFILES = \
    00000001.hzip \
    00000002.hzip \
    00000003.hzip \
    00000004.hzip \
    00000005.hzip \
    00000007.hzip \
    00000010.hzip \
    00000011.hzip \
    00000020.hzip \
    00000021.hzip \
    00000040.hzip \
    00000099.hzip \
    00000202.hzip \
    00000203.hzip \
    00000204.hzip \
    00000205.hzip \
    00000206.hzip \
    00000207.hzip \
    00000208.hzip \
    00000210.hzip \
    00000212.hzip \
    00000213.hzip \
    00000214.hzip \
    00000215.hzip \
    00000401.hzip \
    00000402.hzip \
    00000403.hzip \
    00000404.hzip \
    00000406.hzip \
    00000407.hzip \
    00000408.hzip \
    00000409.hzip \
    00000450.hzip \
    00040500.hzip \
    00040501.hzip \
    00040502.hzip \
    00040503.hzip \
    01000000.hzip \
    01010000.hzip \
    01020000.hzip \
    01050000.hzip \
    icon_alt.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
