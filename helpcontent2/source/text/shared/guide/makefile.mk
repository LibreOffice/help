#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: rt $ $Date: 2005-01-27 09:59:13 $
#*
#*    $Revision: 1.6 $
#*
#*    $Logfile:$
#*
#*    Copyright 2000 Sun Microsystems, Inc. All Rights Reserved.
#*
#*************************************************************************

# edit to match directory level 
PRJ		= ..$/..$/..$/..
# same for all makefiles in "helpcontent2"
PRJNAME = helpcontent2
# edit to match the current package
PACKAGE = text/shared/guide
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = text_shared_guide
# edit to match the current module
MODULE  = shared

# --- Settings -----------------------------------------------------

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

# this list matches the *.xhp files to process
XHPFILES = \
   aaa_start.xhp \
   accessibility.xhp \
   active_help_on_off.xhp \
   activex.xhp \
   assistive.xhp \
   autocorr_url.xhp \
   autohide.xhp \
   background.xhp \
   border_object.xhp \
   border_page.xhp \
   border_paragraph.xhp \
   border_table.xhp \
   breaking_lines.xhp \
   change_title.xhp \
   chart_axis.xhp \
   chart_barformat.xhp \
   chart_insert.xhp \
   chart_legend.xhp \
   chart_title.xhp \
   configure_overview.xhp \
   contextmenu.xhp \
   copy_drawfunctions.xhp \
   copytable2application.xhp \
   copytext2application.xhp \
   ctl.xhp \
   data_addressbook.xhp \
   data_dbase2office.xhp \
   data_enter_sql.xhp \
   data_forms.xhp \
   data_new.xhp \
   data_office2calc.xhp \
   data_queries.xhp \
   data_register.xhp \
   data_report.xhp \
   data_reports.xhp \
   data_search.xhp \
   data_search2.xhp \
   data_tabledefine.xhp \
   data_tables.xhp \
   data_view.xhp \
   database_main.xhp \
   doc_autosave.xhp \
   doc_open.xhp \
   doc_save.xhp \
   dragdrop.xhp \
   dragdrop_beamer.xhp \
   dragdrop_fromgallery.xhp \
   dragdrop_gallery.xhp \
   dragdrop_graphic.xhp \
   dragdrop_table.xhp \
   edit_symbolbar.xhp \
   email.xhp \
   error_report.xhp \
   export_ms.xhp \
   fax.xhp \
   filternavigator.xhp \
   find_attributes.xhp \
   flat_icons.xhp \
   floating_toolbar.xhp \
   fontwork.xhp \
   formfields.xhp \
   gallery_insert.xhp \
   hyperlink_edit.xhp \
   hyperlink_insert.xhp \
   hyperlink_rel_abs.xhp \
   hyperlink_search.xhp \
   import_ms.xhp \
   insert_bitmap.xhp \
   insert_graphic_drawit.xhp \
   insert_specialchar.xhp \
   integratinguno.xhp \
   keyboard.xhp \
   labels.xhp \
   labels_database.xhp \
   language_select.xhp \
   line_intext.xhp \
   lineend_define.xhp \
   linestyle_define.xhp \
   linestyles.xhp \
   macro_recording.xhp \
   main.xhp \
   measurement_units.xhp \
   microsoft_terms.xhp \
   mobiledevicefilters.xhp \
   ms_doctypes.xhp \
   ms_import_export_limitations.xhp \
   ms_user.xhp \
   navigator.xhp \
   navigator_setcursor.xhp \
   navpane_on.xhp \
   numbering_stop.xhp \
   pageformat_max.xhp \
   paintbrush.xhp \
   pasting.xhp \
   print_blackwhite.xhp \
   print_faster.xhp \
   protection.xhp \
   redlining.xhp \
   redlining_accept.xhp \
   redlining_doccompare.xhp \
   redlining_docmerge.xhp \
   redlining_enter.xhp \
   redlining_protect.xhp \
   redlining_versions.xhp \
   round_corner.xhp \
   scripting.xhp \
   space_hyphen.xhp \
   spadmin.xhp \
   standard_template.xhp \
   start_parameters.xhp \
   table_cellmerge.xhp \
   tabs.xhp \
   text_color.xhp \
   textmode_change.xhp \
   undo_formatting.xhp \
   version_number.xhp \
   viewing_file_properties.xhp \
   workfolder.xhp \
   xforms.xhp \
   xsltfilter.xhp 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
