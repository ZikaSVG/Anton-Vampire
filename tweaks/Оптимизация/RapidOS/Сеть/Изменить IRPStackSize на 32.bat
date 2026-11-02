@echo off
title RapidOS Tweak
:: ---
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "IRPStackSize" /t REG_DWORD /d 32 /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
