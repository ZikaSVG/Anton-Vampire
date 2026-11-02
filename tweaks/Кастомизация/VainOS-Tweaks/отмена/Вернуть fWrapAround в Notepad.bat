@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Включить fWrapAround в Notepad

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Включить fWrapAround в Notepad
echo.

reg delete "HKCU\SOFTWARE\Microsoft\Notepad" /v "fWrapAround" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть fWrapAround в Notepad
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
