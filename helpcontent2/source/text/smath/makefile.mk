#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: fpe $ $Date: 2004-08-18 10:58:24 $
#*
#*    $Revision: 1.1 $
#*
#*    $Logfile:$
#*
#*    Copyright 2000 Sun Microsystems, Inc. All Rights Reserved.
#*
#*************************************************************************

# edit to match directory level 
PRJ		= ..$/..$/..
# same for all makefiles in "help2"
PRJNAME = help2
# edit to match the current package
PACKAGE = text/smath
# uniqe name (module wide);
# using a modified forme of package should do here
TARGET  = text_smath
# edit to match the current module
MODULE  = text/smath

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xml files to process
HZIPFILES = \
    main0000.hzip \
    main0100.hzip \
    main0101.hzip \
    main0102.hzip \
    main0103.hzip \
    main0105.hzip \
    main0106.hzip \
    main0107.hzip \
    main0200.hzip \
    main0202.hzip \
    main0203.hzip \
    main0503.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
