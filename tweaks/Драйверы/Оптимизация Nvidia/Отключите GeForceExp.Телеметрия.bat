@echo off
@echo.
@echo t.me/DE3NAKE
@echo.

DevManView.exe /disable "NvModuleTracker Device" >nul 2>&1
DevManView.exe /disable "NVIDIA Virtual Audio Device (Wave Extensible) (WDM)" >nul 2>&1

for %%i in (NvTmMon NvTmRep NvProfile NvNodeLauncher NvDriverUpdateCheckDaily "NVIDIA GeForce Experience SelfUpdate*") do for /f "tokens=1 delims=," %%a in ('schtasks /query /fo csv ^| findstr /v "TaskName" ^| findstr "%%~i"') do schtasks /change /tn "%%a" /disable >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\NVIDIA Corporation\Global\GFExperience" /v "NotifyNewDisplayUpdates" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\NVIDIA Corporation\NvTray" /v "StartOnLogin" /t REG_DWORD /d "0" /f >nul 2>&1

exit