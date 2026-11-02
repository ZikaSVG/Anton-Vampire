@echo off
title VainOS Tweak
:: ---
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\CI\Policy" /v "VerifiedAndReputablePolicyState" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
