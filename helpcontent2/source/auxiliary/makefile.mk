#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: vg $ $Date: 2005-03-08 18:03:05 $
#*
#*    $Revision: 1.4 $
#*
#*    $Logfile:$
#*
#*    Copyright 2000 Sun Microsystems, Inc. All Rights Reserved.
#*
#*************************************************************************

PRJ		= ..$/..
PRJNAME = help2
TARGET  = auxiliary

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk

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

ALLTAR : aux_dirs $(MISC)$/treefiles.done

AUX_DIR_LIST:=$(shell +$(FIND) . -type d ! -name "." | $(GREP) -v "CVS")

.IF "$(GUI)"=="UNX" || "$(USE_SHELL)"!="4nt"
aux_langdirs:=$(shell +find ./ -type d ! -name CVS ! -name "." | sed "s/\.\/\///" | sed "s/\.\///" )
.ELSE           # "$(GUI)"=="UNX"
aux_langdirs:=$(subst,CVS, $(shell +-dir /ba:d ))
.ENDIF          # "$(GUI)"=="UNX"

aux_alllangiso:=$(foreach,i,$(alllangiso) $(foreach,j,$(aux_langdirs) $(eq,$i,$j  $i $(NULL))))

WITH_LANG!:=$(aux_alllangiso)

.EXPORT : WITH_LANG

LOCTREEFILES:=$(foreach,i,$(aux_alllangiso) $(foreach,j,$(TREEFILES) $(MISC)$/$i$/$j))

$(MISC)$/treefiles.done : $(LOCTREEFILES)
    @+$(PERL) $(PRJ)$/helpers$/update_tree.pl && $(TOUCH) $@

%.created:
    @+-$(MKDIRHIER) $(@:d) && $(TOUCH) $@

$(LOCTREEFILES) : $(TREEFILES) $(PRJ)$/source$/text$/shared$/localize.sdf $$(@:d)$/dir.created
    @+$(TOUCH) $@

aux_dirs .PHONY :
    +echo aux_langdirs:=$(aux_langdirs) > $(INCCOM)$/aux_langs.mk

