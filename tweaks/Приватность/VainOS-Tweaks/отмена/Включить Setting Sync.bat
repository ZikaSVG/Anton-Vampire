@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Setting Sync

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить Setting Sync
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSyncOnPaidNetwork" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWindowsSettingSync" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSync" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSyncUserOverride" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSync" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSyncUserOverride" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSync" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSyncUserOverride" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSync" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSyncUserOverride" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSync" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSyncUserOverride" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSync" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSyncUserOverride" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Setting Sync
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
