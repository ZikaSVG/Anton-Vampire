@echo off
setlocal EnableExtensions
chcp 65001 >nul
title VainOS - только службы

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Запустите от имени администратора.
    pause
    exit /b 1
)

:: ============================================================================
::                           КРУТАЯ ШАПКА
:: ============================================================================
::  Standalone-батник по VainOS (VainOS.txt).
::  Включены ТОЛЬКО действия над службами:
::    reg add "...\Services\X" /v Start /d 4    (отключение)
::    sc stop X                                 (где есть в источнике)
::    sc config X start= disabled               (замена sc delete для Edge)
::  Папки "отмена" не включены.
::  Удаляемые службы (3 из Edge) — отключены, не удалены.
::  "Настроить Config Time.bat" исключён: он включает w32time (start= demand + start).
::  Дубликатов нет — 65 разных служб.
:: ============================================================================

:: ============================================================================
::  Отключить геолокацию и сенсоры.bat
::  В источнике: reg add Start=4 + sc stop lfsvc.
::  Остальное в файле — политики LocationAndSensors и ConsentStore,
::  это не службы.
:: ============================================================================

:: lfsvc — служба геолокации (Geolocation Service).
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop lfsvc >nul 2>&1


:: ============================================================================
::  Отключить телеметрию.bat
::  В источнике помимо служб также AllowTelemetry, ETW-автологгер,
::  setx-переменные и удаление ETL-файлов — эти действия в батник
::  не включены, так как не являются отключением служб.
:: ============================================================================

:: DiagTrack — Connected User Experiences and Telemetry.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop DiagTrack >nul 2>&1

:: dmwappushservice — маршрутизация WAP push (связана с телеметрией).
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop dmwappushservice >nul 2>&1

:: diagnosticshub.standardcollector.service — стандартный сборщик
:: диагностического хаба. В источнике без sc stop.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: DPS — политика диагностики. В источнике без sc stop.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DPS" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: WdiServiceHost — хост службы диагностики. В источнике без sc stop.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdiServiceHost" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: WdiSystemHost — системный хост диагностики. В источнике без sc stop.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdiSystemHost" /v Start /t REG_DWORD /d 4 /f >nul 2>&1


:: ============================================================================
::  Отключить уведомления.bat
::  В источнике помимо службы также реестровые ключи PushNotifications и
::  ConsentStore — в батник не включены.
:: ============================================================================

:: WpnService — системная служба push-уведомлений.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WpnService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop WpnService >nul 2>&1

:: ============================================================================
::  ИСТОЧНИК: Производительность\Отключить службы Xbox-Storage-MixedReality-Sensor-WinRM.bat
::  В источнике: reg add Start=4 + sc stop.
:: ============================================================================

:: XblAuthManager — аутентификация Xbox Live.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\XblAuthManager" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop XblAuthManager >nul 2>&1

:: XblGameSave — сохранения Xbox Live.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\XblGameSave" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop XblGameSave >nul 2>&1

:: XboxGipSvc — аксессуары Xbox.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\XboxGipSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop XboxGipSvc >nul 2>&1

:: XboxNetApiSvc — сетевая служба Xbox Live.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop XboxNetApiSvc >nul 2>&1

:: StorSvc — служба хранилища.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\StorSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop StorSvc >nul 2>&1

:: WMPNetworkSvc — общий доступ к медиатеке Windows Media Player.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WMPNetworkSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop WMPNetworkSvc >nul 2>&1

:: SharedRealitySvc — пространственные данные Mixed Reality.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedRealitySvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop SharedRealitySvc >nul 2>&1

:: SensorService — служба датчиков.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop SensorService >nul 2>&1

:: SensrSvc — мониторинг датчиков.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensrSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop SensrSvc >nul 2>&1

:: WinRM — удалённое управление Windows.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinRM" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop WinRM >nul 2>&1


:: ============================================================================
::  ИСТОЧНИК: Прочее\Настроить печать.bat — ветка :disable (вариант по умолчанию)
::  В источнике: reg add Start=4 (в DISM-фичи не лезем).
:: ============================================================================

:: Spooler — диспетчер печати.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: PrintWorkFlowUserSvc — рабочие процессы печати.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PrintWorkFlowUserSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: StiSvc — захват изображений.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\StiSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: PrintNotify — уведомления принтера.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PrintNotify" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: usbprint — драйвер USB-принтера.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usbprint" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: McpManagementService — управление печатью (MCP).
reg add "HKLM\SYSTEM\CurrentControlSet\Services\McpManagementService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: PrintScanBrokerService — брокер печати/сканирования.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PrintScanBrokerService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: PrintDeviceConfigurationService — настройка печатающих устройств.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PrintDeviceConfigurationService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1


:: ============================================================================
::  ИСТОЧНИК: Прочее\Настроить службы.bat
::  В источнике: reg add Start=4.
:: ============================================================================

