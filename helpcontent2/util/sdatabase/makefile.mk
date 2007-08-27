#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: vg $ $Date: 2007-08-27 15:00:07 $
#*
#*    $Revision: 1.22 $
#*
#*    $Logfile:$
#*
#*    Copyright 2000 Sun Microsystems, Inc. All Rights Reserved.
#*
#*************************************************************************

# edit to match directory level 
PRJ		= ..$/..
# same for all makefiles in "helpcontent2"
PRJNAME = helpcontent2
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = util_sdatabase

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

common_build_zip:=
zip1generatedlangs=TRUE
zip1langdirs=$(aux_alllangiso)
ZIP1TARGET=xhp_sdatabase
ZIP1FLAGS= -u -r
ZIP1DIR=$(COMMONMISC)$/$(LANGDIR)
ZIP1LIST=$(LANGDIR)$/text$/shared$/explorer$/database$/main.xhp

LINKNAME=sdatabase
LINKADDEDFILES= \
   -add sdatabase.cfg $(PRJ)$/source$/auxiliary$/LANGUAGE$/sdatabase.cfg \
   -add sdatabase.jar  $(BIN)$/xhp_sdatabase_LANGUAGE.zip


LINKADDEDDEPS= \
   $(PRJ)$/source$/auxiliary$/LANGUAGE$/sdatabase.cfg \
   $(BIN)$/xhp_sdatabase_LANGUAGE.zip


