@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить PC Health Check

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Удалить PC Health Check
echo.

powershell -NoProfile -Command ^
  "$u = Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall','HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall' -EA 0 | Get-ItemProperty | Where-Object { $_.DisplayName -like '*PC Health Check*' };" ^
  "if ($u) { $c = $u.UninstallString; if ($c) { Start-Process cmd.exe -ArgumentList ('/c ' + $c + ' /quiet /norestart') -Wait -NoNewWindow -EA 0 } };" ^
  "Remove-Item ($env:ProgramFiles + '\PCHealthCheck') -Recurse -Force -EA 0"

echo.
echo [OK] Готово: Удалить PC Health Check
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
