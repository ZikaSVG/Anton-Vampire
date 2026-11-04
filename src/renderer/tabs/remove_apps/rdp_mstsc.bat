@echo off
PowerShell "Start-Process mstsc.exe -ArgumentList '/uninstall' -WindowStyle Hidden -ErrorAction SilentlyContinue"
timeout /t 5 /nobreak >nul 2>&1
taskkill /f /im mstsc.exe >nul 2>&1
