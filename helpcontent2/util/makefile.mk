#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: hjs $ $Date: 2004-08-24 11:53:36 $
#*
#*    $Revision: 1.2 $
#*
#*    $Logfile:$
#*
#*    Copyright 2000 Sun Microsystems, Inc. All Rights Reserved.
#*
#*************************************************************************

# edit to match directory level 
PRJ		= ..
# same for all makefiles in "help2"
PRJNAME = help2
# uniqe name (module wide);
# using a modified forme of package should do here
TARGET  = plain_util

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

ZIP1TARGET=helpxsl
ZIP1FLAGS= -u -r
ZIP1DIR=$(PRJ)$/source$/auxiliary
ZIP1LIST=main_transform*.xsl 
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk

ALLTAR : $(COMMONBIN)$/helpimg.ilst

$(COMMONBIN)$/helpimg.ilst: helpimg.ilst
    $(COPY) $< $@

