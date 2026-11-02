@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить файлы Defender

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Удалить файлы Defender
echo.

del /f /q "%windir%\System32\SecurityHealthSystray.exe" >nul 2>&1
del /f /q "%windir%\System32\SecurityHealthService.exe" >nul 2>&1
del /f /q "%windir%\System32\SecurityHealthAgent.dll" >nul 2>&1
del /f /q "%windir%\System32\SecurityHealthHost.exe" >nul 2>&1
del /f /q "%windir%\System32\SecurityHealthSSO.dll" >nul 2>&1
del /f /q "%windir%\System32\SecurityHealthCore.dll" >nul 2>&1
del /f /q "%windir%\System32\SecurityHealthProxyStub.dll" >nul 2>&1
del /f /q "%windir%\System32\SecurityHealthUdk.dll" >nul 2>&1
del /f /q "%windir%\System32\drivers\WdNisDrv.sys" >nul 2>&1
del /f /q "%windir%\System32\smartscreen.exe" >nul 2>&1
del /f /q "%windir%\System32\smartscreenps.dll" >nul 2>&1
rd /s /q "%ProgramW6432%\Windows Defender Advanced Thread Protection" >nul 2>&1
rd /s /q "%ProgramW6432%\Windows Defender Advanced Threat Protection" >nul 2>&1
rd /s /q "%ProgramW6432%\Windows Defender" >nul 2>&1
rd /s /q "%ProgramFiles(x86)%\Windows Defender" >nul 2>&1
rd /s /q "%ProgramData%\Microsoft\Windows Defender" >nul 2>&1
rd /s /q "%ProgramData%\Microsoft\Windows Defender Advanced Threat Protection" >nul 2>&1
rd /s /q "%ProgramW6432%\Microsoft Update Health Tools" >nul 2>&1
rd /s /q "%ProgramW6432%\PCHealthCheck" >nul 2>&1

echo.
echo [OK] Готово: Удалить файлы Defender
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
