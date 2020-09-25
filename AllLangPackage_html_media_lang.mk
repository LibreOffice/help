# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t; fill-column: 100 -*-
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

# Language-specific parts of the help/media/ sub-tree.  All language-specific content from
# $(SRCDIR)/helpcontent2/source/media/ must be listed here.  Content that is present in $(SRCDIR)
# for all languages in some set of languages can be handled with a foreach (like the screenshots
# present for all languages in $(completelangiso) below).  More irregular content that is present in
# $(SRCDIR) only for some languages is handled with the individual per-language blocks.

$(eval $(call gb_AllLangPackage_AllLangPackage,helpcontent2_html_media_lang,$(SRCDIR)/helpcontent2/source/media))

$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,bg,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    helpimg/bg/feldalle.png \
    helpimg/bg/feldbrei.png \
    helpimg/bg/feldcolo.png \
    helpimg/bg/names_as_addressing.png \
    helpimg/bg/sheettabs.png \
    helpimg/bg/swh00117.png \
    helpimg/bg/zellvor.png \
))

$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,cs,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    helpimg/cs/feldalle.png \
    helpimg/cs/feldbrei.png \
    helpimg/cs/feldcolo.png \
    helpimg/cs/names_as_addressing.png \
    helpimg/cs/sheettabs.png \
    helpimg/cs/swh00117.png \
    helpimg/cs/zellvor.png \
))

$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,da,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    helpimg/da/feldalle.png \
    helpimg/da/feldbrei.png \
    helpimg/da/feldcolo.png \
    helpimg/da/names_as_addressing.png \
    helpimg/da/sheettabs.png \
    helpimg/da/swh00117.png \
    helpimg/da/zellvor.png \
))

$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,de,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    helpimg/de/feldalle.png \
    helpimg/de/feldcolo.png \
    helpimg/de/names_as_addressing.png \
    helpimg/de/sheettabs.png \
    helpimg/de/swh00117.png \
    helpimg/de/zellvor.png \
))

$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,es,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    helpimg/es/feldalle.png \
    helpimg/es/feldcolo.png \
    helpimg/es/names_as_addressing.png \
    helpimg/es/sheettabs.png \
    helpimg/es/swh00117.png \
    helpimg/es/zellvor.png \
))

$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,et,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    helpimg/et/feldalle.png \
    helpimg/et/feldbrei.png \
    helpimg/et/feldcolo.png \
    helpimg/et/names_as_addressing.png \
    helpimg/et/sheettabs.png \
    helpimg/et/swh00117.png \
    helpimg/et/zellvor.png \
))

$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,fr,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    files/scalc/fr/pivot.ods \
    helpimg/fr/feldalle.png \
    helpimg/fr/feldbrei.png \
    helpimg/fr/feldcolo.png \
    helpimg/fr/names_as_addressing.png \
    helpimg/fr/sheettabs.png \
    helpimg/fr/swh00117.png \
    helpimg/fr/zellvor.png \
))

$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,hu,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    helpimg/hu/feldalle.png \
    helpimg/hu/feldbrei.png \
    helpimg/hu/feldcolo.png \
    helpimg/hu/names_as_addressing.png \
    helpimg/hu/sheettabs.png \
    helpimg/hu/swh00117.png \
    helpimg/hu/zellvor.png \
))

$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,it,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    helpimg/it/feldalle.png \
    helpimg/it/feldbrei.png \
    helpimg/it/feldcolo.png \
    helpimg/it/names_as_addressing.png \
    helpimg/it/sheettabs.png \
    helpimg/it/swh00117.png \
    helpimg/it/zellvor.png \
))

$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,ja,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    helpimg/ja/feldalle.png \
    helpimg/ja/feldbrei.png \
    helpimg/ja/feldcolo.png \
    helpimg/ja/names_as_addressing.png \
    helpimg/ja/sheettabs.png \
    helpimg/ja/swh00055.png \
    helpimg/ja/swh00117.png \
    helpimg/ja/zellvor.png \
))

$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,km,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    helpimg/km/feldcolo.png \
    helpimg/km/names_as_addressing.png \
    helpimg/km/sheettabs.png \
    helpimg/km/swh00117.png \
    helpimg/km/zellvor.png \
))

$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,ko,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    helpimg/ko/feldalle.png \
    helpimg/ko/feldbrei.png \
    helpimg/ko/feldcolo.png \
    helpimg/ko/names_as_addressing.png \
    helpimg/ko/sheettabs.png \
    helpimg/ko/swh00055.png \
    helpimg/ko/swh00117.png \
    helpimg/ko/zellvor.png \
))

