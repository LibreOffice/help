# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t -*-
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

$(eval $(call gb_CustomTarget_CustomTarget,helpcontent2/source/auxiliary))

helpcontent2_DIR := $(SRCDIR)/helpcontent2/source

$(eval $(call gb_CustomTarget_register_targets,helpcontent2/source/auxiliary,\
	helpimg.ilst \
	screenshotimg.ilst \
	images_helpimg.zip \
))

$(call gb_CustomTarget_get_workdir,helpcontent2/source/auxiliary)/images_helpimg.zip : \
		$(call gb_CustomTarget_get_workdir,helpcontent2/source/auxiliary)/helpimg.ilst \
		$(call gb_CustomTarget_get_workdir,helpcontent2/source/auxiliary)/screenshotimg.ilst \
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),PRL,1)
	$(call gb_Helper_abbreviate_dirs, \
		ILSTFILE=$(call var2file,$(shell $(gb_MKTEMP)),100,$(filter %.ilst,$^)) && \
		$(PERL) $(SRCDIR)/solenv/bin/packimages.pl \
			-g $(icon_DIR) -m $(icon_DIR) -c $(icon_DIR) \
			-l $${ILSTFILE} \
			-s $< -o $@ \
			$(if $(findstring s,$(MAKEFLAGS)),> /dev/null) && \
		rm -rf $${ILSTFILE})


$(call gb_CustomTarget_get_workdir,helpcontent2/source/auxiliary)/helpimg.ilst : \
		$(SRCDIR)/helpcontent2/helpers/create_ilst.pl
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),PRL,1)
	$(call gb_Helper_abbreviate_dirs,\
		$(PERL) $< -dir=$(helpcontent2_DIR)/res/helpimg -pre=res/helpimg> $@.out && \
			mv $@.out $@ \
	)

$(call gb_CustomTarget_get_workdir,helpcontent2/source/auxiliary)/screenshotimg.ilst : \
		$(SRCDIR)/helpcontent2/helpers/create_ilst.pl
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),PRL,1)
	$(call gb_Helper_abbreviate_dirs,\
		$(PERL) $< -dir=$(helpcontent2_DIR)/media/screenshots -pre=media/screenshots > $@.out && \
			mv $@.out $@ \
	)

# vim: set noet sw=4 ts=4:
