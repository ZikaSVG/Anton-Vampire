@echo off
title RapidOS Tweak
:: ---
for %%p in (audiodg dwm lsass ntoskrnl SearchIndexer svchost TrustedInstaller wuauclt) do (
    reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%p.exe\PerfOptions" /f >nul 2>&1
)
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /v "PassiveIntRealTimeWorkerPriority" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\KernelVelocity" /v "DisableFGBoostDecay" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\services\USBHUB3\Parameters" /v "ThreadPriority" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\services\USBXHCI\Parameters" /v "ThreadPriority" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "ThreadPriority" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "ThreadPriority" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
