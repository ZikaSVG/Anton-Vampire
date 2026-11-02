@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Очистить Start Menu кэш

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Очистить Start Menu кэш
echo.

powershell -NoProfile -Command ^
  "$p=@(); Get-ChildItem 'C:\Users\*\AppData\Local\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy' -EA 0 | ForEach-Object { $t=Join-Path $_.FullName 'TempState'; $l=Join-Path $_.FullName 'LocalState'; if (Test-Path $t) { Get-ChildItem $t -Filter 'TileCache*' -Force -EA 0 | ForEach-Object { $p += ('\??\'+$_.FullName); $p += '' } }; if (Test-Path $l) { Get-ChildItem $l -Filter 'start*.bin' -Force -EA 0 | ForEach-Object { $p += ('\??\'+$_.FullName); $p += '' } } };" ^
  "if ($p.Count -gt 0) { $r='HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager'; $e=(Get-ItemProperty -Path $r -Name 'PendingFileRenameOperations' -EA 0).PendingFileRenameOperations; if ($e) { $p=$e+$p }; Set-ItemProperty -Path $r -Name 'PendingFileRenameOperations' -Value $p -Type MultiString -Force }"

echo.
echo [OK] Готово: Очистить Start Menu кэш
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
