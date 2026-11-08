@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить GameBarPresenceWriter

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Отключить GameBarPresenceWriter
echo.

if exist "%WinDir%\System32\GameBarPresenceWriter.old" ren "%WinDir%\System32\GameBarPresenceWriter.old" "GameBarPresenceWriter.exe" >nul 2>&1

echo.
echo [OK] Отменено: Включить GameBarPresenceWriter
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
