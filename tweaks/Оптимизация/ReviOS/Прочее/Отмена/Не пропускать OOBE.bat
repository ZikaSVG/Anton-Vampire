@echo off
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "SkipMachineOOBE" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "SkipMachineOOBE" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "SkipUserOOBE" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "SkipUserOOBE" /f >nul 2>&1
