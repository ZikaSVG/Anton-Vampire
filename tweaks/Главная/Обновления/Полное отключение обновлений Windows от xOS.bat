@echo off
chcp 65001 >nul

echo ================================================================================
echo                 xOS PLAYBOOK - ПОЛНОЕ ОТКЛЮЧЕНИЕ АВТООБНОВЛЕНИЙ
echo           (HARD DISABLE - НИКАКИХ ОБНОВЛЕНИЙ, ДРАЙВЕРОВ, МЕТАДАННЫХ)
echo ================================================================================
echo.
echo ОПИСАНИЕ:
echo ================================================================================
echo Данный скрипт ПОЛНОСТЬЮ ОТКЛЮЧАЕТ автоматические обновления Windows:
echo.
echo   1. ОТКЛЮЧАЕТ СЛУЖБЫ ОБНОВЛЕНИЙ:
echo      - wuauserv (Windows Update)
echo      - bits (Background Intelligent Transfer)
echo      - dosvc (Delivery Optimization)
echo      - UsoSvc (Update Orchestrator)
echo      - WaaSMedicSvc (Windows Update Medic)
echo.
echo   2. ОТКЛЮЧАЕТ ЗАДАЧИ UPDATE ORCHESTRATOR
echo   3. ОТКЛЮЧАЕТ ЗАДАЧИ WINDOWS UPDATE
echo   4. БЛОКИРУЕТ ПОДКЛЮЧЕНИЕ К MICROSOFT
echo   5. ОТКЛЮЧАЕТ АВТООБНОВЛЕНИЯ (NoAutoUpdate)
echo   6. ОТКЛЮЧАЕТ ОБНОВЛЕНИЯ ДРАЙВЕРОВ
echo   7. ОТКЛЮЧАЕТ МЕТАДАННЫЕ УСТРОЙСТВ
echo   8. УДАЛЯЕТ КЛЮЧИ UScheduler
echo   9. БЛОКИРУЕТ ОБНОВЛЕНИЕ ДО ТЕКУЩЕЙ ВЕРСИИ
echo.
echo ================================================================================
echo ПЛЮСЫ:
echo ================================================================================
echo [+] ПОЛНЫЙ КОНТРОЛЬ над обновлениями
echo [+] НЕТ ПРИНУДИТЕЛЬНЫХ ПЕРЕЗАГРУЗОК
echo [+] СНИЖАЕТСЯ СЕТЕВОЙ ТРАФИК
echo [+] УМЕНЬШАЕТСЯ НАГРУЗКА НА CPU
echo [+] СИСТЕМА НЕ ОБНОВЛЯЕТСЯ до новых версий
echo [+] ЭКОНОМИТ МЕСТО на диске
echo [+] MICROSOFT STORE НЕ РАБОТАЕТ (экономия трафика)
echo.
echo ================================================================================
echo МИНУСЫ:
echo ================================================================================
echo [-] ОБНОВЛЕНИЯ НЕ УСТАНАВЛИВАЮТСЯ АВТОМАТИЧЕСКИ
echo [-] Нужно ВРУЧНУЮ проверять обновления
echo [-] Снижается безопасность без критических обновлений
echo [-] Microsoft Store не работает
echo.
echo ================================================================================
echo РЕКОМЕНДАЦИИ:
echo ================================================================================
echo [1] ТОЛЬКО ДЛЯ ПРОДВИНУТЫХ ПОЛЬЗОВАТЕЛЕЙ
echo [2] НЕ РЕКОМЕНДУЕТСЯ для рабочих и корпоративных ПК
echo [3] Регулярно проверяйте обновления ВРУЧНУЮ (раз в 1-2 недели)
echo [4] Для возврата используйте скрипт "Включение автоматических обновлений.bat"
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
set "SysDr=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching"
set "Meta=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata"
set "Svcs=wuauserv bits dosvc UsoSvc WaaSMedicSvc"

echo [ЧАСТЬ 1] ОТКЛЮЧЕНИЕ СЛУЖБ ОБНОВЛЕНИЙ...
echo.

for %%s in (%Svcs%) do (
    echo   Отключение службы: %%s
    sc stop %%s >nul 2>&1
    sc config %%s start= disabled >nul 2>&1
)
echo [OK] Службы обновлений отключены
echo.

echo [ЧАСТЬ 2] ОТКЛЮЧЕНИЕ ЗАДАЧ UPDATE ORCHESTRATOR...
echo.

schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScan_LicenseAccepted" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Report policies" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Maintenance Work" /disable >nul 2>&1
schtasks /delete /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /f >nul 2>&1
schtasks /delete /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /f >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Wake To Work" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Work" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\UIEOrchestrator" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\UpdateModelTask" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Start Oobe Expedite Work" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScan_OobeAppReady" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScanAfterUpdate" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\UUS Failover Task" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\AC Power Download" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\AC Power Install" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Backup Scan" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Battery Saver Deferred Install" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Driver Install" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Maintenance Install" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\MusUx_LogonUpdateResults" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\MusUx_UpdateInterval" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Policy Install" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Reboot" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Reboot_AC" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Reboot_Battery" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Refresh Settings" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Resume On Boot" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Retry Scan" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScan" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\USO_Broker_Display" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker_Display" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker_ReadyToReboot" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Universal Orchestrator Start" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Universal Orchestrator Idle Start" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistant" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistantAllUsersRun" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistantCalendarRun" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistantWakeupRun" /disable >nul 2>&1
echo [OK] Задачи Update Orchestrator отключены
echo.

echo [ЧАСТЬ 3] ОТКЛЮЧЕНИЕ ЗАДАЧ WINDOWS UPDATE...
echo.

schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\AUScheduledInstall" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\AUSessionConnect" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\Automatic App Update" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\RUXIM\PLUGScheduler" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\Scheduled Start With Network" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\sih" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\sihboot" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\sihpostreboot" /disable >nul 2>&1
echo [OK] Задачи Windows Update отключены
echo.

echo [ЧАСТЬ 4] НАСТРОЙКА ПОЛИТИК ОТКЛЮЧЕНИЯ...
echo.

echo [1/7] Блокировка подключения к Microsoft...
reg add "%PolWU%" /v DoNotConnectToWindowsUpdateInternetLocations /t REG_DWORD /d 1 /f >nul
reg add "%PolWU%" /v DisableWindowsUpdateAccess /t REG_DWORD /d 1 /f >nul
echo [OK] Подключение к Microsoft заблокировано
echo.

echo [2/7] Отключение автообновлений (NoAutoUpdate)...
reg add "%PolWU%\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul
echo [OK] NoAutoUpdate = 1
echo.

echo [3/7] Отключение обновлений драйверов...
reg add "%PolWU%" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f >nul
reg add "%PolDr%" /v SearchOrderConfig /t REG_DWORD /d 0 /f >nul
reg add "%SysDr%" /v SearchOrderConfig /t REG_DWORD /d 0 /f >nul
echo [OK] Обновления драйверов отключены
echo.

echo [4/7] Отключение метаданных устройств...
reg add "%Meta%" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f >nul
echo [OK] Метаданные устройств отключены
echo.

echo [5/7] Удаление ключей UScheduler...
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\UScheduler\DevHomeUpdate" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\UScheduler\OutlookUpdate" /f >nul 2>&1
echo [OK] Ключи UScheduler удалены
echo.

echo [6/7] Определение текущей версии Windows...
for /f "tokens=3" %%v in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v DisplayVersion 2^>nul') do set "WINVER=%%v"
echo [OK] Текущая версия: %WINVER%
echo.

echo [7/7] Блокировка обновления до текущей версии...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "TargetReleaseVersionInfo" /t REG_SZ /d "%WINVER%" /f >nul
echo [OK] Обновление версии заблокировано до %WINVER%
echo.

echo ================================================================================
echo                 ГОТОВО! АВТОМАТИЧЕСКИЕ ОБНОВЛЕНИЯ ОТКЛЮЧЕНЫ
echo ================================================================================
echo.
echo Что сделано:
echo   - Отключены все службы обновлений
echo   - Отключены все задачи Update Orchestrator
echo   - Отключены все задачи Windows Update
echo   - Заблокировано подключение к Microsoft
echo   - Отключены автообновления
echo   - Отключены обновления драйверов
echo   - Отключены метаданные устройств
echo   - Удалены ключи UScheduler
echo   - Заблокировано обновление до новой версии
echo.
echo Результат:
echo   - Windows НЕ проверяет обновления автоматически
echo   - Windows НЕ загружает обновления
echo   - Windows НЕ устанавливает обновления
echo   - Windows НЕ перезагружается без разрешения
echo   - Windows НЕ обновляется до новых версий
echo   - Microsoft Store НЕ РАБОТАЕТ
echo.
echo Для установки обновлений:
echo   - Откройте Параметры -> Центр обновления Windows
echo   - Нажмите "Проверить наличие обновлений" вручную
echo.
echo Для возврата используйте скрипт "Включение автоматических обновлений.bat"
echo.

echo.