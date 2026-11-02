@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить OEM информацию

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Настроить OEM информацию
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v "Manufacturer" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v "Model" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v "SupportURL" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "EditionSubVersion" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "RegisteredOrganization" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть OEM информацию
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
