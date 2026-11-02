@echo off
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSyncOnPaidNetwork" /f >nul 2>&1
