@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Setting Sync

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Отключить Setting Sync
echo.

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\settingSync" /v "SyncPolicy" /t REG_DWORD /d "5" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\settingSync\Groups\Accessibility" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\settingSync\Groups\AppSync" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\settingSync\Groups\Browsersettings" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\settingSync\Groups\Credentials" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\settingSync\Groups\DesktopTheme" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\settingSync\Groups\Language" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\settingSync\Groups\PackageState" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\settingSync\Groups\Personalization" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\settingSync\Groups\StartLayout" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\settingSync\Groups\Windows" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisablesettingSync" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisablesettingSyncUserOverride" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableAppSyncsettingSync" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableAppSyncsettingSyncUserOverride" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableApplicationsettingSync" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableApplicationsettingSyncUserOverride" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableCredentialssettingSync" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableCredentialssettingSyncUserOverride" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableDesktopThemesettingSync" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableDesktopThemesettingSyncUserOverride" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisablePersonalizationsettingSync" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisablePersonalizationsettingSyncUserOverride" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableStartLayoutsettingSync" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableStartLayoutsettingSyncUserOverride" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableSyncOnPaidNetwork" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableWebBrowsersettingSync" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableWebBrowsersettingSyncUserOverride" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableWindowssettingSync" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableWindowssettingSyncUserOverride" /t REG_DWORD /d "1" /f >nul 2>&1

echo.
echo [OK] Готово: Отключить Setting Sync
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
