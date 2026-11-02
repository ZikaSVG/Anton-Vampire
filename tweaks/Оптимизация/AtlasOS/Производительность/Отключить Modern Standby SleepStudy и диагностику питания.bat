@echo off
wevtutil.exe set-log "Microsoft-Windows-SleepStudy/Diagnostic" /e:false >nul 2>&1
wevtutil.exe set-log "Microsoft-Windows-Kernel-Processor-Power/Diagnostic" /e:false >nul 2>&1
wevtutil.exe set-log "Microsoft-Windows-UserModePowerService/Diagnostic" /e:false >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /disable >nul 2>&1
