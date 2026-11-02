@echo off
reg add "HKLM\SYSTEM\CurrentControlSet\Services\rdyboost" /v "Start" /t REG_DWORD /d "4" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" /v "Start" /t REG_DWORD /d "4" /f >nul
