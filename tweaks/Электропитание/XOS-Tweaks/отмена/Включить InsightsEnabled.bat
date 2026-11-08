@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить InsightsEnabled per-user

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить InsightsEnabled per-user
echo.

for /f "usebackq delims=" %%s in (`reg query HKU 2^>nul ^| findstr /r "S-1-5-21-[0-9]*-[0-9]*-[0-9]*$"`) do reg add "%%s\Software\Microsoft\input\Settings" /v InsightsEnabled /t REG_DWORD /d 1 /f >nul 2>&1

echo.
echo [OK] Отменено: Включить InsightsEnabled
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
