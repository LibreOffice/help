#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: vg $ $Date: 2005-03-23 13:02:48 $
#*
#*    $Revision: 1.13 $
#*
#*    $Logfile:$
#*
#*    Copyright 2000 Sun Microsystems, Inc. All Rights Reserved.
#*
#*************************************************************************
# edit to match directory level 
PRJ		= ..$/..
# same for all makefiles in "helpcontent2"
PRJNAME = helpcontent2
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = util_schart

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

.IF "$(SOLAR_JAVA)"!=""
common_build_zip:=
zip1generatedlangs=TRUE
zip1langdirs=$(aux_alllangiso)
ZIP1TARGET=xhp_schart
ZIP1FLAGS= -u -r
ZIP1DIR=$(MISC)$/$(LANGDIR)
ZIP1LIST=$(LANGDIR)$/text$/schart$/* -x "*.dphh*" -x "*.hzip" -x "*.created"
.ENDIF			# "$(SOLAR_JAVA)"!=""


LINKNAME=schart
LINKADDEDFILES= \
   -add schart.tree $(MISC)$/LANGUAGE$/schart.tree \
   -add schart.jar  $(BIN)$/xhp_schart_LANGUAGE.zip


LINKADDEDDEPS= \
   $(MISC)$/LANGUAGE$/schart.tree \
   $(BIN)$/xhp_schart_LANGUAGE.zip


LINKLINKFILES= \


# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE :  $(PRJ)$/util$/target.pmk
