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
TARGET  = text

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk

ALLTAR : $(COMMONMISC)$/sbasic.tree.done $(COMMONMISC)$/simpress.tree.done $(COMMONMISC)$/scalc.tree.done $(COMMONMISC)$/smath.tree.done $(COMMONMISC)$/schart.tree.done $(COMMONMISC)$/swriter.tree.done $(COMMONMISC)$/shared.tree.done

.IF "$(WITH_LANG)"!=""

WITH_LANG!:=$(aux_alllangiso)
.EXPORT : WITH_LANG

LOCSBASIC:=$(foreach,i,$(aux_alllangiso) $(COMMONMISC)$/$i$/sbasic.tree)
LOCSIMPRESS:=$(foreach,i,$(aux_alllangiso) $(COMMONMISC)$/$i$/simpress.tree)
LOCSCALC:=$(foreach,i,$(aux_alllangiso) $(COMMONMISC)$/$i$/scalc.tree)
LOCSMATH:=$(foreach,i,$(aux_alllangiso) $(COMMONMISC)$/$i$/smath.tree)
LOCSCHART:=$(foreach,i,$(aux_alllangiso) $(COMMONMISC)$/$i$/schart.tree)
LOCSWRITER:=$(foreach,i,$(aux_alllangiso) $(COMMONMISC)$/$i$/swriter.tree)
LOCSHARED:=$(foreach,i,$(aux_alllangiso) $(COMMONMISC)$/$i$/shared.tree)
.ELSE			#IF "$(WITH_LANG)"!=""

LOCSBASIC:=$(COMMONMISC)$/en-US$/sbasic.tree
LOCSIMPRESS:=$(COMMONMISC)$/en-US$/simpress.tree
LOCSCALC:=$(COMMONMISC)$/en-US$/scalc.tree
LOCSMATH:=$(COMMONMISC)$/en-US$/smath.tree
LOCSCHART:=$(COMMONMISC)$/en-US$/schart.tree
LOCSWRITER:=$(COMMONMISC)$/en-US$/swriter.tree
LOCSHARED:=$(COMMONMISC)$/en-US$/shared.tree
.ENDIF			#IF "$(WITH_LANG)"!=""

$(COMMONMISC)$/sbasic.tree.done : $(LOCSBASIC)
    @$(foreach,lang,$(aux_alllangiso) \
        $(AUGMENT_LIBRARY_PATH) $(TREEX) -i $(SRC_ROOT)/$(PRJNAME)/source/auxiliary/sbasic.tree -o $(subst,$(PRJ),$(SRC_ROOT)/$(PRJNAME) $(COMMONMISC))/$(lang)/sbasic.tree -l $(lang) $(eq,lang,en-US $(NULL) -m $(mktmp $(SRC_ROOT)/translations/source/$(lang)/$(PRJNAME)/source/auxiliary.po)) -r $(subst,$(PRJ),$(SRC_ROOT)/$(PRJNAME) $(COMMONMISC))/$(lang)/text && ) \
    $(TOUCH) $@

$(COMMONMISC)$/simpress.tree.done : $(LOCSIMPRESS)
    @$(foreach,lang,$(aux_alllangiso) \
        $(AUGMENT_LIBRARY_PATH) $(TREEX) -i $(SRC_ROOT)/$(PRJNAME)/source/auxiliary/simpress.tree -o $(subst,$(PRJ),$(SRC_ROOT)/$(PRJNAME) $(COMMONMISC))/$(lang)/simpress.tree -l $(lang) $(eq,lang,en-US $(NULL) -m $(mktmp $(SRC_ROOT)/translations/source/$(lang)/$(PRJNAME)/source/auxiliary.po)) -r $(subst,$(PRJ),$(SRC_ROOT)/$(PRJNAME) $(COMMONMISC))/$(lang)/text && ) \
    $(TOUCH) $@

$(COMMONMISC)$/scalc.tree.done : $(LOCSCALC)
    @$(foreach,lang,$(aux_alllangiso) \
        $(AUGMENT_LIBRARY_PATH) $(TREEX) -i $(SRC_ROOT)/$(PRJNAME)/source/auxiliary/scalc.tree -o $(subst,$(PRJ),$(SRC_ROOT)/$(PRJNAME) $(COMMONMISC))/$(lang)/scalc.tree -l $(lang) $(eq,lang,en-US $(NULL) -m $(mktmp $(SRC_ROOT)/translations/source/$(lang)/$(PRJNAME)/source/auxiliary.po)) -r $(subst,$(PRJ),$(SRC_ROOT)/$(PRJNAME) $(COMMONMISC))/$(lang)/text && ) \
    $(TOUCH) $@

