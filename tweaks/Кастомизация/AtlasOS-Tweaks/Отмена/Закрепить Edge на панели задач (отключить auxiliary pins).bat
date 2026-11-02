@echo off
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /f >nul 2>&1
