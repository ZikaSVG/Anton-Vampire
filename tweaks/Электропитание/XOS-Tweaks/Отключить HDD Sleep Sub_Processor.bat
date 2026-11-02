@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить HDD Sleep Sub_Processor

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить HDD Sleep Sub_Processor
echo.

powercfg /SETACVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1
powercfg /SETDCVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1
powercfg /SETACTIVE SCHEME_CURRENT >nul 2>&1

echo.
echo [OK] Готово: Отключить HDD Sleep Sub_Processor
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