$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,pl,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    helpimg/pl/feldalle.png \
    helpimg/pl/feldbrei.png \
    helpimg/pl/feldcolo.png \
    helpimg/pl/names_as_addressing.png \
    helpimg/pl/sheettabs.png \
    helpimg/pl/swh00117.png \
    helpimg/pl/zellvor.png \
))

$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,pt,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    helpimg/pt/feldalle.png \
    helpimg/pt/feldbrei.png \
    helpimg/pt/feldcolo.png \
    helpimg/pt/names_as_addressing.png \
    helpimg/pt/sheettabs.png \
    helpimg/pt/swh00117.png \
    helpimg/pt/zellvor.png \
))

$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,pt-BR,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    helpimg/pt-BR/feldalle.png \
    helpimg/pt-BR/feldbrei.png \
    helpimg/pt-BR/feldcolo.png \
    helpimg/pt-BR/names_as_addressing.png \
    helpimg/pt-BR/sheettabs.png \
    helpimg/pt-BR/swh00117.png \
    helpimg/pt-BR/zellvor.png \
))

$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,sk,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    helpimg/sk/feldalle.png \
    helpimg/sk/feldbrei.png \
    helpimg/sk/feldcolo.png \
    helpimg/sk/names_as_addressing.png \
    helpimg/sk/sheettabs.png \
    helpimg/sk/swh00117.png \
    helpimg/sk/zellvor.png \
))

$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,sl,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    helpimg/sl/feldalle.png \
    helpimg/sl/feldbrei.png \
    helpimg/sl/feldcolo.png \
    helpimg/sl/names_as_addressing.png \
    helpimg/sl/sheettabs.png \
    helpimg/sl/swh00117.png \
    helpimg/sl/zellvor.png \
))

$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,sv,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    helpimg/sv/feldalle.png \
    helpimg/sv/feldbrei.png \
    helpimg/sv/feldcolo.png \
    helpimg/sv/names_as_addressing.png \
    helpimg/sv/sheettabs.png \
    helpimg/sv/swh00117.png \
    helpimg/sv/zellvor.png \
))

$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,tr,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    helpimg/tr/feldalle.png \
    helpimg/tr/feldbrei.png \
    helpimg/tr/feldcolo.png \
    helpimg/tr/names_as_addressing.png \
    helpimg/tr/sheettabs.png \
    helpimg/tr/swh00117.png \
    helpimg/tr/zellvor.png \
))

$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,zh-CN,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    helpimg/zh-CN/feldalle.png \
    helpimg/zh-CN/feldbrei.png \
    helpimg/zh-CN/feldcolo.png \
    helpimg/zh-CN/names_as_addressing.png \
    helpimg/zh-CN/sheettabs.png \
    helpimg/zh-CN/swh00055.png \
    helpimg/zh-CN/swh00117.png \
    helpimg/zh-CN/zellvor.png \
))

$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,zh-TW,$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    helpimg/zh-TW/feldalle.png \
    helpimg/zh-TW/feldbrei.png \
    helpimg/zh-TW/feldcolo.png \
    helpimg/zh-TW/names_as_addressing.png \
    helpimg/zh-TW/sheettabs.png \
    helpimg/zh-TW/swh00055.png \
    helpimg/zh-TW/swh00117.png \
    helpimg/zh-TW/zellvor.png \
))


