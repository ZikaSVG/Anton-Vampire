@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Mitigations

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Отключить Mitigations
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "ForEach($v in (Get-Command -Name 'Set-ProcessMitigation').Parameters['Disable'].Attributes.ValidValues){Set-ProcessMitigation -SYSTEM -Disable $v.ToString() -ErrorAction SilentlyContinue}" >nul 2>&1

set "mitigation_mask=AAAAAAAA"
for /f "tokens=3 skip=2" %%a in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationAuditOptions" 2^>nul') do set mitigation_mask=%%a
for /L %%a in (0,1,9) do set "mitigation_mask=!mitigation_mask:%%a=2!"

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationOptions" /t REG_BINARY /d "!mitigation_mask!" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationAuditOptions" /t REG_BINARY /d "!mitigation_mask!" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\FTH" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1

echo.
echo [OK] Готово: Отключить Mitigations
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
