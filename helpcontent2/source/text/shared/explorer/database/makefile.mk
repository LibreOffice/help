#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: rt $ $Date: 2004-11-26 22:01:27 $
#*
#*    $Revision: 1.4 $
#*
#*    $Logfile:$
#*
#*    Copyright 2000 Sun Microsystems, Inc. All Rights Reserved.
#*
#*************************************************************************

# edit to match directory level 
PRJ		= ..$/..$/..$/..$/..
# same for all makefiles in "helpcontent2"
PRJNAME = helpcontent2
# edit to match the current package
PACKAGE = text/shared/explorer/database
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = text_shared_explorer_database
# edit to match the current module
MODULE  = shared

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xhp files to process
HZIPFILES = \
   02000000.hzip \
   02000002.hzip \
   02010100.hzip \
   02010101.hzip \
   04000000.hzip \
   04000001.hzip \
   04010000.hzip \
   04030000.hzip \
   05000000.hzip \
   05000001.hzip \
   05000002.hzip \
   05000003.hzip \
   05010000.hzip \
   05010100.hzip \
   05020000.hzip \
   05020100.hzip \
   05030000.hzip \
   05030100.hzip \
   05030200.hzip \
   05030300.hzip \
   05030400.hzip \
   05040000.hzip \
   05040100.hzip \
   05040200.hzip \
   11000000.hzip \
   11000002.hzip \
   11010000.hzip \
   11010100.hzip \
   11020000.hzip \
   11030000.hzip \
   11030100.hzip \
   11040000.hzip \
   11060000.hzip \
   11080000.hzip \
   11090000.hzip \
   11110000.hzip \
   11120000.hzip \
   11150000.hzip \
   11150200.hzip \
   11160000.hzip \
   11170000.hzip \
   11170100.hzip \
   11180000.hzip \
   11180500.hzip \
   11190000.hzip \
   30000000.hzip \
   30100000.hzip \
   dabaadvprop.hzip \
   dabaadvpropdat.hzip \
   dabaadvpropgen.hzip \
   dabadoc.hzip \
   dabaprop.hzip \
   dabapropadd.hzip \
   dabapropcon.hzip \
   dabapropgen.hzip \
   dabawiz00.hzip \
   dabawiz01.hzip \
   dabawiz02.hzip \
   dabawiz02access.hzip \
   dabawiz02adabas.hzip \
   dabawiz02ado.hzip \
   dabawiz02jdbc.hzip \
   dabawiz02ldap.hzip \
   dabawiz02mysql.hzip \
   dabawiz02odbc.hzip \
   dabawiz02oracle.hzip \
   dabawiz02spreadsheet.hzip \
   dabawiz02text.hzip \
   dabawiz03auth.hzip \
   main.hzip \
   menubar.hzip \
   menuedit.hzip \
   menufile.hzip \
   menuinsert.hzip \
   menutools.hzip \
   menuview.hzip \
   querywizard00.hzip \
   querywizard01.hzip \
   querywizard02.hzip \
   querywizard03.hzip \
   querywizard04.hzip \
   querywizard05.hzip \
   querywizard06.hzip \
   querywizard07.hzip \
   querywizard08.hzip \
   tablewizard00.hzip \
   tablewizard01.hzip \
   tablewizard02.hzip \
   tablewizard03.hzip \
   tablewizard04.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
