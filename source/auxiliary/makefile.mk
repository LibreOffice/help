#*************************************************************************
#
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
# 
# Copyright 2000, 2010 Oracle and/or its affiliates.
#
# OpenOffice.org - a multi-platform office productivity suite
#
# This file is part of OpenOffice.org.
#
# OpenOffice.org is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License version 3
# only, as published by the Free Software Foundation.
#
# OpenOffice.org is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License version 3 for more details
# (a copy is included in the LICENSE file that accompanied this code).
#
# You should have received a copy of the GNU Lesser General Public License
# version 3 along with OpenOffice.org.  If not, see
# <http://www.openoffice.org/license.html>
# for a copy of the LGPLv3 License.
#
#*************************************************************************


PRJ		= ..$/..
PRJNAME = helpcontent2
TARGET  = auxiliary

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk

# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.EXPORT : LOCALIZESDF LOCALIZATION_FOUND TRYSDF L10N_MODULE
XMLLINT !:=$(XMLLINT)
.EXPORT : XMLLINT

ALLTAR : aux_dirs $(COMMONBIN)$/helpimg.ilst

.IF "$(WITH_LANG)"!=""
t_aux_langdirs:=$(shell @find ./ -name "*.cfg" | sed "s/\.\/\///" | sed "s/\.\///" )

aux_langdirs:=$(uniq $(t_aux_langdirs:d:d))
help_exist:=$(shell @find $(L10N_MODULE)/source/ -type d -name "helpcontent2" | sed -e "s|/helpcontent2||" -e "s|^.*/||" ) en-US qtz

.ELSE			#IF "$(WITH_LANG)"!=""
aux_langdirs:=en-US
help_exist:=en-US

.ENDIF			#IF "$(WITH_LANG)"!=""

aux_dirs .PHONY :
    @echo aux_langdirs:=$(aux_langdirs) > $(LOCAL_COMMON_OUT)/inc$/aux_langs.mk
    @echo help_exist:=$(help_exist) > $(LOCAL_COMMON_OUT)/inc$/help_exist.mk

$(COMMONBIN)$/helpimg.ilst .PHONY:
    @@-$(RM) $@
    $(COMMAND_ECHO)$(PERL) $(PRJ)$/helpers$/create_ilst.pl -dir=$(SRC_ROOT)/icon-themes/galaxy/res/helpimg > $@.$(INPATH)
    $(COMMAND_ECHO)$(RENAME) $@.$(INPATH) $@
    

