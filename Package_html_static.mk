# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t -*-
#  #
# This file is part of the LibreOffice project.
# #
# # This Source Code Form is subject to the terms of the Mozilla Public
# # License, v. 2.0. If a copy of the MPL was not distributed with this
# # file, You can obtain one at http://mozilla.org/MPL/2.0/.
# #
#
$(eval $(call gb_Package_Package,helpcontent2_html_static,$(SRCDIR)/helpcontent2/help3xsl))

$(eval $(call gb_Package_add_files,helpcontent2_html_static,$(LIBO_SHARE_HELP_FOLDER),\
	index.html \
	help.html \
)) 

$(eval $(call gb_Package_add_file,helpcontent2_html_static,$(LIBO_SHARE_HELP_FOLDER)/$(if $(HELP_ONLINE),$(PRODUCTVERSION),'')/index.html,index2.html))

$(eval $(call gb_Package_add_files,helpcontent2_html_static,$(LIBO_SHARE_HELP_FOLDER)/$(if $(HELP_ONLINE),$(PRODUCTVERSION),''),\
	help.js \
	fuse.js \
	paginathing.js \
	normalize.css \
	default.css \
))

# vim: set noet sw=4 ts=4:
