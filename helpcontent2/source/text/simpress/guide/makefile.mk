#*************************************************************************
#*
#*    $Workfile:$
#*
#*    Creation date     KR 28.06.99
#*    last change       $Author: fpe $ $Date: 2004-08-18 10:58:19 $
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
PACKAGE = text/simpress/guide
# uniqe name (module wide);
# using a modified forme of package should do here
TARGET  = text_simpress_guide
# edit to match the current module
MODULE  = simpress

# --- Settings -----------------------------------------------------

.INCLUDE : $(PRJ)$/settings.pmk
.INCLUDE : settings.mk

# this list matches the *.xml files to process
HZIPFILES = \
    3d_create.hzip \
    animated_gif_create.hzip \
    animated_gif_save.hzip \
    animated_objects.hzip \
    animated_slidechange.hzip \
    arrange_slides.hzip \
    background.hzip \
    change_scale.hzip \
    footer.hzip \
    html_export.hzip \
    html_import.hzip \
    individual.hzip \
    keyboard.hzip \
    layer_move.hzip \
    layer_new.hzip \
    layer_tipps.hzip \
    layers.hzip \
    line_arrow_styles.hzip \
    line_draw.hzip \
    line_edit.hzip \
    livemode.hzip \
    main.hzip \
    masterpage.hzip \
    move_object.hzip \
    orgchart.hzip \
    page_copy.hzip \
    palette_files.hzip \
    print_tofit.hzip \
    printing.hzip \
    rehearse_timings.hzip \
    select_object.hzip \
    table_insert.hzip \
    text2curve.hzip \
    vectorize.hzip 
    
# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
.INCLUDE : $(PRJ)$/makefile.pmk
