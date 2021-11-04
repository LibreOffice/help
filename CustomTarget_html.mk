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

$(eval $(call gb_CustomTarget_register_targets,helpcontent2/help3xsl,\
	hid2file.js \
	languages.js \
	$(foreach lang,$(gb_HELP_LANGS),\
		$(lang)/bookmarks.js \
		$(lang)/contents.js \
		$(lang)/html.text \
		$(foreach module,$(html_TREE_MODULES),$(module)/$(lang)/contents.part) \
		$(foreach module,$(html_BMARK_MODULES),$(firstword $(subst :, ,$(module)))/$(lang)/bookmarks.part) \
		$(foreach module,$(html_TEXT_MODULES),filelists/html-help/$(module)/$(lang).filelist) \
		$(lang)/langnames.js \
		$(if $(HELP_OMINDEX_PAGE),$(lang)/xap_tpl) \
		$(lang)/noscript.html \
	) \
))

# In the below recipe, the file $@.good is used to communicate failure of xsltproc in the pipeline
# (similar to Bash's `set -o pipefail`; the final `rm $@.good` will fail, and fail the whole
# command, if the xsltproc invocation failed):
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/hid2file.js : \
		$(SRCDIR)/helpcontent2/help3xsl/generate_hid2file.xsl \
		$(call gb_ExternalExecutable_get_dependencies,xsltproc) \
		$(foreach module,$(html_TEXT_MODULES),$(call gb_AllLangHelp_get_helpfiles_target,$(module))) \
		$(SRCDIR)/helpcontent2/CustomTarget_html.mk
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),XSL,1)
	$(call gb_Helper_abbreviate_dirs,\
		( \
			echo 'var hid2fileMap = {' \
			&& RESPONSEFILE=$(call gb_var2file,$(shell $(gb_MKTEMP)),100,$(foreach module,$(html_TEXT_MODULES),$(addprefix $(SRCDIR)/,$(gb_AllLangHelp_$(module)_HELPFILES)))) \
			&& <"$$RESPONSEFILE" $(if $(filter WNT,$(OS)),tr -d '\r' | env -i PATH="$$PATH") xargs -n 1 printf '%s\n' \
			| while read xhp; do \
				rm -f $@.good && \
				{ $(call gb_ExternalExecutable_get_command,xsltproc) $< $$xhp && touch $@.good; } \
				| $(gb_AWK) 'NF' \
				&& rm $@.good || exit \
			; done \
			&& rm "$$RESPONSEFILE" \
			&& echo '};' \
		) > $@ \
	)


# Xapian localized templates
ifeq ($(HELP_OMINDEX_PAGE),TRUE)

define html_gen_xaptpl_dep
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(1)/xap_tpl : \
	$(if $(filter en-US,$(1)),$(SRCDIR),$(call gb_HelpTranslatePartTarget_get_workdir,$(1)))/helpcontent2/source/text/shared/help/browserhelp.xhp

endef
	
$(eval $(foreach lang,$(gb_HELP_LANGS),$(call html_gen_xaptpl_dep,$(lang))))

$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/%/xap_tpl : \
		$(SRCDIR)/helpcontent2/help3xsl/xap_templ_query.xsl \
		$(call gb_ExternalExecutable_get_dependencies,xsltproc) \
		$(SRCDIR)/helpcontent2/CustomTarget_html.mk
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),XAT,1)
	$(call gb_Helper_abbreviate_dirs,\
		$(call gb_ExternalExecutable_get_command,xsltproc) \
		--stringparam lang $* \
		--stringparam productname "$(PRODUCTNAME)" \
		--stringparam productversion "$(PRODUCTVERSION)" \
		-o $@ \
		$(SRCDIR)/helpcontent2/help3xsl/xap_templ_query.xsl \
		$(if $(filter en-US,$*),$(SRCDIR),$(call gb_HelpTranslatePartTarget_get_workdir,$*))/helpcontent2/source/text/shared/help/browserhelp.xhp \
	)

endif

# Create noscript.html, when browser has no javascript enabled

define html_gen_noscript_dep
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(1)/noscript.html : \
	$(if $(filter en-US,$(1)),$(SRCDIR),$(call gb_HelpTranslatePartTarget_get_workdir,$(1)))/helpcontent2/source/text/shared/help/browserhelp.xhp

endef

