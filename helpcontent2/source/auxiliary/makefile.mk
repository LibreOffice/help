#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: rt $ $Date: 2004-12-16 12:20:38 $
#*
#*    $Revision: 1.2 $
#*
#*    $Logfile:$
#*
#*    Copyright 2000 Sun Microsystems, Inc. All Rights Reserved.
#*
#*************************************************************************

PRJ		= ..$/..
PRJNAME = help2
TARGET  = auxiliary
# edit to match the current module
MODULE  = sbasic

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk

    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk

ALLTAR : aux_dirs

AUX_DIR_LIST:=$(shell +$(FIND) . -type d ! -name "." | $(GREP) -v "CVS")

.IF "$(GUI)"=="UNX" || "$(USE_SHELL)"!="4nt"
aux_langdirs:=$(shell +find ./ -type d ! -name CVS ! -name "." | sed "s/\.\/\///" | sed "s/\.\///" )
.ELSE           # "$(GUI)"=="UNX"
aux_langdirs:=$(subst,CVS, $(shell +-dir /ba:d ))
.ENDIF          # "$(GUI)"=="UNX"


aux_dirs .PHONY :
    +echo aux_langdirs:=$(aux_langdirs) > $(INCCOM)$/aux_langs.mk

#aux_alllangiso:=$(foreach,i,$(alllangiso) $(foreach,j,$(aux_langdirs) $(eq,$i,$j  $i $(NULL))))
