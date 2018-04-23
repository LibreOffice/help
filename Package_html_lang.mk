# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t -*-
#  #
# This file is part of the LibreOffice project.
# #
# # This Source Code Form is subject to the terms of the Mozilla Public
# # License, v. 2.0. If a copy of the MPL was not distributed with this
# # file, You can obtain one at http://mozilla.org/MPL/2.0/.
# #
#
$(eval $(call gb_Package_Package,helpcontent2_html_lang,$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)))

$(eval $(call gb_Package_use_customtarget,helpcontent2_html_lang,helpcontent2/help3xsl))

$(eval $(call gb_Package_add_files_with_dir,helpcontent2_html_lang,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION)),\
	$(foreach lang,$(gb_HELP_LANGS),\
		$(lang)/bookmarks.js \
		$(lang)/contents.js \
	) \
))

# vim: set noet sw=4 ts=4:
