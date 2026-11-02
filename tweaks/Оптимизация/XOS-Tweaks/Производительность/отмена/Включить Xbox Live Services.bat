@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Xbox Live Services

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Xbox Live Services
echo.

sc config XblAuthManager start= demand >nul 2>&1
sc config XblGameSave start= demand >nul 2>&1
sc config XboxNetApiSvc start= demand >nul 2>&1

echo.
echo [OK] Отменено: Включить Xbox Live Services
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
