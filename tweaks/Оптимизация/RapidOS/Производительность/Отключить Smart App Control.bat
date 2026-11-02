@echo off
title VainOS Tweak
:: ---
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CI\Policy" /v "VerifiedAndReputablePolicyState" /t REG_DWORD /d 0 /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
