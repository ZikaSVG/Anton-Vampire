@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить BFE CollectNetEvents

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить BFE CollectNetEvents
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Services\BFE\Parameters\Policy\Options" /v CollectNetEvents /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить BFE CollectNetEvents
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
