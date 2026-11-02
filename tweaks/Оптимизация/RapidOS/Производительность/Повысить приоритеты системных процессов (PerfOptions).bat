@echo off
title RapidOS Tweak
:: ---
for %%p in (audiodg dwm lsass ntoskrnl SearchIndexer svchost TrustedInstaller wuauclt) do (
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%p.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 2 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%p.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 1 /f >nul 2>&1
)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /v "PassiveIntRealTimeWorkerPriority" /t REG_DWORD /d 18 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\KernelVelocity" /v "DisableFGBoostDecay" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\services\USBHUB3\Parameters" /v "ThreadPriority" /t REG_DWORD /d 15 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\services\USBXHCI\Parameters" /v "ThreadPriority" /t REG_DWORD /d 15 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "ThreadPriority" /t REG_DWORD /d 31 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "ThreadPriority" /t REG_DWORD /d 31 /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
