@echo off
reg add "HKLM\SYSTEM\CurrentControlSet\Services\rdyboost" /v "Start" /t REG_DWORD /d "0" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" /v "Start" /t REG_DWORD /d "2" /f >nul
