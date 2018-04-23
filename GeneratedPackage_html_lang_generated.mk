# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t -*-
#  #
# This file is part of the LibreOffice project.
# #
# # This Source Code Form is subject to the terms of the Mozilla Public
# # License, v. 2.0. If a copy of the MPL was not distributed with this
# # file, You can obtain one at http://mozilla.org/MPL/2.0/.
# #
#
$(eval $(call gb_GeneratedPackage_GeneratedPackage,helpcontent2_html_lang_generated,$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)))

$(eval $(call gb_GeneratedPackage_use_customtarget,helpcontent2_html_lang_generated,helpcontent2/help3xsl))

$(eval $(foreach lang,$(gb_HELP_LANGS),\
$(call gb_GeneratedPackage_add_dir,helpcontent2_html_lang_generated,$(INSTROOT)/$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/$(lang)/text,$(lang)/text) \
))

# vim: set noet sw=4 ts=4:
