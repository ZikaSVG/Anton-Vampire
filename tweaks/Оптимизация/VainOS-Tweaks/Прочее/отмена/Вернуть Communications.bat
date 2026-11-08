@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить Communications

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Настроить Communications
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Communications" /v "ConfigureChatAutoInstall" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть Communications
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
