@echo off
title VainOS Tweak
:: ---
wevtutil sl "Microsoft-Windows-SleepStudy/Diagnostic" /q:false >nul 2>&1
wevtutil sl "Microsoft-Windows-Kernel-Processor-Power/Diagnostic" /q:false >nul 2>&1
wevtutil sl "Microsoft-Windows-UserModePowerService/Diagnostic" /q:false >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /disable >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "SleepStudyDisabled" /t REG_DWORD /d 1 /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
