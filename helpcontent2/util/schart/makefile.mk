#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: ihi $ $Date: 2004-08-18 16:19:22 $
#*
#*    $Revision: 1.3 $
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
ZIP1TARGET=schart_xhp
ZIP1FLAGS= -u -r
ZIP1DIR=$(MISC)$/$(LANGDIR)
ZIP1LIST=$(LANGDIR)$/text$/schart$/* -x "*.dphh*" -x "*.hzip"


LINKNAME=schart
LINKADDEDFILES= \
   -add help$/LANGUAGE$/schart.tree $(PRJ)$/source$/auxiliary$/LANGUAGE$/schart.tree \
   -add help$/LANGUAGE$/schart.jar  $(BIN)$/schart_xhp_LANGUAGE.zip


LINKADDEDDEPS= \
   $(PRJ)$/source$/auxiliary$/LANGUAGE$/schart.tree \
   $(BIN)$/schart_xhp_LANGUAGE.zip


LINKLINKFILES= \


# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE :  $(PRJ)$/util$/target.pmk

