@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Пересобрать NGEN

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Пересобрать NGEN
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ScheduledTask -TaskPath '\Microsoft\Windows\.NET Framework\' -EA 0 | Start-ScheduledTask -EA 0" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$env:PATH = [Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory();" ^
  "[AppDomain]::CurrentDomain.GetAssemblies() | ForEach-Object {" ^
  "  $path = $_.Location;" ^
  "  if ($path) { ngen.exe install $path /nologo | Out-Null }" ^
  "}" >nul 2>&1

echo.
echo [OK] Готово: Пересобрать NGEN
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
