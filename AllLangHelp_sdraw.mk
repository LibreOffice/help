# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t -*-
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

$(eval $(call gb_AllLangHelp_AllLangHelp,sdraw))

$(eval $(call gb_AllLangHelp_set_treefile,sdraw,helpcontent2/source/auxiliary/sdraw))

$(eval $(call gb_AllLangHelp_use_linked_modules,sdraw,\
	schart \
	shared \
	simpress \
))

$(eval $(call gb_AllLangHelp_add_helpfiles,sdraw,\
    helpcontent2/source/text/sdraw/00/00000004 \
    helpcontent2/source/text/sdraw/00/page_menu \
    helpcontent2/source/text/sdraw/01/3dsettings_toolbar \
    helpcontent2/source/text/sdraw/01/consolidatetext \
    helpcontent2/source/text/sdraw/01/delete_page \
    helpcontent2/source/text/sdraw/01/duplicate_page \
    helpcontent2/source/text/sdraw/01/insert_layer \
    helpcontent2/source/text/sdraw/01/modify_layer \
    helpcontent2/source/text/sdraw/01/new_page \
    helpcontent2/source/text/sdraw/01/navigate_page \
    helpcontent2/source/text/sdraw/01/page_properties \
    helpcontent2/source/text/sdraw/01/rename_page \
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
    helpcontent2/source/text/sdraw/guide/layers \
    helpcontent2/source/text/sdraw/guide/layer_move \
    helpcontent2/source/text/sdraw/guide/layer_new \
    helpcontent2/source/text/sdraw/guide/layer_tipps \
    helpcontent2/source/text/sdraw/guide/main \
    helpcontent2/source/text/sdraw/guide/rotate_object \
    helpcontent2/source/text/sdraw/guide/text_enter \
    helpcontent2/source/text/sdraw/main0000 \
    helpcontent2/source/text/sdraw/main0100 \
    helpcontent2/source/text/sdraw/main0101 \
    helpcontent2/source/text/sdraw/main_edit \
    helpcontent2/source/text/sdraw/main0103 \
    helpcontent2/source/text/sdraw/main_insert \
    helpcontent2/source/text/sdraw/main_format \
    helpcontent2/source/text/sdraw/main_page \
    helpcontent2/source/text/sdraw/main_shape \
    helpcontent2/source/text/sdraw/main_tools \
    helpcontent2/source/text/sdraw/main0200 \
    helpcontent2/source/text/sdraw/main0202 \
    helpcontent2/source/text/sdraw/main0210 \
    helpcontent2/source/text/sdraw/main0213 \
    helpcontent2/source/text/sdraw/main0503 \
))

# vim: set noet sw=4 ts=4:
