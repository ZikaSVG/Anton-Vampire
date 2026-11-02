@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Включить Emoji Panel

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Включить Emoji Panel
echo.

reg add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v DisableExpressiveInputShellHotkey /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\proc_1\loc_0409" /v DisableExpressiveInputShellHotkey /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Input\Settings" /v EnableExpressiveInputShellHotkey /t REG_DWORD /d 1 /f
taskkill /f /im ctfmon.exe >nul 2>&1
start ctfmon.exe

echo.
echo [OK] Готово: Включить Emoji Panel
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