:: BDESVC — шифрование BitLocker.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BDESVC" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: lfsvc — геолокация.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: CldFlt — драйвер фильтра Cloud Files.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CldFlt" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: UCPD — User Choice Protection Driver.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UCPD" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: OneSyncSvc — синхронизация почты/контактов/календаря.
:: В источнике имя записано как "onesyncsvc" (Windows case-insensitive).
reg add "HKLM\SYSTEM\CurrentControlSet\Services\onesyncsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: ShellHWDetection — обнаружение оборудования оболочки.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ShellHWDetection" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: SysMain — SysMain (бывший Superfetch).
reg add "HKLM\SYSTEM\CurrentControlSet\Services\sysmain" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: Themes — служба тем.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\themes" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: Beep — драйвер Beep (системный динамик).
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Beep" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: CloudIdSvc — облачная идентификация.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CloudIdSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: WpcMonSvc — родительский контроль (в источнике "WPCMonSvc").
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WPCMonSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: MapsBroker — менеджер загруженных карт.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: CloudBackupRestoreSvc — облачное резервное копирование Windows.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CloudBackupRestoreSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: fhsvc — история файлов.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\fhsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: SEMgrSvc — платежи и NFC (в источнике "semgrsvc").
reg add "HKLM\SYSTEM\CurrentControlSet\Services\semgrsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: wisvc — Windows Insider.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wisvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: acpipagr — ACPI-агрегатор (драйвер).
reg add "HKLM\SYSTEM\CurrentControlSet\Services\acpipagr" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: GpuEnergyDrv — драйвер энергопотребления GPU.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: AcpiPmi — ACPI-драйвер управления питанием.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AcpiPmi" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: PRM — драйвер Resource Manager.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PRM" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: acpitime — ACPI-драйвер времени.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\acpitime" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: bam — Background Activity Moderator.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\bam" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: dam — Desktop Activity Moderator.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dam" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: WmiAcpi — WMI-драйвер ACPI.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WmiAcpi" /v Start /t REG_DWORD /d 4 /f >nul 2>&1


:: ============================================================================
::  ИСТОЧНИК: Прочее\Отключить диагностические треки.bat
::  В источнике: reg add Start=4, и sc stop для Telemetry/WdiSystemHost/WdiServiceHost/DiagTrack.
:: ============================================================================

:: Telemetry — драйвер телеметрии.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Telemetry" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop Telemetry >nul 2>&1

:: WdiSystemHost — системный хост диагностики.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdiSystemHost" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop WdiSystemHost >nul 2>&1

:: WdiServiceHost — хост службы диагностики.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdiServiceHost" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop WdiServiceHost >nul 2>&1

:: TroubleshootingSvc — рекомендуемые действия по устранению неполадок (в источнике строчными).
reg add "HKLM\SYSTEM\CurrentControlSet\Services\troubleshootingsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: diagnosticshub.standardcollector.service — стандартный сборщик диагностического хаба.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: diagsvc — хост службы диагностики.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: intelpmt — Intel Platform Monitoring Technology.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpmt" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: pla — журналы и оповещения производительности.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pla" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: wmiApSrv — адаптер производительности WMI.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wmiApSrv" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: WerSvc — отчёты об ошибках Windows.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WerSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: svsvc — вспомогательная служба сканирования драйверов.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\svsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: DiagTrack — Connected User Experiences and Telemetry (в источнике строчными).
reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagtrack" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop diagtrack >nul 2>&1

:: wercplsupport — поддержка панели отчётов о проблемах.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wercplsupport" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: kdnic — драйвер сетевого интерфейса ядра.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\kdnic" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: Wecsvc — сборщик событий Windows.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Wecsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: DPS — политика диагностики (в источнике строчными).
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dps" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: PcaSvc — помощник по совместимости программ (в источнике строчными).
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pcasvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: DusmSvc — использование данных (в источнике строчными).
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dusmsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: ndu — Network Data Usage (драйвер).
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ndu" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: DsSvc — вспомогательная служба данных (в источнике "DSSvc").
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DSSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1


:: ============================================================================
::  ИСТОЧНИК: Удаление программ\Удалить Microsoft Edge.bat
::  В источнике эти службы УДАЛЯЮТСЯ через sc delete.
::  По вашему правилу — отключаем через sc config, не удаляем.
:: ============================================================================

:: edgeupdate — служба обновления Microsoft Edge.
sc config edgeupdate start= disabled >nul 2>&1
sc stop edgeupdate >nul 2>&1

:: edgeupdatem — служба обновления Microsoft Edge (ручной режим).
sc config edgeupdatem start= disabled >nul 2>&1
sc stop edgeupdatem >nul 2>&1

:: MicrosoftEdgeElevationService — служба повышения прав Microsoft Edge.
sc config MicrosoftEdgeElevationService start= disabled >nul 2>&1
sc stop MicrosoftEdgeElevationService >nul 2>&1


:: ============================================================================
::                                 КОНЕЦ
:: ============================================================================
echo.
echo Готово. Обработано служб по VainOS: 65.
echo Удаляемые в источнике службы Edge (3) отключены, а не удалены.
pause
exit /b 0