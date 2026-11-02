@echo off
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "HideWirelessSetupInOOBE" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "HideWirelessSetupInOOBE" /f >nul 2>&1
