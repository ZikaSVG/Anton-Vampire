@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Desktop-only устройства

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Desktop-only устройства
echo.

powershell -NoProfile -Command ^
  "$ct=3; try { $c=(Get-WmiObject -Class Win32_SystemEnclosure -EA 0).ChassisTypes; if ($c -and $c.Length -gt 0) { $ct=[int]$c[0] } } catch {};" ^
  "if ($ct -gt 7) { exit 0 };" ^
  "$d=@('ACPI Processor Aggregator','ACPI Wake Alarm','AMD Crash Defender','High Precision Event Timer','Intel(R) Platform Monitoring Technology Device');" ^
  "foreach ($n in $d) { try { $q=[char]39; $s=$n -replace $q,($q+$q); Get-WmiObject -Class Win32_PnPEntity -Filter ('Name LIKE '+$q+'%'+$s+'%'+$q) -EA 0 | ForEach-Object { $id=$_.DeviceID; try { $r=$_.Disable(); if ($r.ReturnValue -ne 0) { pnputil /disable-device $id 2>$null | Out-Null } } catch { pnputil /disable-device $id 2>$null | Out-Null } } } catch {} }"

echo.
echo [OK] Готово: Отключить Desktop-only устройства
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
