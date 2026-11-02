@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить OneDrive в автозапуске

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Отключить OneDrive в автозапуске
echo.

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /t REG_SZ /d ""%USERPROFILE%\AppData\Local\Microsoft\OneDrive\OneDrive.exe" /background" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть OneDrive в автозапуск
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
