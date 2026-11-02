@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить HDD Sleep Sub_Processor

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить HDD Sleep Sub_Processor
echo.

powercfg /SETACVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 1 >nul 2>&1

echo.
echo [OK] Отменено: Включить HDD Sleep
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
