@echo off
reg add "HKLM\SYSTEM\ControlSet001\Control\CrashControl" /v "CrashDumpEnabled" /t REG_DWORD /d "3" /f
