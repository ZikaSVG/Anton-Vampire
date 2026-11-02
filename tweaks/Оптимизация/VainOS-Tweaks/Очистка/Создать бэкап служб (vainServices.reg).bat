@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Создать бэкап служб (vainServices.reg)

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Создать бэкап служб (vainServices.reg)
echo.

if not exist "%windir%\ServicesBackup" mkdir "%windir%\ServicesBackup" >nul 2>&1

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$FilePath='$([Environment]::GetFolderPath('Windows'))\ServicesBackup\vainServices.reg';" ^
  "if (Test-Path $FilePath) { exit };" ^
  "Add-Content -Path $FilePath -Value 'Windows Registry Editor Version 5.00';" ^
  "Get-ChildItem 'HKLM:\SYSTEM\CurrentControlSet\Services' | ForEach-Object {" ^
  "  if ((Get-ItemProperty $_.PSPath).PSObject.Properties.Name -contains 'Start') {" ^
  "    $startValue = (Get-ItemProperty -Path $_.PSPath -Name 'Start').Start;" ^
  "    for ($c = 0; $c -le 4; $c++) {" ^
  "      if ($startValue -eq \"0x$c\") {" ^
  "        Add-Content -Path $FilePath -Value (\"`n[\" + $_.Name + \"]\");" ^
  "        Add-Content -Path $FilePath -Value (\"`Start`\"=dword:0000000$c\")" ^
  "      }" ^
  "    }" ^
  "  }" ^
  "}"

echo.
echo [OK] Готово: Создать бэкап служб (vainServices.reg)
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
