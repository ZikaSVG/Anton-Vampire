@echo off
title VainOS Tweak
:: ---
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "DisableBandwidthThrottling" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
