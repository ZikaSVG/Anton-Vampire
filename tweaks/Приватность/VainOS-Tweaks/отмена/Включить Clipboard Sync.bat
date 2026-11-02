@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Clipboard Sync

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить Clipboard Sync
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "AllowClipboardHistory" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "AllowCrossDeviceClipboard" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Clipboard" /v "EnableClipboardHistory" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Clipboard" /v "CloudClipboardAutomaticUpload" /t REG_DWORD /d "1" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Clipboard Sync
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
