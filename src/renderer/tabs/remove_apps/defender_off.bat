@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

rem === Пути к Utils ===
set "UTILS=%~dp0..\..\..\Utils"
set "NS=%UTILS%\NSudoLG.exe"

echo ================================================================================
echo              WINDOWS DEFENDER — ОТКЛЮЧЕНИЕ (обратимо)
echo ================================================================================
echo.
echo   Отключает Defender через политики, НЕ удаляя компоненты.
echo   Для возврата используйте defender_back.bat.
echo.
echo ================================================================================
echo.

echo [1/5] Остановка служб Defender...
sc stop WinDefend >nul 2>&1
sc stop WdNisSvc >nul 2>&1
sc stop Sense >nul 2>&1
sc stop wscsvc >nul 2>&1
timeout /t 2 /nobreak >nul
echo [OK] Службы остановлены
echo.

echo [2/5] Политики отключения...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiVirus" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d 1 /f >nul
echo [OK] Политики добавлены
echo.

echo [3/5] Отключение SmartScreen...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d 0 /f >nul
echo [OK] SmartScreen отключён
echo.

echo [4/5] Отключение телеметрии Defender...
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Spynet" /v "SpyNetReporting" /t REG_DWORD /d 0 /f >nul
echo [OK] Телеметрия отключена
echo.

echo [5/5] Применение политик...
gpupdate /force >nul 2>&1
echo [OK] Готово
echo.

echo ================================================================================
echo              ГОТОВО! DEFENDER ОТКЛЮЧЁН (обратимо)
echo ================================================================================
echo.
echo Для возврата: запустите defender_back.bat
echo.
pause