LINKLINKFILES= \
   text$/shared$/00$/00000001.xhp \
   text$/shared$/00$/00000002.xhp \
   text$/shared$/00$/00000003.xhp \
   text$/shared$/00$/00000004.xhp \
   text$/shared$/00$/00000005.xhp \
   text$/shared$/00$/00000007.xhp \
   text$/shared$/00$/00000010.xhp \
   text$/shared$/00$/00000011.xhp \
   text$/shared$/00$/00000020.xhp \
   text$/shared$/00$/00000021.xhp \
   text$/shared$/00$/00000040.xhp \
   text$/shared$/00$/00000099.xhp \
   text$/shared$/00$/00000202.xhp \
   text$/shared$/00$/00000203.xhp \
   text$/shared$/00$/00000204.xhp \
   text$/shared$/00$/00000205.xhp \
   text$/shared$/00$/00000206.xhp \
   text$/shared$/00$/00000207.xhp \
   text$/shared$/00$/00000208.xhp \
   text$/shared$/00$/00000210.xhp \
   text$/shared$/00$/00000212.xhp \
   text$/shared$/00$/00000213.xhp \
   text$/shared$/00$/00000214.xhp \
   text$/shared$/00$/00000215.xhp \
   text$/shared$/00$/00000401.xhp \
   text$/shared$/00$/00000402.xhp \
   text$/shared$/00$/00000403.xhp \
   text$/shared$/00$/00000404.xhp \
   text$/shared$/00$/00000406.xhp \
   text$/shared$/00$/00000407.xhp \
   text$/shared$/00$/00000408.xhp \
   text$/shared$/00$/00000409.xhp \
   text$/shared$/00$/00000450.xhp \
   text$/shared$/00$/00040500.xhp \
   text$/shared$/00$/00040501.xhp \
   text$/shared$/00$/00040502.xhp \
   text$/shared$/00$/00040503.xhp \
   text$/shared$/00$/01000000.xhp \
   text$/shared$/00$/01010000.xhp \
   text$/shared$/00$/01020000.xhp \
   text$/shared$/00$/01050000.xhp \
   text$/shared$/00$/icon_alt.xhp \
   text$/shared$/01$/01010000.xhp \
   text$/shared$/01$/01010001.xhp \
   text$/shared$/01$/01010100.xhp \
   text$/shared$/01$/01010200.xhp \
   text$/shared$/01$/01010201.xhp \
   text$/shared$/01$/01010202.xhp \
   text$/shared$/01$/01010203.xhp \
   text$/shared$/01$/01010300.xhp \
   text$/shared$/01$/01010301.xhp \
   text$/shared$/01$/01010302.xhp \
   text$/shared$/01$/01010303.xhp \
   text$/shared$/01$/01010304.xhp \
   text$/shared$/01$/01020000.xhp \
   text$/shared$/01$/01020101.xhp \
   text$/shared$/01$/01020103.xhp \
   text$/shared$/01$/01050000.xhp \
   text$/shared$/01$/01060000.xhp \
   text$/shared$/01$/01070000.xhp \
   text$/shared$/01$/01070001.xhp \
   text$/shared$/01$/01100000.xhp \
   text$/shared$/01$/01100100.xhp \
   text$/shared$/01$/01100200.xhp \
   text$/shared$/01$/01100300.xhp \
   text$/shared$/01$/01100400.xhp \
   text$/shared$/01$/01100500.xhp \
   text$/shared$/01$/01110000.xhp \
   text$/shared$/01$/01110100.xhp \
   text$/shared$/01$/01110101.xhp \
   text$/shared$/01$/01110300.xhp \
   text$/shared$/01$/01110400.xhp \
   text$/shared$/01$/01130000.xhp \
   text$/shared$/01$/01140000.xhp \
   text$/shared$/01$/01160000.xhp \
   text$/shared$/01$/01160200.xhp \
   text$/shared$/01$/01160300.xhp \
   text$/shared$/01$/01170000.xhp \
   text$/shared$/01$/01180000.xhp \
   text$/shared$/01$/01190000.xhp \
   text$/shared$/01$/01990000.xhp \
   text$/shared$/01$/02010000.xhp \
   text$/shared$/01$/02020000.xhp \
   text$/shared$/01$/02030000.xhp \
   text$/shared$/01$/02040000.xhp \
   text$/shared$/01$/02050000.xhp \
   text$/shared$/01$/02060000.xhp \
   text$/shared$/01$/02070000.xhp \
   text$/shared$/01$/02090000.xhp \
   text$/shared$/01$/02100000.xhp \
   text$/shared$/01$/02100001.xhp \
   text$/shared$/01$/02100100.xhp \
   text$/shared$/01$/02100200.xhp \
   text$/shared$/01$/02100300.xhp \
   text$/shared$/01$/02110000.xhp \
   text$/shared$/01$/02180000.xhp \
   text$/shared$/01$/02180100.xhp \
   text$/shared$/01$/02190000.xhp \
   text$/shared$/01$/02200000.xhp \
   text$/shared$/01$/02200100.xhp \
   text$/shared$/01$/02200200.xhp \
   text$/shared$/01$/02210101.xhp \
   text$/shared$/01$/02220000.xhp \
   text$/shared$/01$/02220100.xhp \
   text$/shared$/01$/02230000.xhp \
   text$/shared$/01$/02230100.xhp \
   text$/shared$/01$/02230150.xhp \
   text$/shared$/01$/02230200.xhp \
   text$/shared$/01$/02230300.xhp \
   text$/shared$/01$/02230400.xhp \
   text$/shared$/01$/02230401.xhp \
   text$/shared$/01$/02230402.xhp \
   text$/shared$/01$/02230500.xhp \
   text$/shared$/01$/02240000.xhp \
   text$/shared$/01$/02250000.xhp \
   text$/shared$/01$/03010000.xhp \
   text$/shared$/01$/03020000.xhp \
   text$/shared$/01$/03040000.xhp \
   text$/shared$/01$/03050000.xhp \
   text$/shared$/01$/03060000.xhp \
   text$/shared$/01$/03110000.xhp \
   text$/shared$/01$/03150100.xhp \
   text$/shared$/01$/03170000.xhp \
   text$/shared$/01$/03990000.xhp \
   text$/shared$/01$/04050000.xhp \
   text$/shared$/01$/04060000.xhp \
   text$/shared$/01$/04060100.xhp \
   text$/shared$/01$/04060200.xhp \
   text$/shared$/01$/04100000.xhp \
   text$/shared$/01$/04110000.xhp \
   text$/shared$/01$/04140000.xhp \
   text$/shared$/01$/04150000.xhp \
   text$/shared$/01$/04150100.xhp \
   text$/shared$/01$/04150200.xhp \
   text$/shared$/01$/04150300.xhp \
   text$/shared$/01$/04150400.xhp \
   text$/shared$/01$/04150500.xhp \
   text$/shared$/01$/04160300.xhp \
   text$/shared$/01$/04160500.xhp \
   text$/shared$/01$/04180100.xhp \
   text$/shared$/01$/04990000.xhp \
   text$/shared$/01$/05010000.xhp \
   text$/shared$/01$/05020000.xhp \
   text$/shared$/01$/05020100.xhp \
   text$/shared$/01$/05020200.xhp \
   text$/shared$/01$/05020300.xhp \
   text$/shared$/01$/05020301.xhp \
   text$/shared$/01$/05020400.xhp \
   text$/shared$/01$/05020500.xhp \
   text$/shared$/01$/05020600.xhp \
   text$/shared$/01$/05020700.xhp \
   text$/shared$/01$/05030000.xhp \
   text$/shared$/01$/05030100.xhp \
   text$/shared$/01$/05030300.xhp \
   text$/shared$/01$/05030500.xhp \
   text$/shared$/01$/05030600.xhp \
   text$/shared$/01$/05030700.xhp \
   text$/shared$/01$/05030800.xhp \
   text$/shared$/01$/05040100.xhp \
   text$/shared$/01$/05040200.xhp \
   text$/shared$/01$/05040300.xhp \
   text$/shared$/01$/05040400.xhp \
   text$/shared$/01$/05050000.xhp \
   text$/shared$/01$/05060000.xhp \
   text$/shared$/01$/05070000.xhp \
   text$/shared$/01$/05070100.xhp \
   text$/shared$/01$/05070200.xhp \
   text$/shared$/01$/05070300.xhp \
   text$/shared$/01$/05070400.xhp \
   text$/shared$/01$/05070500.xhp \
   text$/shared$/01$/05070600.xhp \
   text$/shared$/01$/05080000.xhp \
   text$/shared$/01$/05080100.xhp \
   text$/shared$/01$/05080200.xhp \
   text$/shared$/01$/05080300.xhp \
   text$/shared$/01$/05080400.xhp \
   text$/shared$/01$/05090000.xhp \
   text$/shared$/01$/05100000.xhp \
   text$/shared$/01$/05110000.xhp \
   text$/shared$/01$/05110100.xhp \
   text$/shared$/01$/05110200.xhp \
   text$/shared$/01$/05110300.xhp \
   text$/shared$/01$/05110400.xhp \
   text$/shared$/01$/05110500.xhp \
   text$/shared$/01$/05110600.xhp \
   text$/shared$/01$/05110700.xhp \
   text$/shared$/01$/05110800.xhp \
   text$/shared$/01$/05120000.xhp \
   text$/shared$/01$/05120100.xhp \
   text$/shared$/01$/05120200.xhp \
   text$/shared$/01$/05120300.xhp \
   text$/shared$/01$/05140100.xhp \
   text$/shared$/01$/05150101.xhp \
   text$/shared$/01$/05190000.xhp \
   text$/shared$/01$/05190100.xhp \
   text$/shared$/01$/05200000.xhp \
   text$/shared$/01$/05200100.xhp \
   text$/shared$/01$/05200200.xhp \
   text$/shared$/01$/05200300.xhp \
   text$/shared$/01$/05210000.xhp \
   text$/shared$/01$/05210100.xhp \
   text$/shared$/01$/05210200.xhp \
   text$/shared$/01$/05210300.xhp \
   text$/shared$/01$/05210400.xhp \
   text$/shared$/01$/05210500.xhp \
   text$/shared$/01$/05210600.xhp \
   text$/shared$/01$/05210700.xhp \
   text$/shared$/01$/05220000.xhp \
   text$/shared$/01$/05230000.xhp \
   text$/shared$/01$/05230100.xhp \
   text$/shared$/01$/05230300.xhp \
   text$/shared$/01$/05230400.xhp \
   text$/shared$/01$/05230500.xhp \
   text$/shared$/01$/05240000.xhp \
   text$/shared$/01$/05240100.xhp \
   text$/shared$/01$/05240200.xhp \
   text$/shared$/01$/05250000.xhp \
   text$/shared$/01$/05250100.xhp \
   text$/shared$/01$/05250200.xhp \
   text$/shared$/01$/05250300.xhp \
   text$/shared$/01$/05250400.xhp \
   text$/shared$/01$/05250500.xhp \
   text$/shared$/01$/05250600.xhp \
   text$/shared$/01$/05260000.xhp \
   text$/shared$/01$/05260100.xhp \
   text$/shared$/01$/05260200.xhp \
   text$/shared$/01$/05260300.xhp \
   text$/shared$/01$/05260400.xhp \
   text$/shared$/01$/05260500.xhp \
   text$/shared$/01$/05260600.xhp \
   text$/shared$/01$/05270000.xhp \
   text$/shared$/01$/05280000.xhp \
   text$/shared$/01$/05290000.xhp \
   text$/shared$/01$/05290100.xhp \
   text$/shared$/01$/05290200.xhp \
   text$/shared$/01$/05290300.xhp \
   text$/shared$/01$/05290400.xhp \
   text$/shared$/01$/05320000.xhp \
   text$/shared$/01$/05340100.xhp \
   text$/shared$/01$/05340200.xhp \
   text$/shared$/01$/05340300.xhp \
   text$/shared$/01$/05340400.xhp \
   text$/shared$/01$/05340402.xhp \
   text$/shared$/01$/05340404.xhp \
   text$/shared$/01$/05340405.xhp \
   text$/shared$/01$/05340500.xhp \
   text$/shared$/01$/05340600.xhp \
   text$/shared$/01$/05350000.xhp \
   text$/shared$/01$/05350200.xhp \
   text$/shared$/01$/05350300.xhp \
   text$/shared$/01$/05350400.xhp \
   text$/shared$/01$/05350500.xhp \
   text$/shared$/01$/05350600.xhp \
   text$/shared$/01$/05360000.xhp \
   text$/shared$/01$/05990000.xhp \
   text$/shared$/01$/06010000.xhp \
   text$/shared$/01$/06010101.xhp \
   text$/shared$/01$/06010500.xhp \
   text$/shared$/01$/06010600.xhp \
   text$/shared$/01$/06010601.xhp \
   text$/shared$/01$/06020000.xhp \
   text$/shared$/01$/06030000.xhp \
   text$/shared$/01$/06040000.xhp \
   text$/shared$/01$/06040100.xhp \
   text$/shared$/01$/06040200.xhp \
   text$/shared$/01$/06040300.xhp \
   text$/shared$/01$/06040400.xhp \
   text$/shared$/01$/06040500.xhp \
   text$/shared$/01$/06040600.xhp \
   text$/shared$/01$/06050000.xhp \
   text$/shared$/01$/06050100.xhp \
   text$/shared$/01$/06050200.xhp \
   text$/shared$/01$/06050300.xhp \
   text$/shared$/01$/06050500.xhp \
   text$/shared$/01$/06050600.xhp \
   text$/shared$/01$/06130000.xhp \
   text$/shared$/01$/06130001.xhp \
   text$/shared$/01$/06130010.xhp \
   text$/shared$/01$/06130100.xhp \
   text$/shared$/01$/06130200.xhp \
   text$/shared$/01$/06130500.xhp \
   text$/shared$/01$/06140000.xhp \
   text$/shared$/01$/06140100.xhp \
   text$/shared$/01$/06140101.xhp \
   text$/shared$/01$/06140102.xhp \
   text$/shared$/01$/06140200.xhp \
   text$/shared$/01$/06140400.xhp \
   text$/shared$/01$/06140401.xhp \
   text$/shared$/01$/06140402.xhp \
   text$/shared$/01$/06140500.xhp \
   text$/shared$/01$/06150000.xhp \
   text$/shared$/01$/06150100.xhp \
   text$/shared$/01$/06150110.xhp \
   text$/shared$/01$/06150120.xhp \
   text$/shared$/01$/06150200.xhp \
   text$/shared$/01$/06150210.xhp \
   text$/shared$/01$/06200000.xhp \
   text$/shared$/01$/06201000.xhp \
   text$/shared$/01$/06202000.xhp \
   text$/shared$/01$/06990000.xhp \
   text$/shared$/01$/07010000.xhp \
   text$/shared$/01$/07080000.xhp \
   text$/shared$/01$/08060100.xhp \
   text$/shared$/01$/about_meta_tags.xhp \
   text$/shared$/01$/digitalsignatures.xhp \
   text$/shared$/01$/extensionupdate.xhp \
   text$/shared$/01$/formatting_mark.xhp \
   text$/shared$/01$/gallery.xhp \
   text$/shared$/01$/gallery_files.xhp \
   text$/shared$/01$/grid.xhp \
   text$/shared$/01$/guides.xhp \
   text$/shared$/01$/mediaplayer.xhp \
   text$/shared$/01$/moviesound.xhp \
   text$/shared$/01$/online_update.xhp \
   text$/shared$/01$/online_update_dialog.xhp \
   text$/shared$/01$/packagemanager.xhp \
   text$/shared$/01$/password_dlg.xhp \
   text$/shared$/01$/password_main.xhp \
   text$/shared$/01$/ref_pdf_export.xhp \
   text$/shared$/01$/ref_pdf_send_as.xhp \
   text$/shared$/01$/securitywarning.xhp \
   text$/shared$/01$/selectcertificate.xhp \
   text$/shared$/01$/webhtml.xhp \
   text$/shared$/01$/xformsdata.xhp \
   text$/shared$/01$/xformsdataadd.xhp \
   text$/shared$/01$/xformsdataaddcon.xhp \
   text$/shared$/01$/xformsdatachange.xhp \
   text$/shared$/01$/xformsdataname.xhp \
   text$/shared$/01$/xformsdatatab.xhp \
   text$/shared$/02$/01110000.xhp \
   text$/shared$/02$/01140000.xhp \
   text$/shared$/02$/01170000.xhp \
   text$/shared$/02$/01170001.xhp \
   text$/shared$/02$/01170002.xhp \
   text$/shared$/02$/01170003.xhp \
   text$/shared$/02$/01170004.xhp \
   text$/shared$/02$/01170100.xhp \
   text$/shared$/02$/01170101.xhp \
   text$/shared$/02$/01170102.xhp \
   text$/shared$/02$/01170103.xhp \
   text$/shared$/02$/01170200.xhp \
   text$/shared$/02$/01170201.xhp \
   text$/shared$/02$/01170202.xhp \
   text$/shared$/02$/01170203.xhp \
   text$/shared$/02$/01170300.xhp \
   text$/shared$/02$/01170400.xhp \
   text$/shared$/02$/01170500.xhp \
   text$/shared$/02$/01170600.xhp \
   text$/shared$/02$/01170700.xhp \
   text$/shared$/02$/01170800.xhp \
   text$/shared$/02$/01170801.xhp \
   text$/shared$/02$/01170802.xhp \
   text$/shared$/02$/01170900.xhp \
   text$/shared$/02$/01170901.xhp \
   text$/shared$/02$/01170902.xhp \
   text$/shared$/02$/01170903.xhp \
   text$/shared$/02$/01170904.xhp \
   text$/shared$/02$/01171000.xhp \
   text$/shared$/02$/01171100.xhp \
   text$/shared$/02$/01171200.xhp \
   text$/shared$/02$/01171300.xhp \
   text$/shared$/02$/01171400.xhp \
   text$/shared$/02$/01220000.xhp \
   text$/shared$/02$/01230000.xhp \
   text$/shared$/02$/02010000.xhp \
   text$/shared$/02$/02020000.xhp \
   text$/shared$/02$/02030000.xhp \
   text$/shared$/02$/02040000.xhp \
   text$/shared$/02$/02050000.xhp \
   text$/shared$/02$/02130000.xhp \
   text$/shared$/02$/02140000.xhp \
   text$/shared$/02$/02160000.xhp \
   text$/shared$/02$/02170000.xhp \
   text$/shared$/02$/03110000.xhp \
   text$/shared$/02$/03120000.xhp \
   text$/shared$/02$/03130000.xhp \
   text$/shared$/02$/03140000.xhp \
   text$/shared$/02$/03150000.xhp \
   text$/shared$/02$/03200000.xhp \
   text$/shared$/02$/05020000.xhp \
   text$/shared$/02$/05090000.xhp \
   text$/shared$/02$/05110000.xhp \
   text$/shared$/02$/06050000.xhp \
   text$/shared$/02$/06060000.xhp \
   text$/shared$/02$/06100000.xhp \
   text$/shared$/02$/06110000.xhp \
   text$/shared$/02$/06120000.xhp \
   text$/shared$/02$/07010000.xhp \
   text$/shared$/02$/07060000.xhp \
   text$/shared$/02$/07070000.xhp \
   text$/shared$/02$/07070100.xhp \
   text$/shared$/02$/07070200.xhp \
   text$/shared$/02$/07080000.xhp \
   text$/shared$/02$/07090000.xhp \
   text$/shared$/02$/08010000.xhp \
   text$/shared$/02$/08020000.xhp \
   text$/shared$/02$/09010000.xhp \
   text$/shared$/02$/09020000.xhp \
   text$/shared$/02$/09030000.xhp \
   text$/shared$/02$/09050000.xhp \
   text$/shared$/02$/09060000.xhp \
   text$/shared$/02$/09070000.xhp \
   text$/shared$/02$/09070100.xhp \
   text$/shared$/02$/09070200.xhp \
   text$/shared$/02$/09070300.xhp \
   text$/shared$/02$/09070400.xhp \
   text$/shared$/02$/10010000.xhp \
   text$/shared$/02$/10020000.xhp \
   text$/shared$/02$/10030000.xhp \
   text$/shared$/02$/10040000.xhp \
   text$/shared$/02$/10100000.xhp \
   text$/shared$/02$/12000000.xhp \
   text$/shared$/02$/12010000.xhp \
   text$/shared$/02$/12020000.xhp \
   text$/shared$/02$/12030000.xhp \
   text$/shared$/02$/12040000.xhp \
   text$/shared$/02$/12050000.xhp \
   text$/shared$/02$/12070000.xhp \
   text$/shared$/02$/12070100.xhp \
   text$/shared$/02$/12070200.xhp \
   text$/shared$/02$/12070300.xhp \
   text$/shared$/02$/12080000.xhp \
   text$/shared$/02$/12090000.xhp \
   text$/shared$/02$/12090100.xhp \
   text$/shared$/02$/12090101.xhp \
   text$/shared$/02$/12100000.xhp \
   text$/shared$/02$/12100100.xhp \
   text$/shared$/02$/12100200.xhp \
   text$/shared$/02$/12110000.xhp \
   text$/shared$/02$/12120000.xhp \
   text$/shared$/02$/12130000.xhp \
   text$/shared$/02$/12140000.xhp \
   text$/shared$/02$/13010000.xhp \
   text$/shared$/02$/13020000.xhp \
   text$/shared$/02$/14010000.xhp \
   text$/shared$/02$/14020000.xhp \
   text$/shared$/02$/14020100.xhp \
   text$/shared$/02$/14020200.xhp \
   text$/shared$/02$/14030000.xhp \
   text$/shared$/02$/14040000.xhp \
   text$/shared$/02$/14050000.xhp \
   text$/shared$/02$/14060000.xhp \
   text$/shared$/02$/14070000.xhp \
   text$/shared$/02$/18010000.xhp \
   text$/shared$/02$/18030000.xhp \
   text$/shared$/02$/19090000.xhp \
   text$/shared$/02$/20020000.xhp \
   text$/shared$/02$/20030000.xhp \
   text$/shared$/02$/20040000.xhp \
   text$/shared$/02$/20050000.xhp \
   text$/shared$/02$/20060000.xhp \
   text$/shared$/02$/20090000.xhp \
   text$/shared$/02$/20100000.xhp \
   text$/shared$/02$/24010000.xhp \
   text$/shared$/02$/24020000.xhp \
   text$/shared$/02$/24030000.xhp \
   text$/shared$/02$/24040000.xhp \
   text$/shared$/02$/24050000.xhp \
   text$/shared$/02$/24060000.xhp \
   text$/shared$/02$/24070000.xhp \
   text$/shared$/02$/24080000.xhp \
   text$/shared$/02$/24090000.xhp \
   text$/shared$/02$/24100000.xhp \
   text$/shared$/02$/basicshapes.xhp \
   text$/shared$/02$/blockarrows.xhp \
   text$/shared$/02$/callouts.xhp \
   text$/shared$/02$/colortoolbar.xhp \
   text$/shared$/02$/flowcharts.xhp \
   text$/shared$/02$/fontwork.xhp \
   text$/shared$/02$/more_controls.xhp \
   text$/shared$/02$/paintbrush.xhp \
   text$/shared$/02$/stars.xhp \
   text$/shared$/02$/symbolshapes.xhp \
   text$/shared$/04$/01010000.xhp \
   text$/shared$/04$/01020000.xhp \
   text$/shared$/05$/00000001.xhp \
   text$/shared$/05$/00000002.xhp \
   text$/shared$/05$/00000100.xhp \
   text$/shared$/05$/00000110.xhp \
   text$/shared$/05$/00000120.xhp \
   text$/shared$/05$/00000130.xhp \
   text$/shared$/05$/00000140.xhp \
   text$/shared$/05$/00000150.xhp \
   text$/shared$/05$/00000160.xhp \
   text$/shared$/05$/err_html.xhp \
   text$/shared$/07$/09000000.xhp \
   text$/shared$/3dsettings_toolbar.xhp \
   text$/shared$/autokorr$/01000000.xhp \
   text$/shared$/autokorr$/02000000.xhp \
   text$/shared$/autokorr$/03000000.xhp \
   text$/shared$/autokorr$/04000000.xhp \
   text$/shared$/autokorr$/05000000.xhp \
   text$/shared$/autokorr$/06000000.xhp \
   text$/shared$/autokorr$/07000000.xhp \
   text$/shared$/autokorr$/08000000.xhp \
   text$/shared$/autokorr$/09000000.xhp \
   text$/shared$/autokorr$/10000000.xhp \
   text$/shared$/autokorr$/11000000.xhp \
   text$/shared$/autokorr$/12000000.xhp \
   text$/shared$/autokorr$/13000000.xhp \
   text$/shared$/autopi$/01000000.xhp \
   text$/shared$/autopi$/01010000.xhp \
   text$/shared$/autopi$/01010100.xhp \
   text$/shared$/autopi$/01010200.xhp \
   text$/shared$/autopi$/01010300.xhp \
   text$/shared$/autopi$/01010400.xhp \
   text$/shared$/autopi$/01010500.xhp \
   text$/shared$/autopi$/01010600.xhp \
   text$/shared$/autopi$/01020000.xhp \
   text$/shared$/autopi$/01020100.xhp \
   text$/shared$/autopi$/01020200.xhp \
   text$/shared$/autopi$/01020300.xhp \
   text$/shared$/autopi$/01020400.xhp \
   text$/shared$/autopi$/01020500.xhp \
   text$/shared$/autopi$/01040000.xhp \
   text$/shared$/autopi$/01040100.xhp \
   text$/shared$/autopi$/01040200.xhp \
   text$/shared$/autopi$/01040300.xhp \
   text$/shared$/autopi$/01040400.xhp \
   text$/shared$/autopi$/01040500.xhp \
   text$/shared$/autopi$/01040600.xhp \
   text$/shared$/autopi$/01050000.xhp \
   text$/shared$/autopi$/01050100.xhp \
   text$/shared$/autopi$/01050200.xhp \
   text$/shared$/autopi$/01050300.xhp \
   text$/shared$/autopi$/01050400.xhp \
   text$/shared$/autopi$/01050500.xhp \
   text$/shared$/autopi$/01090000.xhp \
   text$/shared$/autopi$/01090100.xhp \
   text$/shared$/autopi$/01090200.xhp \
   text$/shared$/autopi$/01090210.xhp \
   text$/shared$/autopi$/01090220.xhp \
   text$/shared$/autopi$/01090300.xhp \
   text$/shared$/autopi$/01090400.xhp \
   text$/shared$/autopi$/01090500.xhp \
   text$/shared$/autopi$/01090600.xhp \
   text$/shared$/autopi$/01100000.xhp \
   text$/shared$/autopi$/01100100.xhp \
   text$/shared$/autopi$/01100150.xhp \
   text$/shared$/autopi$/01100200.xhp \
   text$/shared$/autopi$/01100300.xhp \
   text$/shared$/autopi$/01100400.xhp \
   text$/shared$/autopi$/01100500.xhp \
   text$/shared$/autopi$/01110000.xhp \
   text$/shared$/autopi$/01110100.xhp \
   text$/shared$/autopi$/01110200.xhp \
   text$/shared$/autopi$/01110300.xhp \
   text$/shared$/autopi$/01110400.xhp \
   text$/shared$/autopi$/01110500.xhp \
   text$/shared$/autopi$/01110600.xhp \
   text$/shared$/autopi$/01120000.xhp \
   text$/shared$/autopi$/01120100.xhp \
   text$/shared$/autopi$/01120200.xhp \
   text$/shared$/autopi$/01120300.xhp \
   text$/shared$/autopi$/01120400.xhp \
   text$/shared$/autopi$/01120500.xhp \
   text$/shared$/autopi$/01130000.xhp \
   text$/shared$/autopi$/01130100.xhp \
   text$/shared$/autopi$/01130200.xhp \
   text$/shared$/autopi$/01150000.xhp \
   text$/shared$/autopi$/01170000.xhp \
   text$/shared$/autopi$/01170200.xhp \
   text$/shared$/autopi$/01170300.xhp \
   text$/shared$/autopi$/01170400.xhp \
   text$/shared$/autopi$/01170500.xhp \
   text$/shared$/autopi$/purchase.xhp \
   text$/shared$/autopi$/startup.xhp \
   text$/shared$/autopi$/webwizard00.xhp \
   text$/shared$/autopi$/webwizard01.xhp \
   text$/shared$/autopi$/webwizard02.xhp \
   text$/shared$/autopi$/webwizard03.xhp \
   text$/shared$/autopi$/webwizard04.xhp \
   text$/shared$/autopi$/webwizard05.xhp \
   text$/shared$/autopi$/webwizard05bi.xhp \
   text$/shared$/autopi$/webwizard05is.xhp \
   text$/shared$/autopi$/webwizard06.xhp \
   text$/shared$/autopi$/webwizard07.xhp \
   text$/shared$/autopi$/webwizard07fc.xhp \
   text$/shared$/explorer$/database$/02000000.xhp \
   text$/shared$/explorer$/database$/02000002.xhp \
   text$/shared$/explorer$/database$/02010100.xhp \
   text$/shared$/explorer$/database$/02010101.xhp \
   text$/shared$/explorer$/database$/04000000.xhp \
   text$/shared$/explorer$/database$/04030000.xhp \
   text$/shared$/explorer$/database$/05000000.xhp \
   text$/shared$/explorer$/database$/05000001.xhp \
   text$/shared$/explorer$/database$/05000002.xhp \
   text$/shared$/explorer$/database$/05000003.xhp \
   text$/shared$/explorer$/database$/05010000.xhp \
   text$/shared$/explorer$/database$/05010100.xhp \
   text$/shared$/explorer$/database$/05020000.xhp \
   text$/shared$/explorer$/database$/05020100.xhp \
   text$/shared$/explorer$/database$/05030000.xhp \
   text$/shared$/explorer$/database$/05030100.xhp \
   text$/shared$/explorer$/database$/05030200.xhp \
   text$/shared$/explorer$/database$/05030300.xhp \
   text$/shared$/explorer$/database$/05030400.xhp \
   text$/shared$/explorer$/database$/05040000.xhp \
   text$/shared$/explorer$/database$/05040100.xhp \
   text$/shared$/explorer$/database$/05040200.xhp \
   text$/shared$/explorer$/database$/11000002.xhp \
   text$/shared$/explorer$/database$/11020000.xhp \
   text$/shared$/explorer$/database$/11030000.xhp \
   text$/shared$/explorer$/database$/11030100.xhp \
   text$/shared$/explorer$/database$/11080000.xhp \
   text$/shared$/explorer$/database$/11090000.xhp \
   text$/shared$/explorer$/database$/11150200.xhp \
   text$/shared$/explorer$/database$/11170000.xhp \
   text$/shared$/explorer$/database$/11170100.xhp \
   text$/shared$/explorer$/database$/30000000.xhp \
   text$/shared$/explorer$/database$/30100000.xhp \
   text$/shared$/explorer$/database$/dabaadvprop.xhp \
   text$/shared$/explorer$/database$/dabaadvpropdat.xhp \
   text$/shared$/explorer$/database$/dabaadvpropgen.xhp \
   text$/shared$/explorer$/database$/dabadoc.xhp \
   text$/shared$/explorer$/database$/dabaprop.xhp \
   text$/shared$/explorer$/database$/dabapropadd.xhp \
   text$/shared$/explorer$/database$/dabapropcon.xhp \
   text$/shared$/explorer$/database$/dabapropgen.xhp \
   text$/shared$/explorer$/database$/dabawiz00.xhp \
   text$/shared$/explorer$/database$/dabawiz01.xhp \
   text$/shared$/explorer$/database$/dabawiz02.xhp \
   text$/shared$/explorer$/database$/dabawiz02access.xhp \
   text$/shared$/explorer$/database$/dabawiz02adabas.xhp \
   text$/shared$/explorer$/database$/dabawiz02ado.xhp \
   text$/shared$/explorer$/database$/dabawiz02dbase.xhp \
   text$/shared$/explorer$/database$/dabawiz02jdbc.xhp \
   text$/shared$/explorer$/database$/dabawiz02ldap.xhp \
   text$/shared$/explorer$/database$/dabawiz02mysql.xhp \
   text$/shared$/explorer$/database$/dabawiz02odbc.xhp \
   text$/shared$/explorer$/database$/dabawiz02oracle.xhp \
   text$/shared$/explorer$/database$/dabawiz02spreadsheet.xhp \
   text$/shared$/explorer$/database$/dabawiz02text.xhp \
   text$/shared$/explorer$/database$/dabawiz03auth.xhp \
   text$/shared$/explorer$/database$/main.xhp \
   text$/shared$/explorer$/database$/menubar.xhp \
   text$/shared$/explorer$/database$/menuedit.xhp \
   text$/shared$/explorer$/database$/menufile.xhp \
   text$/shared$/explorer$/database$/menufilesave.xhp \
   text$/shared$/explorer$/database$/menuinsert.xhp \
   text$/shared$/explorer$/database$/menutools.xhp \
   text$/shared$/explorer$/database$/menuview.xhp \
   text$/shared$/explorer$/database$/password.xhp \
   text$/shared$/explorer$/database$/querywizard00.xhp \
   text$/shared$/explorer$/database$/querywizard01.xhp \
   text$/shared$/explorer$/database$/querywizard02.xhp \
   text$/shared$/explorer$/database$/querywizard03.xhp \
   text$/shared$/explorer$/database$/querywizard04.xhp \
   text$/shared$/explorer$/database$/querywizard05.xhp \
   text$/shared$/explorer$/database$/querywizard06.xhp \
   text$/shared$/explorer$/database$/querywizard07.xhp \
   text$/shared$/explorer$/database$/querywizard08.xhp \
   text$/shared$/explorer$/database$/rep_datetime.xhp \
   text$/shared$/explorer$/database$/rep_main.xhp \
   text$/shared$/explorer$/database$/rep_navigator.xhp \
   text$/shared$/explorer$/database$/rep_pagenumbers.xhp \
   text$/shared$/explorer$/database$/rep_prop.xhp \
   text$/shared$/explorer$/database$/rep_sort.xhp \
   text$/shared$/explorer$/database$/tablewizard00.xhp \
   text$/shared$/explorer$/database$/tablewizard01.xhp \
   text$/shared$/explorer$/database$/tablewizard02.xhp \
   text$/shared$/explorer$/database$/tablewizard03.xhp \
   text$/shared$/explorer$/database$/tablewizard04.xhp \
   text$/shared$/explorer$/database$/toolbars.xhp \
   text$/shared$/fontwork_toolbar.xhp \
   text$/shared$/guide$/aaa_start.xhp \
   text$/shared$/guide$/accessibility.xhp \
   text$/shared$/guide$/active_help_on_off.xhp \
   text$/shared$/guide$/activex.xhp \
   text$/shared$/guide$/assistive.xhp \
   text$/shared$/guide$/autocorr_url.xhp \
   text$/shared$/guide$/autohide.xhp \
   text$/shared$/guide$/background.xhp \
   text$/shared$/guide$/border_paragraph.xhp \
   text$/shared$/guide$/border_table.xhp \
   text$/shared$/guide$/breaking_lines.xhp \
   text$/shared$/guide$/change_title.xhp \
   text$/shared$/guide$/chart_axis.xhp \
   text$/shared$/guide$/chart_barformat.xhp \
   text$/shared$/guide$/chart_insert.xhp \
   text$/shared$/guide$/chart_legend.xhp \
   text$/shared$/guide$/chart_title.xhp \
   text$/shared$/guide$/configure_overview.xhp \
   text$/shared$/guide$/contextmenu.xhp \
   text$/shared$/guide$/copy_drawfunctions.xhp \
   text$/shared$/guide$/copytable2application.xhp \
   text$/shared$/guide$/copytext2application.xhp \
   text$/shared$/guide$/ctl.xhp \
   text$/shared$/guide$/data_addressbook.xhp \
   text$/shared$/guide$/data_dbase2office.xhp \
   text$/shared$/guide$/data_enter_sql.xhp \
   text$/shared$/guide$/data_forms.xhp \
   text$/shared$/guide$/data_im_export.xhp \
   text$/shared$/guide$/data_new.xhp \
   text$/shared$/guide$/data_queries.xhp \
   text$/shared$/guide$/data_register.xhp \
   text$/shared$/guide$/data_report.xhp \
   text$/shared$/guide$/data_reports.xhp \
   text$/shared$/guide$/data_search.xhp \
   text$/shared$/guide$/data_search2.xhp \
   text$/shared$/guide$/data_tabledefine.xhp \
   text$/shared$/guide$/data_tables.xhp \
   text$/shared$/guide$/data_view.xhp \
   text$/shared$/guide$/database_main.xhp \
   text$/shared$/guide$/digital_signatures.xhp \
   text$/shared$/guide$/doc_autosave.xhp \
   text$/shared$/guide$/doc_open.xhp \
   text$/shared$/guide$/doc_save.xhp \
   text$/shared$/guide$/dragdrop.xhp \
   text$/shared$/guide$/dragdrop_beamer.xhp \
   text$/shared$/guide$/dragdrop_fromgallery.xhp \
   text$/shared$/guide$/dragdrop_gallery.xhp \
   text$/shared$/guide$/dragdrop_graphic.xhp \
   text$/shared$/guide$/dragdrop_table.xhp \
   text$/shared$/guide$/edit_symbolbar.xhp \
   text$/shared$/guide$/email.xhp \
   text$/shared$/guide$/error_report.xhp \
   text$/shared$/guide$/export_ms.xhp \
   text$/shared$/guide$/fax.xhp \
   text$/shared$/guide$/filternavigator.xhp \
   text$/shared$/guide$/find_attributes.xhp \
   text$/shared$/guide$/flat_icons.xhp \
   text$/shared$/guide$/floating_toolbar.xhp \
   text$/shared$/guide$/fontwork.xhp \
   text$/shared$/guide$/formfields.xhp \
   text$/shared$/guide$/gallery_insert.xhp \
   text$/shared$/guide$/hyperlink_edit.xhp \
   text$/shared$/guide$/hyperlink_insert.xhp \
   text$/shared$/guide$/hyperlink_rel_abs.xhp \
   text$/shared$/guide$/hyperlink_search.xhp \
   text$/shared$/guide$/imagemap.xhp \
   text$/shared$/guide$/import_ms.xhp \
   text$/shared$/guide$/insert_bitmap.xhp \
   text$/shared$/guide$/insert_graphic_drawit.xhp \
   text$/shared$/guide$/insert_specialchar.xhp \
   text$/shared$/guide$/integratinguno.xhp \
   text$/shared$/guide$/keyboard.xhp \
   text$/shared$/guide$/labels.xhp \
   text$/shared$/guide$/labels_database.xhp \
   text$/shared$/guide$/language_select.xhp \
   text$/shared$/guide$/line_intext.xhp \
   text$/shared$/guide$/lineend_define.xhp \
   text$/shared$/guide$/linestyle_define.xhp \
   text$/shared$/guide$/linestyles.xhp \
   text$/shared$/guide$/macro_recording.xhp \
   text$/shared$/guide$/main.xhp \
   text$/shared$/guide$/measurement_units.xhp \
   text$/shared$/guide$/microsoft_terms.xhp \
   text$/shared$/guide$/mobiledevicefilters.xhp \
   text$/shared$/guide$/ms_doctypes.xhp \
   text$/shared$/guide$/ms_import_export_limitations.xhp \
   text$/shared$/guide$/ms_user.xhp \
   text$/shared$/guide$/navigator.xhp \
   text$/shared$/guide$/navigator_setcursor.xhp \
   text$/shared$/guide$/navpane_on.xhp \
   text$/shared$/guide$/numbering_stop.xhp \
   text$/shared$/guide$/pageformat_max.xhp \
   text$/shared$/guide$/paintbrush.xhp \
   text$/shared$/guide$/pasting.xhp \
   text$/shared$/guide$/print_blackwhite.xhp \
   text$/shared$/guide$/print_faster.xhp \
   text$/shared$/guide$/protection.xhp \
   text$/shared$/guide$/redlining.xhp \
   text$/shared$/guide$/redlining_accept.xhp \
   text$/shared$/guide$/redlining_doccompare.xhp \
   text$/shared$/guide$/redlining_docmerge.xhp \
   text$/shared$/guide$/redlining_enter.xhp \
   text$/shared$/guide$/redlining_protect.xhp \
   text$/shared$/guide$/redlining_versions.xhp \
   text$/shared$/guide$/round_corner.xhp \
   text$/shared$/guide$/scripting.xhp \
   text$/shared$/guide$/space_hyphen.xhp \
   text$/shared$/guide$/spadmin.xhp \
   text$/shared$/guide$/standard_template.xhp \
   text$/shared$/guide$/start_parameters.xhp \
   text$/shared$/guide$/tabs.xhp \
   text$/shared$/guide$/text_color.xhp \
   text$/shared$/guide$/textmode_change.xhp \
   text$/shared$/guide$/undo_formatting.xhp \
   text$/shared$/guide$/version_number.xhp \
   text$/shared$/guide$/viewing_file_properties.xhp \
   text$/shared$/guide$/workfolder.xhp \
   text$/shared$/guide$/xforms.xhp \
   text$/shared$/guide$/xsltfilter.xhp \
   text$/shared$/main0108.xhp \
   text$/shared$/main0201.xhp \
   text$/shared$/main0208.xhp \
   text$/shared$/main0209.xhp \
   text$/shared$/main0212.xhp \
   text$/shared$/main0213.xhp \
   text$/shared$/main0214.xhp \
   text$/shared$/main0226.xhp \
   text$/shared$/main0227.xhp \
   text$/shared$/main0400.xhp \
   text$/shared$/main0500.xhp \
   text$/shared$/main0600.xhp \
   text$/shared$/main0650.xhp \
   text$/shared$/main0800.xhp \
   text$/shared$/optionen$/01000000.xhp \
   text$/shared$/optionen$/01010000.xhp \
   text$/shared$/optionen$/01010100.xhp \
   text$/shared$/optionen$/01010200.xhp \
   text$/shared$/optionen$/01010300.xhp \
   text$/shared$/optionen$/01010301.xhp \
   text$/shared$/optionen$/01010400.xhp \
   text$/shared$/optionen$/01010401.xhp \
   text$/shared$/optionen$/01010500.xhp \
   text$/shared$/optionen$/01010501.xhp \
   text$/shared$/optionen$/01010600.xhp \
   text$/shared$/optionen$/01010700.xhp \
   text$/shared$/optionen$/01010800.xhp \
   text$/shared$/optionen$/01010900.xhp \
   text$/shared$/optionen$/01011000.xhp \
   text$/shared$/optionen$/01012000.xhp \
   text$/shared$/optionen$/01013000.xhp \
   text$/shared$/optionen$/01014000.xhp \
   text$/shared$/optionen$/01020000.xhp \
   text$/shared$/optionen$/01020100.xhp \
   text$/shared$/optionen$/01020200.xhp \
   text$/shared$/optionen$/01020300.xhp \
   text$/shared$/optionen$/01020400.xhp \
   text$/shared$/optionen$/01030000.xhp \
   text$/shared$/optionen$/01030300.xhp \
   text$/shared$/optionen$/01030500.xhp \
   text$/shared$/optionen$/01040000.xhp \
   text$/shared$/optionen$/01040200.xhp \
   text$/shared$/optionen$/01040300.xhp \
   text$/shared$/optionen$/01040301.xhp \
   text$/shared$/optionen$/01040400.xhp \
   text$/shared$/optionen$/01040500.xhp \
   text$/shared$/optionen$/01040600.xhp \
   text$/shared$/optionen$/01040700.xhp \
   text$/shared$/optionen$/01040900.xhp \
   text$/shared$/optionen$/01041000.xhp \
   text$/shared$/optionen$/01041100.xhp \
   text$/shared$/optionen$/01050000.xhp \
   text$/shared$/optionen$/01050100.xhp \
   text$/shared$/optionen$/01050300.xhp \
   text$/shared$/optionen$/01060000.xhp \
   text$/shared$/optionen$/01060100.xhp \
   text$/shared$/optionen$/01060300.xhp \
   text$/shared$/optionen$/01060400.xhp \
   text$/shared$/optionen$/01060401.xhp \
   text$/shared$/optionen$/01060500.xhp \
   text$/shared$/optionen$/01060600.xhp \
   text$/shared$/optionen$/01060700.xhp \
   text$/shared$/optionen$/01070000.xhp \
   text$/shared$/optionen$/01070100.xhp \
   text$/shared$/optionen$/01070300.xhp \
   text$/shared$/optionen$/01070400.xhp \
   text$/shared$/optionen$/01070500.xhp \
   text$/shared$/optionen$/01080000.xhp \
   text$/shared$/optionen$/01090000.xhp \
   text$/shared$/optionen$/01090100.xhp \
   text$/shared$/optionen$/01110000.xhp \
   text$/shared$/optionen$/01110100.xhp \
   text$/shared$/optionen$/01130100.xhp \
   text$/shared$/optionen$/01130200.xhp \
   text$/shared$/optionen$/01140000.xhp \
   text$/shared$/optionen$/01150000.xhp \
   text$/shared$/optionen$/01150100.xhp \
   text$/shared$/optionen$/01150200.xhp \
   text$/shared$/optionen$/01150300.xhp \
   text$/shared$/optionen$/01160000.xhp \
   text$/shared$/optionen$/01160100.xhp \
   text$/shared$/optionen$/01160200.xhp \
   text$/shared$/optionen$/01160201.xhp \
   text$/shared$/optionen$/java.xhp \
   text$/shared$/optionen$/javaclasspath.xhp \
   text$/shared$/optionen$/javaparameters.xhp \
   text$/shared$/optionen$/macrosecurity.xhp \
   text$/shared$/optionen$/macrosecurity_sl.xhp \
   text$/shared$/optionen$/macrosecurity_ts.xhp \
   text$/shared$/optionen$/mailmerge.xhp \
   text$/shared$/optionen$/online_update.xhp \
   text$/shared$/optionen$/serverauthentication.xhp \
   text$/shared$/optionen$/testaccount.xhp \
   text$/shared$/optionen$/viewcertificate.xhp \
   text$/shared$/optionen$/viewcertificate_c.xhp \
   text$/shared$/optionen$/viewcertificate_d.xhp \
   text$/shared$/optionen$/viewcertificate_g.xhp \
   text$/shared$/tree_strings.xhp \


# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE :  $(PRJ)$/util$/target.pmk
