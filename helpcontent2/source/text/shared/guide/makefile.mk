#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: rt $ $Date: 2004-11-26 22:28:03 $
#*
#*    $Revision: 1.4 $
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

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xhp files to process
HZIPFILES = \
   aaa_start.hzip \
   accessibility.hzip \
   active_help_on_off.hzip \
   activex.hzip \
   assistive.hzip \
   autocorr_url.hzip \
   autohide.hzip \
   background.hzip \
   border_object.hzip \
   border_page.hzip \
   border_paragraph.hzip \
   border_table.hzip \
   breaking_lines.hzip \
   change_title.hzip \
   chart_axis.hzip \
   chart_barformat.hzip \
   chart_insert.hzip \
   chart_legend.hzip \
   chart_title.hzip \
   configure_overview.hzip \
   contextmenu.hzip \
   copy_drawfunctions.hzip \
   copytable2application.hzip \
   copytext2application.hzip \
   ctl.hzip \
   data_addressbook.hzip \
   data_dbase2office.hzip \
   data_enter_sql.hzip \
   data_forms.hzip \
   data_new.hzip \
   data_office2calc.hzip \
   data_queries.hzip \
   data_register.hzip \
   data_report.hzip \
   data_reports.hzip \
   data_search.hzip \
   data_search2.hzip \
   data_tabledefine.hzip \
   data_tables.hzip \
   data_view.hzip \
   database_main.hzip \
   doc_autosave.hzip \
   doc_open.hzip \
   doc_save.hzip \
   dragdrop.hzip \
   dragdrop_beamer.hzip \
   dragdrop_fromgallery.hzip \
   dragdrop_gallery.hzip \
   dragdrop_graphic.hzip \
   dragdrop_table.hzip \
   edit_symbolbar.hzip \
   email.hzip \
   error_report.hzip \
   export_ms.hzip \
   fax.hzip \
   filternavigator.hzip \
   find_attributes.hzip \
   flat_icons.hzip \
   floating_toolbar.hzip \
   fontwork.hzip \
   formfields.hzip \
   gallery_insert.hzip \
   hyperlink_edit.hzip \
   hyperlink_insert.hzip \
   hyperlink_rel_abs.hzip \
   hyperlink_search.hzip \
   import_ms.hzip \
   insert_bitmap.hzip \
   insert_graphic_drawit.hzip \
   insert_specialchar.hzip \
   integratinguno.hzip \
   keyboard.hzip \
   labels.hzip \
   labels_database.hzip \
   language_select.hzip \
   line_intext.hzip \
   lineend_define.hzip \
   linestyle_define.hzip \
   linestyles.hzip \
   macro_recording.hzip \
   main.hzip \
   measurement_units.hzip \
   microsoft_terms.hzip \
   mobiledevicefilters.hzip \
   ms_doctypes.hzip \
   ms_import_export_limitations.hzip \
   ms_user.hzip \
   navigator.hzip \
   navigator_setcursor.hzip \
   navpane_on.hzip \
   numbering_stop.hzip \
   pageformat_max.hzip \
   paintbrush.hzip \
   pasting.hzip \
   print_blackwhite.hzip \
   print_faster.hzip \
   protection.hzip \
   redlining.hzip \
   redlining_accept.hzip \
   redlining_doccompare.hzip \
   redlining_docmerge.hzip \
   redlining_enter.hzip \
   redlining_protect.hzip \
   redlining_versions.hzip \
   round_corner.hzip \
   scripting.hzip \
   space_hyphen.hzip \
   spadmin.hzip \
   standard_template.hzip \
   start_parameters.hzip \
   table_cellmerge.hzip \
   tabs.hzip \
   text_color.hzip \
   textmode_change.hzip \
   undo_formatting.hzip \
   version_number.hzip \
   viewing_file_properties.hzip \
   workfolder.hzip \
   xforms.hzip \
   xsltfilter.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
