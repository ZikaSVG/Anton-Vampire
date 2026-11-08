@echo off
title RapidOS Tweak
:: ---
reg delete "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontReportInfectionInformation" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\RemovalTools\MpGears" /v "HeartbeatTrackingIndex" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
