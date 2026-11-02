@echo off
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSync" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSyncUserOverride" /f >nul 2>&1
