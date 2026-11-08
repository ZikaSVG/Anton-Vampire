@echo off
taskkill /f /im OneDrive.exe > nul 2>&1
for %%a in ("%windir%\System32\OneDriveSetup.exe" "%windir%\SysWOW64\OneDriveSetup.exe") do (
    if exist "%%a" "%%a" /uninstall > nul 2>&1
)
rmdir /q /s "%ProgramData%\Microsoft OneDrive" > nul 2>&1
rmdir /q /s "%LOCALAPPDATA%\Microsoft\OneDrive" > nul 2>&1
for /f "usebackq delims=" %%a in (`dir /b /a:d "%SystemDrive%\Users"`) do (
    rmdir /q /s "%SystemDrive%\Users\%%a\AppData\Local\Microsoft\OneDrive" > nul 2>&1
    rmdir /q /s "%SystemDrive%\Users\%%a\OneDrive" > nul 2>&1
    del /q /f "%SystemDrive%\Users\%%a\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" > nul 2>&1
)
for /f "usebackq delims=" %%a in (`reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SyncRootManager" ^| findstr /i /c:"OneDrive"`) do reg delete "%%a" /f > nul 2>&1
