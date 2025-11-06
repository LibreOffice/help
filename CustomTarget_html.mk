# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t -*-
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

$(eval $(call gb_CustomTarget_CustomTarget,helpcontent2/help3xsl))

# HACK!!
html_TREE_MODULES := swriter scalc simpress sdraw sdatabase smath schart sbasic shared
html_TEXT_MODULES := $(html_TREE_MODULES)
html_BMARK_MODULES := swriter:WRITER scalc:CALC simpress:IMPRESS sdraw:DRAW sdatabase:BASE smath:MATH schart:CHART sbasic:BASIC shared:SHARED

gb_html_allhelpfiles = $(sort $(subst helpcontent2/source/text/,,$(foreach module,$(html_TEXT_MODULES),$(gb_AllLangHelp_$(module)_HELPFILES))))

# In case someone has a product name containing quotes, use Unicode
# code points for ' (27) and " (22) in JS, CSS and entities for HTML.
gb_PRODUCTNAME_JS := $(subst ',\\\u{27},$(subst ",\\\u{22},$(PRODUCTNAME)))
gb_PRODUCTNAME_CSS := $(subst ',\\\27,$(subst ",\\\22,$(PRODUCTNAME)))
gb_PRODUCTNAME_HTML := $(subst ',&apos;,$(subst ",&quot;,$(PRODUCTNAME)))

$(eval $(call gb_CustomTarget_register_targets,helpcontent2/help3xsl,\
	hid2file.js \
	languages.js \
	default.css \
	help2.js \
	$(if $(HELP_ONLINE),tdf_matomo.js) \
	$(foreach lang,$(gb_HELP_LANGS),\
		$(lang)/bookmarks.js \
		$(lang)/contents.js \
		$(lang)/html.text \
		$(foreach module,$(html_TREE_MODULES),$(module)/$(lang)/contents.part) \
		$(foreach module,$(html_BMARK_MODULES),$(firstword $(subst :, ,$(module)))/$(lang)/bookmarks.part) \
		$(foreach module,$(html_TEXT_MODULES),filelists/html-help/$(module)/$(lang).filelist) \
		$(lang)/langnames.js \
		$(if $(HELP_OMINDEX_PAGE),$(lang)/xap_tpl) \
	) \
))

# trailing space for Windows so that xargs doesn't interpret the final CR (that
# win-make adds as the newline character) as part of the last filename
$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/hid2file.js : \
        $(SRCDIR)/helpcontent2/help3xsl/generate_hid2file.xsl \
        $(foreach module,$(html_TEXT_MODULES),$(call gb_AllLangHelp_get_helpfiles_target,$(module))) \
        $(SRCDIR)/helpcontent2/CustomTarget_html.mk \
        | $(call gb_ExternalExecutable_get_dependencies,xsltproc)
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),XSL,1)
	$(call gb_Trace_StartRange,$(@F),XSL)
	( \
		RESPONSEFILE=$(call gb_var2file,$(shell $(gb_MKTEMP)),$(gb_html_allhelpfiles)$(if $(filter WNT,$(OS)), ))  && \
		echo 'var hid2fileMap = {' \
		&& cd $(SRCDIR)/helpcontent2/source/text && $(call gb_ExternalExecutable_get_command,xsltproc,$(if $(filter WNT,$(OS)),env -i $(gb_Helper_set_ld_path)) xargs) $< <$$RESPONSEFILE || { rm $$RESPONSEFILE; exit 1 ; } \
		&& rm "$$RESPONSEFILE" \
		&& echo '};' \
	) > $@
	$(call gb_Trace_EndRange,$(@F),XSL)

# copy en-US file so that pattern rules below don't need special treatment for en-US
$(gb_HelpTranslatePartTarget_workdir)/en-US/helpcontent2/source/text/shared/help/browserhelp.xhp: $(SRCDIR)/helpcontent2/source/text/shared/help/browserhelp.xhp
	mkdir -p $(@D) && cp $< $@

# Xapian localized templates
ifeq ($(HELP_OMINDEX_PAGE),TRUE)

$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/%/xap_tpl : \
        $(gb_HelpTranslatePartTarget_workdir)/%/helpcontent2/source/text/shared/help/browserhelp.xhp \
        $(SRCDIR)/helpcontent2/help3xsl/xap_templ_query.xsl \
        $(SRCDIR)/helpcontent2/CustomTarget_html.mk \
        | $(call gb_ExternalExecutable_get_dependencies,xsltproc)
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),XAT,1)
	$(call gb_Trace_StartRange,$*/$(@F),XSL)
	$(call gb_Helper_abbreviate_dirs,\
		$(call gb_ExternalExecutable_get_command,xsltproc) \
		--stringparam lang $* \
		--stringparam productname "$(gb_PRODUCTNAME_HTML)" \
		--stringparam productversion "$(PRODUCTVERSION)" \
		-o $@ \
		$(SRCDIR)/helpcontent2/help3xsl/xap_templ_query.xsl \
		$(gb_HelpTranslatePartTarget_workdir)/$*/helpcontent2/source/text/shared/help/browserhelp.xhp \
	)
	$(call gb_Trace_EndRange,$*/$(@F),XSL)

