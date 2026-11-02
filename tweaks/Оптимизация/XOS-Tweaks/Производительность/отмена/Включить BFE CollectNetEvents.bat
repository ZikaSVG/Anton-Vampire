@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить BFE CollectNetEvents

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить BFE CollectNetEvents
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Services\BFE\Parameters\Policy\Options" /v CollectNetEvents /f >nul 2>&1

echo.
echo [OK] Отменено: Включить BFE CollectNetEvents
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
