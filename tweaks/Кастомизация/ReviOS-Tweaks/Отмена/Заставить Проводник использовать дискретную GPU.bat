@echo off
reg delete "HKCU\Software\Microsoft\DirectX\UserGpuPreferences" /v "C:\\Windows\\explorer.exe" /f >nul 2>&1
reg delete "HKU\.DEFAULT\Software\Microsoft\DirectX\UserGpuPreferences" /v "C:\\Windows\\explorer.exe" /f >nul 2>&1
