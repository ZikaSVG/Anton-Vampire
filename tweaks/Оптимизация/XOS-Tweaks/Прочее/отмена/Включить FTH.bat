@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Fault Tolerant Heap

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Fault Tolerant Heap
echo.

reg add "HKLM\SOFTWARE\Microsoft\FTH" /v Enabled /t REG_DWORD /d 1 /f

echo.
echo [OK] Отменено: Включить FTH
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
