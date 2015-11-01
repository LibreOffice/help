#!/bin/bash

zip -r sbasic.jar text/sbasic/
zip -r scalc.jar text/scalc/
zip -r schart.jar text/schart/
zip -r sdraw.jar text/sdraw/
zip -r shared.jar text/shared/
zip -r simpress.jar text/simpress/
zip -r smath.jar text/smath/
zip -r swriter.jar text/swriter/

mv -f *.jar /home/jay/Desktop/LibO_betas/LibreOfficeDev_5.1.0.0.alpha1_Linux_x86-64_deb/install/opt/libreofficedev5.1/help/en-US/
