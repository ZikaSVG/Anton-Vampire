@echo off
title VainOS Tweak
:: ---
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "AutoReboot" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "CrashDumpEnabled" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "LogEvent" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "DisplayParameters" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl\StorageTelemetry" /v "DeviceDumpEnabled" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
