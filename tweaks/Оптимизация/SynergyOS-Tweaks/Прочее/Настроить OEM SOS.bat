@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить OEM SOS

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Настроить OEM SOS
echo.

:: --- Определяем версию Windows
for /f "tokens=3 delims=[]. " %%a in ('ver') do set version=%%a

:: --- Установить OEM-метки (SOS 10 / SOS 11)
if %version% geq 22000 (
  bcdedit /set description "SOS" >nul 2>&1
  Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v "Model" /t REG_SZ /d "SOS 11" /f >nul 2>&1
  Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "RegisteredOrganization" /t REG_SZ /d "SOS 11" /f >nul 2>&1
) else (
  bcdedit /set description "SOS" >nul 2>&1
  Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v "Model" /t REG_SZ /d "SOS 10" /f >nul 2>&1
  Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "RegisteredOrganization" /t REG_SZ /d "SOS 10" /f >nul 2>&1
)

echo.
echo [OK] Готово: Настроить OEM SOS
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
