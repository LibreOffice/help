#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: kz $ $Date: 2006-11-08 11:53:48 $
#*
#*    $Revision: 1.11 $
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

ALLTAR : aux_dirs $(COMMONMISC)$/treefiles.done $(COMMONBIN)$/helpimg.ilst

.IF "$(WITH_LANG)"!=""
.IF "$(GUI)"=="UNX" || "$(USE_SHELL)"!="4nt"
t_aux_langdirs:=$(shell +find ./ -name "*.cfg" | sed "s/\.\/\///" | sed "s/\.\///" )
.ELSE           # "$(GUI)"=="UNX" || "$(USE_SHELL)"!="4nt"
t_aux_langdirs:=$(subst,./, $(shell +$(FIND) ./ -name "*.cfg"))
.ENDIF          # "$(GUI)"=="UNX" || "$(USE_SHELL)"!="4nt"

aux_langdirs:=$(uniq $(t_aux_langdirs:d:d))

aux_alllangiso:=$(foreach,i,$(alllangiso) $(foreach,j,$(aux_langdirs) $(eq,$i,$j  $i $(NULL))))

WITH_LANG!:=$(aux_alllangiso)

.EXPORT : WITH_LANG

LOCTREEFILES:=$(foreach,i,$(aux_alllangiso) $(foreach,j,$(TREEFILES) $(COMMONMISC)$/$i$/$j))
.ELSE			#IF "$(WITH_LANG)"!=""
aux_langdirs:=en-US
LOCTREEFILES:=$(foreach,j,$(TREEFILES) $(COMMONMISC)$/en-US$/$j)
.ENDIF			#IF "$(WITH_LANG)"!=""

$(COMMONMISC)$/treefiles.done : $(LOCTREEFILES)
    @+$(PERL) $(PRJ)$/helpers$/update_tree.pl && $(TOUCH) $@

%.created:
    @+-$(MKDIRHIER) $(@:d) && $(TOUCH) $@

$(LOCTREEFILES) : $(TREEFILES) $$(@:d)$/dir.created
    @+$(TOUCH) $@

.IF "$(WITH_LANG)"!=""
$(LOCTREEFILES) : $(PRJ)$/source$/text$/shared$/localize.sdf
.ENDIF			# "$(WITH_LANG)"!=""

aux_dirs .PHONY :
    echo aux_langdirs:=$(aux_langdirs) > $(INCCOM)$/aux_langs.mk

$(COMMONBIN)$/helpimg.ilst .PHONY:
    +-$(RM) $@
    $(PERL) $(PRJ)$/helpers$/create_ilst.pl -dir=$(SOLARSRC)/default_images/res/helpimg > $@.$(INPATH)
    +$(RENAME) $@.$(INPATH) $@
    