endif

# set of installed languages - has to be language independent
$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/languages.js : $(SRCDIR)/helpcontent2/CustomTarget_html.mk
	$(file >$@,var languagesSet = new Set([$(subst $(WHITESPACE),$(COMMA) ,$(patsubst %,'%',$(gb_HELP_LANGS)))]);)

# names of the languages - has to be translated, ie. per language
$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/%/langnames.js : \
        $(gb_HelpTranslatePartTarget_workdir)/%/helpcontent2/source/text/shared/help/browserhelp.xhp \
        $(SRCDIR)/helpcontent2/CustomTarget_html.mk
	( \
		echo 'var languageNames = {' ; \
			sed -n -e 's/^.*<paragraph[^>]* id="lang_.*<variable id="\([^"]*\)"[^>]*>\([^<]*\)<.*$$/"\1": "\2",/p' $(filter %/browserhelp.xhp,$^) ; \
		echo '};' \
	) > $@

define html_gen_contents_html_dep
$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/$(1)/contents.part : $(call gb_HelpTarget__get_treefile,$(1),$(3))
$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/$(1)/contents.part : TREE_FILE := $(call gb_HelpTarget__get_treefile,$(1),$(3))
$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/$(1)/contents.part : LANGUAGE := $(2)
$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/$(1)/contents.part : MODULE := $(lastword $(subst :, ,$(filter $(module):%, $(html_BMARK_MODULES))))

endef

define html_gen_contents_dep
$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/$(1)/contents.js : \
	$(foreach module,$(html_TREE_MODULES),\
		$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/$(module)/$(1)/contents.part)
$(foreach module,$(html_TREE_MODULES),$(call html_gen_contents_html_dep,$(module)/$(1),$(1),helpcontent2/source/auxiliary/$(module)))

endef

$(eval $(foreach lang,$(gb_HELP_LANGS),$(call html_gen_contents_dep,$(lang))))

$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/%/contents.js :
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),CAT,2)
	$(call gb_Helper_abbreviate_dirs,\
		( \
			echo "document.getElementById(\"Contents\").innerHTML='\\" \
			&& cat $(filter %.part,$^) | $(gb_AWK) 'NF' \
			&& echo "';" \
		) > $@ \
	)

$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/%/contents.part : \
        $(SRCDIR)/helpcontent2/help3xsl/get_tree.xsl \
        $(SRCDIR)/helpcontent2/help3xsl/brand.xsl \
        | $(call gb_ExternalExecutable_get_dependencies,xsltproc)
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),XSL,1)
	$(call gb_Trace_StartRange,$*/$(@F),XSL)
	$(call gb_Helper_abbreviate_dirs,\
		$(call gb_ExternalExecutable_get_command,xsltproc) \
			--stringparam lang $(LANGUAGE) \
			--stringparam local $(if $(HELP_ONLINE),'no','yes') \
			--stringparam module $(MODULE) \
			--stringparam productname "$(gb_PRODUCTNAME_HTML)" \
			--stringparam productversion "$(PRODUCTVERSION)" \
			-o $@ \
			$(SRCDIR)/helpcontent2/help3xsl/get_tree.xsl \
			$(TREE_FILE) \
	)
	$(call gb_Trace_EndRange,$*/$(@F),XSL)

# link txt file for icon replacement table - tdf#128519
# copy online_transform.xsl to workdir and build links.txt.xsl
$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/online_transform.xsl : \
		$(SRCDIR)/helpcontent2/help3xsl/online_transform.xsl
	mkdir -p $(dir $@)
	cp $(SRCDIR)/helpcontent2/help3xsl/online_transform.xsl $@

