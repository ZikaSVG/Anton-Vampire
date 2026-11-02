@echo off
reg delete "HKLM\Software\Policies\Microsoft\Windows\DriverSearching" /v "SearchOrderConfig" /f >nul 2>&1
reg delete "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /f >nul 2>&1
