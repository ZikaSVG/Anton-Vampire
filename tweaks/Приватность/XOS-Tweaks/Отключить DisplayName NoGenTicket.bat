@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить DisplayName NoGenTicket

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить DisplayName NoGenTicket
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v dontdisplaylastusername /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v dontdisplaylastusername /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить DisplayName NoGenTicket
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
