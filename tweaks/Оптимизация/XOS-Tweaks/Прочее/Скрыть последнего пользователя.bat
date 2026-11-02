@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Скрыть последнего пользователя

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Скрыть последнего пользователя
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v dontdisplaylastusername /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v dontdisplaylastusername /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Скрыть последнего пользователя
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
