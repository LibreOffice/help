# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t -*-
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

$(eval $(call gb_CustomTarget_CustomTarget,helpcontent2/source/auxiliary))

$(eval $(call gb_CustomTarget_register_targets,helpcontent2/source/auxiliary,\
	helpimg.ilst \
))

$(call gb_CustomTarget_get_workdir,helpcontent2/source/auxiliary)/helpimg.ilst : \
		$(SRCDIR)/helpcontent2/helpers/create_ilst.pl
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),PRL,1)
	$(call gb_Helper_abbreviate_dirs,\
		$(PERL) $< -dir=$(SRCDIR)/helpcontent2/source/media > $@.out && \
			mv $@.out $@ \
	)

# vim: set noet sw=4 ts=4:
