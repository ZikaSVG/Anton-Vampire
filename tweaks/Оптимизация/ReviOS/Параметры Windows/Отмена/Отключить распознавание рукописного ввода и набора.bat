@echo off
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\TextInput" /v "AllowLinguisticDataCollection" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Input\TIPC" /v "Enabled" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /f >nul 2>&1
