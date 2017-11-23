# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t -*-
#  #
# This file is part of the LibreOffice project.
# #
# # This Source Code Form is subject to the terms of the Mozilla Public
# # License, v. 2.0. If a copy of the MPL was not distributed with this
# # file, You can obtain one at http://mozilla.org/MPL/2.0/.
# #
#
$(eval $(call gb_GeneratedPackage_GeneratedPackage,helpcontent2_html_media,$(SRCDIR)))

$(eval $(call gb_GeneratedPackage_add_dir,helpcontent2_html_media,$(INSTROOT)/$(LIBO_SHARE_HELP_FOLDER)/$(PRODUCTVERSION)/media/icon-themes,icon-themes/galaxy))

$(eval $(call gb_GeneratedPackage_add_dir,helpcontent2_html_media,$(INSTROOT)/$(LIBO_SHARE_HELP_FOLDER)/$(PRODUCTVERSION)/media/helpimg,helpcontent2/source/media/helpimg))
$(eval $(call gb_GeneratedPackage_add_dir,helpcontent2_html_media,$(INSTROOT)/$(LIBO_SHARE_HELP_FOLDER)/$(PRODUCTVERSION)/media/navigation,helpcontent2/source/media/navigation))
$(eval $(call gb_GeneratedPackage_add_dir,helpcontent2_html_media,$(INSTROOT)/$(LIBO_SHARE_HELP_FOLDER)/$(PRODUCTVERSION)/media/screenshots,helpcontent2/source/media/screenshots))

# vim: set noet sw=4 ts=4:
