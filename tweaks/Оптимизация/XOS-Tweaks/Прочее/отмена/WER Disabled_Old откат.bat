@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: WER Disabled_Old rename

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] WER Disabled_Old rename
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled_Old /f >nul 2>&1

echo.
echo [OK] Отменено: WER Disabled_Old откат
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
