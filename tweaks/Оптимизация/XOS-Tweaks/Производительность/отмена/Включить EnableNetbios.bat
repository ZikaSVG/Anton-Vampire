@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить EnableNetbios

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить EnableNetbios
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v EnableNetbios /t REG_DWORD /d 1 /f

echo.
echo [OK] Отменено: Включить EnableNetbios
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
