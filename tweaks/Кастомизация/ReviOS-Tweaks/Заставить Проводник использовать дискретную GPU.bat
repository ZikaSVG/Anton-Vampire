@echo off
reg add "HKCU\Software\Microsoft\DirectX\UserGpuPreferences" /v "C:\\Windows\\explorer.exe" /t REG_SZ /d "GpuPreference=2;" /f
reg add "HKU\.DEFAULT\Software\Microsoft\DirectX\UserGpuPreferences" /v "C:\\Windows\\explorer.exe" /t REG_SZ /d "GpuPreference=2;" /f
