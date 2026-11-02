@echo off
title RapidOS Tweak
:: ---
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /v "ShippedWithReserves" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /v "PassedPolicy" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /v "MiscPolicyInfo" /t REG_DWORD /d 1 /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
