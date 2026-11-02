@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить Teams Meeting Add-in

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

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
echo [OK] Готово: Удалить Teams Meeting Add-in
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
