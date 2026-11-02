@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить Internet Explorer

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Удалить Internet Explorer
echo.

rd /s /q "%ProgramFiles(x86)%\Internet Explorer" > nul 2>&1
rd /s /q "%ProgramW6432%\Internet Explorer" > nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Font Drivers" /v "Adobe Type Manager" /f > nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\DevHomeUpdate" /f > nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\EdgeUpdate" /f > nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\OutlookUpdate" /f > nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\CrossDeviceUpdate" /f > nul 2>&1

echo.
echo [OK] Готово: Удалить Internet Explorer
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
