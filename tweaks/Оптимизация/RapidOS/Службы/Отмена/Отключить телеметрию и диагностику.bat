@echo off
title RapidOS Tweak
:: ---
sc config DiagTrack start= auto >nul 2>&1
sc start DiagTrack >nul 2>&1
sc config dmwappushservice start= auto >nul 2>&1
sc start dmwappushservice >nul 2>&1
sc config diagnosticshub.standardcollector.service start= demand >nul 2>&1
sc config pla start= demand >nul 2>&1
sc config WdiServiceHost start= demand >nul 2>&1
sc config WdiSystemHost start= demand >nul 2>&1
sc config WerSvc start= demand >nul 2>&1
:: ---
echo Done.
pause
exit /b
