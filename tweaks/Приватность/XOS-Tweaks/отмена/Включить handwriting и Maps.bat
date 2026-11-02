@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить handwriting и Maps

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить handwriting и Maps
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /v PreventHandwritingErrorReports /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\Maps" /v AutoUpdateEnabled /t REG_DWORD /d 1 /f

echo.
echo [OK] Отменено: Включить handwriting и Maps
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
