#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: fpe $ $Date: 2004-08-18 11:52:07 $
#*
#*    $Revision: 1.2 $
#*
#*    $Logfile:$
#*
#*    Copyright 2000 Sun Microsystems, Inc. All Rights Reserved.
#*
#*************************************************************************

# edit to match directory level 
PRJ		= ..$/..$/..$/..
# same for all makefiles in "help2"
PRJNAME = help2
# edit to match the current package
PACKAGE = text/shared/guide
# uniqe name (module wide);
# using a modified forme of package should do here
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
    data_office2calc.hzip \
    data_report.hzip \
    data_search.hzip \
    data_search2.hzip \
    data_tabledefine.hzip \
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
    flat_icons.hzip \
    floating_toolbar.hzip \
    formfields.hzip \
    functionbar_edit.hzip \
    gallery_insert.hzip \
    hyperlink_edit.hzip \
    hyperlink_insert.hzip \
    hyperlink_rel_abs.hzip \
    hyperlink_search.hzip \
    import_ms.hzip \
    insert_bitmap.hzip \
    insert_graphic_drawit.hzip \
    insert_specialchar.hzip \
    install_change.hzip \
    install_repair.hzip \
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
    ms_import_export_limitations.hzip \
    ms_user.hzip \
    navigator.hzip \
    navigator_setcursor.hzip \
    navpane_on.hzip \
    numbering_stop.hzip \
    pageformat_max.hzip \
    paintbrush.hzip \
    print_blackwhite.hzip \
    print_faster.hzip \
    protection.hzip \
    quicklaunch.hzip \
    redlining.hzip \
    redlining_accept.hzip \
    redlining_doccompare.hzip \
    redlining_docmerge.hzip \
    redlining_enter.hzip \
    redlining_protect.hzip \
    redlining_versions.hzip \
    round_corner.hzip \
    space_hyphen.hzip \
    spadmin.hzip \
    standard_template.hzip \
    start_parameters.hzip \
    symbolbar_switch.hzip \
    table_cellmerge.hzip \
    tabs.hzip \
    text_color.hzip \
    textmode_change.hzip \
    undo_formatting.hzip \
    url_autocomplete.hzip \
    url_open.hzip \
    version_number.hzip \
    viewing_file_properties.hzip \
    workfolder.hzip \
    xsltfilter.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
