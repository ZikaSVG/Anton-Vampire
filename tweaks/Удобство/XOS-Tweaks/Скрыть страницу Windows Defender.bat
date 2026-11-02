@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Скрыть страницу Windows Defender

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Скрыть страницу Windows Defender
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v SettingsPageVisibility /t REG_SZ /d "hide:windowsdefender" /f

echo.
echo [OK] Готово: Скрыть страницу Windows Defender
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
