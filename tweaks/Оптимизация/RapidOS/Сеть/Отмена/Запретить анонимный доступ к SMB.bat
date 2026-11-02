@echo off
title RapidOS Tweak
:: ---
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /v "RestrictNullSessAccess" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
