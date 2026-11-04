@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить Microsoft Teams

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Удалить Microsoft Teams
echo.

taskkill /f /im msteams.exe > nul 2>&1
taskkill /f /im Teams.exe > nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -Name '*MSTeams*' -AllUsers -EA 0 | Remove-AppxPackage -AllUsers -EA 0"
powershell -NoProfile -Command "Get-AppxPackage -Name '*MicrosoftTeams*' -AllUsers -EA 0 | Remove-AppxPackage -AllUsers -EA 0"

echo [XOS] Удалить Teams Meeting Add-in
echo.

powershell -NoProfile -Command ^
  "foreach ($p in @('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall','HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall')) {" ^
  "  Get-ChildItem $p -EA 0 | ForEach-Object {" ^
  "    $dn = (Get-ItemProperty $_.PSPath -EA 0).DisplayName;" ^
  "    if ($dn -and $dn -match '(?i)teams meeting add-in') { Remove-Item $_.PSPath -Recurse -Force -EA 0 }" ^
  "  }" ^
  "}"

echo.
echo [OK] Готово: Удалить Microsoft Teams
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
