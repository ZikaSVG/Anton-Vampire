@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - ВКЛЮЧЕНИЕ АВТООБНОВЛЕНИЙ WINDOWS
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Данный скрипт ВОССТАНАВЛИВАЕТ автоматические обновления Windows.
echo Это полный откат для скрипта "Полное отключение автоматических обновлений.bat".
echo.
echo ================================================================================
echo ПРИМЕНЕНИЕ:
echo ================================================================================

:: Проверка прав администратора
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ОШИБКА] Запустите от имени Администратора!
    echo.
    exit /b 1
)

set "PolWU=HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
set "PolDr=HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching"
set "Meta=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata"
set "Svcs=wuauserv bits dosvc UsoSvc WaaSMedicSvc"

echo [ЧАСТЬ 1] ВКЛЮЧЕНИЕ СЛУЖБ ОБНОВЛЕНИЙ...
echo.

for %%s in (%Svcs%) do (
    echo   Включение службы: %%s
    sc config %%s start= auto >nul 2>&1
    sc start %%s >nul 2>&1
)
echo [OK] Службы обновлений включены
echo.

echo [ЧАСТЬ 2] ВКЛЮЧЕНИЕ ЗАДАЧ UPDATE ORCHESTRATOR...
echo.

schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScan_LicenseAccepted" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Report policies" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Maintenance Work" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Wake To Work" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Work" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\UIEOrchestrator" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\UpdateModelTask" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Start Oobe Expedite Work" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScan_OobeAppReady" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScanAfterUpdate" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\UUS Failover Task" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\AC Power Download" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\AC Power Install" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Backup Scan" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Battery Saver Deferred Install" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Driver Install" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Maintenance Install" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\MusUx_LogonUpdateResults" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\MusUx_UpdateInterval" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Policy Install" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Reboot" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Reboot_AC" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Reboot_Battery" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Refresh Settings" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Resume On Boot" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Retry Scan" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScan" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\USO_Broker_Display" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker_Display" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker_ReadyToReboot" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Universal Orchestrator Start" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Universal Orchestrator Idle Start" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistant" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistantAllUsersRun" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistantCalendarRun" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistantWakeupRun" /enable >nul 2>&1
echo [OK] Задачи Update Orchestrator включены
echo.

echo [ЧАСТЬ 3] ВКЛЮЧЕНИЕ ЗАДАЧ WINDOWS UPDATE...
echo.

schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\AUScheduledInstall" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\AUSessionConnect" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\Automatic App Update" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\RUXIM\PLUGScheduler" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\Scheduled Start With Network" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\sih" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\sihboot" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\sihpostreboot" /enable >nul 2>&1
echo [OK] Задачи Windows Update включены
echo.

echo [ЧАСТЬ 4] УДАЛЕНИЕ ПОЛИТИК ОТКЛЮЧЕНИЯ...
echo.

reg delete "%PolWU%" /f >nul 2>&1
reg delete "%PolDr%" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 1 /f >nul
reg delete "%Meta%" /v PreventDeviceMetadataFromNetwork /f >nul 2>&1
echo [OK] Политики отключения удалены
echo.

echo ================================================================================
echo                ГОТОВО! АВТОМАТИЧЕСКИЕ ОБНОВЛЕНИЯ ВКЛЮЧЕНЫ
echo ================================================================================
echo.
echo Что сделано:
echo   - Включены все службы обновлений
echo   - Включены все задачи Update Orchestrator
echo   - Включены все задачи Windows Update
echo   - Удалены политики отключения
echo   - Восстановлены драйверы и метаданные
echo.
echo Результат:
echo   - Windows снова проверяет и устанавливает обновления
echo   - Рекомендуется перезагрузить компьютер
echo.

echo.