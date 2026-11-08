@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Xbox Live Services

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Xbox Live Services
echo.

sc config XblAuthManager start= disabled >nul 2>&1
sc stop XblAuthManager >nul 2>&1
sc config XblGameSave start= disabled >nul 2>&1
sc stop XblGameSave >nul 2>&1
sc config XboxNetApiSvc start= disabled >nul 2>&1
sc stop XboxNetApiSvc >nul 2>&1

echo.
echo [OK] Готово: Отключить Xbox Live Services
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
