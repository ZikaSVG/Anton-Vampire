@echo off
taskkill /f /im OneDrive.exe >nul 2>&1
%SystemRoot%\System32\OneDriveSetup.exe /uninstall >nul 2>&1
for %%P in ("%LocalAppData%\OneDrive" "%ProgramData%\Microsoft OneDrive" "%UserProfile%\OneDrive" "%LocalAppData%\Microsoft\OneDrive") do rd /s /q "%%P" >nul 2>&1
for /d %%i in ("%SystemRoot%\WinSxS\amd64_microsoft-windows-onedrive-setup*") do rd /s /q "%%i" >nul 2>&1
for %%F in ("OneDriveSetup.exe" "OneDrive.ico") do del /q "%SystemRoot%\System32\%%F" >nul 2>&1
reg delete "HKCU\Software\Microsoft\OneDrive" /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\OneDrive" /f >nul 2>&1
