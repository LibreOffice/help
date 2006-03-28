#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: obo $ $Date: 2006-03-28 13:29:04 $
#*
#*    $Revision: 1.10 $
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

.INCLUDE : settings.mk
.INCLUDE : $(PRJ)$/settings.pmk

# this list matches the *.xhp files to process
XHPFILES = \
   address_auto.xhp \
   address_byname.xhp \
   auto_off.xhp \
   autofilter.xhp \
   autoformat.xhp \
   calc_date.xhp \
   calc_series.xhp \
   calc_timevalues.xhp \
   calculate.xhp \
   cell_protect.xhp \
   cell_unprotect.xhp \
   cellcopy.xhp \
   cellreference_dragdrop.xhp \
   cellreferences.xhp \
   cellreferences_url.xhp \
   cellstyle_by_formula.xhp \
   cellstyle_conditional.xhp \
   cellstyle_minusvalue.xhp \
   consolidate.xhp \
   csv_files.xhp \
   csv_formula.xhp \
   currency_format.xhp \
   database_define.xhp \
   database_filter.xhp \
   database_sort.xhp \
   datapilot.xhp \
   datapilot_createtable.xhp \
   datapilot_deletetable.xhp \
   datapilot_edittable.xhp \
   datapilot_filtertable.xhp \
   datapilot_grouping.xhp \
   datapilot_tipps.xhp \
   datapilot_updatetable.xhp \
   dbase_files.xhp \
   design.xhp \
   edit_multitables.xhp \
   filters.xhp \
   format_table.xhp \
   format_value.xhp \
   format_value_userdef.xhp \
   formula_copy.xhp \
   formula_enter.xhp \
   formula_value.xhp \
   formulas.xhp \
   fraction_enter.xhp \
   goalseek.xhp \
   html_doc.xhp \
   integer_leading_zero.xhp \
   keyboard.xhp \
   line_fix.xhp \
   main.xhp \
   mark_cells.xhp \
   matrixformula.xhp \
   multi_tables.xhp \
   multioperation.xhp \
   multitables.xhp \
   note_insert.xhp \
   print_details.xhp \
   print_exact.xhp \
   print_landscape.xhp \
   print_title_row.xhp \
   printranges.xhp \
   relativ_absolut_ref.xhp \
   rename_table.xhp \
   rounding_numbers.xhp \
   row_height.xhp \
   scenario.xhp \
   sorted_list.xhp \
   specialfilter.xhp \
   super_subscript.xhp \
   table_rotate.xhp \
   table_view.xhp \
   text_numbers.xhp \
   text_rotate.xhp \
   text_wrap.xhp \
   userdefined_function.xhp \
   validity.xhp \
   value_with_name.xhp \
   webquery.xhp \
   year2000.xhp 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
