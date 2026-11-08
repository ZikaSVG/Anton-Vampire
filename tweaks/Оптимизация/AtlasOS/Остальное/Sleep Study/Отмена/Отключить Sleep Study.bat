@echo off
wevtutil sl "Microsoft-Windows-SleepStudy/Diagnostic" /q:true >nul
wevtutil sl "Microsoft-Windows-Kernel-Processor-Power/Diagnostic" /q:true >nul
wevtutil sl "Microsoft-Windows-UserModePowerService/Diagnostic" /q:true >nul
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /enable >nul