$(eval $(foreach lang,$(gb_HELP_LANGS),$(call html_gen_noscript_dep,$(lang))))

$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/%/noscript.html : \
		$(SRCDIR)/helpcontent2/help3xsl/noscript.xsl \
		$(SRCDIR)/helpcontent2/help3xsl/brand.xsl \
		$(call gb_ExternalExecutable_get_dependencies,xsltproc) \
		$(SRCDIR)/helpcontent2/CustomTarget_html.mk
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),NJS,1)
	$(call gb_Helper_abbreviate_dirs,\
		$(call gb_ExternalExecutable_get_command,xsltproc) \
		--stringparam lang $* \
		--stringparam productname "$(PRODUCTNAME)" \
		--stringparam productversion "$(PRODUCTVERSION)" \
		-o $@ \
		$(SRCDIR)/helpcontent2/help3xsl/noscript.xsl \
		$(if $(filter en-US,$*),$(SRCDIR),$(call gb_HelpTranslatePartTarget_get_workdir,$*))/helpcontent2/source/text/shared/help/browserhelp.xhp \
	)


# set of installed languages - has to be language independent
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/languages.js : \
		$(SRCDIR)/helpcontent2/CustomTarget_html.mk
	( \
		printf 'var languagesSet = new Set([' ; \
		for lang in $(gb_HELP_LANGS) ; do printf '%s' "'$$lang', " ; done | sed 's/, $$//' ; \
		printf ']);\n' \
	) > $@


define html_gen_langnames_js_dep
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(1)/langnames.js : \
	$(if $(filter en-US,$(1)),$(SRCDIR),$(call gb_HelpTranslatePartTarget_get_workdir,$(1)))/helpcontent2/source/text/shared/help/browserhelp.xhp

endef

$(eval $(foreach lang,$(gb_HELP_LANGS),$(call html_gen_langnames_js_dep,$(lang))))

# names of the languages - has to be translated, ie. per language
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/%/langnames.js : \
		$(SRCDIR)/helpcontent2/CustomTarget_html.mk
	( \
		echo 'var languageNames = {' ; \
		grep '<paragraph[^>]*id="lang_' $(if $(filter en-US,$*),$(SRCDIR),$(call gb_HelpTranslatePartTarget_get_workdir,$*))/helpcontent2/source/text/shared/help/browserhelp.xhp | \
			sed -e 's/^.*<variable id="\([^"]*\)"[^>]*>\([^<]*\)<.*$$/"\1": "\2",/' ; \
		echo '};' \
	) > $@

define html_gen_contents_html_dep
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(1)/contents.part : $(call gb_HelpTarget__get_treefile,$(1),$(3))
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(1)/contents.part : TREE_FILE := $(call gb_HelpTarget__get_treefile,$(1),$(3))
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(1)/contents.part : LANGUAGE := $(2)
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(1)/contents.part : MODULE := $(lastword $(subst :, ,$(filter $(module):%, $(html_BMARK_MODULES))))

endef

define html_gen_contents_dep
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(1)/contents.js : \
	$(foreach module,$(html_TREE_MODULES),\
		$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(module)/$(1)/contents.part)
$(foreach module,$(html_TREE_MODULES),$(call html_gen_contents_html_dep,$(module)/$(1),$(1),helpcontent2/source/auxiliary/$(module)))

endef

$(eval $(foreach lang,$(gb_HELP_LANGS),$(call html_gen_contents_dep,$(lang))))

$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/%/contents.js :
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),CAT,2)
	$(call gb_Helper_abbreviate_dirs,\
		( \
			echo "document.getElementById(\"Contents\").innerHTML='\\" \
			&& cat $(filter %.part,$^) | $(gb_AWK) 'NF' \
			&& echo "';" \
		) > $@ \
	)

$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/%/contents.part : \
		$(SRCDIR)/helpcontent2/help3xsl/get_tree.xsl \
		$(SRCDIR)/helpcontent2/help3xsl/brand.xsl \
		$(call gb_ExternalExecutable_get_dependencies,xsltproc)
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),XSL,1)
	$(call gb_Helper_abbreviate_dirs,\
		$(call gb_ExternalExecutable_get_command,xsltproc) \
			--stringparam lang $(LANGUAGE) \
			--stringparam local $(if $(HELP_ONLINE),'no','yes') \
			--stringparam module $(MODULE) \
			--stringparam productname "$(PRODUCTNAME)" \
			--stringparam productversion "$(PRODUCTVERSION)" \
			-o $@ \
			$(SRCDIR)/helpcontent2/help3xsl/get_tree.xsl \
			$(TREE_FILE) \
	)

