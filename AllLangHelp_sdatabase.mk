# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t -*-
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

$(eval $(call gb_AllLangHelp_AllLangHelp,sdatabase))

$(eval $(call gb_AllLangHelp_set_treefile,sdatabase,helpcontent2/source/auxiliary/sdatabase))

$(eval $(call gb_AllLangHelp_use_linked_modules,sdatabase,\
	shared \
))

$(eval $(call gb_AllLangHelp_add_helpfiles,sdatabase,\
    helpcontent2/source/text/sdatabase/main \
    helpcontent2/source/text/sdatabase/02000000 \
    helpcontent2/source/text/sdatabase/02000002 \
    helpcontent2/source/text/sdatabase/02010100 \
    helpcontent2/source/text/sdatabase/02010101 \
    helpcontent2/source/text/sdatabase/04000000 \
    helpcontent2/source/text/sdatabase/04030000 \
    helpcontent2/source/text/sdatabase/05000000 \
    helpcontent2/source/text/sdatabase/05000001 \
    helpcontent2/source/text/sdatabase/05000003 \
    helpcontent2/source/text/sdatabase/05010000 \
    helpcontent2/source/text/sdatabase/05010100 \
    helpcontent2/source/text/sdatabase/toolbars \
))

# vim: set noet sw=4 ts=4:
