#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: fpe $ $Date: 2004-08-18 10:58:14 $
#*
#*    $Revision: 1.1 $
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
PACKAGE = text/simpress/02
# uniqe name (module wide);
# using a modified forme of package should do here
TARGET  = text_simpress_02
# edit to match the current module
MODULE  = simpress

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xml files to process
HZIPFILES = \
    04010000.hzip \
    04020000.hzip \
    04030000.hzip \
    04040000.hzip \
    04050000.hzip \
    04060000.hzip \
    04070000.hzip \
    08020000.hzip \
    08060000.hzip \
    10020000.hzip \
    10030000.hzip \
    10030200.hzip \
    10050000.hzip \
    10060000.hzip \
    10070000.hzip \
    10080000.hzip \
    10090000.hzip \
    10100000.hzip \
    10110000.hzip \
    10120000.hzip \
    10130000.hzip \
    11060000.hzip \
    11070000.hzip \
    11080000.hzip \
    11090000.hzip \
    11100000.hzip \
    11110000.hzip \
    13010000.hzip \
    13020000.hzip \
    13030000.hzip \
    13040000.hzip \
    13050000.hzip \
    13060000.hzip \
    13070000.hzip \
    13080000.hzip \
    13090000.hzip \
    13100000.hzip \
    13140000.hzip \
    13150000.hzip \
    13160000.hzip \
    13170000.hzip \
    13180000.hzip \
    13190000.hzip \
    13200000.hzip \
    13210000.hzip \
    13220000.hzip \
    13230000.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
