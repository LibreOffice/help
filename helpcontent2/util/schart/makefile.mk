#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: hr $ $Date: 2004-11-09 11:47:26 $
#*
#*    $Revision: 1.8 $
#*
#*    $Logfile:$
#*
#*    Copyright 2000 Sun Microsystems, Inc. All Rights Reserved.
#*
#*************************************************************************

# edit to match directory level 
PRJ		= ..$/..
# same for all makefiles in "help2"
PRJNAME = help2
# uniqe name (module wide);
# using a modified forme of package should do here
TARGET  = schart_util

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

.IF "$(SOLAR_JAVA)"!=""
common_build_zip:=
zip1generatedlangs=TRUE
ZIP1TARGET=schart_xhp
ZIP1FLAGS= -u -r
ZIP1DIR=$(MISC)$/$(LANGDIR)
ZIP1LIST=$(LANGDIR)$/text$/schart$/* -x "*.dphh*" -x "*.hzip"
.ENDIF


LINKNAME=schart
LINKADDEDFILES= \
   -add schart.tree $(PRJ)$/source$/auxiliary$/LANGUAGE$/schart.tree \
   -add schart.jar  $(BIN)$/schart_xhp_LANGUAGE.zip


LINKADDEDDEPS= \
   $(PRJ)$/source$/auxiliary$/LANGUAGE$/schart.tree \
   $(BIN)$/schart_xhp_LANGUAGE.zip


LINKLINKFILES= \


# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE :  $(PRJ)$/util$/target.pmk

