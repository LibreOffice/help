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
PRJ		= ..$/..$/..$/..
# same for all makefiles in "helpcontent2"
PRJNAME = helpcontent2
# edit to match the current package
PACKAGE = text/shared/01
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = text_shared_01
# edit to match the current module
MODULE  = shared

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

# this list matches the *.xhp files to process
XHPFILES = \
   01010000.xhp \
   01010001.xhp \
   01010100.xhp \
   01010200.xhp \
   01010201.xhp \
   01010202.xhp \
   01010203.xhp \
   01010300.xhp \
   01010301.xhp \
   01010302.xhp \
   01010303.xhp \
   01010304.xhp \
   01020000.xhp \
   01020101.xhp \
   01020103.xhp \
   01050000.xhp \
   01060000.xhp \
   01070000.xhp \
   01070001.xhp \
   01100000.xhp \
   01100100.xhp \
   01100200.xhp \
   01100300.xhp \
   01100400.xhp \
   01100500.xhp \
   01100600.xhp \
   01110000.xhp \
   01110101.xhp \
   01110300.xhp \
   01110400.xhp \
   01130000.xhp \
   01140000.xhp \
   01160000.xhp \
   01160200.xhp \
   01160300.xhp \
   01170000.xhp \
   01180000.xhp \
   01190000.xhp \
   01990000.xhp \
   02010000.xhp \
   02020000.xhp \
   02030000.xhp \
   02040000.xhp \
   02050000.xhp \
   02060000.xhp \
   02070000.xhp \
   02090000.xhp \
   02100000.xhp \
   02100001.xhp \
   02100100.xhp \
   02100200.xhp \
   02100300.xhp \
   02110000.xhp \
   02180000.xhp \
   02180100.xhp \
   02190000.xhp \
   02200000.xhp \
   02200100.xhp \
   02200200.xhp \
   02210101.xhp \
   02220000.xhp \
   02220100.xhp \
   02230000.xhp \
   02230100.xhp \
   02230150.xhp \
   02230200.xhp \
   02230300.xhp \
   02230400.xhp \
   02230401.xhp \
   02230402.xhp \
   02230500.xhp \
   02240000.xhp \
   02250000.xhp \
   03010000.xhp \
   03020000.xhp \
   03040000.xhp \
   03050000.xhp \
   03060000.xhp \
   03110000.xhp \
   03150100.xhp \
   03170000.xhp \
   03990000.xhp \
   04050000.xhp \
   04060000.xhp \
   04060100.xhp \
   04060200.xhp \
   04100000.xhp \
   04140000.xhp \
   04150000.xhp \
   04150100.xhp \
   04150200.xhp \
   04150400.xhp \
   04150500.xhp \
   04160300.xhp \
   04160500.xhp \
   04180100.xhp \
   04990000.xhp \
   05010000.xhp \
   05020000.xhp \
   05020100.xhp \
   05020200.xhp \
   05020300.xhp \
   05020301.xhp \
   05020400.xhp \
   05020500.xhp \
   05020600.xhp \
   05020700.xhp \
   05030000.xhp \
   05030100.xhp \
   05030300.xhp \
   05030500.xhp \
   05030600.xhp \
   05030700.xhp \
   05030800.xhp \
   05040100.xhp \
   05040200.xhp \
   05040300.xhp \
   05040400.xhp \
   05050000.xhp \
   05060000.xhp \
   05070000.xhp \
   05070100.xhp \
   05070200.xhp \
   05070300.xhp \
   05070400.xhp \
   05070500.xhp \
   05070600.xhp \
   05080000.xhp \
   05080100.xhp \
   05080200.xhp \
   05080300.xhp \
   05080400.xhp \
   05090000.xhp \
   05100000.xhp \
   05100100.xhp \
   05100200.xhp \
   05100500.xhp \
   05100600.xhp \
   05100700.xhp \
   05110000.xhp \
   05110100.xhp \
   05110200.xhp \
   05110300.xhp \
   05110400.xhp \
   05110500.xhp \
   05110600m.xhp \
   05110700.xhp \
   05110800.xhp \
   05120000.xhp \
   05120100.xhp \
   05120200.xhp \
   05120300.xhp \
   05120600.xhp \
   05140100.xhp \
   05150101.xhp \
   05190000.xhp \
   05190100.xhp \
   05200000.xhp \
   05200100.xhp \
   05200200.xhp \
   05200300.xhp \
   05210000.xhp \
   05210100.xhp \
   05210200.xhp \
   05210300.xhp \
   05210400.xhp \
   05210500.xhp \
   05210600.xhp \
   05210700.xhp \
   05220000.xhp \
   05230000.xhp \
   05230100.xhp \
   05230300.xhp \
   05230400.xhp \
   05230500.xhp \
   05240000.xhp \
   05240100.xhp \
   05240200.xhp \
   05250000.xhp \
   05250100.xhp \
   05250200.xhp \
   05250300.xhp \
   05250400.xhp \
   05250500.xhp \
   05250600.xhp \
   05260000.xhp \
   05260100.xhp \
   05260200.xhp \
   05260300.xhp \
   05260400.xhp \
   05260500.xhp \
   05260600.xhp \
   05270000.xhp \
   05280000.xhp \
   05290000.xhp \
   05290100.xhp \
   05290200.xhp \
   05290300.xhp \
   05290400.xhp \
   05320000.xhp \
   05340100.xhp \
   05340200.xhp \
   05340300.xhp \
   05340400.xhp \
   05340402.xhp \
   05340404.xhp \
   05340405.xhp \
   05340500.xhp \
   05340600.xhp \
   05350000.xhp \
   05350200.xhp \
   05350300.xhp \
   05350400.xhp \
   05350500.xhp \
   05350600.xhp \
   05360000.xhp \
   05990000.xhp \
   06010000.xhp \
   06010101.xhp \
   06010500.xhp \
   06010600.xhp \
   06010601.xhp \
   06020000.xhp \
   06030000.xhp \
   06040000.xhp \
   06040100.xhp \
   06040200.xhp \
   06040300.xhp \
   06040400.xhp \
   06040500.xhp \
   06040600.xhp \
   06040700.xhp \
   06050000.xhp \
   06050100.xhp \
   06050200.xhp \
   06050300.xhp \
   06050400.xhp \
   06050500.xhp \
   06050600.xhp \
   06130000.xhp \
   06130001.xhp \
   06130010.xhp \
   06130100.xhp \
   06130200.xhp \
   06130500.xhp \
   06140000.xhp \
   06140100.xhp \
   06140101.xhp \
   06140102.xhp \
   06140200.xhp \
   06140400.xhp \
   06140402.xhp \
   06140500.xhp \
   06150000.xhp \
   06150100.xhp \
   06150110.xhp \
   06150120.xhp \
   06150200.xhp \
   06150210.xhp \
   06200000.xhp \
   06201000.xhp \
   06202000.xhp \
   06990000.xhp \
   07010000.xhp \
   07080000.xhp \
   about_meta_tags.xhp \
   digitalsignatures.xhp \
   extensionupdate.xhp \
   formatting_mark.xhp \
   gallery.xhp \
   gallery_files.xhp \
   grid.xhp \
   guides.xhp \
   mediaplayer.xhp \
   moviesound.xhp \
   online_update.xhp \
   online_update_dialog.xhp \
   packagemanager.xhp \
   password_dlg.xhp \
   password_main.xhp \
   ref_pdf_export.xhp \
   ref_pdf_send_as.xhp \
   securitywarning.xhp \
   selectcertificate.xhp \
   webhtml.xhp \
   xformsdata.xhp \
   xformsdataadd.xhp \
   xformsdataaddcon.xhp \
   xformsdatachange.xhp \
   xformsdataname.xhp \
   xformsdatatab.xhp 

# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : tg_help.mk
