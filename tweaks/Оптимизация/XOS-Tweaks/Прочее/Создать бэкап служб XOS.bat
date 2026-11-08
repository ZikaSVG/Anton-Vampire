@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Создать бэкап служб XOS

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Создать бэкап служб XOS
echo.

if not exist "C:\Windows\service-backups" mkdir "C:\Windows\service-backups" >nul 2>&1
powershell -NoProfile -Command ^
  "$o='C:\Windows\service-backups\xos-default-services.reg';" ^
  "$sb=New-Object System.Text.StringBuilder(65536); $q=[char]34;" ^
  "[void]$sb.AppendLine('Windows Registry Editor Version 5.00');" ^
  "Get-ChildItem 'HKLM:\SYSTEM\CurrentControlSet\Services' -EA 0 | ForEach-Object { try { $s=(Get-ItemProperty -Path $_.PSPath -Name 'Start' -EA 0).Start; if ($null -ne $s -and $s -ge 0 -and $s -le 4) { [void]$sb.AppendLine(''); [void]$sb.AppendLine('[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\'+$_.PSChildName+']'); [void]$sb.AppendLine($q+'Start'+$q+('=dword:{0:x8}' -f [int]$s)) } } catch {} };" ^
  "[IO.File]::WriteAllText($o,$sb.ToString())"

echo.
echo [OK] Готово: Создать бэкап служб XOS
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
