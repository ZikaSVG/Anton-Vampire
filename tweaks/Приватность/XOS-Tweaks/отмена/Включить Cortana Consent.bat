@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Cortana Consent и Search Settings

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Cortana Consent и Search Settings
echo.

reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v CortanaConsent /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCortanaButton /t REG_DWORD /d 1 /f

echo.
echo [OK] Отменено: Включить Cortana Consent
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
