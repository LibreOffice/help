#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: fpe $ $Date: 2004-08-24 10:55:19 $
#*
#*    $Revision: 1.5 $
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
TARGET  = util

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

common_build_zip:=
zip1generatedlangs=TRUE
ZIP1TARGET=schart_xml
ZIP1FLAGS= -u -r
ZIP1DIR=$(MISC)$/$(LANGDIR)
ZIP1LIST=$(LANGDIR)$/text$/schart$/* -x "*.dphh*" -x "*.hzip"


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

