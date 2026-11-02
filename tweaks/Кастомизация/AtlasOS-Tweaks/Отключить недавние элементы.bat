@echo off
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoInstrumentation" /t REG_DWORD /d "1" /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "ClearRecentDocsOnExit" /t REG_DWORD /d "1" /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoRecentDocsHistory" /t REG_DWORD /d "1" /f >nul
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoRemoteDestinations" /t REG_DWORD /d "1" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoStartMenuMFUprogramsList" /t REG_DWORD /d "1" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoRecentDocsHistory" /t REG_DWORD /d "1" /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "ShowOrHideMostUsedApps" /t REG_DWORD /d "1" /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "HideRecentlyAddedApps" /t REG_DWORD /d "1" /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d "0" /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d "0" /f >nul
taskkill /f /im explorer.exe >nul 2>&1
taskkill /f /im SettingsApp.exe >nul 2>&1
start explorer.exe
