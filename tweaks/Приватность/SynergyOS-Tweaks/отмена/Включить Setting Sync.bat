@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Setting Sync

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Отключить Setting Sync
echo.

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\settingSync" /v "SyncPolicy" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\settingSync\Groups\Accessibility" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\settingSync\Groups\AppSync" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\settingSync\Groups\Browsersettings" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\settingSync\Groups\Credentials" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\settingSync\Groups\DesktopTheme" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\settingSync\Groups\Language" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\settingSync\Groups\PackageState" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\settingSync\Groups\Personalization" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\settingSync\Groups\StartLayout" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\settingSync\Groups\Windows" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisablesettingSync" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisablesettingSyncUserOverride" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableAppSyncsettingSync" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableAppSyncsettingSyncUserOverride" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableApplicationsettingSync" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableApplicationsettingSyncUserOverride" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableCredentialssettingSync" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableCredentialssettingSyncUserOverride" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableDesktopThemesettingSync" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableDesktopThemesettingSyncUserOverride" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisablePersonalizationsettingSync" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisablePersonalizationsettingSyncUserOverride" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableStartLayoutsettingSync" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableStartLayoutsettingSyncUserOverride" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableSyncOnPaidNetwork" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableWebBrowsersettingSync" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableWebBrowsersettingSyncUserOverride" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableWindowssettingSync" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\settingSync" /v "DisableWindowssettingSyncUserOverride" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Setting Sync
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
