@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Запретить апгрейд Windows

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Запретить апгрейд Windows
echo.

powershell -NoProfile -Command ^
  "$cv = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -EA 0; $v = if ($cv.DisplayVersion) { $cv.DisplayVersion } elseif ($cv.ReleaseId) { $cv.ReleaseId } else { $null }; if ($v) { $k='HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate'; if (-not (Test-Path $k)) { New-Item -Path $k -Force -EA 0 | Out-Null }; New-ItemProperty -Path $k -Name 'TargetReleaseVersionInfo' -Value $v -PropertyType String -Force -EA 0 | Out-Null }"

echo.
echo [OK] Готово: Запретить апгрейд Windows
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