# link txt file for icon replacement table - tdf#128519
# copy online_transform.xsl to workdir and build links.txt.xsl
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl/online_transform.xsl) : \
		$(SRCDIR)/helpcontent2/help3xsl/online_transform.xsl
	cp $(SRCDIR)/helpcontent2/help3xsl/online_transform.xsl $@

$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl/links.txt.xsl) : \
		$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl/online_transform.xsl) \
		$(SRCDIR)/icon-themes/colibre/links.txt \
		$(SRCDIR)/helpcontent2/helpers/make_icon_link.txt.py \
		$(call gb_ExternalExecutable_get_dependencies,python)
	$(call gb_ExternalExecutable_get_command,python) $(SRCDIR)/helpcontent2/helpers/make_icon_link.txt.py $(SRCDIR)/icon-themes/colibre/links.txt $@

define html_gen_html_dep
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(1)/html.text : \
		$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl/links.txt.xsl) \
	$(foreach module,$(html_TEXT_MODULES), \
		$(if $(filter en-US,$(1)), \
			$(call gb_AllLangHelp_get_helpfiles_target,$(module)), \
			$(call gb_HelpTranslateTarget_get_target,$(module)/$(1))))

endef

$(eval $(foreach lang,$(gb_HELP_LANGS),$(call html_gen_html_dep,$(lang))))

$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/%/html.text : \
		$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl/links.txt.xsl) \
		$(call gb_ExternalExecutable_get_dependencies,xsltproc)
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),XSL,1)
	$(call gb_Helper_abbreviate_dirs,\
		cd $(if $(filter en-US,$*),$(SRCDIR),$(call gb_HelpTranslatePartTarget_get_workdir,$*))/helpcontent2/source \
		&& rm -rf $(dir $@)text \
		&& RESPONSEFILE=$(call gb_var2file,$(shell $(gb_MKTEMP)),100,$(foreach module,$(html_TEXT_MODULES),$(patsubst helpcontent2/source/%,%,$(gb_AllLangHelp_$(module)_HELPFILES)))) \
		&& <"$$RESPONSEFILE" $(if $(filter WNT,$(OS)),tr -d '\r' | env -i PATH="$$PATH") xargs -n 1 printf '%s\n' \
		| while read xhp; do \
			mkdir -p $$(dirname $(dir $@)$$xhp) && \
			$(call gb_ExternalExecutable_get_command,xsltproc) \
				--stringparam Language $* \
				--stringparam local $(if $(HELP_ONLINE),'no','yes') \
				--stringparam root $(if $(filter WNT,$(OS)),$$(cygpath -m `pwd`),`pwd`)/ \
				--stringparam productname "$(PRODUCTNAME)" \
				--stringparam productversion "$(PRODUCTVERSION)" \
				--stringparam xapian $(if $(filter TRUE, $(HELP_OMINDEX_PAGE)),'yes','no') \
				-o $(dir $@)$${xhp%.xhp}.html \
				$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl/online_transform.xsl) \
				$(if $(filter WNT,$(OS)),$$(cygpath -m `pwd`),`pwd`)/$$xhp \
			|| exit \
		; done \
		&& rm "$$RESPONSEFILE" \
		&& touch $@ \
	)

$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/%/bookmarks.js :
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),CAT,2)
	$(call gb_Helper_abbreviate_dirs,\
		( \
			echo 'var bookmarks = [' \
			&& cat $(filter %.part,$^) \
			&& echo '];' \
		) > $@ \
	)

define html__gen_bookmarks_lang_dep
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(2)/$(1)/bookmarks.part : \
    $(if $(filter en-US,$(1)), \
        $(call gb_AllLangHelp_get_helpfiles_target,$(firstword $(subst /, ,$(2)))), \
        $(call gb_HelpTranslateTarget_get_target,$(firstword $(subst /, ,$(2)))/$(1)))

endef

define html__gen_bookmarks_lang_deps
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(1)/bookmarks.js : \
	$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(2)/$(1)/bookmarks.part
$(call html__gen_bookmarks_lang_dep,$(1),$(2))
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(2)/$(1)/bookmarks.part : HELP_LANG := $(1)

endef

