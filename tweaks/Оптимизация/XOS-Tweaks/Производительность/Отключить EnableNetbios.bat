@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить EnableNetbios

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить EnableNetbios
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v EnableNetbios /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить EnableNetbios
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
