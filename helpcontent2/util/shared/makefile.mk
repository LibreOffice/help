#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: fpe $ $Date: 2004-08-20 10:24:41 $
#*
#*    $Revision: 1.4 $
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
ZIP1TARGET=shared_xml
ZIP1FLAGS= -u -r
ZIP1DIR=$(MISC)$/$(LANGDIR)
ZIP1LIST=$(LANGDIR)$/text$/shared$/* -x "*.dphh*" -x "*.hzip"


LINKNAME=shared
LINKADDEDFILES= \
   -add shared.tree $(PRJ)$/source$/auxiliary$/LANGUAGE$/shared.tree \
   -add shared.jar  $(BIN)$/shared_xhp_LANGUAGE.zip \
   -add default.css  $(PRJ)$/source$/auxiliary$/LANGUAGE$/default.css \
   -add highcontrast1.css  $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrast1.css \
   -add highcontrast2.css  $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrast2.css \
   -add highcontrastwhite.css  $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrastwhite.css \
   -add highcontrastblack.css  $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrastblack.css \
   -add err.html  $(PRJ)$/source$/auxiliary$/LANGUAGE$/err.html \
   -add help$/main_transform.xsl  $(PRJ)$/source$/auxiliary$/main_transform.xsl


LINKADDEDDEPS= \
   $(PRJ)$/source$/auxiliary$/LANGUAGE$/shared.tree \
   $(BIN)$/shared_xhp_LANGUAGE.zip \
   $(PRJ)$/source$/auxiliary$/LANGUAGE$/default.css \
   $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrast1.css \
   $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrast2.css \
   $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrastwhite.css \
   $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrastblack.css \
   $(PRJ)$/source$/auxiliary$/LANGUAGE$/err.html \
   $(PRJ)$/source$/auxiliary$/main_transform.xsl


LINKLINKFILES= \


# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE :  $(PRJ)$/util$/target.pmk

