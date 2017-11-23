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
html_TREE_MODULES := sbasic scalc schart shared simpress smath swriter
html_TEXT_MODULES := $(html_TREE_MODULES) sdatabase sdraw
html_BMARK_MODULES := scalc:CALC schart:CHART swriter:WRITER sdraw:DRAW simpress:IMPRESS smath:MATH sbasic:BASIC shared:SHARED shared/explorer/database:BASE

$(eval $(call gb_CustomTarget_register_targets,helpcontent2/help3xsl,\
	hid2file.js \
	$(foreach lang,$(gb_HELP_LANGS),\
		$(lang)/bookmarks.js \
		$(lang)/contents.js \
		$(lang)/html.text \
		$(foreach module,$(html_TREE_MODULES),$(module)/$(lang)/contents.part) \
		$(foreach module,$(html_BMARK_MODULES),$(firstword $(subst :, ,$(module)))/$(lang)/bookmarks.part) \
	) \
))

$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/hid2file.js : \
		$(SRCDIR)/helpcontent2/help3xsl/get_url.xsl \
		$(call gb_ExternalExecutable_get_dependencies,xsltproc)
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),XSL,1)
	$(call gb_Helper_abbreviate_dirs,\
		( \
			echo 'var map={' \
			&& find $(SRCDIR)/helpcontent2/source/text -type f -name '*.xhp' \
			| while read xhp; do \
				$(call gb_ExternalExecutable_get_command,xsltproc) $< $$xhp \
				| $(gb_AWK) 'NF' \
			; done \
			&& echo '};' \
		) > $@ \
	)

define html_gen_contents_html_dep
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(1)/contents.part : $(call gb_HelpTarget__get_treefile,$(1),$(3))
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(1)/contents.part : TREE_FILE := $(call gb_HelpTarget__get_treefile,$(1),$(3))
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(1)/contents.part : LANG := $(2)

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
		$(call gb_ExternalExecutable_get_dependencies,xsltproc)
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),XSL,1)
	$(call gb_Helper_abbreviate_dirs,\
		$(call gb_ExternalExecutable_get_command,xsltproc) \
			--stringparam lang $(LANG) \
			--stringparam productversion $(PRODUCTVERSION) \
			-o $@ \
			$(SRCDIR)/helpcontent2/help3xsl/get_tree.xsl \
			$(TREE_FILE) \
	)

define html_gen_html_dep
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(1)/html.text : \
	$(foreach module,$(html_TEXT_MODULES),$(call gb_HelpTranslateTarget_get_target,$(module)/$(1)))

endef

$(eval $(foreach lang,$(filter-out en-US,$(gb_HELP_LANGS)),$(call html_gen_html_dep,$(lang))))

$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/%/html.text : \
		$(SRCDIR)/helpcontent2/help3xsl/online_transform.xsl \
		$(call gb_ExternalExecutable_get_dependencies,xsltproc)
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),XSL,1)
	$(call gb_Helper_abbreviate_dirs,\
		cd $(if $(filter en-US,$*),$(SRCDIR),$(call gb_HelpTranslatePartTarget_get_workdir,$*))/helpcontent2/source \
		&& rm -rf $(dir $@)text \
		&& find text -name "*.xhp" \
		| while read xhp; do \
			$(call gb_ExternalExecutable_get_command,xsltproc) \
				--stringparam fileTree '/' \
				--stringparam Language $* \
				--stringparam local 'yes' \
				--stringparam root `pwd`/ \
				--stringparam productversion $(PRODUCTVERSION) \
				-o $(dir $@)$${xhp%.xhp}.html \
				$(SRCDIR)/helpcontent2/help3xsl/online_transform.xsl \
				`pwd`/$$xhp \
		; done \
		&& touch $@ \
	)

$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/%/bookmarks.js :
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),CAT,2)
	$(call gb_Helper_abbreviate_dirs,\
		cat $(filter %.part,$^) > $@ \
	)

define html__gen_bookmarks_lang_dep
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(2)/$(1)/bookmarks.part : \
	$(call gb_HelpTranslateTarget_get_target,$(firstword $(subst /, ,$(2)))/$(1))

endef

define html__gen_bookmarks_lang_deps
$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(1)/bookmarks.js : \
	$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/$(2)/$(1)/bookmarks.part
$(if $(filter-out en-US,$(1)),$(call html__gen_bookmarks_lang_dep,$(1),$(2)))
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

$(call gb_CustomTarget_get_workdir,helpcontent2/help3xsl)/%/bookmarks.part : \
		$(SRCDIR)/helpcontent2/help3xsl/get_bookmark.xsl \
		$(call gb_ExternalExecutable_get_dependencies,xsltproc)
	$(call gb_Output_announce,$(subst $(WORKDIR)/,,$@),$(true),XSL,1)
	$(call gb_Helper_abbreviate_dirs,\
		( \
			echo "document.getElementById(\"bookmark$(APP)\").innerHTML='\\" \
			&& find $(if $(filter en-US,$(HELP_LANG)),$(SRCDIR),$(call gb_HelpTranslatePartTarget_get_workdir,$(HELP_LANG)))/helpcontent2/source/text/$(APPDIR) -name "*.xhp" \
			| while read xhp; do \
				$(call gb_ExternalExecutable_get_command,xsltproc) \
					--stringparam app $(APP) \
					--stringparam Language $(HELP_LANG) \
					--stringparam productversion $(PRODUCTVERSION) \
					$(SRCDIR)/helpcontent2/help3xsl/get_bookmark.xsl \
					$$xhp \
			; done \
			| sort -k3b -t\> -s \
			| awk 'NF' \
			&& echo "'" \
		) > $@ \
	)

# vim: set noet sw=4 ts=4:
