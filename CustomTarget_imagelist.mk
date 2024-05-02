# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t -*-
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

$(eval $(call gb_CustomTarget_CustomTarget,helpcontent2/source/auxiliary))

helpmedia_DIR := $(SRCDIR)/helpcontent2/source

$(eval $(call gb_CustomTarget_register_targets,helpcontent2/source/auxiliary,\
	helpimg.ilst \
	images_helpimg.zip \
))

$(gb_CustomTarget_workdir)/helpcontent2/source/auxiliary/images_helpimg.zip : \
		$(gb_CustomTarget_workdir)/helpcontent2/source/auxiliary/helpimg.ilst \
		| $(call gb_ExternalExecutable_get_dependencies,python)
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),PRL,1)
	$(call gb_Helper_abbreviate_dirs, \
		ILSTFILE=$(call gb_var2file,$(shell $(gb_MKTEMP)),$(filter %.ilst,$^)) && \
		$(call gb_ExternalExecutable_get_command,python) $(SRCDIR)/solenv/bin/pack_images.py \
			-g $(helpmedia_DIR) -m $(helpmedia_DIR) -c $(helpmedia_DIR) \
			-l $${ILSTFILE} \
			-s $< -o $@ \
			$(if $(findstring s,$(MAKEFLAGS)),> /dev/null) && \
		rm -rf $${ILSTFILE})

# include everything including directories to also rebuild on file deletion
helpmedia_allMedia:=$(shell $(FIND) $(helpmedia_DIR)/media/helpimg)
# but we're only interested in the png images
helpmedia_images = $(filter %.png,$(helpmedia_allMedia))

$(gb_CustomTarget_workdir)/helpcontent2/source/auxiliary/helpimg.ilst: $(helpmedia_allMedia)
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),LST,1)
	$(file >$@,$(subst $(WHITESPACE),$(NEWLINE),$(sort $(subst $(helpmedia_DIR)/,%MODULE%/,$(helpmedia_images)))))

# vim: set noet sw=4 ts=4:
