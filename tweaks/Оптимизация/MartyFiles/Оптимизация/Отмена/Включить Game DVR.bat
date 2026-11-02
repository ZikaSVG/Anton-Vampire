@echo off
reg add "HKCR\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 1 /f >nul
reg add "HKCR\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "Value" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 1 /f >nul
