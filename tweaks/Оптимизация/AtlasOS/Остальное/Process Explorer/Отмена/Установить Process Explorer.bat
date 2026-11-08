@echo off
winget uninstall -e --id Microsoft.Sysinternals.ProcessExplorer --force --purge --disable-interactivity --accept-source-agreements -h >nul
sc config pcw start=boot >nul
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskmgr.exe" /v "Debugger" /f >nul 2>&1
del /f /q "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Process Explorer.lnk" >nul 2>&1
