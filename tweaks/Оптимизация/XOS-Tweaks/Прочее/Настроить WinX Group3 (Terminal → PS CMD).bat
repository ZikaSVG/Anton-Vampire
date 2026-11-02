@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить WinX Group3 (Terminal → PS/CMD)

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Настроить WinX Group3 (Terminal → PS/CMD)
echo.

powershell -NoProfile -Command ^
  "foreach ($g in (Get-Item 'C:\Users\*\AppData\Local\Microsoft\Windows\WinX\Group3','C:\Users\Default\AppData\Local\Microsoft\Windows\WinX\Group3' -EA 0)) {" ^
  "  Get-ChildItem $g.FullName -Filter '*Terminal*' -EA 0 | Remove-Item -Force -EA 0;" ^
  "  $d=$g.FullName; $ps=$env:windir+'\System32\WindowsPowerShell\v1.0\powershell.exe'; $cmd=$env:windir+'\System32\cmd.exe'; $w=New-Object -ComObject WScript.Shell;" ^
  "  $l=$w.CreateShortcut($d+'\01 - Windows PowerShell.lnk'); $l.TargetPath=$ps; $l.Save();" ^
  "  $l=$w.CreateShortcut($d+'\01b - Windows PowerShell.lnk'); $l.TargetPath=$ps; $l.Save();" ^
  "  $p=$d+'\01b - Windows PowerShell.lnk'; $b=[IO.File]::ReadAllBytes($p); $b[0x15]=$b[0x15] -bor 0x20; [IO.File]::WriteAllBytes($p,$b);" ^
  "  $l=$w.CreateShortcut($d+'\02 - Command Prompt.lnk'); $l.TargetPath=$cmd; $l.Save();" ^
  "  $l=$w.CreateShortcut($d+'\02b - Command Prompt.lnk'); $l.TargetPath=$cmd; $l.Save();" ^
  "  $p=$d+'\02b - Command Prompt.lnk'; $b=[IO.File]::ReadAllBytes($p); $b[0x15]=$b[0x15] -bor 0x20; [IO.File]::WriteAllBytes($p,$b)" ^
  "}"

echo.
echo [OK] Готово: Настроить WinX Group3 (Terminal → PS/CMD)
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
