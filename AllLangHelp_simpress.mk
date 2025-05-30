# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t -*-
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

$(eval $(call gb_AllLangHelp_AllLangHelp,simpress))

$(eval $(call gb_AllLangHelp_set_treefile,simpress,helpcontent2/source/auxiliary/simpress))

$(eval $(call gb_AllLangHelp_use_linked_modules,simpress,\
	schart \
	sdraw \
	shared \
))

$(eval $(call gb_AllLangHelp_add_helpfiles,simpress,\
    helpcontent2/source/text/simpress/00/00000004 \
    helpcontent2/source/text/simpress/00/00000401 \
    helpcontent2/source/text/simpress/00/00000402 \
    helpcontent2/source/text/simpress/00/00000403 \
    helpcontent2/source/text/simpress/00/00000404 \
    helpcontent2/source/text/simpress/00/00000405 \
    helpcontent2/source/text/simpress/00/00000406 \
    helpcontent2/source/text/simpress/00/00000407 \
    helpcontent2/source/text/simpress/00/00000413 \
    helpcontent2/source/text/simpress/00/slide_menu \
    helpcontent2/source/text/simpress/01/01170000 \
    helpcontent2/source/text/simpress/01/slide_properties \
    helpcontent2/source/text/simpress/01/02110000 \
    helpcontent2/source/text/simpress/01/02120000 \
    helpcontent2/source/text/simpress/01/02130000 \
    helpcontent2/source/text/simpress/01/02140000 \
    helpcontent2/source/text/simpress/01/02150000 \
    helpcontent2/source/text/simpress/01/02160000 \
    helpcontent2/source/text/simpress/01/03050000 \
    helpcontent2/source/text/simpress/01/03060000 \
    helpcontent2/source/text/simpress/01/03070000 \
    helpcontent2/source/text/simpress/01/03080000 \
    helpcontent2/source/text/simpress/01/03090000 \
    helpcontent2/source/text/simpress/01/03100000 \
    helpcontent2/source/text/simpress/01/03110000 \
    helpcontent2/source/text/simpress/01/03120000 \
    helpcontent2/source/text/simpress/01/03130000 \
    helpcontent2/source/text/simpress/01/03150000 \
    helpcontent2/source/text/simpress/01/03150100 \
    helpcontent2/source/text/simpress/01/03150300 \
    helpcontent2/source/text/simpress/01/03151000 \
    helpcontent2/source/text/simpress/01/03151100 \
    helpcontent2/source/text/simpress/01/03151200 \
    helpcontent2/source/text/simpress/01/03152000 \
    helpcontent2/source/text/simpress/01/03180000 \
    helpcontent2/source/text/simpress/01/new_slide \
    helpcontent2/source/text/simpress/01/04030000 \
    helpcontent2/source/text/simpress/01/04030100 \
    helpcontent2/source/text/simpress/01/04110100 \
    helpcontent2/source/text/simpress/01/04110200 \
    helpcontent2/source/text/simpress/01/04120000 \
    helpcontent2/source/text/simpress/01/04130000 \
    helpcontent2/source/text/simpress/01/04140000 \
    helpcontent2/source/text/simpress/01/04990000 \
    helpcontent2/source/text/simpress/01/04990100 \
    helpcontent2/source/text/simpress/01/04990200 \
    helpcontent2/source/text/simpress/01/04990300 \
    helpcontent2/source/text/simpress/01/04990400 \
    helpcontent2/source/text/simpress/01/04990500 \
    helpcontent2/source/text/simpress/01/04990700 \
    helpcontent2/source/text/simpress/01/05090000m \
    helpcontent2/source/text/simpress/01/05120000 \
    helpcontent2/source/text/simpress/01/05130000 \
    helpcontent2/source/text/simpress/01/05150000 \
    helpcontent2/source/text/simpress/01/05170000 \
    helpcontent2/source/text/simpress/01/05250000 \
    helpcontent2/source/text/simpress/01/05250500 \
    helpcontent2/source/text/simpress/01/05250600 \
    helpcontent2/source/text/simpress/01/05250700 \
    helpcontent2/source/text/simpress/01/06030000 \
    helpcontent2/source/text/simpress/01/06040000 \
    helpcontent2/source/text/simpress/01/06050000 \
    helpcontent2/source/text/simpress/01/06060000 \
    helpcontent2/source/text/simpress/01/06070000 \
    helpcontent2/source/text/simpress/01/06080000 \
    helpcontent2/source/text/simpress/01/06100000 \
    helpcontent2/source/text/simpress/01/06100100 \
    helpcontent2/source/text/simpress/01/13050000 \
    helpcontent2/source/text/simpress/01/13050100 \
    helpcontent2/source/text/simpress/01/13050200 \
    helpcontent2/source/text/simpress/01/13050300 \
    helpcontent2/source/text/simpress/01/13050400 \
    helpcontent2/source/text/simpress/01/13050500 \
    helpcontent2/source/text/simpress/01/13050600 \
    helpcontent2/source/text/simpress/01/13050700 \
    helpcontent2/source/text/simpress/01/13140000 \
    helpcontent2/source/text/simpress/01/13150000 \
    helpcontent2/source/text/simpress/01/13160000 \
    helpcontent2/source/text/simpress/01/13170000 \
    helpcontent2/source/text/simpress/01/13180000 \
    helpcontent2/source/text/simpress/01/13180100 \
    helpcontent2/source/text/simpress/01/13180200 \
    helpcontent2/source/text/simpress/01/13180300 \
    helpcontent2/source/text/simpress/01/bulletandposition \
    helpcontent2/source/text/simpress/01/effectoptions \
    helpcontent2/source/text/simpress/01/effectoptionseffect \
    helpcontent2/source/text/simpress/01/effectoptionstext \
    helpcontent2/source/text/simpress/01/effectoptionstiming \
    helpcontent2/source/text/simpress/01/PresentationMinimizer \
    helpcontent2/source/text/simpress/01/remoteconnections \
    helpcontent2/source/text/simpress/01/slidesorter \
    helpcontent2/source/text/simpress/02/04010000 \
    helpcontent2/source/text/simpress/02/04020000 \
    helpcontent2/source/text/simpress/02/04030000 \
    helpcontent2/source/text/simpress/02/04060000 \
    helpcontent2/source/text/simpress/02/04070000 \
    helpcontent2/source/text/simpress/02/08020000 \
    helpcontent2/source/text/simpress/02/08060000 \
    helpcontent2/source/text/simpress/02/10020000 \
    helpcontent2/source/text/simpress/02/10030000 \
    helpcontent2/source/text/simpress/02/10030200 \
    helpcontent2/source/text/simpress/02/10050000 \
    helpcontent2/source/text/simpress/02/10060000 \
    helpcontent2/source/text/simpress/02/10070000 \
    helpcontent2/source/text/simpress/02/10080000 \
    helpcontent2/source/text/simpress/02/10090000 \
    helpcontent2/source/text/simpress/02/10100000 \
    helpcontent2/source/text/simpress/02/10110000 \
    helpcontent2/source/text/simpress/02/10120000 \
    helpcontent2/source/text/simpress/02/11060000 \
    helpcontent2/source/text/simpress/02/11070000 \
    helpcontent2/source/text/simpress/02/11080000 \
    helpcontent2/source/text/simpress/02/11090000 \
    helpcontent2/source/text/simpress/02/11100000 \
    helpcontent2/source/text/simpress/02/11110000 \
    helpcontent2/source/text/simpress/02/13010000 \
    helpcontent2/source/text/simpress/02/13020000 \
    helpcontent2/source/text/simpress/02/13030000 \
    helpcontent2/source/text/simpress/02/13040000 \
    helpcontent2/source/text/simpress/02/13050000 \
    helpcontent2/source/text/simpress/02/13060000 \
    helpcontent2/source/text/simpress/02/13090000 \
    helpcontent2/source/text/simpress/02/13100000 \
    helpcontent2/source/text/simpress/02/13140000 \
    helpcontent2/source/text/simpress/02/13150000 \
    helpcontent2/source/text/simpress/02/13160000 \
    helpcontent2/source/text/simpress/02/13170000 \
    helpcontent2/source/text/simpress/02/13180000 \
    helpcontent2/source/text/simpress/02/13190000 \
    helpcontent2/source/text/simpress/04/01020000 \
    helpcontent2/source/text/simpress/04/presenter \
    helpcontent2/source/text/simpress/guide/3d_create \
    helpcontent2/source/text/simpress/guide/animated_gif_create \
    helpcontent2/source/text/simpress/guide/animated_gif_save \
    helpcontent2/source/text/simpress/guide/animated_objects \
    helpcontent2/source/text/simpress/guide/animated_slidechange \
    helpcontent2/source/text/simpress/guide/arrange_slides \
    helpcontent2/source/text/simpress/guide/background \
    helpcontent2/source/text/simpress/guide/change_scale \
    helpcontent2/source/text/simpress/guide/footer \
    helpcontent2/source/text/simpress/guide/gluepoints \
    helpcontent2/source/text/simpress/guide/html_import \
    helpcontent2/source/text/simpress/guide/impress_remote \
    helpcontent2/source/text/simpress/guide/individual \
    helpcontent2/source/text/simpress/guide/keyboard \
    helpcontent2/source/text/simpress/guide/line_arrow_styles \
    helpcontent2/source/text/simpress/guide/line_draw \
    helpcontent2/source/text/simpress/guide/line_edit \
    helpcontent2/source/text/simpress/guide/main \
    helpcontent2/source/text/simpress/guide/masterpage \
    helpcontent2/source/text/simpress/guide/move_object \
    helpcontent2/source/text/simpress/guide/orgchart \
    helpcontent2/source/text/simpress/guide/page_copy \
    helpcontent2/source/text/simpress/guide/photo_album \
    helpcontent2/source/text/simpress/guide/presenter_console \
    helpcontent2/source/text/simpress/guide/print_tofit \
    helpcontent2/source/text/simpress/guide/printing \
    helpcontent2/source/text/simpress/guide/rehearse_timings \
    helpcontent2/source/text/simpress/guide/select_object \
    helpcontent2/source/text/simpress/guide/show \
    helpcontent2/source/text/simpress/guide/table_insert \
    helpcontent2/source/text/simpress/guide/text2curve \
    helpcontent2/source/text/simpress/guide/vectorize \
    helpcontent2/source/text/simpress/main0000 \
    helpcontent2/source/text/simpress/main0100 \
    helpcontent2/source/text/simpress/main0113 \
    helpcontent2/source/text/simpress/main0114 \
    helpcontent2/source/text/simpress/main_slide \
    helpcontent2/source/text/simpress/main0200 \
    helpcontent2/source/text/simpress/main0202 \
    helpcontent2/source/text/simpress/main0203 \
    helpcontent2/source/text/simpress/main0204 \
    helpcontent2/source/text/simpress/main0206 \
    helpcontent2/source/text/simpress/main0209 \
    helpcontent2/source/text/simpress/main0210 \
    helpcontent2/source/text/simpress/main0211 \
    helpcontent2/source/text/simpress/main0212 \
    helpcontent2/source/text/simpress/main0213 \
    helpcontent2/source/text/simpress/main0214 \
    helpcontent2/source/text/simpress/main0503 \
    helpcontent2/source/text/simpress/submenu_object_shape \
))

# vim: set noet sw=4 ts=4:
