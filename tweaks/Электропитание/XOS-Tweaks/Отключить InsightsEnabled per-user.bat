@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить InsightsEnabled per-user

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить InsightsEnabled per-user
echo.

for /f "usebackq delims=" %%s in (`reg query HKU 2^>nul ^| findstr /r "S-1-5-21-[0-9]*-[0-9]*-[0-9]*$"`) do reg add "%%s\Software\Microsoft\input\Settings" /v InsightsEnabled /t REG_DWORD /d 0 /f >nul 2>&1

echo.
echo [OK] Готово: Отключить InsightsEnabled per-user
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
