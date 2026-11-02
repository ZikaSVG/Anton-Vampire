@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Включить Emoji Panel

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Включить Emoji Panel
echo.

reg add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v DisableExpressiveInputShellHotkey /t REG_DWORD /d 1 /f

echo.
echo [OK] Отменено: Отключить Emoji Panel
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
