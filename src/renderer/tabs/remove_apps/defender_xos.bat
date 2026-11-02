@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

rem === Пути к Utils ===
set "UTILS=%~dp0..\..\..\Utils"
set "NS=%UTILS%\NSudoLG.exe"

echo ================================================================================
echo              WINDOWS DEFENDER — УДАЛЕНИЕ (xOS Edition)
echo ================================================================================
echo.
echo ВНИМАНИЕ! Процесс НЕОБРАТИМ без переустановки Windows.
echo           Создайте точку восстановления ЗАРАНЕЕ!
echo.
echo ================================================================================
echo.

echo [1/10] Завершение процессов Defender...
for %%P in (NisSrv.exe SecurityHealthHost.exe SecurityHealthService.exe SecurityHealthSystray.exe MsMpEng.exe smartscreen.exe) do taskkill /f /im %%P >nul 2>&1
echo [OK] Процессы завершены
echo.

echo [2/10] Удаление AppX-пакетов Defender...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Get-AppxPackage '*SecHealthUI*' | Remove-AppxPackage -ErrorAction SilentlyContinue; Get-AppxPackage '*Apprep.ChxApp*' | Remove-AppxPackage -ErrorAction SilentlyContinue" >nul 2>&1
echo [OK] AppX удалены
echo.

echo [3/10] Политики отключения Defender...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiVirus" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Microsoft Antimalware\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Microsoft Antimalware\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 1 /f >nul
echo [OK] Политики добавлены
echo.

echo [4/10] Удаление служб Defender...
for %%S in (
    Sense WinDefend MsSecCore wscsvc WdFilter WdBoot WdNisDrv WdNisSvc
    MsSecWfp MsSecFlt wtd webthreatdefusersvc webthreatdefsvc SecurityHealthService
) do reg delete "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /f >nul 2>&1
echo [OK] Службы удалены
echo.

echo [5/10] Дополнительные настройки...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components" /v "ServiceEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Spynet" /v "SpyNetReporting" /t REG_DWORD /d 0 /f >nul
echo [OK] Настройки применены
echo.

echo [6/10] Удаление автозагрузки Defender...
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "WindowsDefender" /f >nul 2>&1
echo [OK] Автозагрузка очищена
echo.

echo [7/10] Удаление файлов Defender...
for %%F in (
    SecurityHealthSystray.exe SecurityHealthService.exe SecurityHealthAgent.dll
    SecurityHealthHost.exe SecurityHealthSSO.dll SecurityHealthCore.dll
    SecurityHealthProxyStub.dll SecurityHealthUdk.dll smartscreen.exe smartscreenps.dll
) do del /f /q "%windir%\System32\%%F" >nul 2>&1
del /f /q "%windir%\System32\drivers\WdNisDrv.sys" >nul 2>&1
echo [OK] Файлы удалены
echo.

echo [8/10] Удаление папок Defender...
rd /s /q "%ProgramW6432%\Windows Defender Advanced Thread Protection" >nul 2>&1
rd /s /q "%ProgramW6432%\Windows Defender" >nul 2>&1
rd /s /q "%PROGRAMFILES(x86)%\Windows Defender" >nul 2>&1
rd /s /q "%ProgramData%\Microsoft\Windows Defender" >nul 2>&1
rd /s /q "%SystemDrive%\ProgramData\Microsoft\Windows Defender Advanced Threat Protection" >nul 2>&1
rd /s /q "%ProgramW6432%\Microsoft Update Health Tools" >nul 2>&1
rd /s /q "%ProgramW6432%\PCHealthCheck" >nul 2>&1
echo [OK] Папки удалены
echo.

echo [9/10] Удаление задач планировщика и контекстного меню...
schtasks /change /tn "\Microsoft\Windows\ExploitGuard\ExploitGuard MDM policy Refresh" /disable >nul 2>&1
schtasks /delete /tn "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /f >nul 2>&1
schtasks /delete /tn "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /f >nul 2>&1
schtasks /delete /tn "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /f >nul 2>&1
schtasks /delete /tn "\Microsoft\Windows\Windows Defender\Windows Defender Verification" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Classes\*\ShellEx\ContextMenuHandlers\EPP" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Classes\Drive\ShellEx\ContextMenuHandlers\EPP" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Classes\Directory\ShellEx\ContextMenuHandlers\EPP" /f >nul 2>&1
echo [OK] Задачи и меню удалены
echo.

echo [10/10] Отключение логов и DISM...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" /v "Start" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" /v "Start" /t REG_DWORD /d 0 /f >nul
DISM.exe /Online /Disable-Feature /FeatureName:"Windows-Defender-Default-Definitions" /NoRestart >nul 2>&1
echo [OK] Логи и DISM обработаны
echo.

echo ================================================================================
echo                    ГОТОВО! WINDOWS DEFENDER УДАЛЁН
echo ================================================================================
echo.
echo ВАЖНО: Установите альтернативный антивирус и перезагрузитесь!
echo.
pause