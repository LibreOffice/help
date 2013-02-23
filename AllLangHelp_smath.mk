# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t -*-
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

$(eval $(call gb_AllLangHelp_AllLangHelp,smath))

$(eval $(call gb_AllLangHelp_set_treefile,smath,helpcontent2/source/auxiliary/smath))

$(eval $(call gb_AllLangHelp_use_linked_modules,smath,\
	shared \
))

$(eval $(call gb_AllLangHelp_add_helpfiles,smath,\
    helpcontent2/source/text/smath/00/00000004 \
    helpcontent2/source/text/smath/01/02080000 \
    helpcontent2/source/text/smath/01/02090000 \
    helpcontent2/source/text/smath/01/02100000 \
    helpcontent2/source/text/smath/01/02110000 \
    helpcontent2/source/text/smath/01/03040000 \
    helpcontent2/source/text/smath/01/03050000 \
    helpcontent2/source/text/smath/01/03060000 \
    helpcontent2/source/text/smath/01/03070000 \
    helpcontent2/source/text/smath/01/03080000 \
    helpcontent2/source/text/smath/01/03090000 \
    helpcontent2/source/text/smath/01/03090100 \
    helpcontent2/source/text/smath/01/03090200 \
    helpcontent2/source/text/smath/01/03090300 \
    helpcontent2/source/text/smath/01/03090400 \
    helpcontent2/source/text/smath/01/03090500 \
    helpcontent2/source/text/smath/01/03090600 \
    helpcontent2/source/text/smath/01/03090700 \
    helpcontent2/source/text/smath/01/03090800 \
    helpcontent2/source/text/smath/01/03090900 \
    helpcontent2/source/text/smath/01/03090901 \
    helpcontent2/source/text/smath/01/03090902 \
    helpcontent2/source/text/smath/01/03090903 \
    helpcontent2/source/text/smath/01/03090904 \
    helpcontent2/source/text/smath/01/03090905 \
    helpcontent2/source/text/smath/01/03090906 \
    helpcontent2/source/text/smath/01/03090907 \
    helpcontent2/source/text/smath/01/03090908 \
    helpcontent2/source/text/smath/01/03090909 \
    helpcontent2/source/text/smath/01/03090910 \
    helpcontent2/source/text/smath/01/03091100 \
    helpcontent2/source/text/smath/01/03091200 \
    helpcontent2/source/text/smath/01/03091300 \
    helpcontent2/source/text/smath/01/03091400 \
    helpcontent2/source/text/smath/01/03091500 \
    helpcontent2/source/text/smath/01/03091501 \
    helpcontent2/source/text/smath/01/03091502 \
    helpcontent2/source/text/smath/01/03091503 \
    helpcontent2/source/text/smath/01/03091504 \
    helpcontent2/source/text/smath/01/03091505 \
    helpcontent2/source/text/smath/01/03091506 \
    helpcontent2/source/text/smath/01/03091507 \
    helpcontent2/source/text/smath/01/03091508 \
    helpcontent2/source/text/smath/01/03091509 \
    helpcontent2/source/text/smath/01/03091600 \
    helpcontent2/source/text/smath/01/05010000 \
    helpcontent2/source/text/smath/01/05010100 \
    helpcontent2/source/text/smath/01/05020000 \
    helpcontent2/source/text/smath/01/05030000 \
    helpcontent2/source/text/smath/01/05040000 \
    helpcontent2/source/text/smath/01/05050000 \
    helpcontent2/source/text/smath/01/06010000 \
    helpcontent2/source/text/smath/01/06010100 \
    helpcontent2/source/text/smath/01/06020000 \
    helpcontent2/source/text/smath/02/03010000 \
    helpcontent2/source/text/smath/04/01020000 \
    helpcontent2/source/text/smath/guide/align \
    helpcontent2/source/text/smath/guide/attributes \
    helpcontent2/source/text/smath/guide/brackets \
    helpcontent2/source/text/smath/guide/comment \
    helpcontent2/source/text/smath/guide/keyboard \
    helpcontent2/source/text/smath/guide/limits \
    helpcontent2/source/text/smath/guide/main \
    helpcontent2/source/text/smath/guide/newline \
    helpcontent2/source/text/smath/guide/parentheses \
    helpcontent2/source/text/smath/guide/text \
    helpcontent2/source/text/smath/main0000 \
    helpcontent2/source/text/smath/main0100 \
    helpcontent2/source/text/smath/main0101 \
    helpcontent2/source/text/smath/main0102 \
    helpcontent2/source/text/smath/main0103 \
    helpcontent2/source/text/smath/main0105 \
    helpcontent2/source/text/smath/main0106 \
    helpcontent2/source/text/smath/main0107 \
    helpcontent2/source/text/smath/main0200 \
    helpcontent2/source/text/smath/main0202 \
    helpcontent2/source/text/smath/main0203 \
    helpcontent2/source/text/smath/main0503 \
))

# vim: set noet sw=4 ts=4:
