#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: fpe $ $Date: 2004-08-18 10:59:34 $
#*
#*    $Revision: 1.1 $
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
PACKAGE = text/swriter/guide
# uniqe name (module wide);
# using a modified forme of package should do here
TARGET  = text_swriter_guide
# edit to match the current module
MODULE  = swriter

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xml files to process
HZIPFILES = \
    anchor_object.hzip \
    arrange_chapters.hzip \
    auto_numbering.hzip \
    auto_off.hzip \
    auto_spellcheck.hzip \
    autocorr_except.hzip \
    autotext.hzip \
    calculate.hzip \
    calculate_clipboard.hzip \
    calculate_intable.hzip \
    calculate_intext.hzip \
    calculate_intext2.hzip \
    calculate_multitable.hzip \
    captions.hzip \
    captions_numbers.hzip \
    change_header.hzip \
    chapter_numbering.hzip \
    conditional_text.hzip \
    conditional_text2.hzip \
    delete_from_dict.hzip \
    dragdroptext.hzip \
    even_odd_sdw.hzip \
    field_convert.hzip \
    fields.hzip \
    fields_date.hzip \
    fields_enter.hzip \
    fields_userdata.hzip \
    fontwork.hzip \
    footer_nextpage.hzip \
    footer_pagenumber.hzip \
    footnote_usage.hzip \
    footnote_with_line.hzip \
    form_letters_main.hzip \
    globaldoc.hzip \
    header_footer.hzip \
    header_pagestyles.hzip \
    header_with_chapter.hzip \
    header_with_line.hzip \
    hidden_text.hzip \
    hyperlinks.hzip \
    import_bulletlist.hzip \
    indices_delete.hzip \
    indices_edit.hzip \
    indices_enter.hzip \
    indices_form.hzip \
    indices_index.hzip \
    indices_literature.hzip \
    indices_multidoc.hzip \
    indices_toc.hzip \
    indices_userdef.hzip \
    insert_beforetable.hzip \
    insert_graphic.hzip \
    insert_graphic_dialog.hzip \
    insert_graphic_fromchart.hzip \
    insert_graphic_fromdraw.hzip \
    insert_graphic_gallery.hzip \
    insert_graphic_scan.hzip \
    insert_line.hzip \
    insert_tab_innumbering.hzip \
    join_numbered_lists.hzip \
    jump2statusbar.hzip \
    keyboard.hzip \
    link_edit.hzip \
    load_styles.hzip \
    main.hzip \
    navigator.hzip \
    number_date_conv.hzip \
    number_sequence.hzip \
    numbering_lines.hzip \
    numbering_paras.hzip \
    page_break.hzip \
    pagebackground.hzip \
    pageorientation.hzip \
    pagestyles.hzip \
    para_style_quickuse.hzip \
    print_preview.hzip \
    print_small.hzip \
    printer_tray.hzip \
    printing_order.hzip \
    references.hzip \
    references_modify.hzip \
    registertrue.hzip \
    removing_line_breaks.hzip \
    reset_format.hzip \
    resize_navigator.hzip \
    search_regexp.hzip \
    section_edit.hzip \
    section_insert.hzip \
    sections.hzip \
    select_language.hzip \
    send2html.hzip \
    shortcut_writing.hzip \
    spellcheck_dialog.hzip \
    stylist_fillformat.hzip \
    stylist_fromselect.hzip \
    stylist_update.hzip \
    subscript.hzip \
    table_cells.hzip \
    table_delete.hzip \
    table_insert.hzip \
    table_repeat_multiple_headers.hzip \
    table_sizing.hzip \
    tablemode.hzip \
    template_create.hzip \
    template_default.hzip \
    templates_styles.hzip \
    text_along_line.hzip \
    text_animation.hzip \
    text_capital.hzip \
    text_centervert.hzip \
    text_direct_cursor.hzip \
    text_emphasize.hzip \
    text_frame.hzip \
    text_nav_keyb.hzip \
    text_rotate.hzip \
    textdoc_inframe.hzip \
    using_hyphen.hzip \
    using_numbered_lists.hzip \
    using_numbered_lists2.hzip \
    using_numbering.hzip \
    using_thesaurus.hzip \
    word_completion.hzip \
    words_count.hzip \
    wrap.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
