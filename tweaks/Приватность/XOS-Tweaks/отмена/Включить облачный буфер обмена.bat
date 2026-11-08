@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить облачный буфер обмена

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить облачный буфер обмена
echo.

reg add "HKCU\SOFTWARE\Microsoft\Clipboard" /v CloudClipboardAutomaticUpload /t REG_DWORD /d 1 /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v AllowCrossDeviceClipboard /f >nul 2>&1

echo.
echo [OK] Отменено: Включить облачный буфер обмена
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
