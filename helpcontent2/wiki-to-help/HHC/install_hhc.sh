#!/bin/bash -e
# -e  Exit immediately if a command exits with a non-zero status.

# This installs Microsofts HHC (HTML Help Compiler)
# Copyright 2011 Timo Richter and others.
# Licensed under GNU GPLv3
# Depends on: wine, wget, cabextract
#
# Usage of HHC: wine c:\\htmlhelp\\hhc.exe c:\\test\\htmlhelp.hhp
#
# Changes:  Set installation directory to c:\htmlhelp
#           Copy also itcc.dll, this is neccessary
#           No execution of htmlhelp.exe installer needed
#           Abortion of install if anything fails, e.g. the download of HHC.
#

which wine > /dev/null 2>&1 || { echo "Please install 'wine'." ; exit 1 ; }
which cabextract > /dev/null 2>&1 || { echo "Please install 'cabextract'." ; exit 1 ; }
which wget > /dev/null 2>&1 || { echo "Please install 'wget'." ; exit 1 ; }

echo "Going to install hhc.exe to your wine installation..."

cd "$(dirname $0)" # cd to path of this script

WINEPREFIX=${WINEPREFIX:=$HOME/.wine}
test -d "$WINEPREFIX" || winecfg
HHDIR="${WINEPREFIX}/dosdevices/c:/htmlhelp"
mkdir -p "$HHDIR"

# Setup the registry
# Set Wine's Windows version to Windows 2000 (or above), and add an override to use the native itss.dll, both via winecfg.
wine regedit htmlhelp.reg

cd "$HHDIR"

# Install HTML Help Workshop
wget -O htmlhelp.exe 'http://go.microsoft.com/fwlink/?LinkId=14188'

# unneccessary
#wine htmlhelp.exe

cabextract -F hhc.exe htmlhelp.exe
cabextract -F HHA.dll htmlhelp.exe

# Install ITSS.DLL
cabextract -F hhupd.exe htmlhelp.exe
cabextract -F itircl.dll hhupd.exe
cabextract -F itss.dll hhupd.exe
cabextract -F itcc.dll htmlhelp.exe
cabextract -F hhctrl.ocx hhupd.exe
cp -a itircl.dll "$WINEPREFIX/drive_c/windows/system32/"
cp -a itcc.dll "$WINEPREFIX/drive_c/windows/system32/"
cp -a itss.dll "$WINEPREFIX/drive_c/windows/system32/"
cp -a hhctrl.ocx "$WINEPREFIX/drive_c/windows/system32/"
wine regsvr32 'C:\WINDOWS\SYSTEM32\itcc.dll'
wine regsvr32 'C:\WINDOWS\SYSTEM32\itircl.dll'
wine regsvr32 'C:\WINDOWS\SYSTEM32\itss.dll'
wine regsvr32 'C:\WINDOWS\SYSTEM32\hhctrl.ocx'

# Install MFC40.DLL
wget -N http://activex.microsoft.com/controls/vc/mfc40.cab
cabextract -F mfc40.exe mfc40.cab
cabextract -F mfc40.dll mfc40.exe
cp -a mfc40.dll "$WINEPREFIX/drive_c/windows/system32/"

echo
echo Done, hhc.exe installed.

exit 0