$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/links.txt.xsl : \
        $(gb_CustomTarget_workdir)/helpcontent2/help3xsl/online_transform.xsl \
        $(SRCDIR)/icon-themes/colibre/links.txt \
        $(SRCDIR)/helpcontent2/helpers/make_icon_link.txt.py \
        | $(call gb_ExternalExecutable_get_dependencies,python)
	$(call gb_Trace_StartRange,$(@F),PY)
	$(call gb_ExternalExecutable_get_command,python) $(SRCDIR)/helpcontent2/helpers/make_icon_link.txt.py $(SRCDIR)/icon-themes/colibre/links.txt $@
	$(call gb_Trace_EndRange,$(@F),PY)

define html_gen_html_dep
$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/$(1)/html.text : \
		$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/links.txt.xsl \
	$(foreach module,$(html_TEXT_MODULES), \
		$(if $(filter en-US,$(1)), \
			$(call gb_AllLangHelp_get_helpfiles_target,$(module)), \
			$(call gb_HelpTranslateTarget_get_target,$(module)/$(1))))

endef

$(eval $(foreach lang,$(gb_HELP_LANGS),$(call html_gen_html_dep,$(lang))))

$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/%/html.text : \
        $(gb_CustomTarget_workdir)/helpcontent2/help3xsl/links.txt.xsl \
        | $(call gb_ExternalExecutable_get_dependencies,xsltproc)
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),XSL,1)
	$(call gb_Trace_StartRange,$*/$(@F),XSL)
	rm -rf $(dir $@)text && mkdir -p $(dir $@)text && cd $(dir $@)text && mkdir -p $(sort $(dir $(gb_html_allhelpfiles))) \
	&& cd $(if $(filter en-US,$*),$(SRCDIR),$(gb_HelpTranslatePartTarget_workdir)/$*) \
	&& RESPONSEFILE=$(call gb_var2file,$(shell $(gb_MKTEMP)),$(addsuffix $(WHITESPACE)dummyIgnoreCRinEOL$(NEWLINE),$(gb_html_allhelpfiles))) \
	&& while read xhp dummy; do \
	    $(call gb_ExternalExecutable_get_command,xsltproc) \
	        --stringparam Language $* \
	        --stringparam local $(if $(HELP_ONLINE),'no','yes') \
	        --stringparam root $(if $(filter en-US,$*),$(SRCDIR),$(gb_HelpTranslatePartTarget_workdir)/$*)/helpcontent2/source/ \
	        --stringparam productname "$(gb_PRODUCTNAME_HTML)" \
	        --stringparam productversion "$(PRODUCTVERSION)" \
	        --stringparam xapian $(if $(filter TRUE, $(HELP_OMINDEX_PAGE)),'yes','no') \
	        -o $(dir $@)/text/$${xhp%.xhp}.html \
	        $(gb_CustomTarget_workdir)/helpcontent2/help3xsl/online_transform.xsl \
	        helpcontent2/source/text/$$xhp \
	    || exit \
	; done <"$$RESPONSEFILE" \
	&& rm "$$RESPONSEFILE" \
	&& touch $@
	$(call gb_Trace_EndRange,$*/$(@F),XSL)

$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/%/bookmarks.js :
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),CAT,2)
	$(call gb_Helper_abbreviate_dirs,\
		( \
			echo 'var bookmarks = [' \
			&& cat $(filter %.part,$^) \
			&& echo '];' \
		) > $@ \
	)

define html__gen_bookmarks_lang_dep
$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/$(2)/$(1)/bookmarks.part : \
    $(if $(filter en-US,$(1)), \
        $(call gb_AllLangHelp_get_helpfiles_target,$(firstword $(subst /, ,$(2)))), \
        $(call gb_HelpTranslateTarget_get_target,$(firstword $(subst /, ,$(2)))/$(1)))

endef

define html__gen_bookmarks_lang_deps
$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/$(1)/bookmarks.js : \
	$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/$(2)/$(1)/bookmarks.part
$(call html__gen_bookmarks_lang_dep,$(1),$(2))
$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/$(2)/$(1)/bookmarks.part : HELP_LANG := $(1)

endef

define html__gen_bookmarks_deps
$(foreach lang,$(gb_HELP_LANGS),$(call html__gen_bookmarks_lang_deps,$(lang),$(1)))
$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/$(1)/%/bookmarks.part : APP := $(2)
$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/$(1)/%/bookmarks.part : APPDIR := $(1)

endef

html_gen_bookmarks_deps = $(call html__gen_bookmarks_deps,$(firstword $(1)),$(lastword $(1)))

$(eval $(foreach module,$(html_BMARK_MODULES),$(call html_gen_bookmarks_deps,$(subst :, ,$(module)))))

