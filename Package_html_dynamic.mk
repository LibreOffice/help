# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t; fill-column: 100 -*-
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

$(eval $(call gb_Package_Package,helpcontent2_html_dynamic,$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)))

$(eval $(call gb_Package_use_customtarget,helpcontent2_html_dynamic,helpcontent2/help3xsl))

$(eval $(call gb_Package_add_files,helpcontent2_html_dynamic,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION)), \
    hid2file.js \
    languages.js \
    default.css \
    help2.js \
))

# vim: set noet sw=4 ts=4:
