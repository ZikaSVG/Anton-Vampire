@echo off
wevtutil.exe set-log "Microsoft-Windows-SleepStudy/Diagnostic" /e:true >nul 2>&1
wevtutil.exe set-log "Microsoft-Windows-Kernel-Processor-Power/Diagnostic" /e:true >nul 2>&1
wevtutil.exe set-log "Microsoft-Windows-UserModePowerService/Diagnostic" /e:true >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /enable >nul 2>&1
