@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить Update Health Tools

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Удалить Update Health Tools
echo.

set "code="
for /f "delims=" %%k in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s /f "Update Health Tools" /d 2^>nul ^| findstr /i /c:"\Uninstall\{"') do (
  for %%g in (%%~nxk) do set "code=%%g"
)
if defined code msiexec /x !code! /qn /norestart >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\UpdateHealthTools" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\rempl" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\CloudManagedUpdate" /f >nul 2>&1
rd /s /q "%ProgramW6432%\Microsoft Update Health Tools" >nul 2>&1

echo.
echo [OK] Готово: Удалить Update Health Tools
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
