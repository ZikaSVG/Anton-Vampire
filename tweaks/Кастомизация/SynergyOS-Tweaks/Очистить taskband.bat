@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Очистить taskband

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Очистить taskband
echo.

taskkill /f /im explorer.exe >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /f >nul 2>&1
del /f /q "%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*" >nul 2>&1
start explorer.exe >nul 2>&1

echo.
echo [OK] Готово: Очистить taskband
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
