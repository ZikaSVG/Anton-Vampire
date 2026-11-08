@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Mitigations

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить Mitigations
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationOptions" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationAuditOptions" /f >nul 2>&1
for %%a in (fontdrvhost.exe dwm.exe lsass.exe svchost.exe WmiPrvSE.exe winlogon.exe csrss.exe audiodg.exe ntoskrnl.exe services.exe) do (
  reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%a" /v "MitigationOptions" /f >nul 2>&1
  reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%a" /v "MitigationAuditOptions" /f >nul 2>&1
)

echo.
echo [OK] Отменено: Включить Mitigations
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
