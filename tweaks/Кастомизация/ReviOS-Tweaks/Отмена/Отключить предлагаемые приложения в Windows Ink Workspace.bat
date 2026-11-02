@echo off
reg delete "HKLM\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" /v "AllowSuggestedAppsInWindowsInkWorkspace" /f >nul 2>&1
