#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: vg $ $Date: 2005-03-09 12:50:41 $
#*
#*    $Revision: 1.12 $
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
TARGET  = util_shared

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

.IF "$(SOLAR_JAVA)"!=""
common_build_zip:=
zip1generatedlangs=TRUE
zip1langdirs=$(aux_alllangiso)
ZIP1TARGET=xhp_shared
ZIP1FLAGS= -u -r
ZIP1DIR=$(MISC)$/$(LANGDIR)
ZIP1LIST=$(LANGDIR)$/text$/shared$/* -x "*.dphh*" -x "*.hzip" -x "*.created"
.ENDIF			# "$(SOLAR_JAVA)"!=""


LINKNAME=shared
LINKADDEDFILES= \
   -add shared.tree $(MISC)$/LANGUAGE$/shared.tree \
   -add shared.jar  $(BIN)$/xhp_shared_LANGUAGE.zip \
   -add default.css  $(PRJ)$/source$/auxiliary$/LANGUAGE$/default.css \
   -add highcontrast1.css  $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrast1.css \
   -add highcontrast2.css  $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrast2.css \
   -add highcontrastwhite.css  $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrastwhite.css \
   -add highcontrastblack.css  $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrastblack.css \
   -add err.html  $(MISC)$/LANGUAGE$/text$/shared$/05$/err_html.xhp


LINKADDEDDEPS= \
   $(MISC)$/LANGUAGE$/shared.tree \
   $(BIN)$/xhp_shared_LANGUAGE.zip \
   $(PRJ)$/source$/auxiliary$/LANGUAGE$/default.css \
   $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrast1.css \
   $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrast2.css \
   $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrastwhite.css \
   $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrastblack.css \
   $(MISC)$/LANGUAGE$/text$/shared$/05$/err_html.xhp


LINKLINKFILES= \


# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE :  $(PRJ)$/util$/target.pmk