$(COMMONMISC)$/smath.tree.done : $(LOCSMATH)
    @$(foreach,lang,$(aux_alllangiso) \
        $(AUGMENT_LIBRARY_PATH) $(TREEX) -i $(SRC_ROOT)/$(PRJNAME)/source/auxiliary/smath.tree -o $(subst,$(PRJ),$(SRC_ROOT)/$(PRJNAME) $(COMMONMISC))/$(lang)/smath.tree -l $(lang) $(eq,lang,en-US $(NULL) -m $(mktmp $(SRC_ROOT)/translations/source/$(lang)/$(PRJNAME)/source/auxiliary.po)) -r $(subst,$(PRJ),$(SRC_ROOT)/$(PRJNAME) $(COMMONMISC))/$(lang)/text && ) \
    $(TOUCH) $@

$(COMMONMISC)$/schart.tree.done : $(LOCSCHART)
    @$(foreach,lang,$(aux_alllangiso) \
        $(AUGMENT_LIBRARY_PATH) $(TREEX) -i $(SRC_ROOT)/$(PRJNAME)/source/auxiliary/schart.tree -o $(subst,$(PRJ),$(SRC_ROOT)/$(PRJNAME) $(COMMONMISC))/$(lang)/schart.tree -l $(lang) $(eq,lang,en-US $(NULL) -m $(mktmp $(SRC_ROOT)/translations/source/$(lang)/$(PRJNAME)/source/auxiliary.po)) -r $(subst,$(PRJ),$(SRC_ROOT)/$(PRJNAME) $(COMMONMISC))/$(lang)/text && ) \
    $(TOUCH) $@

$(COMMONMISC)$/swriter.tree.done : $(LOCSWRITER)
    @$(foreach,lang,$(aux_alllangiso) \
        $(AUGMENT_LIBRARY_PATH) $(TREEX) -i $(SRC_ROOT)/$(PRJNAME)/source/auxiliary/swriter.tree -o $(subst,$(PRJ),$(SRC_ROOT)/$(PRJNAME) $(COMMONMISC))/$(lang)/swriter.tree -l $(lang) $(eq,lang,en-US $(NULL) -m $(mktmp $(SRC_ROOT)/translations/source/$(lang)/$(PRJNAME)/source/auxiliary.po)) -r $(subst,$(PRJ),$(SRC_ROOT)/$(PRJNAME) $(COMMONMISC))/$(lang)/text && ) \
    $(TOUCH) $@

$(COMMONMISC)$/shared.tree.done : $(LOCSHARED)
    @$(foreach,lang,$(aux_alllangiso) \
        $(AUGMENT_LIBRARY_PATH) $(TREEX) -i $(SRC_ROOT)/$(PRJNAME)/source/auxiliary/shared.tree -o $(subst,$(PRJ),$(SRC_ROOT)/$(PRJNAME) $(COMMONMISC))/$(lang)/shared.tree -l $(lang) $(eq,lang,en-US $(NULL) -m $(mktmp $(SRC_ROOT)/translations/source/$(lang)/$(PRJNAME)/source/auxiliary.po)) -r $(subst,$(PRJ),$(SRC_ROOT)/$(PRJNAME) $(COMMONMISC))/$(lang)/text && ) \
    $(TOUCH) $@

%.created:
    @-$(MKDIRHIER) $(@:d) && $(TOUCH) $@

$(LOCSBASIC) : ../auxiliary/sbasic.tree $$(@:d)$/dir.created
    @$(TOUCH) $@

$(LOCSIMPRESS) : ../auxiliary/simpress.tree $$(@:d)$/dir.created
    @$(TOUCH) $@

$(LOCSCALC) : ../auxiliary/scalc.tree $$(@:d)$/dir.created
    @$(TOUCH) $@

$(LOCSMATH) : ../auxiliary/smath.tree $$(@:d)$/dir.created
    @$(TOUCH) $@

$(LOCSCHART) : ../auxiliary/schart.tree $$(@:d)$/dir.created
    @$(TOUCH) $@

$(LOCSWRITER) : ../auxiliary/swriter.tree $$(@:d)$/dir.created
    @$(TOUCH) $@

$(LOCSHARED) : ../auxiliary/shared.tree $$(@:d)$/dir.created
    @$(TOUCH) $@
