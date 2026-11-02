@echo off
title VainOS Tweak
:: ---
wevtutil sl "Microsoft-Windows-SleepStudy/Diagnostic" /q:true >nul 2>&1
wevtutil sl "Microsoft-Windows-Kernel-Processor-Power/Diagnostic" /q:true >nul 2>&1
wevtutil sl "Microsoft-Windows-UserModePowerService/Diagnostic" /q:true >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /enable >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "SleepStudyDisabled" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
