@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Восстановить W10 Notepad

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Восстановить W10 Notepad
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers 'Microsoft.WindowsNotepad' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register ($_.InstallLocation + '\AppxManifest.xml') -EA 0 }" >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Notepad" /v "ShowStoreBanner" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Notepad" /v "fWrapAround" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть Store Notepad
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
