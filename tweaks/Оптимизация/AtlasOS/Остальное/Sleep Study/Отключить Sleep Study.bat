@echo off
wevtutil sl "Microsoft-Windows-SleepStudy/Diagnostic" /q:false >nul
wevtutil sl "Microsoft-Windows-Kernel-Processor-Power/Diagnostic" /q:false >nul
wevtutil sl "Microsoft-Windows-UserModePowerService/Diagnostic" /q:false >nul
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /disable >nul
