# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t -*-
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

$(eval $(call gb_AllLangHelp_AllLangHelp,sdraw))

$(eval $(call gb_AllLangHelp_use_linked_modules,sdraw,\
	schart \
	shared \
	simpress \
))

$(eval $(call gb_AllLangHelp_add_helpfiles,sdraw,\
    helpcontent2/source/text/sdraw/00/00000004 \
    helpcontent2/source/text/sdraw/01/04010000 \
    helpcontent2/source/text/sdraw/04/01020000 \
    helpcontent2/source/text/sdraw/guide/align_arrange \
    helpcontent2/source/text/sdraw/guide/color_define \
    helpcontent2/source/text/sdraw/guide/combine_etc \
    helpcontent2/source/text/sdraw/guide/cross_fading \
    helpcontent2/source/text/sdraw/guide/draw_sector \
    helpcontent2/source/text/sdraw/guide/duplicate_object \
    helpcontent2/source/text/sdraw/guide/eyedropper \
    helpcontent2/source/text/sdraw/guide/gradient \
    helpcontent2/source/text/sdraw/guide/graphic_insert \
    helpcontent2/source/text/sdraw/guide/groups \
    helpcontent2/source/text/sdraw/guide/join_objects \
    helpcontent2/source/text/sdraw/guide/join_objects3d \
    helpcontent2/source/text/sdraw/guide/keyboard \
    helpcontent2/source/text/sdraw/guide/main \
    helpcontent2/source/text/sdraw/guide/rotate_object \
    helpcontent2/source/text/sdraw/guide/text_enter \
    helpcontent2/source/text/sdraw/main0000 \
    helpcontent2/source/text/sdraw/main0100 \
    helpcontent2/source/text/sdraw/main0101 \
    helpcontent2/source/text/sdraw/main0102 \
    helpcontent2/source/text/sdraw/main0103 \
    helpcontent2/source/text/sdraw/main0104 \
    helpcontent2/source/text/sdraw/main0105 \
    helpcontent2/source/text/sdraw/main0106 \
    helpcontent2/source/text/sdraw/main0200 \
    helpcontent2/source/text/sdraw/main0202 \
    helpcontent2/source/text/sdraw/main0210 \
    helpcontent2/source/text/sdraw/main0213 \
    helpcontent2/source/text/sdraw/main0503 \
))

# vim: set noet sw=4 ts=4:
