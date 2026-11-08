@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Process Mitigations

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Process Mitigations
echo.

powershell -NoProfile -Command ^
  "try { ForEach ($v in (Get-Command -Name 'Set-ProcessMitigation').Parameters['Disable'].Attributes.ValidValues) { Set-ProcessMitigation -SYSTEM -Disable $v.ToString() -EA 0 } } catch {};" ^
  "$k='HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\kernel';" ^
  "$len=38; try { $e=(Get-ItemProperty -Path $k -EA 0).MitigationAuditOptions; if ($e -and $e.Length -gt 0) { $len=$e.Length } } catch {};" ^
  "$m=[byte[]]::new($len); for ($i=0; $i -lt $len; $i++) { $m[$i]=0x22 };" ^
  "$exes=@('fontdrvhost.exe','dwm.exe','lsass.exe','svchost.exe','WmiPrvSE.exe','winlogon.exe','csrss.exe','ntoskrnl.exe','services.exe');" ^
  "foreach ($x in $exes) { $p='HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\'+$x; try { if (-not (Test-Path $p)) { New-Item -Path $p -Force | Out-Null }; Set-ItemProperty -Path $p -Name 'MitigationOptions' -Value $m -Type Binary -Force -EA 0; Set-ItemProperty -Path $p -Name 'MitigationAuditOptions' -Value $m -Type Binary -Force -EA 0 } catch {} };" ^
  "try { if (-not (Test-Path $k)) { New-Item -Path $k -Force | Out-Null }; Set-ItemProperty -Path $k -Name 'MitigationOptions' -Value $m -Type Binary -Force -EA 0 } catch {}"

echo.
echo [OK] Готово: Отключить Process Mitigations
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
