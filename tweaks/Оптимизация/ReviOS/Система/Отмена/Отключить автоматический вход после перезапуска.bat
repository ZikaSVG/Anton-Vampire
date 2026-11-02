@echo off
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableAutomaticRestartSignOn" /f >nul 2>&1