# strip the helpcontent2/source/text prefix and cd to the corresponding directory to maximize
# the number of files that xargs can squeeze into a single invocation of xsltproc
$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/%/bookmarks.part : \
        $(SRCDIR)/helpcontent2/help3xsl/get_bookmark.xsl \
        $(SRCDIR)/helpcontent2/help3xsl/brand.xsl \
        | $(call gb_ExternalExecutable_get_dependencies,xsltproc)
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),XSL,1)
	$(call gb_Trace_StartRange,$*/$(@F),XSL)
	RESPONSEFILE=$(call gb_var2file,$(shell $(gb_MKTEMP)),$(subst helpcontent2/source/text/,,$(gb_AllLangHelp_$(APPDIR)_BOOKMARK_HELPFILES))$(if $(filter WNT,$(OS)), )) \
	&& cd $(if $(filter en-US,$(HELP_LANG)),$(SRCDIR),$(gb_HelpTranslatePartTarget_workdir)/$(HELP_LANG))/helpcontent2/source/text \
	&& ( \
	    $(call gb_ExternalExecutable_get_command,xsltproc,$(if $(filter WNT,$(OS)),env -i $(gb_Helper_set_ld_path)) xargs) \
	        --stringparam app $(APP) \
	        --stringparam Language $(HELP_LANG) \
	        --stringparam local $(if $(HELP_ONLINE),'no','yes') \
	        --stringparam productname "$(gb_PRODUCTNAME_HTML)" \
	        --stringparam productversion "$(PRODUCTVERSION)" \
	        $(SRCDIR)/helpcontent2/help3xsl/get_bookmark.xsl \
	    <$$RESPONSEFILE || { rm $$RESPONSEFILE; exit 1; } \
	) | sort -k3b -s >$@ && rm "$$RESPONSEFILE"
	$(call gb_Trace_EndRange,$*/$(@F),XSL)

# The various gid_File_Help_*_Zip in scp2 that use EXTRA_ALL_GOOD_HELP_LOCALIZATIONS_LANG expect
# $(module)/$(lang).filelist files containing lists of files (in instdir) for the corresponding
# module/lang parts of help data.  As a hack, generate those from the existing HelpTarget file
# lists, which specify the original .xhp files (in SRCDIR for en-US, translated for all other
# langs).  For the shared module, also include the per-lang non .xhp/.html files from the
# AllLangPackages helpcontent2_html_lang and helpcontent2_html_media_lang:

# html__filelist,lang,module
define html__filelist
$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/filelists/html-help/$(2)/$(1).filelist: \
        $(call gb_HelpTarget_get_filelist,$(2)/$(1)) \
        $(if $(filter $(2),shared), \
            $(call gb_Package_get_target,helpcontent2_html_lang_$(1)) \
            $(call gb_Package_get_target,helpcontent2_html_media_lang_$(1)))
	mkdir -p $$$$(dirname $$@)
	sed -e 's|$(if $(filter $(1),en-US),$(SRCDIR),$(gb_HelpTranslatePartTarget_workdir)/$(1))/helpcontent2/source/|$(INSTROOT)/$(LIBO_SHARE_HELP_FOLDER)/$(1)/|g' -e 's|.xhp|.html|g' $(call gb_HelpTarget_get_filelist,$(2)/$(1)) > $$@
	$(if $(filter $(2),shared),cat $(call gb_Package_get_target,helpcontent2_html_lang_$(1)) $(call gb_Package_get_target,helpcontent2_html_media_lang_$(1)) >> $$@,:)

endef

$(eval $(foreach lang,$(gb_HELP_LANGS),$(foreach module,$(html_TEXT_MODULES),$(call html__filelist,$(lang),$(module)))))

$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/default.css : \
                $(SRCDIR)/helpcontent2/help3xsl/default.css \
                $(BUILDDIR)/config_host.mk
	sed -e "s/%PRODUCTNAME/$(gb_PRODUCTNAME_CSS)/g" $< > $@

$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/help2.js : \
                $(SRCDIR)/helpcontent2/help3xsl/help2.js \
                $(BUILDDIR)/config_host.mk
	sed -e "s/%PRODUCTNAME/$(gb_PRODUCTNAME_JS)/g" $< > $@

$(gb_CustomTarget_workdir)/helpcontent2/help3xsl/tdf_matomo.js : \
                $(SRCDIR)/helpcontent2/help3xsl/tdf_matomo.js 
	mkdir -p $(dir $@)
	cp $(SRCDIR)/helpcontent2/help3xsl/tdf_matomo.js $@

# vim: set noet sw=4 ts=4:
