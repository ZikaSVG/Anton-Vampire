@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить CEIP и SQM

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить CEIP и SQM
echo.

reg add "HKLM\Software\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 1 /f

echo.
echo [OK] Отменено: Включить CEIP и SQM
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