define html__gen_bookmarks_deps
$(foreach lang,$(gb_HELP_LANGS),$(call html__gen_bookmarks_lang_deps,$(lang),$(1)))
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(1)/%/bookmarks.part : APP := $(2)
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(1)/%/bookmarks.part : APPDIR := $(1)

endef

define html_gen_bookmarks_deps
$(call html__gen_bookmarks_deps,$(firstword $(1)),$(lastword $(1)))

endef

$(eval $(foreach module,$(html_BMARK_MODULES),$(call html_gen_bookmarks_deps,$(subst :, ,$(module)))))

# In the below recipe, the file $@.good is used to communicate failure of xsltproc in the pipeline
# (similar to Bash's `set -o pipefail`; the final `rm $@.good` will fail, and fail the whole
# command, if any xsltproc invocation failed):
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/%/bookmarks.part : \
		$(SRCDIR)/helpcontent2/help3xsl/get_bookmark.xsl \
		$(SRCDIR)/helpcontent2/help3xsl/brand.xsl \
		$(call gb_ExternalExecutable_get_dependencies,xsltproc)
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),XSL,1)
	$(call gb_Helper_abbreviate_dirs,\
		RESPONSEFILE=$(call gb_var2file,$(shell $(gb_MKTEMP)),100,$(addprefix $(if $(filter en-US,$(HELP_LANG)),$(SRCDIR),$(call gb_HelpTranslatePartTarget_get_workdir,$(HELP_LANG)))/,$(gb_AllLangHelp_$(APPDIR)_BOOKMARK_HELPFILES))) \
		&& ( \
			<"$$RESPONSEFILE" $(if $(filter WNT,$(OS)),tr -d '\r' | env -i PATH="$$PATH") xargs -n 1 printf '%s\n' \
			| { rm -f $@.good && while read xhp; do \
				$(call gb_ExternalExecutable_get_command,xsltproc) \
					--stringparam app $(APP) \
					--stringparam Language $(HELP_LANG) \
					--stringparam local $(if $(HELP_ONLINE),'no','yes') \
					--stringparam productname "$(PRODUCTNAME)" \
					--stringparam productversion "$(PRODUCTVERSION)" \
					$(SRCDIR)/helpcontent2/help3xsl/get_bookmark.xsl \
					$$xhp \
				|| exit \
			; done && touch $@.good; } \
			| sort -k3b -s \
			| awk 'NF' \
			&& rm $@.good \
		) > $@ \
		&& rm "$$RESPONSEFILE" \
	)	

# The various gid_File_Help_*_Zip in scp2 that use EXTRA_ALL_GOOD_HELP_LOCALIZATIONS_LANG expect
# $(module)/$(lang).filelist files containing lists of files (in instdir) for the corresponding
# module/lang parts of help data.  As a hack, generate those from the existing HelpTarget file
# lists, which specify the original .xhp files (in SRCDIR for en-US, translated for all other
# langs).  For the shared module, also include the per-lang non .xhp/.html files from the
# AllLangPackages helpcontent2_html_lang and helpcontent2_html_media_lang:

# html__filelist,lang,module
define html__filelist
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/filelists/html-help/$(2)/$(1).filelist: \
        $(call gb_HelpTarget_get_filelist,$(2)/$(1)) \
        $(if $(filter $(2),shared), \
            $(call gb_Package_get_target,helpcontent2_html_lang_$(1)) \
            $(call gb_Package_get_target,helpcontent2_html_media_lang_$(1)))
	mkdir -p $$$$(dirname $$@)
	sed -e 's|$(if $(filter $(1),en-US),$(SRCDIR),$(call gb_HelpTranslatePartTarget_get_workdir,$(1)))/helpcontent2/source/|$(INSTROOT)/$(LIBO_SHARE_HELP_FOLDER)/$(1)/|g' -e 's|.xhp|.html|g' $(call gb_HelpTarget_get_filelist,$(2)/$(1)) > $$@
	$(if $(filter $(2),shared),cat $(call gb_Package_get_target,helpcontent2_html_lang_$(1)) $(call gb_Package_get_target,helpcontent2_html_media_lang_$(1)) >> $$@,:)

endef

$(eval $(foreach lang,$(gb_HELP_LANGS),$(foreach module,$(html_TEXT_MODULES),$(call html__filelist,$(lang),$(module)))))

# vim: set noet sw=4 ts=4:
