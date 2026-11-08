@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Включить fWrapAround в Notepad

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Включить fWrapAround в Notepad
echo.

reg add "HKCU\SOFTWARE\Microsoft\Notepad" /v "fWrapAround" /t REG_DWORD /d "1" /f >nul 2>&1

echo.
echo [OK] Готово: Включить fWrapAround в Notepad
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
