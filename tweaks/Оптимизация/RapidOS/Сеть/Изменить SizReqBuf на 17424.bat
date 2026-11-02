@echo off
title RapidOS Tweak
:: ---
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "SizReqBuf" /t REG_DWORD /d 17424 /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
