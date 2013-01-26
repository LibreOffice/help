#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# This file incorporates work covered by the following license notice:
#
#   Licensed to the Apache Software Foundation (ASF) under one or more
#   contributor license agreements. See the NOTICE file distributed
#   with this work for additional information regarding copyright
#   ownership. The ASF licenses this file to you under the Apache
#   License, Version 2.0 (the "License"); you may not use this file
#   except in compliance with the License. You may obtain a copy of
#   the License at http://www.apache.org/licenses/LICENSE-2.0 .
#


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
help_exist:=$(shell @find $(L10N_MODULE)/source/ -type d -name "helpcontent2" | sed -e "s|/helpcontent2||" -e "s|^.*/||" ) en-US

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
    

