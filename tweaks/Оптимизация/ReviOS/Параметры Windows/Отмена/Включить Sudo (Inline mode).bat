@echo off
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Sudo" /v "Enabled" /f >nul 2>&1
