@echo off
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSync" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSyncUserOverride" /f >nul 2>&1