$(foreach lang,$(filter-out en-US,$(gb_HELP_LANGS)),$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,$(lang),$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    screenshots/modules/smath/ui/alignmentdialog/$(lang)/AlignmentDialog.png \
    screenshots/modules/smath/ui/fontdialog/$(lang)/FontDialog.png \
    screenshots/modules/smath/ui/fontsizedialog/$(lang)/FontSizeDialog.png \
    screenshots/modules/smath/ui/fonttypedialog/$(lang)/FontsDialog.png \
    screenshots/modules/smath/ui/savedefaultsdialog/$(lang)/SaveDefaultsDialog.png \
    screenshots/modules/smath/ui/spacingdialog/$(lang)/SpacingDialog.png \
    screenshots/svx/ui/compressgraphicdialog/$(lang)/CompressGraphicDialog.png \
    screenshots/miscellaneous/impressremote/ui/image01/$(lang)/impress_remote01.png \
    screenshots/miscellaneous/impressremote/ui/image02/$(lang)/impress_remote02.png \
    screenshots/modules/scalc/ui/xmlsourcedialog/$(lang)/XMLSourceDialog.png \
    screenshots/modules/simpress/ui/optimpressgeneralpage/$(lang)/OptSavePage.png \
    screenshots/modules/simpress/ui/sdviewpage/$(lang)/SdViewPage.png \
    screenshots/modules/simpress/ui/prntopts/$(lang)/prntopts.png \
    screenshots/modules/simpress/ui/photoalbum/$(lang)/PhotoAlbumCreatorDialog.png \
    screenshots/modules/simpress/ui/presentationdialog/$(lang)/PresentationDialog.png \
    screenshots/modules/simpress/ui/slidedesigndialog/$(lang)/SlideDesignDialog.png \
    screenshots/modules/simpress/ui/headerfooterdialog/$(lang)/HeaderFooterDialog.png \
    screenshots/modules/simpress/ui/masterlayoutdlg/$(lang)/MasterLayoutDialog.png \
    screenshots/modules/simpress/ui/customslideshows/$(lang)/CustomSlideShows.png \
    screenshots/modules/simpress/ui/definecustomslideshow/$(lang)/DefineCustomSlideShow.png \
    screenshots/modules/simpress/ui/customanimationeffecttab/$(lang)/EffectTab.png \
    screenshots/modules/simpress/ui/customanimationtexttab/$(lang)/TextAnimationTab.png \
    screenshots/modules/simpress/ui/customanimationtimingtab/$(lang)/TimingTab.png \
    screenshots/writerperfect/ui/exportepub/$(lang)/EpubDialog.png \
    screenshots/cui/ui/colorpickerdialog/$(lang)/ColorPicker.png \
    screenshots/cui/ui/colorpage/$(lang)/ColorPage.png \
    screenshots/cui/ui/effectspage/$(lang)/EffectsPage.png \
    screenshots/cui/ui/hyperlinkdocpage/$(lang)/HyperlinkDocPage.png \
    screenshots/cui/ui/hyperlinkinternetpage/$(lang)/HyperlinkInternetPage.png \
    screenshots/cui/ui/hyperlinkmailpage/$(lang)/HyperlinkMailPage.png \
    screenshots/cui/ui/hyperlinknewdocpage/$(lang)/HyperlinkNewDocPage.png \
    screenshots/cui/ui/optviewpage/$(lang)/OptViewPage.png \
    screenshots/cui/ui/optfltrpage/$(lang)/OptFltrPage.png \
    screenshots/cui/ui/opthtmlpage/$(lang)/OptHtmlPage.png \
    screenshots/cui/ui/optaccessibilitypage/$(lang)/OptAccessibilityPage.png \
    screenshots/cui/ui/optsavepage/$(lang)/OptSavePage.png \
    screenshots/cui/ui/optadvancedpage/$(lang)/OptAdvancedPage.png \
    screenshots/cui/ui/optasianpage/$(lang)/OptAsianPage.png \
    screenshots/cui/ui/optctlpage/$(lang)/OptCTLPage.png \
    screenshots/cui/ui/optsecuritypage/$(lang)/OptSecurityPage.png \
    screenshots/cui/ui/optlanguagespage/$(lang)/OptLanguagesPage.png \
    screenshots/cui/ui/optgeneralpage/$(lang)/OptGeneralPage.png \
    screenshots/cui/ui/pageformatpage/$(lang)/PageFormatPage.png \
    screenshots/cui/ui/slantcornertabpage/$(lang)/SlantAndCornerRadius.png \
    screenshots/filter/ui/pdfgeneralpage/$(lang)/PdfGeneralPage.png \
    screenshots/filter/ui/pdflinkspage/$(lang)/PdfLinksPage.png \
    screenshots/filter/ui/pdfviewpage/$(lang)/PdfViewPage.png \
    screenshots/filter/ui/pdfuserinterfacepage/$(lang)/PdfUserInterfacePage.png \
    screenshots/filter/ui/pdfsignpage/$(lang)/PdfSignPage.png \
    screenshots/filter/ui/pdfsecuritypage/$(lang)/PdfSecurityPage.png \
)))
#TODO: Find a clever way to pick en-US files (default) when localized files are missing
# 
$(foreach lang,$(filter-out en-US,$(gb_HELP_LANGS)),$(eval $(call gb_AllLangPackage_add_files_for_lang,helpcontent2_html_media_lang,$(lang),$(LIBO_SHARE_HELP_FOLDER)$(if $(HELP_ONLINE),/$(PRODUCTVERSION))/media, \
    files/scalc/$(lang)/imtrigon.ods \
    files/scalc/$(lang)/trigon.ods \
    files/scalc/$(lang)/pivot.ods \
    files/scalc/$(lang)/functions_ifs.ods \
    files/scalc/$(lang)/function_fourier.ods \
)))
# vim: set noet sw=4 ts=4:
