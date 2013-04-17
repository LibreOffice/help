# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t -*-
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

$(eval $(call gb_AllLangHelp_AllLangHelp,schart))

$(eval $(call gb_AllLangHelp_set_treefile,schart,helpcontent2/source/auxiliary/schart))

$(eval $(call gb_AllLangHelp_use_linked_modules,schart,\
	shared \
))

$(eval $(call gb_AllLangHelp_add_helpfiles,schart,\
    helpcontent2/source/text/schart/00/00000004 \
    helpcontent2/source/text/schart/01/03010000 \
    helpcontent2/source/text/schart/01/04010000 \
    helpcontent2/source/text/schart/01/04020000 \
    helpcontent2/source/text/schart/01/04030000 \
    helpcontent2/source/text/schart/01/04040000 \
    helpcontent2/source/text/schart/01/04050000 \
    helpcontent2/source/text/schart/01/04050100 \
    helpcontent2/source/text/schart/01/04060000 \
    helpcontent2/source/text/schart/01/04070000 \
    helpcontent2/source/text/schart/01/05010000 \
    helpcontent2/source/text/schart/01/05010100 \
    helpcontent2/source/text/schart/01/05010200 \
    helpcontent2/source/text/schart/01/05020000 \
    helpcontent2/source/text/schart/01/05020100 \
    helpcontent2/source/text/schart/01/05020101 \
    helpcontent2/source/text/schart/01/05020200 \
    helpcontent2/source/text/schart/01/05020201 \
    helpcontent2/source/text/schart/01/05030000 \
    helpcontent2/source/text/schart/01/05040000 \
    helpcontent2/source/text/schart/01/05040100 \
    helpcontent2/source/text/schart/01/05040200 \
    helpcontent2/source/text/schart/01/05040201 \
    helpcontent2/source/text/schart/01/05040202 \
    helpcontent2/source/text/schart/01/05050000 \
    helpcontent2/source/text/schart/01/05050100 \
    helpcontent2/source/text/schart/01/05060000 \
    helpcontent2/source/text/schart/01/05070000 \
    helpcontent2/source/text/schart/01/05080000 \
    helpcontent2/source/text/schart/01/05120000 \
    helpcontent2/source/text/schart/01/choose_chart_type \
    helpcontent2/source/text/schart/01/smooth_line_properties \
    helpcontent2/source/text/schart/01/stepped_line_properties \
    helpcontent2/source/text/schart/01/three_d_view \
    helpcontent2/source/text/schart/01/type_area \
    helpcontent2/source/text/schart/01/type_bubble \
    helpcontent2/source/text/schart/01/type_column_bar \
    helpcontent2/source/text/schart/01/type_column_line \
    helpcontent2/source/text/schart/01/type_line \
    helpcontent2/source/text/schart/01/type_net \
    helpcontent2/source/text/schart/01/type_pie \
    helpcontent2/source/text/schart/01/type_stock \
    helpcontent2/source/text/schart/01/type_xy \
    helpcontent2/source/text/schart/01/wiz_chart_elements \
    helpcontent2/source/text/schart/01/wiz_chart_type \
    helpcontent2/source/text/schart/01/wiz_data_range \
    helpcontent2/source/text/schart/01/wiz_data_series \
    helpcontent2/source/text/schart/02/01190000 \
    helpcontent2/source/text/schart/02/01200000 \
    helpcontent2/source/text/schart/02/01210000 \
    helpcontent2/source/text/schart/02/01220000 \
    helpcontent2/source/text/schart/02/02020000 \
    helpcontent2/source/text/schart/04/01020000 \
    helpcontent2/source/text/schart/main0000 \
    helpcontent2/source/text/schart/main0202 \
    helpcontent2/source/text/schart/main0503 \
))

# vim: set noet sw=4 ts=4:
