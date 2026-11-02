@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить GameBarPresenceWriter

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Отключить GameBarPresenceWriter
echo.

taskkill /f /im GameBarPresenceWriter.exe >nul 2>&1
takeown /f "%WinDir%\System32\GameBarPresenceWriter.exe" /a >nul 2>&1
icacls "%WinDir%\System32\GameBarPresenceWriter.exe" /grant Administrators:(F) >nul 2>&1
ren "%WinDir%\System32\GameBarPresenceWriter.exe" "GameBarPresenceWriter.old" >nul 2>&1

echo.
echo [OK] Готово: Отключить GameBarPresenceWriter
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
