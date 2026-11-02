@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Скрыть Галерею и Home

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Скрыть Галерею и Home
echo.

reg add "HKCU\SOFTWARE\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" /f >nul 2>&1
reg add "HKCU\Software\Classes\CLSID\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Classes\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Classes\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f >nul 2>&1

echo.
echo [OK] Готово: Скрыть Галерею и Home
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
