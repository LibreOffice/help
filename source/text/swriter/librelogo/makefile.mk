# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t -*-
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

PRJ     = ../../../..
PRJNAME = helpcontent2
PACKAGE = text/swriter/librelogo
TARGET  = text_swriter_librelogo
MODULE  = swriter

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)/settings.pmk

XHPFILES = LibreLogo.xhp 

.INCLUDE :  target.mk
.INCLUDE : tg_help.mk

# vim: set noet sw=4 ts=4:
