#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# This file incorporates work covered by the following license notice:
#
#   Licensed to the Apache Software Foundation (ASF) under one or more
#   contributor license agreements. See the NOTICE file distributed
#   with this work for additional information regarding copyright
#   ownership. The ASF licenses this file to you under the Apache
#   License, Version 2.0 (the "License"); you may not use this file
#   except in compliance with the License. You may obtain a copy of
#   the License at http://www.apache.org/licenses/LICENSE-2.0 .
#


# edit to match directory level 
PRJ		= ..$/..
# same for all makefiles in "helpcontent2"
PRJNAME = helpcontent2
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = util_shared

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk


LINKNAME=shared
LINKADDEDFILES= \
   -add shared.tree $(COMMONMISC)$/LANGUAGE$/shared.tree \
   -add default.css  $(PRJ)$/source$/auxiliary$/LANGUAGE$/default.css \
   -add highcontrast1.css  $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrast1.css \
   -add highcontrast2.css  $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrast2.css \
   -add highcontrastwhite.css  $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrastwhite.css \
   -add highcontrastblack.css  $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrastblack.css \
   -add err.html  $(COMMONMISC)$/LANGUAGE$/text$/shared$/05$/err_html.xhp


LINKADDEDDEPS= \
   $(COMMONMISC)$/LANGUAGE$/shared.tree \
   $(PRJ)$/source$/auxiliary$/LANGUAGE$/default.css \
   $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrast1.css \
   $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrast2.css \
   $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrastwhite.css \
   $(PRJ)$/source$/auxiliary$/LANGUAGE$/highcontrastblack.css \
   $(COMMONMISC)$/LANGUAGE$/text$/shared$/05$/err_html.xhp


LINKLINKFILES= \


# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE :  $(PRJ)$/util$/target.pmk
