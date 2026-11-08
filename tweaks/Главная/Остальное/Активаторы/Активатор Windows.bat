@echo OFF
title Windows Activator by danL
color 02
echo Choose your Windows version:
echo -----------------------------
echo "pro" - Windows 10 Pro
echo -----------------------------
echo "corp" - Windows 10 Corporation
echo ---------------------------------
set /p a=
if "%a%" == "pro" goto :pro
if "%a%" == "corp" goto :corp
:pro
cls
echo Activation will take up to a minute
slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
timeout 1
slmgr /skms kms8.msguides.com
timeout 1
slmgr /ato
timeout 1
cls
:corp
cls
echo Activation will take up to a minute
slmgr /ipk NPPR9-FWDCX-D2C8J-H872K-2YT43
timeout 1
slmgr /skms kms8.msguides.com
timeout 1
slmgr /ato
timeout 1
cls