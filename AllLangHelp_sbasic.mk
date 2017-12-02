# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t -*-
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

$(eval $(call gb_AllLangHelp_AllLangHelp,sbasic))

$(eval $(call gb_AllLangHelp_set_treefile,sbasic,helpcontent2/source/auxiliary/sbasic))

$(eval $(call gb_AllLangHelp_use_linked_modules,sbasic,\
	shared \
))

$(eval $(call gb_AllLangHelp_add_helpfiles,sbasic,\
    helpcontent2/source/text/sbasic/guide/access2base \
    helpcontent2/source/text/sbasic/guide/control_properties \
    helpcontent2/source/text/sbasic/guide/create_dialog \
    helpcontent2/source/text/sbasic/guide/insert_control \
    helpcontent2/source/text/sbasic/guide/sample_code \
    helpcontent2/source/text/sbasic/guide/show_dialog \
    helpcontent2/source/text/sbasic/guide/translation \
    helpcontent2/source/text/sbasic/shared/00000002 \
    helpcontent2/source/text/sbasic/shared/00000003 \
    helpcontent2/source/text/sbasic/shared/01/06130000 \
    helpcontent2/source/text/sbasic/shared/01/06130100 \
    helpcontent2/source/text/sbasic/shared/01/06130500 \
    helpcontent2/source/text/sbasic/shared/01000000 \
    helpcontent2/source/text/sbasic/shared/01010210 \
    helpcontent2/source/text/sbasic/shared/01020000 \
    helpcontent2/source/text/sbasic/shared/01020100 \
    helpcontent2/source/text/sbasic/shared/01020200 \
    helpcontent2/source/text/sbasic/shared/01020300 \
    helpcontent2/source/text/sbasic/shared/01020500 \
    helpcontent2/source/text/sbasic/shared/01030000 \
    helpcontent2/source/text/sbasic/shared/01030100 \
    helpcontent2/source/text/sbasic/shared/01030200 \
    helpcontent2/source/text/sbasic/shared/01030300 \
    helpcontent2/source/text/sbasic/shared/01030400 \
    helpcontent2/source/text/sbasic/shared/01040000 \
    helpcontent2/source/text/sbasic/shared/01050000 \
    helpcontent2/source/text/sbasic/shared/01050100 \
    helpcontent2/source/text/sbasic/shared/01050200 \
    helpcontent2/source/text/sbasic/shared/01050300 \
    helpcontent2/source/text/sbasic/shared/01170100 \
    helpcontent2/source/text/sbasic/shared/01170101 \
    helpcontent2/source/text/sbasic/shared/01170103 \
    helpcontent2/source/text/sbasic/shared/02/11010000 \
    helpcontent2/source/text/sbasic/shared/02/11020000 \
    helpcontent2/source/text/sbasic/shared/02/11030000 \
    helpcontent2/source/text/sbasic/shared/02/11040000 \
    helpcontent2/source/text/sbasic/shared/02/11050000 \
    helpcontent2/source/text/sbasic/shared/02/11060000 \
    helpcontent2/source/text/sbasic/shared/02/11070000 \
    helpcontent2/source/text/sbasic/shared/02/11080000 \
    helpcontent2/source/text/sbasic/shared/02/11090000 \
    helpcontent2/source/text/sbasic/shared/02/11100000 \
    helpcontent2/source/text/sbasic/shared/02/11110000 \
    helpcontent2/source/text/sbasic/shared/02/11120000 \
    helpcontent2/source/text/sbasic/shared/02/11140000 \
    helpcontent2/source/text/sbasic/shared/02/11150000 \
    helpcontent2/source/text/sbasic/shared/02/11160000 \
    helpcontent2/source/text/sbasic/shared/02/11170000 \
    helpcontent2/source/text/sbasic/shared/02/11180000 \
    helpcontent2/source/text/sbasic/shared/02/11190000 \
    helpcontent2/source/text/sbasic/shared/02/20000000 \
    helpcontent2/source/text/sbasic/shared/03000000 \
    helpcontent2/source/text/sbasic/shared/03010000 \
    helpcontent2/source/text/sbasic/shared/03010100 \
    helpcontent2/source/text/sbasic/shared/03010101 \
    helpcontent2/source/text/sbasic/shared/03010102 \
    helpcontent2/source/text/sbasic/shared/03010103 \
    helpcontent2/source/text/sbasic/shared/03010200 \
    helpcontent2/source/text/sbasic/shared/03010201 \
    helpcontent2/source/text/sbasic/shared/03010300 \
    helpcontent2/source/text/sbasic/shared/03010301 \
    helpcontent2/source/text/sbasic/shared/03010302 \
    helpcontent2/source/text/sbasic/shared/03010303 \
    helpcontent2/source/text/sbasic/shared/03010304 \
    helpcontent2/source/text/sbasic/shared/03010305 \
    helpcontent2/source/text/sbasic/shared/03020000 \
    helpcontent2/source/text/sbasic/shared/03020100 \
    helpcontent2/source/text/sbasic/shared/03020101 \
    helpcontent2/source/text/sbasic/shared/03020102 \
    helpcontent2/source/text/sbasic/shared/03020103 \
    helpcontent2/source/text/sbasic/shared/03020104 \
    helpcontent2/source/text/sbasic/shared/03020200 \
    helpcontent2/source/text/sbasic/shared/03020201 \
    helpcontent2/source/text/sbasic/shared/03020202 \
    helpcontent2/source/text/sbasic/shared/03020203 \
    helpcontent2/source/text/sbasic/shared/03020204 \
    helpcontent2/source/text/sbasic/shared/03020205 \
    helpcontent2/source/text/sbasic/shared/03020301 \
    helpcontent2/source/text/sbasic/shared/03020302 \
    helpcontent2/source/text/sbasic/shared/03020303 \
    helpcontent2/source/text/sbasic/shared/03020304 \
    helpcontent2/source/text/sbasic/shared/03020305 \
    helpcontent2/source/text/sbasic/shared/03020400 \
    helpcontent2/source/text/sbasic/shared/03020401 \
    helpcontent2/source/text/sbasic/shared/03020402 \
    helpcontent2/source/text/sbasic/shared/03020403 \
    helpcontent2/source/text/sbasic/shared/03020404 \
    helpcontent2/source/text/sbasic/shared/03020405 \
    helpcontent2/source/text/sbasic/shared/03020406 \
    helpcontent2/source/text/sbasic/shared/03020407 \
    helpcontent2/source/text/sbasic/shared/03020408 \
    helpcontent2/source/text/sbasic/shared/03020409 \
    helpcontent2/source/text/sbasic/shared/03020410 \
    helpcontent2/source/text/sbasic/shared/03020411 \
    helpcontent2/source/text/sbasic/shared/03020412 \
    helpcontent2/source/text/sbasic/shared/03020413 \
    helpcontent2/source/text/sbasic/shared/03020414 \
    helpcontent2/source/text/sbasic/shared/03020415 \
    helpcontent2/source/text/sbasic/shared/03030000 \
    helpcontent2/source/text/sbasic/shared/03030100 \
    helpcontent2/source/text/sbasic/shared/03030101 \
    helpcontent2/source/text/sbasic/shared/03030102 \
    helpcontent2/source/text/sbasic/shared/03030103 \
    helpcontent2/source/text/sbasic/shared/03030104 \
    helpcontent2/source/text/sbasic/shared/03030105 \
    helpcontent2/source/text/sbasic/shared/03030106 \
    helpcontent2/source/text/sbasic/shared/03030107 \
    helpcontent2/source/text/sbasic/shared/03030108 \
    helpcontent2/source/text/sbasic/shared/03030110 \
    helpcontent2/source/text/sbasic/shared/03030111 \
    helpcontent2/source/text/sbasic/shared/03030112 \
    helpcontent2/source/text/sbasic/shared/03030113 \
    helpcontent2/source/text/sbasic/shared/03030114 \
    helpcontent2/source/text/sbasic/shared/03030115 \
    helpcontent2/source/text/sbasic/shared/03030116 \
    helpcontent2/source/text/sbasic/shared/03030120 \
    helpcontent2/source/text/sbasic/shared/03030130 \
    helpcontent2/source/text/sbasic/shared/03030200 \
    helpcontent2/source/text/sbasic/shared/03030201 \
    helpcontent2/source/text/sbasic/shared/03030202 \
    helpcontent2/source/text/sbasic/shared/03030203 \
    helpcontent2/source/text/sbasic/shared/03030204 \
    helpcontent2/source/text/sbasic/shared/03030205 \
    helpcontent2/source/text/sbasic/shared/03030206 \
    helpcontent2/source/text/sbasic/shared/03030300 \
    helpcontent2/source/text/sbasic/shared/03030301 \
    helpcontent2/source/text/sbasic/shared/03030302 \
    helpcontent2/source/text/sbasic/shared/03030303 \
    helpcontent2/source/text/sbasic/shared/03040000 \
    helpcontent2/source/text/sbasic/shared/03050000 \
    helpcontent2/source/text/sbasic/shared/03050100 \
    helpcontent2/source/text/sbasic/shared/03050200 \
    helpcontent2/source/text/sbasic/shared/03050300 \
    helpcontent2/source/text/sbasic/shared/03050500 \
    helpcontent2/source/text/sbasic/shared/03060000 \
    helpcontent2/source/text/sbasic/shared/03060100 \
    helpcontent2/source/text/sbasic/shared/03060200 \
    helpcontent2/source/text/sbasic/shared/03060300 \
    helpcontent2/source/text/sbasic/shared/03060400 \
    helpcontent2/source/text/sbasic/shared/03060500 \
    helpcontent2/source/text/sbasic/shared/03060600 \
    helpcontent2/source/text/sbasic/shared/03070000 \
    helpcontent2/source/text/sbasic/shared/03070100 \
    helpcontent2/source/text/sbasic/shared/03070200 \
    helpcontent2/source/text/sbasic/shared/03070300 \
    helpcontent2/source/text/sbasic/shared/03070400 \
    helpcontent2/source/text/sbasic/shared/03070500 \
    helpcontent2/source/text/sbasic/shared/03070600 \
    helpcontent2/source/text/sbasic/shared/03080000 \
    helpcontent2/source/text/sbasic/shared/03080100 \
    helpcontent2/source/text/sbasic/shared/03080101 \
    helpcontent2/source/text/sbasic/shared/03080102 \
    helpcontent2/source/text/sbasic/shared/03080103 \
    helpcontent2/source/text/sbasic/shared/03080104 \
    helpcontent2/source/text/sbasic/shared/03080200 \
    helpcontent2/source/text/sbasic/shared/03080201 \
    helpcontent2/source/text/sbasic/shared/03080202 \
    helpcontent2/source/text/sbasic/shared/03080300 \
    helpcontent2/source/text/sbasic/shared/03080301 \
    helpcontent2/source/text/sbasic/shared/03080302 \
    helpcontent2/source/text/sbasic/shared/03080400 \
    helpcontent2/source/text/sbasic/shared/03080401 \
    helpcontent2/source/text/sbasic/shared/03080500 \
    helpcontent2/source/text/sbasic/shared/03080501 \
    helpcontent2/source/text/sbasic/shared/03080502 \
    helpcontent2/source/text/sbasic/shared/03080600 \
    helpcontent2/source/text/sbasic/shared/03080601 \
    helpcontent2/source/text/sbasic/shared/03080700 \
    helpcontent2/source/text/sbasic/shared/03080701 \
    helpcontent2/source/text/sbasic/shared/03080800 \
    helpcontent2/source/text/sbasic/shared/03080801 \
    helpcontent2/source/text/sbasic/shared/03080802 \
    helpcontent2/source/text/sbasic/shared/03090000 \
    helpcontent2/source/text/sbasic/shared/03090100 \
    helpcontent2/source/text/sbasic/shared/03090101 \
    helpcontent2/source/text/sbasic/shared/03090102 \
    helpcontent2/source/text/sbasic/shared/03090103 \
    helpcontent2/source/text/sbasic/shared/03090200 \
    helpcontent2/source/text/sbasic/shared/03090201 \
    helpcontent2/source/text/sbasic/shared/03090202 \
    helpcontent2/source/text/sbasic/shared/03090203 \
    helpcontent2/source/text/sbasic/shared/03090300 \
    helpcontent2/source/text/sbasic/shared/03090301 \
    helpcontent2/source/text/sbasic/shared/03090302 \
    helpcontent2/source/text/sbasic/shared/03090303 \
    helpcontent2/source/text/sbasic/shared/03090400 \
    helpcontent2/source/text/sbasic/shared/03090401 \
    helpcontent2/source/text/sbasic/shared/03090402 \
    helpcontent2/source/text/sbasic/shared/03090403 \
    helpcontent2/source/text/sbasic/shared/03090404 \
    helpcontent2/source/text/sbasic/shared/03090405 \
    helpcontent2/source/text/sbasic/shared/03090406 \
    helpcontent2/source/text/sbasic/shared/03090407 \
    helpcontent2/source/text/sbasic/shared/03090408 \
    helpcontent2/source/text/sbasic/shared/03090409 \
    helpcontent2/source/text/sbasic/shared/03090410 \
    helpcontent2/source/text/sbasic/shared/03090411 \
    helpcontent2/source/text/sbasic/shared/03090412 \
    helpcontent2/source/text/sbasic/shared/03090413 \
    helpcontent2/source/text/sbasic/shared/03100000 \
    helpcontent2/source/text/sbasic/shared/03100050 \
    helpcontent2/source/text/sbasic/shared/03100060 \
    helpcontent2/source/text/sbasic/shared/03100070 \
    helpcontent2/source/text/sbasic/shared/03100080 \
    helpcontent2/source/text/sbasic/shared/03100100 \
    helpcontent2/source/text/sbasic/shared/03100300 \
    helpcontent2/source/text/sbasic/shared/03100400 \
    helpcontent2/source/text/sbasic/shared/03100500 \
    helpcontent2/source/text/sbasic/shared/03100600 \
    helpcontent2/source/text/sbasic/shared/03100700 \
    helpcontent2/source/text/sbasic/shared/03100900 \
    helpcontent2/source/text/sbasic/shared/03101000 \
    helpcontent2/source/text/sbasic/shared/03101100 \
    helpcontent2/source/text/sbasic/shared/03101110 \
    helpcontent2/source/text/sbasic/shared/03101120 \
    helpcontent2/source/text/sbasic/shared/03101130 \
    helpcontent2/source/text/sbasic/shared/03101140 \
    helpcontent2/source/text/sbasic/shared/03101300 \
    helpcontent2/source/text/sbasic/shared/03101400 \
    helpcontent2/source/text/sbasic/shared/03101500 \
    helpcontent2/source/text/sbasic/shared/03101600 \
    helpcontent2/source/text/sbasic/shared/03101700 \
    helpcontent2/source/text/sbasic/shared/03102000 \
    helpcontent2/source/text/sbasic/shared/03102100 \
    helpcontent2/source/text/sbasic/shared/03102101 \
    helpcontent2/source/text/sbasic/shared/03102200 \
    helpcontent2/source/text/sbasic/shared/03102300 \
    helpcontent2/source/text/sbasic/shared/03102400 \
    helpcontent2/source/text/sbasic/shared/03102450 \
    helpcontent2/source/text/sbasic/shared/03102600 \
    helpcontent2/source/text/sbasic/shared/03102700 \
    helpcontent2/source/text/sbasic/shared/03102800 \
    helpcontent2/source/text/sbasic/shared/03102900 \
    helpcontent2/source/text/sbasic/shared/03103000 \
    helpcontent2/source/text/sbasic/shared/03103100 \
    helpcontent2/source/text/sbasic/shared/03103200 \
    helpcontent2/source/text/sbasic/shared/03103300 \
    helpcontent2/source/text/sbasic/shared/03103350 \
    helpcontent2/source/text/sbasic/shared/03103400 \
    helpcontent2/source/text/sbasic/shared/03103450 \
    helpcontent2/source/text/sbasic/shared/03103500 \
    helpcontent2/source/text/sbasic/shared/03103600 \
    helpcontent2/source/text/sbasic/shared/03103700 \
    helpcontent2/source/text/sbasic/shared/03103800 \
    helpcontent2/source/text/sbasic/shared/03103900 \
    helpcontent2/source/text/sbasic/shared/03104000 \
    helpcontent2/source/text/sbasic/shared/03104100 \
    helpcontent2/source/text/sbasic/shared/03104200 \
    helpcontent2/source/text/sbasic/shared/03104300 \
    helpcontent2/source/text/sbasic/shared/03104400 \
    helpcontent2/source/text/sbasic/shared/03104500 \
    helpcontent2/source/text/sbasic/shared/03104600 \
    helpcontent2/source/text/sbasic/shared/03104700 \
    helpcontent2/source/text/sbasic/shared/03110000 \
    helpcontent2/source/text/sbasic/shared/03110100 \
    helpcontent2/source/text/sbasic/shared/03120000 \
    helpcontent2/source/text/sbasic/shared/03120100 \
    helpcontent2/source/text/sbasic/shared/03120101 \
    helpcontent2/source/text/sbasic/shared/03120102 \
    helpcontent2/source/text/sbasic/shared/03120103 \
    helpcontent2/source/text/sbasic/shared/03120104 \
    helpcontent2/source/text/sbasic/shared/03120105 \
    helpcontent2/source/text/sbasic/shared/03120111 \
    helpcontent2/source/text/sbasic/shared/03120112 \
    helpcontent2/source/text/sbasic/shared/03120200 \
    helpcontent2/source/text/sbasic/shared/03120201 \
    helpcontent2/source/text/sbasic/shared/03120202 \
    helpcontent2/source/text/sbasic/shared/03120300 \
    helpcontent2/source/text/sbasic/shared/03120301 \
    helpcontent2/source/text/sbasic/shared/03120302 \
    helpcontent2/source/text/sbasic/shared/03120303 \
    helpcontent2/source/text/sbasic/shared/03120304 \
    helpcontent2/source/text/sbasic/shared/03120305 \
    helpcontent2/source/text/sbasic/shared/03120306 \
    helpcontent2/source/text/sbasic/shared/03120307 \
    helpcontent2/source/text/sbasic/shared/03120308 \
    helpcontent2/source/text/sbasic/shared/03120309 \
    helpcontent2/source/text/sbasic/shared/03120310 \
    helpcontent2/source/text/sbasic/shared/03120311 \
    helpcontent2/source/text/sbasic/shared/03120312 \
    helpcontent2/source/text/sbasic/shared/03120313 \
    helpcontent2/source/text/sbasic/shared/03120314 \
    helpcontent2/source/text/sbasic/shared/03120315 \
    helpcontent2/source/text/sbasic/shared/03120400 \
    helpcontent2/source/text/sbasic/shared/03120401 \
    helpcontent2/source/text/sbasic/shared/03120402 \
    helpcontent2/source/text/sbasic/shared/03120403 \
    helpcontent2/source/text/sbasic/shared/03120411 \
    helpcontent2/source/text/sbasic/shared/03120412 \
    helpcontent2/source/text/sbasic/shared/03130000 \
    helpcontent2/source/text/sbasic/shared/03130100 \
    helpcontent2/source/text/sbasic/shared/03130500 \
    helpcontent2/source/text/sbasic/shared/03130600 \
    helpcontent2/source/text/sbasic/shared/03130700 \
    helpcontent2/source/text/sbasic/shared/03130800 \
    helpcontent2/source/text/sbasic/shared/03131000 \
    helpcontent2/source/text/sbasic/shared/03131300 \
    helpcontent2/source/text/sbasic/shared/03131400 \
    helpcontent2/source/text/sbasic/shared/03131500 \
    helpcontent2/source/text/sbasic/shared/03131600 \
    helpcontent2/source/text/sbasic/shared/03131700 \
    helpcontent2/source/text/sbasic/shared/03131800 \
    helpcontent2/source/text/sbasic/shared/03131900 \
    helpcontent2/source/text/sbasic/shared/03132000 \
    helpcontent2/source/text/sbasic/shared/03132100 \
    helpcontent2/source/text/sbasic/shared/03132200 \
    helpcontent2/source/text/sbasic/shared/03132300 \
    helpcontent2/source/text/sbasic/shared/03132400 \
    helpcontent2/source/text/sbasic/shared/03132500 \
    helpcontent2/source/text/sbasic/shared/03140000 \
    helpcontent2/source/text/sbasic/shared/03140001 \
    helpcontent2/source/text/sbasic/shared/03140002 \
    helpcontent2/source/text/sbasic/shared/03140003 \
    helpcontent2/source/text/sbasic/shared/03140004 \
    helpcontent2/source/text/sbasic/shared/03140005 \
    helpcontent2/source/text/sbasic/shared/03140006 \
    helpcontent2/source/text/sbasic/shared/03140007 \
    helpcontent2/source/text/sbasic/shared/03140008 \
    helpcontent2/source/text/sbasic/shared/03140009 \
    helpcontent2/source/text/sbasic/shared/03140010 \
    helpcontent2/source/text/sbasic/shared/03140011 \
    helpcontent2/source/text/sbasic/shared/03140012 \
    helpcontent2/source/text/sbasic/shared/03150000 \
    helpcontent2/source/text/sbasic/shared/03150001 \
    helpcontent2/source/text/sbasic/shared/03160000 \
    helpcontent2/source/text/sbasic/shared/03170000 \
    helpcontent2/source/text/sbasic/shared/05060700 \
    helpcontent2/source/text/sbasic/shared/code-stubs \
    helpcontent2/source/text/sbasic/shared/keys \
    helpcontent2/source/text/sbasic/shared/main0211 \
    helpcontent2/source/text/sbasic/shared/main0601 \
    helpcontent2/source/text/sbasic/shared/special_vba_func \
    helpcontent2/source/text/sbasic/shared/vbasupport \
))

# vim: set noet sw=4 ts=4:
