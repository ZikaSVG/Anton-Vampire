@echo off
reg add "HKLM\Software\Policies\Microsoft\Windows\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "0" /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "1" /f >nul
