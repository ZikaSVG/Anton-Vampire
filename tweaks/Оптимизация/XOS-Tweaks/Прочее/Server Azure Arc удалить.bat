@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Server Azure Arc удалить

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Server Azure Arc удалить
echo.

if exist "C:\Windows\AzureArcSetup\Systray" (
  powershell -NoProfile -Command ^
    "$p='C:\Windows\AzureArcSetup\Systray';" ^
    "Get-ChildItem $p -Filter '*.exe' -Recurse -EA 0 | Where-Object { $_.Name -match 'uninstall|remove' -or $_.FullName -match 'uninstall' } | Select-Object -First 1 | ForEach-Object { Start-Process $_.FullName -ArgumentList '/quiet /norestart' -Wait -NoNewWindow -EA 0 };" ^
    "Remove-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'AzureArcSetup' -Force -EA 0;" ^
    "Start-Sleep 2;" ^
    "Remove-Item $p -Recurse -Force -EA 0"
)

echo.
echo [OK] Готово: Server Azure Arc удалить
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
