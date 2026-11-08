@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить FTH

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить FTH
echo.

reg add "HKLM\SOFTWARE\Microsoft\FTH" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить FTH
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
