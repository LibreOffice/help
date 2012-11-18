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
TARGET  = text


# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

TREEFILES  = \
    sbasic.tree \
    simpress.tree \
    scalc.tree \
    smath.tree \
    schart.tree \
    swriter.tree \
    shared.tree

# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk

ALLTAR : $(COMMONMISC)$/treefiles.done

.IF "$(WITH_LANG)"!=""

WITH_LANG!:=$(aux_alllangiso)
.EXPORT : WITH_LANG

LOCTREEFILES:=$(foreach,i,$(aux_alllangiso) $(foreach,j,$(TREEFILES) $(COMMONMISC)$/$i$/$j))
.ELSE			#IF "$(WITH_LANG)"!=""

LOCTREEFILES:=$(foreach,j,$(TREEFILES) $(COMMONMISC)$/en-US$/$j)
.ENDIF			#IF "$(WITH_LANG)"!=""

$(COMMONMISC)$/treefiles.done : $(LOCTREEFILES)
    @$(foreach,lang,$(aux_alllangiso) \
        $(foreach,tree,$(TREEFILES) \
            $(AUGMENT_LIBRARY_PATH) $(TREEX) -i $(SRC_ROOT)/$(PRJNAME)/source/auxiliary/$(tree) -o $(subst,$(PRJ),$(SRC_ROOT)/$(PRJNAME) $(COMMONMISC))/$(lang)/$(tree) -l $(lang) $(eq,lang,en-US $(NULL) -m $(mktmp $(SRC_ROOT)/translations/source/$(lang)/$(PRJNAME)/source/auxiliary.po)) -r $(subst,$(PRJ),$(SRC_ROOT)/$(PRJNAME) $(COMMONMISC))/$(lang)/text && )) \
    $(TOUCH) $@

%.created:
    @-$(MKDIRHIER) $(@:d) && $(TOUCH) $@

$(LOCTREEFILES) : $(foreach,tree,$(TREEFILES) ../auxiliary/$(tree)) $$(@:d)$/dir.created
    @$(TOUCH) $@

