@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Fault Tolerant Heap

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Fault Tolerant Heap
echo.

reg add "HKLM\SOFTWARE\Microsoft\FTH" /v Enabled /t REG_DWORD /d 0 /f
rundll32.exe fthsvc.dll,FthSysprepSpecialize >nul 2>&1

echo.
echo [OK] Готово: Отключить Fault Tolerant Heap
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
