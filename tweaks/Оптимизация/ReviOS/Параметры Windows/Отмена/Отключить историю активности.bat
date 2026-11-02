@echo off
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /f >nul 2>&1
