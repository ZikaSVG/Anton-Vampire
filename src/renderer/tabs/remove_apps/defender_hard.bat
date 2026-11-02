@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

rem === Пути к Utils ===
set "UTILS=%~dp0..\..\..\Utils"
set "NS=%UTILS%\NSudoLG.exe"

echo ================================================================================
echo              WINDOWS DEFENDER — ХАРДКОР УДАЛЕНИЕ
echo ================================================================================
echo.
echo   Максимально агрессивное удаление Defender + Update Health Tools.
echo   Использует Utils\NSudoLG.exe для защиты файлов.
echo.
echo ВНИМАНИЕ: Процесс НЕОБРАТИМ. Создайте точку восстановления!
echo ================================================================================
echo.

echo [1/13] Завершение процессов...
for %%P in (NisSrv.exe MsMpEng.exe SecurityHealthHost.exe SecurityHealthService.exe SecurityHealthSystray.exe smartscreen.exe MpCmdRun.exe) do taskkill /f /im %%P >nul 2>&1
timeout /t 2 /nobreak >nul
echo [OK] Процессы завершены
echo.

echo [2/13] Удаление AppX-пакетов Defender...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Get-AppxPackage '*SecHealthUI*' | Remove-AppxPackage -ErrorAction SilentlyContinue; Get-AppxPackage '*Apprep*' | Remove-AppxPackage -ErrorAction SilentlyContinue; Get-AppxPackage '*WindowsSecurity*' | Remove-AppxPackage -ErrorAction SilentlyContinue" >nul 2>&1
echo [OK] AppX удалены
echo.

echo [3/13] Политики отключения Defender...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiVirus" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SpynetReporting" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d 2 /f >nul
echo [OK] Политики добавлены
echo.

echo [4/13] Удаление служб...
for %%S in (
    Sense WinDefend MsSecCore wscsvc WdFilter WdBoot WdNisDrv WdNisSvc
    MsSecWfp MsSecFlt wtd webthreatdefusersvc webthreatdefsvc SecurityHealthService
    SecurityHealthUI Mpssvc
) do reg delete "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /f >nul 2>&1
echo [OK] Службы удалены
echo.

echo [5/13] Удаление защищённых файлов (через NSudoLG)...
if exist "%NS%" (
    echo   Используем NSudoLG: %NS%
    "%NS%" -U:T -P:E -ShowWindowMode:Hide -Wait cmd.exe /c "del /f /q ""%windir%\System32\SecurityHealthService.exe""" >nul 2>&1
    "%NS%" -U:T -P:E -ShowWindowMode:Hide -Wait cmd.exe /c "del /f /q ""%windir%\System32\SecurityHealthSystray.exe""" >nul 2>&1
    "%NS%" -U:T -P:E -ShowWindowMode:Hide -Wait cmd.exe /c "del /f /q ""%windir%\System32\MsMpEng.exe""" >nul 2>&1
) else (
    echo   [ПРЕДУПРЕЖДЕНИЕ] NSudoLG не найден: %NS%
)
for %%F in (
    SecurityHealthService.exe SecurityHealthSystray.exe SecurityHealthAgent.dll
    SecurityHealthHost.exe SecurityHealthSSO.dll SecurityHealthCore.dll
    SecurityHealthProxyStub.dll SecurityHealthUdk.dll smartscreen.exe smartscreenps.dll
    MpClient.dll MpCommu.dll MpOAV.dll MpSvc.dll
) do del /f /q "%windir%\System32\%%F" >nul 2>&1
for %%D in (WdNisDrv.sys WdFilter.sys WdBoot.sys) do del /f /q "%windir%\System32\drivers\%%D" >nul 2>&1
echo [OK] Файлы обработаны
echo.

echo [6/13] Удаление папок Defender...
for %%P in (
    "%ProgramW6432%\Windows Defender"
    "%ProgramW6432%\Windows Defender Advanced Thread Protection"
    "%ProgramFiles(x86)%\Windows Defender"
    "%ProgramData%\Microsoft\Windows Defender"
    "%ProgramData%\Microsoft\Windows Defender Advanced Threat Protection"
    "%ProgramData%\Microsoft\Windows Security Health"
) do (
    if exist %%P (
        takeown /f %%P /r /d y >nul 2>&1
        icacls %%P /grant administrators:F /t >nul 2>&1
        rd %%P /Q /S >nul 2>&1
    )
)
echo [OK] Папки удалены
echo.

echo [7/13] Удаление Update Health Tools...
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\UpdateHealthTools" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\rempl" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\CloudManagedUpdate" /f >nul 2>&1
rd "%ProgramW6432%\Microsoft Update Health Tools" /Q /S >nul 2>&1
rd "%ProgramW6432%\PCHealthCheck" /Q /S >nul 2>&1
echo [OK] Update Health Tools удалены
echo.

echo [8/13] Удаление задач планировщика...
schtasks /change /tn "\Microsoft\Windows\ExploitGuard\ExploitGuard MDM policy Refresh" /disable >nul 2>&1
schtasks /delete /tn "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /f >nul 2>&1
schtasks /delete /tn "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /f >nul 2>&1
schtasks /delete /tn "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /f >nul 2>&1
schtasks /delete /tn "\Microsoft\Windows\Windows Defender\Windows Defender Verification" /f >nul 2>&1
echo [OK] Задачи удалены
echo.

echo [9/13] Удаление контекстного меню...
for %%K in (
    "HKLM\SOFTWARE\Classes\*\ShellEx\ContextMenuHandlers\EPP"
    "HKLM\SOFTWARE\Classes\Drive\ShellEx\ContextMenuHandlers\EPP"
    "HKLM\SOFTWARE\Classes\Directory\ShellEx\ContextMenuHandlers\EPP"
    "HKLM\SOFTWARE\Classes\AllFilesystemObjects\ShellEx\ContextMenuHandlers\EPP"
) do reg delete %%K /f >nul 2>&1
echo [OK] Меню удалено
echo.

echo [10/13] Отключение логов WMI...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" /v "Start" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" /v "Start" /t REG_DWORD /d 0 /f >nul
echo [OK] Логи отключены
echo.

echo [11/13] Отключение SmartScreen и HVC...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 0 /f >nul
echo [OK] SmartScreen и HVC отключены
echo.

echo [12/13] Очистка HKCU...
reg delete "HKCU\Software\Microsoft\Windows Defender" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /f >nul 2>&1
echo [OK] HKCU очищен
echo.

echo [13/13] DISM и gpupdate...
DISM.exe /Online /Disable-Feature /FeatureName:"Windows-Defender-Default-Definitions" /NoRestart >nul 2>&1
DISM.exe /Online /Disable-Feature /FeatureName:"Windows-Defender" /NoRestart >nul 2>&1
gpupdate /force >nul 2>&1
echo [OK] DISM выполнен
echo.

echo ================================================================================
echo                    ГОТОВО! DEFENDER УДАЛЁН (ХАРДКОР)
echo ================================================================================
echo.
echo ВАЖНО:
echo   - Установите альтернативный антивирус
echo   - Перезагрузите компьютер
echo.
pause