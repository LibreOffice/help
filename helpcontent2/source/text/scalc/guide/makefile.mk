#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: rt $ $Date: 2004-11-26 19:58:37 $
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
PACKAGE = text/scalc/guide
# uniqe name (module wide);
# using a modified form of package should do here
TARGET  = text_scalc_guide
# edit to match the current module
MODULE  = scalc

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xhp files to process
HZIPFILES = \
   address_auto.hzip \
   address_byname.hzip \
   auto_off.hzip \
   autofilter.hzip \
   autoformat.hzip \
   calc_date.hzip \
   calc_series.hzip \
   calc_timevalues.hzip \
   calculate.hzip \
   cell_protect.hzip \
   cell_unprotect.hzip \
   cellcopy.hzip \
   cellreference_dragdrop.hzip \
   cellreferences.hzip \
   cellreferences_url.hzip \
   cellstyle_by_formula.hzip \
   cellstyle_conditional.hzip \
   cellstyle_minusvalue.hzip \
   consolidate.hzip \
   csv_files.hzip \
   csv_formula.hzip \
   currency_format.hzip \
   database_define.hzip \
   database_filter.hzip \
   database_group.hzip \
   database_sort.hzip \
   datapilot.hzip \
   datapilot_createtable.hzip \
   datapilot_deletetable.hzip \
   datapilot_edittable.hzip \
   datapilot_filtertable.hzip \
   datapilot_grouping.hzip \
   datapilot_tipps.hzip \
   datapilot_updatetable.hzip \
   dbase_files.hzip \
   design.hzip \
   edit_multitables.hzip \
   filters.hzip \
   format_table.hzip \
   format_value.hzip \
   format_value_userdef.hzip \
   formula_copy.hzip \
   formula_enter.hzip \
   formula_value.hzip \
   formulas.hzip \
   fraction_enter.hzip \
   goalseek.hzip \
   html_doc.hzip \
   integer_leading_zero.hzip \
   keyboard.hzip \
   line_fix.hzip \
   main.hzip \
   mark_cells.hzip \
   matrixformula.hzip \
   multi_tables.hzip \
   multioperation.hzip \
   multitables.hzip \
   note_insert.hzip \
   print_details.hzip \
   print_exact.hzip \
   print_landscape.hzip \
   print_title_row.hzip \
   printranges.hzip \
   relativ_absolut_ref.hzip \
   rename_table.hzip \
   rounding_numbers.hzip \
   row_height.hzip \
   scenario.hzip \
   sorted_list.hzip \
   specialfilter.hzip \
   super_subscript.hzip \
   table_rotate.hzip \
   table_view.hzip \
   text_numbers.hzip \
   text_rotate.hzip \
   text_wrap.hzip \
   userdefined_function.hzip \
   validity.hzip \
   value_with_name.hzip \
   webquery.hzip \
   year2000.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
