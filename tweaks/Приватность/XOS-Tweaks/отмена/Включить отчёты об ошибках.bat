@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить отчёты об ошибках Windows

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить отчёты об ошибках Windows
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v LoggingDisabled /t REG_DWORD /d 0 /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v Disabled /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v DisableArchive /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v DisableWerUpload /f >nul 2>&1

echo.
echo [OK] Отменено: Включить отчёты об ошибках
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
