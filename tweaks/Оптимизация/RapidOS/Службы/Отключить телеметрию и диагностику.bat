@echo off
title RapidOS Tweak
:: ---
sc config DiagTrack start= disabled >nul 2>&1
sc stop DiagTrack >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1
sc stop dmwappushservice >nul 2>&1
sc config diagnosticshub.standardcollector.service start= disabled >nul 2>&1
sc stop diagnosticshub.standardcollector.service >nul 2>&1
sc config pla start= disabled >nul 2>&1
sc stop pla >nul 2>&1
sc config WdiServiceHost start= disabled >nul 2>&1
sc stop WdiServiceHost >nul 2>&1
sc config WdiSystemHost start= disabled >nul 2>&1
sc stop WdiSystemHost >nul 2>&1
sc config WerSvc start= disabled >nul 2>&1
sc stop WerSvc >nul 2>&1
:: ---
echo Done.
pause
exit /b
