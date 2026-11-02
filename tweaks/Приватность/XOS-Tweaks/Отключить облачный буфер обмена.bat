@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить облачный буфер обмена

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить облачный буфер обмена
echo.

reg add "HKCU\SOFTWARE\Microsoft\Clipboard" /v CloudClipboardAutomaticUpload /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Clipboard" /v CloudClipRDPOverride /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v AllowCrossDeviceClipboard /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить облачный буфер обмена
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
