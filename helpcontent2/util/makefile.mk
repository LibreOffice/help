#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: rt $ $Date: 2004-12-16 13:00:10 $
#*
#*    $Revision: 1.5 $
#*
#*    $Logfile:$
#*
#*    Copyright 2000 Sun Microsystems, Inc. All Rights Reserved.
#*
#*************************************************************************

# edit to match directory level 
PRJ		= ..
# same for all makefiles in "helpcontent2"
PRJNAME = helpcontent2
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = plain_util

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

ZIP1TARGET=helpxsl
ZIP1FLAGS= -u -r
ZIP1DIR=$(PRJ)$/source$/auxiliary
ZIP1LIST=main_transform*.xsl 
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk

ALLTAR : $(COMMONBIN)$/helpimg.ilst

$(COMMONBIN)$/helpimg.ilst: helpimg.ilst
    +$(COPY) $< $@
