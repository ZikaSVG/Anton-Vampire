@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Print Spooler полностью

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Print Spooler полностью
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" /v RestrictDriverInstallationToAdministrators /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers" /v DisableWebPnPDownload /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Print Spooler полностью
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
