@echo off
reg add "HKLM\SYSTEM\Maps" /v "UpdateOnlyOnWifi" /t REG_DWORD /d "1" /f
