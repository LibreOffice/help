# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t; fill-column: 100 -*-
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

# The help/media/icon-themes/ sub-tree.

$(eval $(call gb_GeneratedPackage_GeneratedPackage,helpcontent2_html_icon-themes,$(SRCDIR)/icon-themes))

$(eval $(call gb_GeneratedPackage_add_dir,helpcontent2_html_icon-themes,$(INSTROOT)/$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media/icon-themes,colibre_svg))

# vim: set noet sw=4 ts=4:
