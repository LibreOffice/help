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
PRJ		= ..$/..$/..
# same for all makefiles in "helpcontent2"
PRJNAME = helpcontent2
# edit to match the current package
PACKAGE = text/shared
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = text_shared
# edit to match the current module
MODULE  = shared

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

# this list matches the *.xhp files to process
XHPFILES = \
   3dsettings_toolbar.xhp \
   fontwork_toolbar.xhp \
   main0108.xhp \
   main0201.xhp \
   main0204.xhp \
   main0208.xhp \
   main0212.xhp \
   main0213.xhp \
   main0214.xhp \
   main0226.xhp \
   main0227.xhp \
   main0400.xhp \
   main0500.xhp \
   main0600.xhp \
   main0650.xhp \
   main0800.xhp
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : tg_help.mk
