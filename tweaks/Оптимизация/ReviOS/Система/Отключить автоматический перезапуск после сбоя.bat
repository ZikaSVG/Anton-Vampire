@echo off
reg add "HKLM\SYSTEM\ControlSet001\Control\CrashControl" /v "AutoReboot" /t REG_DWORD /d "0" /f
