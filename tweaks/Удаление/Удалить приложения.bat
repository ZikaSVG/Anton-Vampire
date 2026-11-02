@echo off
chcp 65001 >nul
title Удалить приложения
cls
echo ==========================================
echo    Удалить приложения
echo    Файлов: 10
echo    Путь: Удалить приложения
echo ==========================================
rem Файл: ЗащитникУбийца.bat
:: DefenderKiller By Vlado -  https://win10tweaker.ru/forum/topic/defenderkiller
:: Thanks for test Eject - https://win10tweaker.ru/forum/profile/eject
:: StopDefender - https://github.com/lab52io/StopDefender
:: FuckDefender - http://win10tweaker.ru/fwd
:: NsudoLC - https://github.com/M2TeamArchived/NSudo/releases
:: nhmb - https://nhutils.ru/blog/nhmb/
:: LGPO - https://www.microsoft.com/en-us/download/details.aspx?id=55319
:: Last Version - https://pastebin.com/raw/dnENFgmC
:Start
	@echo off
	Title DK
	chcp 866 >nul
	SetLocal EnableDelayedExpansion
	Color 0f
	cd /d "%~dp0Work"
	reg query "HKU\S-1-5-19" >nul 2>&1
rem Цветной текст/lgpo
	set "ch=cecho.exe"
	set "LGPOtemp=LGPO-temp.txt"
	set "RepeatDel="
rem Версия программы/Удаляем файл, который может оставаться после обновления в корне диска
	set Version=11.1.3
	set DateProgram=18.01.2024
	if exist "%SystemDrive%\latestVersion.bat" del /q "%SystemDrive%\latestVersion.bat"
rem Если не существует WMIC/nhmb
rem Получение SID перед запуском от имени TI
	for /f %%s in ('2^>nul wmic UserAccount where "Domain='%UserDomain%' and Name='%UserName%'" Get SID^|find "-"') do set SID=%%s
rem Проверка разрядности системы
	set xOS=x64& (If "%PROCESSOR_ARCHITECTURE%"=="x86" If Not Defined PROCESSOR_ARCHITEW6432 Set xOS=x86)
rem Запуск от имени TI
rem Размер программы в зависимости от наличия службы, расположение по центру экрана и название
	set "serviceswebmask="
	for /f "usebackq delims=" %%n In (`2^>nul reg query "HKLM\System\CurrentControlSet\Services" /f "webthreatdefusersvc*" /k^|findstr ^H`) do set serviceswebmask=%%~nxn
	if defined serviceswebmask (Mode 82,45) else (Mode 80,45)
	nircmd win center process cmd.exe & nircmd win settext foreground "DK"
rem SmartScreen | Процессы | Службы | Драйвера | Задачи | Проверка наличия GP [Home версия]
	set "ArgNsudo="
	reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" | find /i "0x0" >nul 2>&1 && set "ArgNsudo=C" || set "ArgNsudo=E"
	if not exist "%SystemRoot%\System32\smartscreen.exe" (set "SmartScreen=0a") else (set "SmartScreen=0c")
	if not exist "%SystemRoot%\System32\gpedit.msc" set "NoGP=Yes"
(
	qprocess "MsMpEng.exe" && set "MsMpEng=0c" || set "MsMpEng=0a"
	qprocess "SgrmBroker.exe" && set "SgrmBroker=0c" || set "SgrmBroker=0a"
	qprocess "uhssvc.exe" && set "uhssvc=0c" || set "uhssvc=0a"
	qprocess "NisSrv.exe" && set "NisSrv=0c" || set "NisSrv=0a"
	qprocess "MpCmdRun.exe" && set "MpCmdRun=0c" || set "MpCmdRun=0a"
	qprocess "MPSigStub.exe" && set "MPSigStub=0c" || set "MPSigStub=0a"
	qprocess "SecHealthUI.exe" && set "SecHealthUI=0c" || set "SecHealthUI=0a"
	qprocess "SecurityHealthSystray.exe" && set "SecurityHealthSystray=0c" || set "SecurityHealthSystray=0a"
	qprocess "SecurityHealthService.exe" && set "SecurityHealthService=0c" || set "SecurityHealthService=0a"
	qprocess "SecurityHealthHost.exe" && set "SecurityHealthHost=0c" || set "SecurityHealthHost=0a"
	sc query WinDefend && set "WinDefend=0c" || set "WinDefend=0a"
	sc query WdNisSvc && set "WdNisSvc=0c" || set "WdNisSvc=0a"
	sc query Sense && set "Sense=0c" || set "Sense=0a"
	sc query wscsvc && set "wscsvc=0c" || set "wscsvc=0a"
	sc query SgrmBroker && set "SgrmBroker=0c" || set "SgrmBroker=0a"
	sc query SecurityHealthService && set "SecurityHealthService=0c" || set "SecurityHealthService=0a"
	sc query webthreatdefsvc && set "webthreatdefsvc=0c" || set "webthreatdefsvc=0a"
	sc query webthreatdefusersvc && set "webthreatdefusersvc=0c" || set "webthreatdefusersvc=0a"
	sc query WdNisDrv && set "WdNisDrv=0c" || set "WdNisDrv=0a"
	sc query WdBoot && set "WdBoot=0c" || set "WdBoot=0a"
	sc query WdFilter && set "WdFilter=0c" || set "WdFilter=0a"
	sc query SgrmAgent && set "SgrmAgent=0c" || set "SgrmAgent=0a"
	sc query wtd && set "wtd=0c" || set "wtd=0a"
	sc query MsSecWfp && set "MsSecWfp=0c" || set "MsSecWfp=0a"
	sc query MsSecFlt && set "MsSecFlt=0c" || set "MsSecFlt=0a"
	sc query MsSecCore && set "MsSecCore=0c" || set "MsSecCore=0a"
) >nul 2>&1
	set PathTask=%SystemRoot%\System32\Tasks\Microsoft\Windows\Windows Defender
	if not exist "%PathTask%\Windows Defender Cache Maintenance" (set "Maintenance=0a") else (set "Maintenance=0c")
	if not exist "%PathTask%\Windows Defender Scheduled Scan" (set "Scan=0a") else (set "Scan=0c")
	if not exist "%PathTask%\Windows Defender Verification" (set "Verification=0a") else (set "Verification=0c")
	if not exist "%PathTask%\Windows Defender Cleanup" (set "Cleanup=0a") else (set "Cleanup=0c")
	if not exist "%SystemRoot%\System32\Tasks\Microsoft\Windows\AppID\SmartScreenSpecific" (set "SmartScreenSpecific=0a") else (set "SmartScreenSpecific=0c")
	%ch% {03}Состояние процессов защитника:{\n #}
	%ch% {%SmartScreen%}SmartScreen{\n #}
	%ch% {%MsMpEng%}MsMpEng{#}   {08} [Antimalware Service Executable]{\n #}
	%ch% {%SgrmBroker%}SgrmBroker{#} {08}[Брокер среды выполнения System Guard]{\n #}
	%ch% {%uhssvc%}uhssvc{#}    {08} [Microsoft Update Health Service]{\n #}
	%ch% {%NisSrv%}NisSrv{#}    {08} [Network Realtime Inspection]{\n #}
	%ch% {%MpCmdRun%}MpCmdRun{#}  {08} [Microsoft malware protection]{\n #}
	%ch% {%MPSigStub%}MPSigStub{#}{08}  [Malware Protection Signature Update Stub]{\n #}
	%ch% {%SecHealthUI%}SHealthUI{#}{08}  [Безопасность Windows]{\n #}
	%ch% {%SecurityHealthSystray%}HealthTray{#}{08} [SecurityHealthSystray иконка в трее]{\n #}
	%ch% {%SecurityHealthService%}HealthServ{#}{08} [SecurityHealthService]{\n #}
	%ch% {%SecurityHealthHost%}HealthHost{#}{08} [SecurityHealthHost]{\n #}{\n #}
	%ch% {03}Состояние служб и драйверов защитника:{\n #}
	%ch% {%webthreatdefsvc%}webthreat{#}  {08}[Служба защиты от Веб-угроз - webthreatdefsvc]{\n #}
	if defined serviceswebmask (
	%ch% {%webthreatdefusersvc%}webthreatu{#} {08}[Служба защиты пользоват. от Веб-угроз - {04}%serviceswebmask%{08}]{\n #}
	) else (
	%ch% {%webthreatdefusersvc%}webthreatu{#} {08}[Служба защиты пользоват. от Веб-угроз - webthreatdefusersvc]{\n #}
	)
	%ch% {%WinDefend%}WinDefend{#} {08} [Служба Антивирусная программа Защитника Windows]{\n #}
	%ch% {%WdNisSvc%}WdNisSvc{#} {08}  [Служба проверки сети Windows Defender Antivirus]{\n #}
	%ch% {%Sense%}Sense{#}     {08} [Служба Advanced Threat Protection]{\n #}
	%ch% {%wscsvc%}wscsvc{#}     {08}[Служба Центр обеспечения безопасности]{\n #}
	%ch% {%SgrmBroker%}SgrmBroker{#} {08}[Служба Брокер мониторинга среды выполнения System Guard]{\n #}
	%ch% {%SecurityHealthService%}SHealthSer{#} {08}[Служба Центр безопасности Защитника Windows]{\n #}
	%ch% {%WdNisDrv%}WdNisDrv{#}   {08}[Драйвер WD Network Inspection Driver]{\n #}
	%ch% {%WdBoot%}WdBoot{#}     {08}[Драйвер WD Antivirus Boot Driver]{\n #}
	%ch% {%WdFilter%}WdFilter{#}{08}   [Драйвер WD Antivirus Mini-Filter Driver]{\n #}
	%ch% {%SgrmAgent%}SgrmAgent{#}{08}  [Драйвер System Guard Runtime Monitor Agent Driver]{\n #}
	%ch% {%wtd%}wtd{#}{08}        [Драйвер WTD Driver]{\n #}
	%ch% {%MsSecWfp%}MsSecWfp{#}{08}   [Драйвер Microsoft Security WFP Callout Driver]{\n #}
	%ch% {%MsSecFlt%}MsSecFlt{#}{08}   [Драйвер Security Events Component Minifilter]{\n #}
	%ch% {%MsSecCore%}MsSecCore{#}{08}  [Драйвер Microsoft Security Core Boot Driver]{\n #}
	echo.
	%ch% {03}Состояние заданий в планировщике:{\n #}
	%ch% {%Maintenance%}Windows Defender Cache Maintenance{\n #}
	%ch% {%Scan%}Windows Defender Scheduled Scan{\n #}
	%ch% {%Verification%}Windows Defender Verification{\n #}
	%ch% {%Cleanup%}Windows Defender Cleanup{\n #}
	%ch% {%SmartScreenSpecific%}SmartScreenSpecific{\n #}
	echo.
	%ch% {0f}1{#} - {0c}Удалить Защитник Windows{\n #}
	%ch% {0f}2{#} - {0f}Состояние папок и файлов{\n #}
	%ch% {0f}3{#} - {03}Проверить обновления DK {08}[текущая  {09}%Version% {08}от {03}%DateProgram% {08}^| By {02}Vlado{08}]{\n #}
	%ch% {0f}4{#} - {08}Восстановить Защитник Windows{\n #}
	%ch% {0f}5{#} - {08}Информация о DK{\n #}
	set "input="
	set /p input=
	if not defined input cls && goto Start
	if "%input%"=="1"  cls && goto DeleteDefender
	if "%input%"=="2"  cls && goto Catalogs
	if "%input%"=="3"  cls && goto CheckUpdate
	if "%input%"=="4"  cls && goto RestoreDefender
	if "%input%"=="5"  cls && goto Information 
	) else (
	cls & %ch%    {0c}Такой функции не существует{\n #}
	timeout /t 1 >nul & endlocal & goto Start
	)
:DeleteDefender
rem Проверка места на диске перед удалением
	set "sFreeSize="
	set "sFreeSizePseudoMb="
	set "sFreeSizePseudoMb1="
	set "Freed="
	set "NameSecHealth="
	set "NotChangeUAC="
	for /f "usebackq tokens=2 delims==" %%i in (`wmic.exe LogicalDisk where "Name='c:'" get FreeSpace /value`) do set sFreeSize=%%i
	if defined sFreeSize set sFreeSizePseudoMb=%sFreeSize:~0,-7%
rem Если существует папка защитника ...
	if exist "%AllUsersProfile%\Microsoft\Windows Defender" (
rem Проверяем удалялся ли защитник ранее по ветке реестра, которая удаляется в процессе удаления. Если защитник не удалён - проверяем состояние Защиты от подделки.
	reg query "HKLM\Software\Microsoft\Windows Defender\Features" >nul 2>&1 && echo >nul || goto NotTamper
rem Проверяем наличие приложения Безопасность Windows
	for /F "usebackq delims=" %%n In (`2^>nul reg query "HKU\!SID!\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages" /f "*SecHealthUI*" /k^|findstr ^H`) do set NameSecHealth=%%~nxn
rem Если приложение Безопасность не удалено, проверяем состояние защиты от подделки
	if defined NameSecHealth (
	reg query "HKLM\Software\Microsoft\Windows Defender\Features" /v "TamperProtection" | find /i "0x4" >nul 2>&1 && (
	%ch%    {0a} Защита от подделки отключена^^!{\n #}{\n #}
	) || (
	%ch%    {04} Будут выключены все параметры Defender в автоматическом режиме.{\n #}
	%ch%    {08} Если что-то не отключилось - отключите вручную.{\n #}
	%ch%    {08} Главное, что необходимо отключить - {04}Защита от подделки{\n #}{\n #}
	%ch%    {0c} Если у Вас Windows 10 - необходимо вручную отключить "Защиту от подделки"{\n #}{\n #}
	%ch%    {08} Нажмите любую клавишу для продолжения{\n #}
rem Отключаем всплывающее окно UAC, если UAC не отключался ранее, чтобы nircmd sendkeypress работало без окна UAC
	reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" | find /i "0x0" >nul && set "NotChangeUAC=Yes"
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 0 /f >nul
rem Запускаем параметры
	explorer windowsdefender://ThreatSettings
	timeout /t 2 /nobreak >nul
rem Выключаем все параметры с помощью nircmd
	nircmd sendkeypress 0x20 0x09 0x20 0x09 0x20 0x09 0x09 0x20
:TamperProtectionStatus
rem Проверяем наличие процесса окна безопасности, если процесс существует, проверяем отключилась ли защита от подделки. Если процесса нет - выводим сообщение.
	qprocess SecHealthUI.exe >nul 2>&1 && (
	echo>nul) || (
	%ch%    {0c} Защита от подделки {4f}не{0c} отключена^^!{\n #}{\n #}
	%ch%    {08} 1 - {0c}Я не могу отключить защиту от подделки{\n #}
	%ch%    {04} Используйте, если действительно не можете отключить данную функцию{\n #}{\n #}
	%ch%    {0c} ВЫПОЛНЯЯ ЭТОТ ШАГ, ВЫ ПРОПУСКАЕТЕ СОЗДАНИЕ РЕЗЕРВНОЙ КОПИИ ЗАЩИТНИКА{\n #}{\n #}
	%ch%    {08} 2 - Вернуться обратно{\n #}
	choice /c 12 /n /m " "
	if errorlevel 2 cls && goto Start
	if errorlevel 1 cls && goto NotTamper)
rem Проверка защиты от подделки после nircmd sendkeypress
	reg query "HKLM\Software\Microsoft\Windows Defender\Features" /v "TamperProtection" | find /i "0x4" >nul 2>&1 && cls && %ch%    {0a} Защита от подделки отключена^^!{\n #}{\n #}|| goto TamperProtectionStatus
		)
	)
rem Фокус на программу
	nircmd win activate process cmd.exe
rem Вопрос о создании рез. копии
	nhmb "Вы хотите создать резервную копию Windows Defender перед выполнением удаления?\nРезервная копия позволяет восстановить защитник после удаления.\nВосстановление может потребоваться, если Вы обновляете Windows.\n\nВыбирайте нет, только в том случае, если Вам НЕ нужны обновления Windows, либо у Вас уже есть резервная копия защитника с этой версии Windows." "BackupDefender" "Warning|YesNo|DefButton2"
	if errorlevel 7 goto NotTamper
	if errorlevel 6 call :CreateBackupDefender
:NotTamper
rem Восстанавливаем по умолчанию, если параметр ConsentPromptBehaviorAdmin не изменялся ранее [в значение 5 по-умолчанию]
	if not defined NotChangeUAC reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 5 /f >nul
rem Если нет GP - пропуск [Home версия]
	if defined NoGP %ch%    {08}Пропуск отключения ГП, т.к. не найдено ГП{\n #}&&goto NotGP
	%ch%    {03} Отключаем защитник [ГП] ^>
rem Информация по политикам : https://learn.microsoft.com/ru-ru/windows/client-management/mdm/policy-csp-admx-microsoftdefenderantivirus
rem Выключить антивирусную программу Microsoft Defender (включена) [DisableAntiSpyware]
rem Разрешить постоянную работу службы защиты от вредоносных программ (отключена) [ServiceKeepAlive]
rem Выключить плановое исправление (включено) [DisableRoutinelyTakingAction]
rem Разрешить запуск службы защиты от вредоносных программ с обычным приоритетом (отключено) [AllowFastServiceStartup]
rem Выключить защиту в реальном времени (включено) [DisableRealtimeMonitoring]
rem Проверять все загруженные файлы и вложения (отключено) [DisableIOAVProtection]
rem Включить наблюдение за поведением (отключено) [DisableBehaviorMonitoring]
rem Включить проверку процессов, если включена защита в режиме реального времени (отключено) [DisableScanOnRealtimeEnable]
rem Отслеживать активность программ и файлов на компьютере (отключено) [DisableOnAccessProtection]
rem Настроить локальное переопределение для включения защиты в режиме реального времени (отключено) [LocalSettingOverrideDisableRealtimeMonitoring]
rem Настроить локальное переопределение для включения контроля поведения (отключено) [LocalSettingOverrideDisableBehaviorMonitoring]
rem Настроить локальное переопределение для проверки всех загруженных файлов и вложений (отключено) [LocalSettingOverrideDisableIOAVProtection]
rem Настроить локальное переопределение для отправки отчётов в MAPS (отключено) [LocalSettingOverrideSpynetReporting]
rem Присоединится к Microsoft MAPS (отключено) [**del.SpynetReporting]
rem Отправлять образцы файлов, если требуется дальнейший анализ (включено) [SubmitSamplesConsent]
rem Разрешить обновления службы безопасности в реальном времени на основе отчётов в Microsoft MAPS (отключено) [RealtimeSignatureDelivery]
rem Запускать обновления службы анализа безопасности при запуске (отключено) [DisableUpdateOnStartupWithoutEngine]
rem Проверять наличие последней версии службы защиты при запуске (отключено) [UpdateOnStartUp]
rem Включить проверку после обновления службы анализа безопасности (отключено) [DisableScanOnUpdate]
rem Настроить события программы "Доктор Ватсон" (отправка данных сборщиком ошибок) (отключено) [DisableGenericRePorts]
rem Включить дополнительную проверку для полных/быстрых проверок (отключено) [DisableCatchupFullScan/DisableCatchupQuickScan]
rem Проверять съемные носители во время быстрого сканирования (отключено) [DisableRemovableDriveScanning]
rem Проверять сетевые файлы (отключено) [DisableScanningNetworkFiles]
rem Выполнять полную проверку на подключенных сетевых дисках (отключено) [DisableScanningMappedNetworkDrivesForFullScan]
rem Проверять архивные файлы (отключено) [DisableArchiveScanning]
rem Настроить функцию SmartScreen Защитника Windows (3 политики) (отключены)
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "AllowFastServiceStartup" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableRealtimeMonitoring" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableBehaviorMonitoring" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableIOAVProtection" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Spynet" /v "LocalSettingOverrideSpynetReporting" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Spynet" /v "**del.SpynetReporting" /t REG_SZ /d " " /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d "2" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "RealtimeSignatureDelivery" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableUpdateOnStartupWithoutEngine" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "UpdateOnStartUp" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableScanOnUpdate" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Reporting" /v "DisableGenericRePorts" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableCatchupFullScan" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableCatchupQuickScan" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableRemovableDriveScanning" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableScanningNetworkFiles" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableScanningMappedNetworkDrivesForFullScan" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableArchiveScanning" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "**del.ShellSmartScreenLevel" /t REG_SZ /d " " /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d "0" /f
	call :LGPO_APPLY
:NotGP
rem Фокус на программу
	nircmd win activate process cmd.exe
rem SmartScreen BX
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f >nul
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide cmd.exe /c reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f >nul
rem Уведомления от центра безопасности
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d "0" /f >nul
rem MSRT - Средство удаления вредоносных программ от Microsoft. [Не отправлять отчеты от MSRT/Отключить получение обновлений для MSRT]
	reg add "HKLM\Software\Policies\Microsoft\MRT" /v "DontReportInfectionInformation" /t REG_DWORD /d "1" /f >nul
	reg add "HKLM\Software\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /t REG_DWORD /d "1" /f >nul
	)
rem Пропуск Unlocker; DefenderStop, если защитник уже удалён
	if not exist "%AllUsersProfile%\Microsoft\Windows Defender" goto NotFuckWD
	if not exist "%SystemDrive%\Program Files\Windows Defender" goto NotFuckWD
rem                                                                   =================================
rem Если это вторая [повторная] проходка удаления, то пропускаем добавление в исключения
	if not defined RepeatDel (
	%ch%    {03} Добавляем Unlocker/DefenderStop в исключения{\n #}{\n #}
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide -Wait PowerShell "Add-MpPreference -ExclusionPath '%~dp0Work', '%LocalAppData%\Temp\RarSFX0', '%LocalAppData%\Temp\RarSFX1', '%LocalAppData%\Temp\RarSFX2', '%Temp%\RarSFX0', '%Temp%\RarSFX1', '%Temp%\RarSFX2'" >nul 2>&1)
rem Завершаем процессы Защитника
	nircmd killprocess MpCmdRun.exe
	nircmd killprocess MsMpEng.exe
	nircmd killprocess SecurityHealthSystray.exe
	nircmd killprocess SecurityHealthService.exe
	nircmd killprocess SecurityHealthHost.exe
	nircmd killprocess smartscreen.exe
	nircmd killprocess SgrmBroker.exe
	nircmd killprocess SecHealthUI.exe
	nircmd killprocess uhssvc.exe
	nircmd killprocess NisSrv.exe
	nircmd killprocess MPSigStub.exe
	if not exist DefenderStop.exe (
	ping www.google.nl -n 1 -w 1000 |>nul find /i "TTL=" && curl -g -k -L -# -o "DefenderStop.exe" "https://i.getspace.eu/cloud/s/GXAtGk7qLbHj2CS/download" >nul 2>&1
	) || %ch%    {0c} Невозможно скачать DefenderStop/Unlocker. Нет подключения к интернету{\n #}{\n #}&& goto NotFuckWD
	%ch%    {03} Используем DefenderStop{\n #}{\n #}
	nircmd exec hide DefenderStop.exe
	nircmd wait 3000
	nircmd exec hide DefenderStop.exe
rem                                                                   =================================
	if "%xOS%"=="x86" (
	%ch%    {04} Unlocker не работает на x32 системе.{\n #}
	%ch%    {04} После перезагрузки ПК необходимо повторное удаление.{\n #}
	goto NotFuckWD)
	if not exist FuckDefender.exe curl -g -k -L -# -o "FuckDefender.exe" "https://i.getspace.eu/cloud/s/Eb3sKTfwiamRAnt/download" >nul 2>&1
	%ch%    {0c} Выполняется удаление с помощью Unlocker{\n #}
	%ch%    {08} Время ожидания - 20 сек.{\n #}{\n #}
rem By XpucT/Vlado/Eject
	start FuckDefender
	timeout /t 3 /nobreak >nul
	qprocess Unlocker.exe >nul 2>&1 && echo >nul || goto NotFuckWD
rem Ждём 20 секунд, если Unlocker смог запуститься
(
	timeout /t 20 /nobreak
	taskkill /f /im Unlocker.exe
	taskkill /f /im FuckDefender.exe
	taskkill /f /im wscript.exe
	nircmd killprocess Unlocker.exe & nircmd killprocess FuckDefender.exe & nircmd killprocess wscript.exe
rem Удаляем Unlocker и драйвер. Восстановится сам, если используется IObitUnlocker - https://cdn.discordapp.com/attachments/1099332280629084163/1196482117383766138/IObitUnlocker_Test.mp4
	del /q FuckDefender.exe
	sc delete IObitUnlocker
	reg delete HKLM\System\CurrentControlset\Services\IObitUnlocker /f	
) >nul 2>&1
rem                                                                   =================================
:NotFuckWD
	%ch%    {03} Удаляем папки и файлы WD{\n #}{\n #}
(
rem ProgramData
	rmdir /s /q "%AllUsersProfile%\Microsoft\Windows Defender"
	rmdir /s /q "%AllUsersProfile%\Microsoft\Windows Defender Advanced Threat Protection"
	rmdir /s /q "%AllUsersProfile%\Microsoft\Windows Security Health"
	rmdir /s /q "%AllUsersProfile%\Microsoft\Storage Health"
rem SystemDrive - Program Files
	rmdir /s /q "%SystemDrive%\Program Files\Windows Defender"
	rmdir /s /q "%SystemDrive%\Program Files\Windows Defender Sleep"
	rmdir /s /q "%SystemDrive%\Program Files\Windows Defender Advanced Threat Protection"
	rmdir /s /q "%SystemDrive%\Program Files\Windows Security"
	rmdir /s /q "%SystemDrive%\Program Files\PCHealthCheck"
	rmdir /s /q "%SystemDrive%\Program Files\Microsoft Update Health Tools"
rem SystemDrive - Program Files 86
	rmdir /s /q "%SystemDrive%\Program Files (x86)\Windows Defender"
	rmdir /s /q "%SystemDrive%\Program Files (x86)\Windows Defender Advanced Threat Protection"
rem Windows
	rmdir /s /q "%SystemRoot%\security\database"
rem Windows - System32
	rmdir /s /q "%SystemRoot%\System32\HealthAttestationClient"
	rmdir /s /q "%SystemRoot%\System32\SecurityHealth"
	rmdir /s /q "%SystemRoot%\System32\WebThreatDefSvc"
	rmdir /s /q "%SystemRoot%\System32\Sgrm"
	rmdir /s /q "%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\Defender"
	rmdir /s /q "%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\DefenderPerformance"
	rmdir /s /q "%SystemRoot%\System32\Tasks_Migrated\Microsoft\Windows\Windows Defender"
	rmdir /s /q "%SystemRoot%\System32\drivers\wd"
rem Windows - SysWOW64
	rmdir /s /q "%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\Modules\Defender"
	rmdir /s /q "%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\Modules\DefenderPerformance"
rem Переименование файлов которые могут мешать удалению
	if exist "%AllUsersProfile%\Microsoft\Windows Defender\Platform" (
	for /r "%AllUsersProfile%\Microsoft\Windows Defender\Platform" %%i in ("MpOAV.dll") do ren "%%i" "MpOAV.dll_fuck" >nul 2>&1
	for /r "%AllUsersProfile%\Microsoft\Windows Defender\Platform" %%i in ("MpClient.dll") do ren "%%i" "MpClient.dll_fuck" >nul 2>&1
	for /r "%AllUsersProfile%\Microsoft\Windows Defender\Platform" %%i in ("MsMpEng.exe") do ren "%%i" "MsMpEng.exe_fuck" >nul 2>&1)
	if exist "%SystemDrive%\Program Files\Windows Defender" (
	ren "%SystemDrive%\Program Files\Windows Defender\MpOAV.dll" "MpOAV.dll_fuck" >nul 2>&1
	ren "%SystemDrive%\Program Files\Windows Defender\MpClient.dll" "MpClient.dll_fuck" >nul 2>&1
	ren "%SystemDrive%\Program Files\Windows Defender\MsMpEng.exe" "MsMpEng.exe_fuck" >nul 2>&1)
	ren "%SystemRoot%\System32\SecurityHealthService.exe" "SecurityHealthService.exe_fuck"
	ren "%SystemRoot%\System32\smartscreenps.dll" smartscreenps.dll_fuck
	ren "%SystemRoot%\System32\wscapi.dll" wscapi.dll_fuck
rem WindowsDefenderApplicationGuard.wim
	del /f /q "%SystemRoot%\Containers\WindowsDefenderApplicationGuard.wim"
	del /f /q "%SystemRoot%\Containers\serviced\WindowsDefenderApplicationGuard.wim"
rem Удаление файлов System32
	del /f /q "%SystemRoot%\System32\SecurityHealthService.exe"
	del /f /q "%SystemRoot%\System32\SecurityHealthService.exe_fuck"
	del /f /q "%SystemRoot%\System32\SecurityHealthSystray.exe"
	del /f /q "%SystemRoot%\System32\SecurityHealthHost.exe"
	del /f /q "%SystemRoot%\System32\SecurityHealthAgent.dll"
	del /f /q "%SystemRoot%\System32\SecurityHealthSSO.dll"
	del /f /q "%SystemRoot%\System32\SecurityHealthProxyStub.dll"
	del /f /q "%SystemRoot%\System32\LogFiles\WMI\RtBackup\EtwRTDefenderApiLogger.etl"
	del /f /q "%SystemRoot%\System32\LogFiles\WMI\RtBackup\EtwRTDefenderAuditLogger.etl"
	del /f /q "%SystemRoot%\System32\smartscreen.dll"
	del /f /q "%SystemRoot%\System32\wscisvif.dll"
	del /f /q "%SystemRoot%\System32\wscproxystub.dll"
	del /f /q "%SystemRoot%\System32\smartscreenps.dll"
	del /f /q "%SystemRoot%\System32\smartscreenps.dll_fuck"
	del /f /q "%SystemRoot%\System32\wscapi.dll"
	del /f /q "%SystemRoot%\System32\wscapi.dll_fuck"
	del /f /q "%SystemRoot%\System32\windowsdefenderapplicationguardcsp.dll"
	del /f /q "%SystemRoot%\System32\wscsvc.dll"
	del /f /q "%SystemRoot%\System32\SecurityHealthCore.dll"
	del /f /q "%SystemRoot%\System32\SecurityHealthSsoUdk.dll"
	del /f /q "%SystemRoot%\System32\SecurityHealthUdk.dll"
rem Удаление SmartScreen.exe
	taskkill /f /im smartscreen.exe
	ren "%SystemRoot%\System32\smartscreen.exe" "smartscreen.exedel"
	del /f /q "%SystemRoot%\System32\smartscreen.exe"
	del /f /q "%SystemRoot%\System32\smartscreen.exedel"
rem Удаление файлов SysWOW64
	del /f /q "%SystemRoot%\SysWOW64\smartscreen.dll"
	del /f /q "%SystemRoot%\SysWOW64\wscisvif.dll"
	del /f /q "%SystemRoot%\SysWOW64\wscproxystub.dll"
	del /f /q "%SystemRoot%\SysWOW64\smartscreenps.dll"
	del /f /q "%SystemRoot%\SysWOW64\wscapi.dll"
	del /f /q "%SystemRoot%\SysWOW64\windowsdefenderapplicationguardcsp.dll"
) >nul 2>&1
rem                                                                   =================================
	%ch%    {03} Удаляем службы{\n #}
	%ch%    {0a} WinDefend, SecurityHealthService, Sense, WdNisSvc, wscsvc, webthreatdefsvc{\n #}
	%ch%    {0a} webthreatdefusersvc{\n #}{\n #}
	if exist DefenderStop.exe nircmd exec hide DefenderStop.exe
(
rem Остановка служб
	sc stop WinDefend
	sc stop SecurityHealthService
	sc stop Sense
	sc stop WdNisSvc
	sc stop wscsvc
	sc stop SgrmBroker
	sc stop webthreatdefsvc
	sc stop webthreatdefusersvc
	sc stop %serviceswebmask%
rem Удаление служб
	sc delete WinDefend
	sc delete SecurityHealthService
	sc delete Sense
	sc delete WdNisSvc
	sc delete wscsvc
	sc delete SgrmBroker
	sc delete webthreatdefsvc
	sc delete webthreatdefusersvc
	sc delete %serviceswebmask%
	reg delete HKLM\System\ControlSet001\Services\EventLog\System\WinDefend /f 
	reg delete HKLM\System\ControlSet001\Services\SecurityHealthService /f
	reg delete HKLM\System\ControlSet001\Services\Sense /f
	reg delete HKLM\System\ControlSet001\Services\WdNisSvc /f
	reg delete HKLM\System\ControlSet001\Services\WinDefend /f
	reg delete HKLM\System\ControlSet001\Services\wscsvc /f
	reg delete HKLM\System\ControlSet001\Services\SgrmBroker /f
	reg delete HKLM\System\ControlSet001\Services\webthreatdefsvc /f
	reg delete HKLM\System\ControlSet001\Services\webthreatdefusersvc /f
	reg delete HKLM\System\CurrentControlSet\Services\EventLog\System\WinDefend /f
	reg delete HKLM\System\CurrentControlset\Services\SecurityHealthService /f
	reg delete HKLM\System\CurrentControlset\Services\Sense /f
	reg delete HKLM\System\CurrentControlset\Services\WdNisSvc /f
	reg delete HKLM\System\CurrentControlset\Services\WinDefend /f
	reg delete HKLM\System\CurrentControlset\Services\wscsvc /f
	reg delete HKLM\System\CurrentControlset\Services\SgrmBroker /f
	reg delete HKLM\System\CurrentControlset\Services\webthreatdefsvc /f
	reg delete HKLM\System\CurrentControlset\Services\webthreatdefusersvc /f
	del /q DefenderStop.exe
) >nul 2>&1
rem                                                                   =================================
	%ch%    {03} Удаляем драйвера{\n #}
	%ch%    {0a} WdNisDrv, WdBoot, WdFilter, SgrmAgent, wtd, MsSecWfp, MsSecFlt, MsSecCore{\n #}{\n #}
(
rem Отключение и удаление драйверов
	sc stop WdNisDrv
	sc stop WdBoot
	sc stop WdFilter
	sc stop SgrmAgent
	sc stop wtd
	sc stop MsSecWfp
	sc stop MsSecFlt
	sc stop MsSecCore
	sc delete WdNisDrv
	sc delete WdBoot
	sc delete WdFilter
	sc delete SgrmAgent
	sc delete wtd
	sc delete MsSecWfp
	sc delete MsSecFlt
	sc delete MsSecCore
	reg delete "HKLM\System\CurrentControlset\Services\WdNisDrv" /f
	reg delete "HKLM\System\CurrentControlset\Services\WdBoot" /f
	reg delete "HKLM\System\CurrentControlset\Services\WdFilter" /f
	reg delete "HKLM\System\CurrentControlset\Services\SgrmAgent" /f
	reg delete "HKLM\System\CurrentControlset\Services\wtd" /f
	reg delete "HKLM\System\CurrentControlset\Services\MsSecWfp" /f
	reg delete "HKLM\System\CurrentControlset\Services\MsSecFlt" /f
	reg delete "HKLM\System\CurrentControlset\Services\MsSecCore" /f
) >nul 2>&1
rem                                                                   =================================
	%ch%    {03} Удаляем задания из планировщика{\n #}
	rmdir /s /q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Windows Defender" >nul 2>&1
	schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /f >nul 2>&1 & %ch% {0a}    Windows Defender Cache Maintenance{\n #}
	schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /f >nul 2>&1 & %ch% {0a}    Windows Defender Cleanup{\n #}
	schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /f >nul 2>&1 & %ch% {0a}    Windows Defender Scheduled Scan{\n #}
	schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Verification" /f >nul 2>&1 & %ch% {0a}    Windows Defender Verification{\n #}
	schtasks /Delete /TN "Microsoft\Windows\AppID\SmartScreenSpecific" >nul 2>&1 & %ch% {0a}    SmartScreenSpecific{\n #}{\n #}
rem                                                                   =================================
(
rem Очистка контекстного меню
	reg delete "HKCR\*\shellex\ContextMenuHandlers\EPP" /f
	reg delete "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /f
	reg delete "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /f
	reg delete "HKLM\Software\Classes\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved" /v "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
rem Удаление из автозапуска
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth" /f
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Defender" /f
rem Удаление Windows Defender из реестра
	reg delete "HKLM\System\CurrentControlset\Control\WMI\Autologger\DefenderApiLogger" /f
	reg delete "HKLM\System\CurrentControlset\Control\WMI\Autologger\DefenderAuditLogger" /f
	reg delete "HKLM\Software\Microsoft\Windows Defender" /f
	reg delete "HKLM\Software\Microsoft\Windows Defender Security Center" /f
	reg delete "HKLM\Software\Microsoft\Windows Advanced Threat Protection" /f
	reg delete "HKLM\Software\Microsoft\Windows Security Health" /f
rem Удаление надписи в параметрах
	reg delete "HKLM\Software\Microsoft\SystemSettings\SettingId\SystemSettings_WindowsDefender_UseWindowsDefender" /f
rem Удаление журналов событий
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/WHC" /f
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\NIS-Driver-WFP/Diagnostic" /f
) >nul 2>&1
rem                                                                   =================================
rem Если удалялась эта ветка ранее, пропускаем удаление папок из WinSxS
	reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/Operational" >nul 2>&1 && (
	%ch%    {03} Удаляем папки из WinSxS{\n #}{\n #}
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%SystemRoot%\WinSxS\*windows-defender*" /S /B /A:D`) do rmdir "%%d" /s /q >nul 2>&1
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%SystemRoot%\WinSxS\*windows-senseclient-service*" /S /B /A:D`) do rmdir "%%d" /s /q >nul 2>&1
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%SystemRoot%\WinSxS\*windows-dynamic-image*" /S /B /A:D`) do rmdir "%%d" /s /q >nul 2>&1
	)
rem Файлы из WinSxS нельзя удалять, ломается скачивание обновлений Windows!
rem del /q /s %SystemRoot%\WinSxS\*defender* >nul 2>&1
rem Удаление ветки после удаления папок из WinSxS , выполняется СТРОГО после удаления папок из WinSxS чтобы 1 раз удаление папок произошло, но последующие удаления пропускалось
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/Operational" /f >nul 2>&1
rem                                                                   =================================
:SecHealthUI
	VER | FINDSTR /IL "6.3." > NUL && %ch%    {0c} Windows 8.1 не нуждается в удалении приложения 'Безопасность' и 'SmartScreen'{\n #}&&goto FinishDelete
rem Проверяем создавался ли бекап, если да - пропускаем удаление приложений
	reg query "HKLM\Software\DefenderKiller" >nul 2>&1 && 	%ch%    {0e} Было выбрано создание резервной копии, пропускаем удаление приложений{\n #}{\n #}&&goto FinishDelete
rem Проверка через PS
	rem PowerShell "Get-AppxPackage -AllUsers *SecHealth*" | find /i "PackageFullName" >nul
	%ch%    {09} Безопасность Windows{\n #}
	set "NameSecHealth="
rem Получаем имя приложения Безопасность
	for /F "usebackq delims=" %%n In (`2^>nul reg query "HKU\%SID%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages" /f "*SecHealthUI*" /k^|findstr ^H`) do set NameSecHealth=%%~nxn
	if not defined NameSecHealth %ch%    {02} Приложение Безопасность Windows удалено{\n #}{\n #}&goto AppRepSys
	%ch%    {0b} Удаляем приложение Безопасность Windows{\n #}
	%ch%    {08} %NameSecHealth%{\n #}{\n #}
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\S-1-5-18\%NameSecHealth%" /f >nul
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\%SID%\%NameSecHealth%" /f >nul
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide -Wait PowerShell "Get-AppxPackage -AllUsers *SecHealthUI* | Remove-AppxPackage"	
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\InboxApplications\%NameSecHealth%" /f >nul 2>&1
rem Эти папки можно удалять. Восстанавливаются сами, если восстановить приложение Безопасность.
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%ProgramData%\Microsoft\Windows\AppRepository\Packages\*SecHealth*" /S /B /A:D`) Do rmdir "%%d" /s /q
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%LocalAppData%\Packages\*SecHealth*" /S /B /A:D`) Do rmdir "%%d" /s /q
rem                                                                   =================================
:AppRepSys
	%ch%    {09} SmartScreen защитника Windows{\n #}
	set "NameAppRep="
rem Получаем имя приложения AppRep
	for /F "usebackq delims=" %%n In (`2^>nul reg query "HKU\%SID%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages" /f "*Apprep.ChxApp*" /k^|findstr ^H`) do set NameAppRep=%%~nxn
	if not defined NameAppRep %ch%    {02} Приложение SmartScreen защитника Windows удалено{\n #}&goto FinishDelete
	%ch%    {0b} Удаляем приложение SmartScreen защитника Windows{\n #}
	%ch%    {08} %NameAppRep%{\n #}
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\S-1-5-18\%NameAppRep%" /f >nul
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\%SID%\%NameAppRep%" /f >nul
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide -Wait PowerShell "Get-AppxPackage -AllUsers *Apprep.ChxApp* | Remove-AppxPackage"	
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\InboxApplications\%NameAppRep%" /f >nul 2>&1
rem Эти папки можно удалять, восстанавливаются сами, если восстановить приложение Apprep.ChxApp
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%ProgramData%\Microsoft\Windows\AppRepository\Packages\*Apprep.ChxApp*" /S /B /A:D`) Do rmdir "%%d" /s /q
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%LocalAppData%\Packages\*Apprep.ChxApp*" /S /B /A:D`) Do rmdir "%%d" /s /q
rem                                                                   =================================
:FinishDelete
rem Освобождённое место на диске
	for /f "usebackq tokens=2 delims==" %%i in (`wmic.exe LogicalDisk where "Name='c:'" get FreeSpace /value`) do set sFreeSize=%%i
	if defined sFreeSize (set sFreeSizePseudoMb1=%sFreeSize:~0,-7%)
	set /a Freed=%sFreeSizePseudoMb1% - %sFreeSizePseudoMb%
	echo.
	%ch%    {06} %Freed% Мегабайт места освобождено после удаления{\n #}
	if not exist "%AllUsersProfile%\Microsoft\Windows Defender" (
	%ch%    {02} Защитник Windows удален{\n #}{\n #}
	%ch%    {08} Ориентируйтесь на состояние папок [2]{\n #}   {08} Если что-то осталось, перезагрузите ПК и повторите удаление{\n #}
	%ch%    {08} Нажмите любую клавишу для продолжения{\n #}{\n #}
	) else (
	echo.
	nhmb "Защитник Windows НЕ удален.\nПовторить удаление защитника?\n\nЕсли после нескольких попыток удаления защитник не удаляется и появляется это сообщение, выполните перезагрузку компьютера и повторите попытку удаления." "DK" "Information|YesNo"
	if errorlevel 7 cls && goto Start
	if errorlevel 6 cls && set "RepeatDel=Yes" && goto DeleteDefender
	)
rem                                                                   =================================
:Catalogs
rem Размер окна в зависимости от наличия службы
	if defined serviceswebmask (Mode 82,45) else (Mode 80,45)
	%ch% {3f}%SystemRoot%\System32{\n #}
rem 14.03.23
	if not exist "%SystemRoot%\System32\HealthAttestationClient" (%ch% {0a} %SystemRoot%\System32\HealthAttestationClient{\n #}) else (%ch%  {0c}%SystemRoot%\System32\HealthAttestationClient{\n #})
	if not exist "%SystemRoot%\System32\SecurityHealth" (%ch% {0a} %SystemRoot%\System32\SecurityHealth{\n #}) else (%ch%  {0c}%SystemRoot%\System32\SecurityHealth{\n #})
	if not exist "%SystemRoot%\System32\WebThreatDefSvc" (%ch% {0a} %SystemRoot%\System32\WebThreatDefSvc{\n #}) else (%ch%  {0c}%SystemRoot%\System32\WebThreatDefSvc{\n #})
	if not exist "%SystemRoot%\System32\Sgrm" (%ch% {0a} %SystemRoot%\System32\Sgrm{\n #}) else (%ch%  {0c}%SystemRoot%\System32\Sgrm{\n #})
	if not exist "%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\Defender" (%ch% {0a} %SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\Defender{\n #}) else (%ch%  {0c}%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\Defender{\n #})
	if not exist "%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\DefenderPerformance" (%ch% {0a} %SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\DefenderPerformance{\n #}) else (%ch%  {0c}%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\DefenderPerformance{\n #})
	if not exist "%SystemRoot%\System32\Tasks_Migrated\Microsoft\Windows\Windows Defender" (%ch% {0a} %SystemRoot%\System32\Tasks_Migrated\Microsoft\Windows\Windows Defender{\n #}) else (%ch%  {0c}%SystemRoot%\System32\Tasks_Migrated\Microsoft\Windows\Windows Defender{\n #})
	echo.
	%ch% {3f}C:\Program Files{\n #}
	if not exist "%SystemDrive%\Program Files\Windows Defender" (%ch% {0a} C:\Program Files\Windows Defender {08}- основная папка защитника 1{\n #}) else (%ch%  {4f}C:\Program Files\Windows Defender{08} - основная папка защитника 1{\n #})
	if not exist "%SystemDrive%\Program Files\Windows Defender Sleep" (%ch% {0a} C:\Program Files\Windows Defender Sleep {\n #}) else (%ch%  {4f}C:\Program Files\Windows Defender Sleep{\n #})
	if not exist "%SystemDrive%\Program Files\Windows Defender Advanced Threat Protection" (%ch% {0a} C:\Program Files\Windows Defender Advanced Threat Protection{\n #}) else (%ch%  {0c}C:\Program Files\Windows Defender Advanced Threat Protection{\n #})
	if not exist "%SystemDrive%\Program Files\Windows Security" (%ch% {0a} C:\Program Files\Windows Security{\n #}) else (%ch%  {0c}C:\Program Files\Windows Security{\n #})
	if not exist "%SystemDrive%\Program Files\PCHealthCheck" (%ch% {0a} C:\Program Files\PCHealthCheck{\n #}) else (%ch%  {0c}C:\Program Files\PCHealthCheck{\n #})
	if not exist "%SystemDrive%\Program Files\Microsoft Update Health Tools" (%ch% {0a} C:\Program Files\Microsoft Update Health Tools{\n #}) else (%ch%  {0c}C:\Program Files\Microsoft Update Health Tools{\n #})
	echo.
	%ch% {3f}C:\Program Files (^x86^){\n #}
	if not exist "%ProgramFiles(x86)%\Windows Defender" (%ch% {0a} C:\Program Files (^x86^)\Windows Defender{\n #}) else (%ch%  {0c}C:\Program Files (^x86^)\Windows Defender{\n #})
	if not exist "%ProgramFiles(x86)%\Windows Defender Advanced Threat Protection" (%ch% {0a} C:\Program Files (^x86^)\Windows Defender Advanced Threat Protection{\n #}) else (%ch%  {0c}C:\Program Files (^x86^)\Windows Defender Advanced Threat Protection{\n #})
	echo.
	%ch% {3f}C:\ProgramData{\n #}
	if not exist "%AllUsersProfile%\Microsoft\Windows Defender" (%ch% {0a} C:\ProgramData\Microsoft\Windows Defender {08}- основная папка защитника 2{\n #}) else (%ch%  {4f}C:\ProgramData\Microsoft\Windows Defender{08} - основная папка защитника 2{\n #})
	if not exist "%AllUsersProfile%\Microsoft\Windows Defender Advanced Threat Protection" (%ch% {0a} C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection{\n #}) else (%ch%  {0c}C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection{\n #})
	if not exist "%AllUsersProfile%\Microsoft\Windows Security Health" (%ch% {0a} C:\ProgramData\Microsoft\Windows Security Health{\n #}) else (%ch%  {0c}C:\ProgramData\Microsoft\Windows Security Health{\n #})
	if not exist "%AllUsersProfile%\Microsoft\Storage Health" (%ch% {0a} C:\ProgramData\Microsoft\Storage Health{\n #}) else (%ch%  {0c}C:\ProgramData\Microsoft\Storage Health{\n #})
	echo.
	%ch% {3f}Папка задач планировщика защитника{\n #}
	if not exist "%SYSTEMROOT%\System32\Tasks\Microsoft\Windows\Windows Defender" (%ch% {0a} C:\Windows\System32\Tasks\Microsoft\Windows\Windows Defender{\n #}) else (%ch%  {0c}C:\Windows\System32\Tasks\Microsoft\Windows\Windows Defender{\n #})
	echo.
	%ch% {3f}Остальные файлы{\n #}
	if not exist "%SystemRoot%\Containers\WindowsDefenderApplicationGuard.wim" (%ch% {0a} C:\Windows\Containers\WindowsDefenderApplicationGuard.wim{\n #}) else (%ch%  {0c}C:\Windows\Containers\WindowsDefenderApplicationGuard.wim{\n #})
	if not exist "%SystemRoot%\Containers\serviced\WindowsDefenderApplicationGuard.wim" (%ch% {0a} C:\Windows\Containers\serviced\WindowsDefenderApplicationGuard.wim{\n #}) else (%ch%  {0c}C:\Windows\Containers\serviced\WindowsDefenderApplicationGuard.wim{\n #})
	echo.
	if not exist "%SystemRoot%\System32\SecurityHealthService.exe" (%ch% {02} SecurityHealthService.exe{#} ^| ) else (%ch% {0c} SecurityHealthService.exe {#}^| )
	if not exist "%SystemRoot%\System32\SecurityHealthSystray.exe" (%ch% {02}SecurityHealthSystray.exe{#} ^| ) else (%ch% {0c}SecurityHealthSystray.exe {#}^| )
	if not exist "%SystemRoot%\System32\SecurityHealthHost.exe" (%ch% {02}SecurityHealthHost.exe{\n #}) else (%ch% {0c}SecurityHealthHost.exe{\n #})
	if not exist "%SystemRoot%\System32\SecurityHealthAgent.dll" (%ch% {02} SecurityHealthAgent.dll{#} ^| ) else (%ch% {0c} SecurityHealthAgent.dll{#} ^| )
	if not exist "%SystemRoot%\System32\SecurityHealthSSO.dll" (%ch% {02}SecurityHealthSSO.dll{#} ^| ) else (%ch% {0c}SecurityHealthSSO.dll{#} ^| )
	if not exist "%SystemRoot%\System32\SecurityHealthProxyStub.dll" (%ch% {02}SecurityHealthProxyStub.dll{\n #}) else (%ch% {0c}SecurityHealthProxyStub.dll{\n #})
	if not exist "%SystemRoot%\System32\smartscreen.dll" (%ch% {02} smartscreen.dll{#} ^| ) else (%ch% {0c} smartscreen.dll{#} ^| )
	if not exist "%SystemRoot%\System32\wscisvif.dll" (%ch% {02}wscisvif.dll{#} ^| ) else (%ch% {0c}wscisvif.dll{#} ^| )
	if not exist "%SystemRoot%\System32\wscproxystub.dll" (%ch% {02}wscproxystub.dll{#} ^| ) else (%ch% {0c}wscproxystub.dll{#} ^| )
	if not exist "%SystemRoot%\System32\smartscreenps.dll" (%ch% {02}smartscreenps.dll{\n #}) else (%ch% {0c}smartscreenps.dll{\n #})
	if not exist "%SystemRoot%\System32\wscapi.dll" (%ch% {02} wscapi.dll{#} ^| ) else (%ch% {0c} wscapi.dll{#} ^| )
	if not exist "%SystemRoot%\System32\windowsdefenderapplicationguardcsp.dll" (%ch% {02} windowsdefenderapplicationguardcsp.dll{#} ^| ) else (%ch% {0c} windowsdefenderapplicationguardcsp.dll{#} ^| )
	if not exist "%SystemRoot%\System32\wscsvc.dll" (%ch% {02}wscsvc.dll{\n #}) else (%ch% {0c}wscsvc.dll{\n #})
	if not exist "%SystemRoot%\System32\SecurityHealthCore.dll"  (%ch% {02} SecurityHealthCore.dll{\n #}) else (%ch% {0c} SecurityHealthCore.dll{\n #})
	if not exist "%SystemRoot%\System32\SecurityHealthSsoUdk.dll"  (%ch% {02} SecurityHealthSsoUdk.dll{\n #}) else (%ch% {0c} SecurityHealthSsoUdk.dll{\n #})
	if not exist "%SystemRoot%\System32\SecurityHealthUdk.dll" (%ch% {02} SecurityHealthUdk.dll{\n #}) else (%ch% {0c} SecurityHealthUdk.dll{\n #})
	if not exist "%SystemRoot%\System32\SecurityHealthAgent.dll"  (%ch% {02} SecurityHealthAgent.dll{\n #}) else (%ch% {0c} SecurityHealthAgent.dll{\n #})
rem                                                                   =================================
:CreateBackupDefender
rem Проверяем наличие интернета, чтобы использовать DefenderStop перед созданием резервной копии [нужен, т.к. без него не копируется папка защитника, из-за включённых служб]
	if not exist DefenderStop.exe (
	ping www.google.nl -n 1 -w 1000 |>nul find /i "TTL=" && curl -g -k -L -# -o "DefenderStop.exe" "https://i.getspace.eu/cloud/s/GXAtGk7qLbHj2CS/download" >nul 2>&1
	) || (
	%ch%    {0c} Невозможно создать резервную копию, нет подключения к интернету{\n #}
	%ch%    {0c} Невозможно скачать DefenderStop{\n #}{\n #}
	%ch%    {08} https://i.getspace.eu/cloud/s/GXAtGk7qLbHj2CS/download{\n #}
rem Используем несколько раз для уверенности выполнения
	%ch%    {03} Используем DefenderStop для отключения служб защитника{\n #}{\n #}
	nircmd exec hide DefenderStop.exe
	nircmd wait 3000
	nircmd exec hide DefenderStop.exe
	nircmd exec hide DefenderStop.exe
	%ch%    {02} Создаём резервную копию папок из %AllUsersProfile%{\n #}
(
    xcopy /s /e /h /y /i "%AllUsersProfile%\Microsoft\Windows Defender" "%SystemDrive%\WDefenderBackup\Folder\ProgramData\Microsoft\Windows Defender"
    xcopy /s /e /h /y /i "%AllUsersProfile%\Microsoft\Windows Defender Advanced Threat Protection" "%SystemDrive%\WDefenderBackup\Folder\ProgramData\Microsoft\Windows Defender Advanced Threat Protection"
    xcopy /s /e /h /y /i "%AllUsersProfile%\Microsoft\Windows Security Health" "%SystemDrive%\WDefenderBackup\Folder\ProgramData\Microsoft\Windows Security Health"
    xcopy /s /e /h /y /i "%AllUsersProfile%\Microsoft\Storage Health" "%SystemDrive%\WDefenderBackup\Folder\ProgramData\Microsoft\Storage Health"
) >nul 2>&1
rem Проверка после копирования главной папки, скопировалась ли ...
	dir /b "%SystemDrive%\WDefenderBackup\Folder\ProgramData\Microsoft\Windows Defender" | findstr /r "^" >nul && (
	echo >nul
	) || (
	%ch% {04} Папку "%AllUsersProfile%\Microsoft\Windows Defender" скопировать не удалось{\n #}
	%ch% {04} Такое возможно, если у Вас не отработал DefenderStop и не отключились службы защитника{\n #}
	%ch% {04} Вы используете либо Win 11 Dev/Beta версию, либо Microsoft что-то изменила{\n #}{\n #}
	%ch% {08} Попробуйте еще раз повторить попытку...{\n #}
	rd /s /q "%SystemDrive%\WDefenderBackup" >nul 2>&1
	cls && goto Start
	)
	%ch%    {02} Создаём резервную копию папок из %ProgramFiles% и %ProgramFiles(x86)%{\n #}
(
rem Создаём раздел в реестре по которому будем проверять, что резервная копия создана. Требуется для пропуска удаления SysApps [Безопасность/AppRep]
	reg add "HKLM\Software\DefenderKiller" /f
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files\Windows Defender" "%SystemDrive%\WDefenderBackup\Folder\Program Files\Windows Defender"
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files\Windows Defender Sleep" "%SystemDrive%\WDefenderBackup\Folder\Program Files\Windows Defender Sleep"
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files\Windows Defender Advanced Threat Protection" "%SystemDrive%\WDefenderBackup\Folder\Program Files\Windows Defender Advanced Threat Protection"
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files\Windows Security" "%SystemDrive%\WDefenderBackup\Folder\Program Files\Windows Security"
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files\PCHealthCheck" "%SystemDrive%\WDefenderBackup\Folder\Program Files\PCHealthCheck"
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files\Microsoft Update Health Tools" "%SystemDrive%\WDefenderBackup\Folder\Program Files\Microsoft Update Health Tools"
rem ProgramFiles X86	
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files (x86)\Windows Defender" "%SystemDrive%\WDefenderBackup\Folder\Program Files (x86)\Windows Defender"
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files (x86)\Windows Defender Advanced Threat Protection" "%SystemDrive%\WDefenderBackup\Folder\Program Files (x86)\Windows Defender Advanced Threat Protection"
) >nul 2>&1
	%ch%    {02} Создаём резервную копию папок из System32 и SysWOW64{\n #}
(
rem Windows - System32
    xcopy /s /e /h /y /i "%SystemRoot%\security\database" "%SystemDrive%\WDefenderBackup\Folder\Windows\security\database"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\HealthAttestationClient" "%SystemDrive%\WDefenderBackup\Folder\System32\HealthAttestationClient"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\SecurityHealth" "%SystemDrive%\WDefenderBackup\Folder\System32\SecurityHealth"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\WebThreatDefSvc" "%SystemDrive%\WDefenderBackup\Folder\System32\WebThreatDefSvc"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\Sgrm" "%SystemDrive%\WDefenderBackup\Folder\System32\Sgrm"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\Defender" "%SystemDrive%\WDefenderBackup\Folder\System32\WindowsPowerShell\v1.0\Modules\Defender"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\DefenderPerformance" "%SystemDrive%\WDefenderBackup\Folder\System32\WindowsPowerShell\v1.0\Modules\DefenderPerformance"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\Tasks_Migrated\Microsoft\Windows\Windows Defender" "%SystemDrive%\WDefenderBackup\Folder\System32\Tasks_Migrated\Microsoft\Windows\Windows Defender"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\drivers\wd" "%SystemDrive%\WDefenderBackup\Folder\System32\drivers\wd"
rem Задачи защитника
	xcopy /s /e /h /y /i "%SystemRoot%\System32\Tasks\Microsoft\Windows\Windows Defender" "%SystemDrive%\WDefenderBackup\Folder\System32\Tasks\Microsoft\Windows\Windows Defender"
rem SysWOW64
    xcopy /s /e /h /y /i "%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\Modules\Defender" "%SystemDrive%\WDefenderBackup\Folder\SysWOW64\WindowsPowerShell\v1.0\Modules\Defender"
    xcopy /s /e /h /y /i "%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\Modules\DefenderPerformance" "%SystemDrive%\WDefenderBackup\Folder\SysWOW64\WindowsPowerShell\v1.0\Modules\DefenderPerformance"
) >nul 2>&1
	%ch%    {02} Создаём резервную копию файлов из System32 и SysWOW64{\n #}
(
	md "%SystemDrive%\WDefenderBackup\Files"
	md "%SystemDrive%\WDefenderBackup\Files\System32"
	md "%SystemDrive%\WDefenderBackup\Files\SysWOW64"
	md "%SystemDrive%\WDefenderBackup\Files\Windows\Containers"
	md "%SystemDrive%\WDefenderBackup\Files\Windows\Containers\serviced"
rem Копирование файлов из System32
	copy /Y "%SystemRoot%\System32\SecurityHealthService.exe" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthSystray.exe" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthHost.exe" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthAgent.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthSSO.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthProxyStub.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\LogFiles\WMI\RtBackup\EtwRTDefenderApiLogger.etl" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\LogFiles\WMI\RtBackup\EtwRTDefenderAuditLogger.etl" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\smartscreen.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\wscisvif.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\wscproxystub.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\smartscreenps.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\wscapi.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\windowsdefenderapplicationguardcsp.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\wscsvc.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthCore.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthSsoUdk.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthUdk.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\smartscreen.exe" "%SystemDrive%\WDefenderBackup\Files\System32\"
rem Копирование файлов из SysWow64
	copy /Y "%SystemRoot%\SysWOW64\smartscreen.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\SysWOW64\wscisvif.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\SysWOW64\wscproxystub.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\SysWOW64\smartscreenps.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\SysWOW64\wscapi.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\SysWOW64\windowsdefenderapplicationguardcsp.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\Containers\WindowsDefenderApplicationGuard.wim" "%SystemDrive%\WDefenderBackup\Files\Windows\Containers\"
	copy /Y "%SystemRoot%\Containers\serviced\WindowsDefenderApplicationGuard.wim" "%SystemDrive%\WDefenderBackup\Files\Windows\Containers\serviced"
) >nul 2>&1
	%ch%    {02} Создаём резервную копию папок из WinSxS{\n #}
(
	md "%SystemDrive%\WDefenderBackup\Folder\WinSxS"
	for /d %%i in ("%SystemRoot%\WinSxS\*windows-defender*") do xcopy "%%i" "%SystemDrive%\WDefenderBackup\Folder\WinSxS\%%~nxi" /I /E /H /Y
	for /d %%i in ("%SystemRoot%\WinSxS\*windows-senseclient-service*") do xcopy "%%i" "%SystemDrive%\WDefenderBackup\Folder\WinSxS\%%~nxi" /I /E /H /Y
	for /d %%i in ("%SystemRoot%\WinSxS\*windows-dynamic-image*") do xcopy "%%i" "%SystemDrive%\WDefenderBackup\Folder\WinSxS\%%~nxi" /I /E /H /Y
) >nul 2>&1
	md "%SystemDrive%\WDefenderBackup\ServicesDrivers"
	md "%SystemDrive%\WDefenderBackup\RegEdit"
	set "PathServDrive=%SystemDrive%\WDefenderBackup\ServicesDrivers"
	set "PathRegedit=%SystemDrive%\WDefenderBackup\RegEdit"
(	
rem Службы
	reg export "HKLM\System\CurrentControlSet\Services\EventLog\System\WinDefend" "%PathServDrive%\WinDefendEvent.reg"
	reg export "HKLM\System\CurrentControlSet\Services\SecurityHealthService" "%PathServDrive%\SecurityHealthService.reg"
	reg export "HKLM\System\CurrentControlSet\Services\Sense" "%PathServDrive%\Sense.reg"
	reg export "HKLM\System\CurrentControlSet\Services\WdNisSvc" "%PathServDrive%\WdNisSvc.reg"
	reg export "HKLM\System\CurrentControlSet\Services\WinDefend" "%PathServDrive%\WinDefend.reg"
	reg export "HKLM\System\CurrentControlSet\Services\wscsvc" "%PathServDrive%\wscsvc.reg"
	reg export "HKLM\System\CurrentControlSet\Services\SgrmBroker" "%PathServDrive%\SgrmBroker.reg"
	reg export "HKLM\System\CurrentControlSet\Services\webthreatdefsvc" "%PathServDrive%\webthreatdefsvc.reg"
	reg export "HKLM\System\CurrentControlSet\Services\webthreatdefusersvc" "%PathServDrive%\webthreatdefusersvc.reg"
rem Драйвера
	reg export "HKLM\System\CurrentControlSet\Services\WdNisDrv" "%PathServDrive%\WdNisDrv.reg"
	reg export "HKLM\System\CurrentControlSet\Services\WdBoot" "%PathServDrive%\WdBoot.reg"
	reg export "HKLM\System\CurrentControlSet\Services\WdFilter" "%PathServDrive%\WdFilter.reg"
	reg export "HKLM\System\CurrentControlSet\Services\SgrmAgent" "%PathServDrive%\SgrmAgent.reg"
	reg export "HKLM\System\CurrentControlSet\Services\wtd" "%PathServDrive%\wtd.reg"
	reg export "HKLM\System\CurrentControlSet\Services\MsSecWfp" "%PathServDrive%\MsSecWfp.reg"
	reg export "HKLM\System\CurrentControlSet\Services\MsSecFlt" "%PathServDrive%\MsSecFlt.reg"
	reg export "HKLM\System\CurrentControlSet\Services\MsSecCore" "%PathServDrive%\MsSecCore.reg"
rem Экспорт веток реестра
	reg export "HKCR\*\shellex\ContextMenuHandlers\EPP" "%PathRegedit%\1.reg"
	reg export "HKCR\Directory\shellex\ContextMenuHandlers\EPP" "%PathRegedit%\2.reg"
	reg export "HKCR\Drive\shellex\ContextMenuHandlers\EPP" "%PathRegedit%\3.reg"
	reg export "HKLM\Software\Classes\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}" "%PathRegedit%\4.reg"
	reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved" "%PathRegedit%\5.reg"
	reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" "%PathRegedit%\6.reg"
	reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" "%PathRegedit%\7.reg"
	reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Defender" "%PathRegedit%\8.reg"
	reg export "HKLM\System\CurrentControlset\Control\WMI\Autologger\DefenderApiLogger" "%PathRegedit%\9.reg"
	reg export "HKLM\System\CurrentControlset\Control\WMI\Autologger\DefenderAuditLogger" "%PathRegedit%\10.reg"
	reg export "HKLM\Software\Microsoft\Windows Defender" "%PathRegedit%\11.reg"
	reg export "HKLM\Software\Microsoft\Windows Defender Security Center" "%PathRegedit%\12.reg"
	reg export "HKLM\Software\Microsoft\Windows Advanced Threat Protection" "%PathRegedit%\13.reg"
	reg export "HKLM\Software\Microsoft\Windows Security Health" "%PathRegedit%\14.reg"
	reg export "HKLM\Software\Microsoft\SystemSettings\SettingId\SystemSettings_WindowsDefender_UseWindowsDefender" "%PathRegedit%\15.reg"
	reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/Operational" "%PathRegedit%\16.reg"
	reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/WHC" "%PathRegedit%\17.reg"
	reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\NIS-Driver-WFP/Diagnostic" "%PathRegedit%\18.reg"
) >nul 2>&1
	%ch%    {08} Резервная копия создана в {0b}%SystemDrive%\WDefenderBackup{\n #}{\n #}
:RestoreDefender
rem Для корректного отображения диалогового окна, т.к. программа запущена от TI
	if not exist "%SystemRoot%\System32\config\systemprofile\Desktop" md "%SystemRoot%\System32\config\systemprofile\Desktop"
	set "BackupFolder="
	for /f %%A in ('powershell -c "(New-Object -COM 'Shell.Application').BrowseForFolder(0, 'Выберите папку с ранее созданной резервной копией Windows Defender', 0, 0).Self.Path"') do set "BackupFolder=%%A"
	echo.
	if not defined BackupFolder cls && goto Start
	if not exist "%BackupFolder%\Folder" %ch%    {04} Неверная резервная копия. Выберите правильную резервную копию{\n #}&&timeout /t 3 >nul && cls && goto RestoreDefender
	if not exist "%BackupFolder%\ServicesDrivers" %ch%    {04} Неверная резервная копия. Выберите правильную резервную копию{\n #}&&timeout /t 3 >nul && cls && goto RestoreDefender
rem Задаём вопрос о восстановлении защитника
	%ch% {0f} Резервная копия выбрана - {04}%BackupFolder%{\n #}
	echo  1 - Восстановить защитник
	echo  2 - Отмена 
	choice /c 12 /n /m " "
	if errorlevel 2 cls && goto Start
rem Восстановление политик
	if not defined NoGP (
	%ch% {03} Восстановление групповых политик{\n #}
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender" /v "AllowFastServiceStartup" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableRealtimeMonitoring" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableBehaviorMonitoring" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableIOAVProtection" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Spynet" /v "LocalSettingOverrideSpynetReporting" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Spynet" /v "**del.SpynetReporting" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Spynet" /v "**del.SubmitSamplesConsent" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "RealtimeSignatureDelivery" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableUpdateOnStartupWithoutEngine" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "UpdateOnStartUp" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableScanOnUpdate" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Reporting" /v "DisableGenericRePorts" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableCatchupFullScan" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableCatchupQuickScan" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableRemovableDriveScanning" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableScanningNetworkFiles" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableScanningMappedNetworkDrivesForFullScan" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableArchiveScanning" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows\System" /v "**del.ShellSmartScreenLevel" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /f
	nircmd win activate process cmd.exe
	call :LGPO_APPLY
	nircmd win activate process cmd.exe
	)
rem Восстановление параметров реестра
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /f >nul 2>&1
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /f >nul 2>&1
	reg delete "HKLM\Software\Policies\Microsoft\MRT" /f >nul 2>&1
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide cmd.exe /c reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /f >nul 2>&1
	%ch% {03} Восстановление файлов/папок{\n #}{\n #}
	pushd "%BackupFolder%"
(
	copy /y "Files\System32" %SystemRoot%\System32
	copy /y "Files\SysWOW64" %SystemRoot%\SysWOW64
	copy /y "Files\Windows\Containers\WindowsDefenderApplicationGuard.wim" "%SystemRoot%\Containers\"
	copy /y "Files\Windows\Containers\serviced\WindowsDefenderApplicationGuard.wim" "%SystemRoot%\Containers\serviced"
	xcopy "Folder\Program Files\*" "%ProgramFiles%\" /E /H /K /Y
	xcopy "Folder\Program Files (x86)\*" "%ProgramFiles(x86)%\" /E /H /K /Y
	xcopy "Folder\ProgramData\*" "%ProgramData%\" /E /H /K /Y
	xcopy "Folder\System32\*" "%SystemRoot%\System32" /E /H /K /Y
	xcopy "Folder\SysWow64\*" "%SystemRoot%\SysWow64" /E /H /K /Y
	xcopy "Folder\Windows\*" "%SystemRoot%\" /E /H /K /Y
	xcopy "Folder\WinSxS\*" "%SystemRoot%\WinSxS\" /E /H /K /Y
rem Восстановление реестра/служб, драйверов
	for %%f in ("RegEdit\*.reg") do reg import "%%f"
	for %%f in ("ServicesDrivers\*.reg") do reg import "%%f"
rem Восстановление SmartScreen.exe
	if exist "%SystemRoot%\System32\smartscreen_disabled.exe" rename "%SystemRoot%\System32\smartscreen_disabled.exe" "smartscreen.exe"
rem Удаляем раздел по которому проверяется создана ли резервная копия. Теперь SysApps будут удаляться.
	reg delete "HKLM\Software\DefenderKiller" /f
) >nul 2>&1
	popd
	nhmb "Требуется перезапуск ПК" "DK" "Information|Ok"
	cls && goto Start
rem                                                                   =================================
:CheckUpdate
rem Windows 8.1 не поддерживает функционал обновлений
rem Удаляем файл, если тот остался...
	del /q "%SystemDrive%\latestVersion.bat" >nul 2>&1
rem Проверяем наличие интернет-соединения
	ping www.google.nl -n 1 -w 1000 |>nul find /i "TTL="||cls&&%ch% {04} Невозможно проверить обновления программы, отсутствует интернет{\n #}&&timeout /t 3 >nul&&cls&&goto Start
rem Проверка обновлений программы
	curl -g -k -L -# -o "%SystemDrive%\latestVersion.bat" "https://pastebin.com/raw/dnENFgmC" >nul 2>&1
	call "%SystemDrive%\latestVersion.bat"
	if "%Version%" lss "%latestVersion%" (cls) else (cls & %ch% {0a} Вы используете последнюю актуальную версию программы - {0e}%Version%{\n #}&timeout /t 4 >nul&goto Start)
rem Обновление программы
	%ch%  {0f} Найдена новая версия, нажмите любую клавишу чтобы обновить программу{\n #}
	curl -g -k -L -# -o %0 "https://github.com/oatmealcookiec/MyProgramm/releases/latest/download/DefenderKiller.bat" >nul 2>&1
	call %0
:Information
	nhmb "DefenderKiller - программа для удаления защитника Windows и его компонентов.\nВ программе имеется возможность восстановления (если создана резервная копия)\nКрасным цветом в меню - не удалено. Зеленым цветом - удалено.\n\nПри нажатии на кнопку ОК будет открыт сайт программы, где можно детально ознакомиться с программой, задать вопрос, высказать предложение или сообщить об ошибке.\n\nBy Vlado." "DK" "Information|Ok"
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide cmd.exe /c start https://win10tweaker.ru/forum/topic/defenderkiller 
	cls & goto Start
rem Создано WestLife AutoSettings
:LGPOFILE
	setlocal
	if /i "%~2" NEQ "delete" if /i "%~2" NEQ "add" (
	if /i "%~2" EQU "delete" if "%~7" NEQ "" (
	set "RegType=%~7:"
	set "RegType=%RegType:REG=%"
	set "RegType=%RegType:_=%"
	set "RegType=%RegType:PAND=%"
	if "%~3" NEQ "" for /f "tokens=1* delims=\" %%I in ("%~3") do ( set "RegKey=%%J"
	 if /i "%%I" EQU "HKEY_LOCAL_MACHINE" (set Config=Computer) else if /i "%%I" EQU "HKLM" (set Config=Computer
	 ) else if /i "%%I" EQU "HKEY_CURRENT_USER" (set Config=User) else if /i "%%I" EQU "HKCU" (set Config=User
	if "%~9" NEQ "" set "Action=%RegType%%~9"
	if /i "%~6" EQU "/d" set "Action=SZ:%~7"
	if /i "%~2" EQU "delete" set "Action=DELETE"
	if "%~5" EQU "" ( set "Action=DELETEALLVALUES" & set "ValueName=*" ) else ( set "ValueName=%~5" )
	if /i "%~2" EQU "add" if /i "%~4" EQU "/f" set "Action=CREATEKEY" & set "ValueName=*"
	(echo.%Config%& echo.%RegKey%& echo.%ValueName%& echo.%Action%& echo.)>>"%LGPOtemp%"
:LGPO_APPLY	
	%ch% {04} Применение параметров групповых политик{\n #}{\n #}&LGPO.exe /t "%LGPOtemp%" /q
	if exist "%LGPOtemp%" del /f /q "%LGPOtemp%"
rem Файл: Отключить Defender, SmartScreen и Antimalware.bat
sc stop windefend & sc config windefend start=disabled
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "off" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SmartScreen" /v "ConfigureAppInstallControl" /t REG_SZ /d "Anywhere" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SmartScreen" /v "ConfigureAppInstallControlEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wscsvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f
rem Файл: Программа удаления OneDrive v1.4.bat
@rem OneDrive Complete uninstaller batch process for Windows 10.
@rem Run as administrator to completely delete all OneDrive components and files.
@rem Written by TERRA Operative - 2020/03/02. V1.4
@rem Feel free to distribute freely as long as you leave this entire file unchanged and intact,
@rem and if you do make changes and adaptions, don't be a dick about not attributing where due.
@rem And most importantly, peace out and keep it real.
@REM Set variables for coloured text
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)
   echo ------Windows 10 OneDrive Uninstaller V1.4------
   echo.
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
   echo        Administrator Privileges Detected!
   echo.
) ELSE (
   echo.
   call :colorEcho 0C "########### ERROR - ADMINISTRATOR PRIVILEGES REQUIRED #############"
   echo.
   call :colorEcho 0C "#                                                                 #"
   echo.
   call :colorEcho 0C "#"
   call :colorEcho 07 "    This script must be run as administrator to work properly."
   call :colorEcho 0C "    #"
   echo.
   call :colorEcho 0C "#"
   call :colorEcho 07 "    If you're seeing this after double clicking on the icon,"
   call :colorEcho 0C "     #"
   echo.
   call :colorEcho 0C "#"
   call :colorEcho 07 "  then right click on the icon and select 'Run As Administrator'"
   call :colorEcho 0C " #"
   echo.
   call :colorEcho 0C "#                                                                 #"
   echo.
   call :colorEcho 0C "###################################################################"
   echo.
   echo.
 /B 1
)
   echo -----------------------------------------------
   call :colorEcho 0C "                    WARNING"
   echo.
   call :colorEcho 0C "  This script will completely and permanently"
   echo.
   call :colorEcho 0C "      remove OneDrive from your computer."
   echo.
   call :colorEcho 0C "        Make sure all OneDrive documents"   
   echo.
   call :colorEcho 0C "       that are stored locally are fully"
   echo.
   call :colorEcho 0C "          backed up before proceeding."   
   echo.
   echo -----------------------------------------------
   echo.
	if %M% ==Y goto PROCESSKILL
	if %M% ==y goto PROCESSKILL
 /B 1
@rem The following is based on info from here written by 'LK':
@rem https://techjourney.net/disable-or-uninstall-onedrive-completely-in-windows-10/
@rem Terminate any OneDrive process
:PROCESSKILL
   echo.
   echo Terminating OneDrive process.
taskkill /f /im OneDrive.exe
@rem Detect if OS is 32 or 64 bit
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
if %OS%==32BIT GOTO 32BIT
if %OS%==64BIT GOTO 64BIT
@rem Uninstall OneDrive app
:32BIT
   echo.
   echo This is a 32-bit operating system.
   echo Removing OneDrive setup files.
%SystemRoot%\System32\OneDriveSetup.exe /uninstall
GOTO CLEAN
:64BIT
   echo.
   echo This is a 64-bit operating system.
   echo Removing OneDrive setup files.
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
GOTO CLEAN
@rem Clean and remove OneDrive remnants
:CLEAN
   echo.
   echo Removing remaining OneDrive folders.
   rd "%UserProfile%\OneDrive" /s /q
   rd "%LocalAppData%\Microsoft\OneDrive" /s /q
   rd "%ProgramData%\Microsoft OneDrive" /s /q
   rd "C:\OneDriveTemp" /s /q
   del "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" /s /f /q
   echo.
   call :colorEcho 0C "If you see 'access denied' errors here, reboot and run this batch file again."
   echo.
   echo.
   echo 'The system cannot find the file specified.' errors are ok, it means the files are already gone.
   echo.
@rem Delete and remove OneDrive in file explorer folder tree registry key
   echo -----------------------------------------------
   echo.
   echo Removing OneDrive registry keys.
   REG Delete "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
   REG Delete "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
   REG ADD "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v System.IsPinnedToNameSpaceTree /d "0" /t REG_DWORD /f
   echo.
   echo.
   echo 'The system was unable to find the specified registry key or value.' errors are ok,
   echo it means the Registry entries already don't exist.
   echo.
   echo -----------------------------------------------
   echo.
   echo OneDrive Uninstall and cleaning completed.
   echo.
   echo So long and thanks for all the fish...
   PING -n 2 127.0.0.1>nul
 /B 1
@rem Settings for text colour
:colorEcho
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1i
rem Файл: Удалить Microsoft Edge Appx.bat
:: Check if ran as Admin
setlocal enabledelayedexpansion
:: Get user SID
for /f "delims=" %%a in ('powershell "(New-Object System.Security.Principal.NTAccount($env:USERNAME)).Translate([System.Security.Principal.SecurityIdentifier]).Value"') do set "USER_SID=%%a"
:: Remove Edge Appx Packages
for /f "delims=" %%a in ('powershell -NoProfile -Command "Get-AppxPackage -AllUsers ^| Where-Object { $_.PackageFullName -like '*microsoftedge*' } ^| Select-Object -ExpandProperty PackageFullName"') do (
    if not "%%a"=="" (
        set "APP=%%a"
        reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\!USER_SID!\!APP!" /f >nul 2>&1
        reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\S-1-5-18\!APP!" /f >nul 2>&1
        reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned\!APP!" /f >nul 2>&1
        powershell -Command "Remove-AppxPackage -Package '!APP!'" 2>nul
        powershell -Command "Remove-AppxPackage -Package '!APP!' -AllUsers" 2>nul
    )
)
endlocal
rem Файл: Удалить OneDrive.bat
cls
set x86="%SYSTEMROOT%\System32\OneDriveSetup.exe"
set x64="%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe"
echo Closing OneDrive process.
echo.
taskkill /f /im OneDrive.exe > NUL 2>&1
ping 127.0.0.1 -n 5 > NUL 2>&1
echo Uninstalling OneDrive...
echo.
if exist %x64% (
%x64% /uninstall
) else (
%x86% /uninstall
)
ping 127.0.0.1 -n 5 > NUL 2>&1
echo Removing OneDrive leftovers...
echo.
rd "%USERPROFILE%\OneDrive" /Q /S > NUL 2>&1
rd "C:\OneDriveTemp" /Q /S > NUL 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S > NUL 2>&1
rd "%LOCALAPPDATA%\OneDrive" /Q /S > NUL 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S > NUL 2>&1 
echo Removing OneDrive from the Explorer Side Panel...
echo.
REG DELETE "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
rem Файл: Удалить Windows Defender (DefenderKiller).bat
:: DefenderKiller By Vlado -  https://win10tweaker.ru/forum/topic/defenderkiller
:: Thanks for test Eject - https://win10tweaker.ru/forum/profile/eject
:: StopDefender - https://github.com/lab52io/StopDefender
:: FuckDefender - http://win10tweaker.ru/fwd
:: NsudoLC - https://github.com/M2TeamArchived/NSudo/releases
:: nhmb - https://nhutils.ru/blog/nhmb/
:: LGPO - https://www.microsoft.com/en-us/download/details.aspx?id=55319
:: Last Version - https://pastebin.com/raw/dnENFgmC
:Start
	@echo off
	Title DK
	chcp 866 >nul
	SetLocal EnableDelayedExpansion
	Color 0f
	cd /d "%~dp0Work"
	reg query "HKU\S-1-5-19" >nul 2>&1
rem Цветной текст/lgpo
	set "ch=cecho.exe"
	set "LGPOtemp=LGPO-temp.txt"
	set "RepeatDel="
rem Версия программы/Удаляем файл, который может оставаться после обновления в корне диска
	set Version=11.1.3
	set DateProgram=18.01.2024
	if exist "%SystemDrive%\latestVersion.bat" del /q "%SystemDrive%\latestVersion.bat"
rem Если не существует WMIC/nhmb
rem Получение SID перед запуском от имени TI
	for /f %%s in ('2^>nul wmic UserAccount where "Domain='%UserDomain%' and Name='%UserName%'" Get SID^|find "-"') do set SID=%%s
rem Проверка разрядности системы
	set xOS=x64& (If "%PROCESSOR_ARCHITECTURE%"=="x86" If Not Defined PROCESSOR_ARCHITEW6432 Set xOS=x86)
rem Запуск от имени TI
rem Размер программы в зависимости от наличия службы, расположение по центру экрана и название
	set "serviceswebmask="
	for /f "usebackq delims=" %%n In (`2^>nul reg query "HKLM\System\CurrentControlSet\Services" /f "webthreatdefusersvc*" /k^|findstr ^H`) do set serviceswebmask=%%~nxn
	if defined serviceswebmask (Mode 82,45) else (Mode 80,45)
	nircmd win center process cmd.exe & nircmd win settext foreground "DK"
rem SmartScreen | Процессы | Службы | Драйвера | Задачи | Проверка наличия GP [Home версия]
	set "ArgNsudo="
	reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" | find /i "0x0" >nul 2>&1 && set "ArgNsudo=C" || set "ArgNsudo=E"
	if not exist "%SystemRoot%\System32\smartscreen.exe" (set "SmartScreen=0a") else (set "SmartScreen=0c")
	if not exist "%SystemRoot%\System32\gpedit.msc" set "NoGP=Yes"
(
	qprocess "MsMpEng.exe" && set "MsMpEng=0c" || set "MsMpEng=0a"
	qprocess "SgrmBroker.exe" && set "SgrmBroker=0c" || set "SgrmBroker=0a"
	qprocess "uhssvc.exe" && set "uhssvc=0c" || set "uhssvc=0a"
	qprocess "NisSrv.exe" && set "NisSrv=0c" || set "NisSrv=0a"
	qprocess "MpCmdRun.exe" && set "MpCmdRun=0c" || set "MpCmdRun=0a"
	qprocess "MPSigStub.exe" && set "MPSigStub=0c" || set "MPSigStub=0a"
	qprocess "SecHealthUI.exe" && set "SecHealthUI=0c" || set "SecHealthUI=0a"
	qprocess "SecurityHealthSystray.exe" && set "SecurityHealthSystray=0c" || set "SecurityHealthSystray=0a"
	qprocess "SecurityHealthService.exe" && set "SecurityHealthService=0c" || set "SecurityHealthService=0a"
	qprocess "SecurityHealthHost.exe" && set "SecurityHealthHost=0c" || set "SecurityHealthHost=0a"
	sc query WinDefend && set "WinDefend=0c" || set "WinDefend=0a"
	sc query WdNisSvc && set "WdNisSvc=0c" || set "WdNisSvc=0a"
	sc query Sense && set "Sense=0c" || set "Sense=0a"
	sc query wscsvc && set "wscsvc=0c" || set "wscsvc=0a"
	sc query SgrmBroker && set "SgrmBroker=0c" || set "SgrmBroker=0a"
	sc query SecurityHealthService && set "SecurityHealthService=0c" || set "SecurityHealthService=0a"
	sc query webthreatdefsvc && set "webthreatdefsvc=0c" || set "webthreatdefsvc=0a"
	sc query webthreatdefusersvc && set "webthreatdefusersvc=0c" || set "webthreatdefusersvc=0a"
	sc query WdNisDrv && set "WdNisDrv=0c" || set "WdNisDrv=0a"
	sc query WdBoot && set "WdBoot=0c" || set "WdBoot=0a"
	sc query WdFilter && set "WdFilter=0c" || set "WdFilter=0a"
	sc query SgrmAgent && set "SgrmAgent=0c" || set "SgrmAgent=0a"
	sc query wtd && set "wtd=0c" || set "wtd=0a"
	sc query MsSecWfp && set "MsSecWfp=0c" || set "MsSecWfp=0a"
	sc query MsSecFlt && set "MsSecFlt=0c" || set "MsSecFlt=0a"
	sc query MsSecCore && set "MsSecCore=0c" || set "MsSecCore=0a"
) >nul 2>&1
	set PathTask=%SystemRoot%\System32\Tasks\Microsoft\Windows\Windows Defender
	if not exist "%PathTask%\Windows Defender Cache Maintenance" (set "Maintenance=0a") else (set "Maintenance=0c")
	if not exist "%PathTask%\Windows Defender Scheduled Scan" (set "Scan=0a") else (set "Scan=0c")
	if not exist "%PathTask%\Windows Defender Verification" (set "Verification=0a") else (set "Verification=0c")
	if not exist "%PathTask%\Windows Defender Cleanup" (set "Cleanup=0a") else (set "Cleanup=0c")
	if not exist "%SystemRoot%\System32\Tasks\Microsoft\Windows\AppID\SmartScreenSpecific" (set "SmartScreenSpecific=0a") else (set "SmartScreenSpecific=0c")
	%ch% {03}Состояние процессов защитника:{\n #}
	%ch% {%SmartScreen%}SmartScreen{\n #}
	%ch% {%MsMpEng%}MsMpEng{#}   {08} [Antimalware Service Executable]{\n #}
	%ch% {%SgrmBroker%}SgrmBroker{#} {08}[Брокер среды выполнения System Guard]{\n #}
	%ch% {%uhssvc%}uhssvc{#}    {08} [Microsoft Update Health Service]{\n #}
	%ch% {%NisSrv%}NisSrv{#}    {08} [Network Realtime Inspection]{\n #}
	%ch% {%MpCmdRun%}MpCmdRun{#}  {08} [Microsoft malware protection]{\n #}
	%ch% {%MPSigStub%}MPSigStub{#}{08}  [Malware Protection Signature Update Stub]{\n #}
	%ch% {%SecHealthUI%}SHealthUI{#}{08}  [Безопасность Windows]{\n #}
	%ch% {%SecurityHealthSystray%}HealthTray{#}{08} [SecurityHealthSystray иконка в трее]{\n #}
	%ch% {%SecurityHealthService%}HealthServ{#}{08} [SecurityHealthService]{\n #}
	%ch% {%SecurityHealthHost%}HealthHost{#}{08} [SecurityHealthHost]{\n #}{\n #}
	%ch% {03}Состояние служб и драйверов защитника:{\n #}
	%ch% {%webthreatdefsvc%}webthreat{#}  {08}[Служба защиты от Веб-угроз - webthreatdefsvc]{\n #}
	if defined serviceswebmask (
	%ch% {%webthreatdefusersvc%}webthreatu{#} {08}[Служба защиты пользоват. от Веб-угроз - {04}%serviceswebmask%{08}]{\n #}
	) else (
	%ch% {%webthreatdefusersvc%}webthreatu{#} {08}[Служба защиты пользоват. от Веб-угроз - webthreatdefusersvc]{\n #}
	)
	%ch% {%WinDefend%}WinDefend{#} {08} [Служба Антивирусная программа Защитника Windows]{\n #}
	%ch% {%WdNisSvc%}WdNisSvc{#} {08}  [Служба проверки сети Windows Defender Antivirus]{\n #}
	%ch% {%Sense%}Sense{#}     {08} [Служба Advanced Threat Protection]{\n #}
	%ch% {%wscsvc%}wscsvc{#}     {08}[Служба Центр обеспечения безопасности]{\n #}
	%ch% {%SgrmBroker%}SgrmBroker{#} {08}[Служба Брокер мониторинга среды выполнения System Guard]{\n #}
	%ch% {%SecurityHealthService%}SHealthSer{#} {08}[Служба Центр безопасности Защитника Windows]{\n #}
	%ch% {%WdNisDrv%}WdNisDrv{#}   {08}[Драйвер WD Network Inspection Driver]{\n #}
	%ch% {%WdBoot%}WdBoot{#}     {08}[Драйвер WD Antivirus Boot Driver]{\n #}
	%ch% {%WdFilter%}WdFilter{#}{08}   [Драйвер WD Antivirus Mini-Filter Driver]{\n #}
	%ch% {%SgrmAgent%}SgrmAgent{#}{08}  [Драйвер System Guard Runtime Monitor Agent Driver]{\n #}
	%ch% {%wtd%}wtd{#}{08}        [Драйвер WTD Driver]{\n #}
	%ch% {%MsSecWfp%}MsSecWfp{#}{08}   [Драйвер Microsoft Security WFP Callout Driver]{\n #}
	%ch% {%MsSecFlt%}MsSecFlt{#}{08}   [Драйвер Security Events Component Minifilter]{\n #}
	%ch% {%MsSecCore%}MsSecCore{#}{08}  [Драйвер Microsoft Security Core Boot Driver]{\n #}
	echo.
	%ch% {03}Состояние заданий в планировщике:{\n #}
	%ch% {%Maintenance%}Windows Defender Cache Maintenance{\n #}
	%ch% {%Scan%}Windows Defender Scheduled Scan{\n #}
	%ch% {%Verification%}Windows Defender Verification{\n #}
	%ch% {%Cleanup%}Windows Defender Cleanup{\n #}
	%ch% {%SmartScreenSpecific%}SmartScreenSpecific{\n #}
	echo.
	%ch% {0f}1{#} - {0c}Удалить Защитник Windows{\n #}
	%ch% {0f}2{#} - {0f}Состояние папок и файлов{\n #}
	%ch% {0f}3{#} - {03}Проверить обновления DK {08}[текущая  {09}%Version% {08}от {03}%DateProgram% {08}^| By {02}Vlado{08}]{\n #}
	%ch% {0f}4{#} - {08}Восстановить Защитник Windows{\n #}
	%ch% {0f}5{#} - {08}Информация о DK{\n #}
	set "input="
	set /p input=
	if not defined input cls && goto Start
	if "%input%"=="1"  cls && goto DeleteDefender
	if "%input%"=="2"  cls && goto Catalogs
	if "%input%"=="3"  cls && goto CheckUpdate
	if "%input%"=="4"  cls && goto RestoreDefender
	if "%input%"=="5"  cls && goto Information 
	) else (
	cls & %ch%    {0c}Такой функции не существует{\n #}
	timeout /t 1 >nul & endlocal & goto Start
	)
:DeleteDefender
rem Проверка места на диске перед удалением
	set "sFreeSize="
	set "sFreeSizePseudoMb="
	set "sFreeSizePseudoMb1="
	set "Freed="
	set "NameSecHealth="
	set "NotChangeUAC="
	for /f "usebackq tokens=2 delims==" %%i in (`wmic.exe LogicalDisk where "Name='c:'" get FreeSpace /value`) do set sFreeSize=%%i
	if defined sFreeSize set sFreeSizePseudoMb=%sFreeSize:~0,-7%
rem Если существует папка защитника ...
	if exist "%AllUsersProfile%\Microsoft\Windows Defender" (
rem Проверяем удалялся ли защитник ранее по ветке реестра, которая удаляется в процессе удаления. Если защитник не удалён - проверяем состояние Защиты от подделки.
	reg query "HKLM\Software\Microsoft\Windows Defender\Features" >nul 2>&1 && echo >nul || goto NotTamper
rem Проверяем наличие приложения Безопасность Windows
	for /F "usebackq delims=" %%n In (`2^>nul reg query "HKU\!SID!\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages" /f "*SecHealthUI*" /k^|findstr ^H`) do set NameSecHealth=%%~nxn
rem Если приложение Безопасность не удалено, проверяем состояние защиты от подделки
	if defined NameSecHealth (
	reg query "HKLM\Software\Microsoft\Windows Defender\Features" /v "TamperProtection" | find /i "0x4" >nul 2>&1 && (
	%ch%    {0a} Защита от подделки отключена^^!{\n #}{\n #}
	) || (
	%ch%    {04} Будут выключены все параметры Defender в автоматическом режиме.{\n #}
	%ch%    {08} Если что-то не отключилось - отключите вручную.{\n #}
	%ch%    {08} Главное, что необходимо отключить - {04}Защита от подделки{\n #}{\n #}
	%ch%    {0c} Если у Вас Windows 10 - необходимо вручную отключить "Защиту от подделки"{\n #}{\n #}
	%ch%    {08} Нажмите любую клавишу для продолжения{\n #}
rem Отключаем всплывающее окно UAC, если UAC не отключался ранее, чтобы nircmd sendkeypress работало без окна UAC
	reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" | find /i "0x0" >nul && set "NotChangeUAC=Yes"
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 0 /f >nul
rem Запускаем параметры
	explorer windowsdefender://ThreatSettings
	timeout /t 2 /nobreak >nul
rem Выключаем все параметры с помощью nircmd
	nircmd sendkeypress 0x20 0x09 0x20 0x09 0x20 0x09 0x09 0x20
:TamperProtectionStatus
rem Проверяем наличие процесса окна безопасности, если процесс существует, проверяем отключилась ли защита от подделки. Если процесса нет - выводим сообщение.
	qprocess SecHealthUI.exe >nul 2>&1 && (
	echo>nul) || (
	%ch%    {0c} Защита от подделки {4f}не{0c} отключена^^!{\n #}{\n #}
	%ch%    {08} 1 - {0c}Я не могу отключить защиту от подделки{\n #}
	%ch%    {04} Используйте, если действительно не можете отключить данную функцию{\n #}{\n #}
	%ch%    {0c} ВЫПОЛНЯЯ ЭТОТ ШАГ, ВЫ ПРОПУСКАЕТЕ СОЗДАНИЕ РЕЗЕРВНОЙ КОПИИ ЗАЩИТНИКА{\n #}{\n #}
	%ch%    {08} 2 - Вернуться обратно{\n #}
	choice /c 12 /n /m " "
	if errorlevel 2 cls && goto Start
	if errorlevel 1 cls && goto NotTamper)
rem Проверка защиты от подделки после nircmd sendkeypress
	reg query "HKLM\Software\Microsoft\Windows Defender\Features" /v "TamperProtection" | find /i "0x4" >nul 2>&1 && cls && %ch%    {0a} Защита от подделки отключена^^!{\n #}{\n #}|| goto TamperProtectionStatus
		)
	)
rem Фокус на программу
	nircmd win activate process cmd.exe
rem Вопрос о создании рез. копии
	nhmb "Вы хотите создать резервную копию Windows Defender перед выполнением удаления?\nРезервная копия позволяет восстановить защитник после удаления.\nВосстановление может потребоваться, если Вы обновляете Windows.\n\nВыбирайте нет, только в том случае, если Вам НЕ нужны обновления Windows, либо у Вас уже есть резервная копия защитника с этой версии Windows." "BackupDefender" "Warning|YesNo|DefButton2"
	if errorlevel 7 goto NotTamper
	if errorlevel 6 call :CreateBackupDefender
:NotTamper
rem Восстанавливаем по умолчанию, если параметр ConsentPromptBehaviorAdmin не изменялся ранее [в значение 5 по-умолчанию]
	if not defined NotChangeUAC reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 5 /f >nul
rem Если нет GP - пропуск [Home версия]
	if defined NoGP %ch%    {08}Пропуск отключения ГП, т.к. не найдено ГП{\n #}&&goto NotGP
	%ch%    {03} Отключаем защитник [ГП] ^>
rem Информация по политикам : https://learn.microsoft.com/ru-ru/windows/client-management/mdm/policy-csp-admx-microsoftdefenderantivirus
rem Выключить антивирусную программу Microsoft Defender (включена) [DisableAntiSpyware]
rem Разрешить постоянную работу службы защиты от вредоносных программ (отключена) [ServiceKeepAlive]
rem Выключить плановое исправление (включено) [DisableRoutinelyTakingAction]
rem Разрешить запуск службы защиты от вредоносных программ с обычным приоритетом (отключено) [AllowFastServiceStartup]
rem Выключить защиту в реальном времени (включено) [DisableRealtimeMonitoring]
rem Проверять все загруженные файлы и вложения (отключено) [DisableIOAVProtection]
rem Включить наблюдение за поведением (отключено) [DisableBehaviorMonitoring]
rem Включить проверку процессов, если включена защита в режиме реального времени (отключено) [DisableScanOnRealtimeEnable]
rem Отслеживать активность программ и файлов на компьютере (отключено) [DisableOnAccessProtection]
rem Настроить локальное переопределение для включения защиты в режиме реального времени (отключено) [LocalSettingOverrideDisableRealtimeMonitoring]
rem Настроить локальное переопределение для включения контроля поведения (отключено) [LocalSettingOverrideDisableBehaviorMonitoring]
rem Настроить локальное переопределение для проверки всех загруженных файлов и вложений (отключено) [LocalSettingOverrideDisableIOAVProtection]
rem Настроить локальное переопределение для отправки отчётов в MAPS (отключено) [LocalSettingOverrideSpynetReporting]
rem Присоединится к Microsoft MAPS (отключено) [**del.SpynetReporting]
rem Отправлять образцы файлов, если требуется дальнейший анализ (включено) [SubmitSamplesConsent]
rem Разрешить обновления службы безопасности в реальном времени на основе отчётов в Microsoft MAPS (отключено) [RealtimeSignatureDelivery]
rem Запускать обновления службы анализа безопасности при запуске (отключено) [DisableUpdateOnStartupWithoutEngine]
rem Проверять наличие последней версии службы защиты при запуске (отключено) [UpdateOnStartUp]
rem Включить проверку после обновления службы анализа безопасности (отключено) [DisableScanOnUpdate]
rem Настроить события программы "Доктор Ватсон" (отправка данных сборщиком ошибок) (отключено) [DisableGenericRePorts]
rem Включить дополнительную проверку для полных/быстрых проверок (отключено) [DisableCatchupFullScan/DisableCatchupQuickScan]
rem Проверять съемные носители во время быстрого сканирования (отключено) [DisableRemovableDriveScanning]
rem Проверять сетевые файлы (отключено) [DisableScanningNetworkFiles]
rem Выполнять полную проверку на подключенных сетевых дисках (отключено) [DisableScanningMappedNetworkDrivesForFullScan]
rem Проверять архивные файлы (отключено) [DisableArchiveScanning]
rem Настроить функцию SmartScreen Защитника Windows (3 политики) (отключены)
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "AllowFastServiceStartup" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableRealtimeMonitoring" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableBehaviorMonitoring" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableIOAVProtection" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Spynet" /v "LocalSettingOverrideSpynetReporting" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Spynet" /v "**del.SpynetReporting" /t REG_SZ /d " " /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d "2" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "RealtimeSignatureDelivery" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableUpdateOnStartupWithoutEngine" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "UpdateOnStartUp" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableScanOnUpdate" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Reporting" /v "DisableGenericRePorts" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableCatchupFullScan" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableCatchupQuickScan" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableRemovableDriveScanning" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableScanningNetworkFiles" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableScanningMappedNetworkDrivesForFullScan" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableArchiveScanning" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "**del.ShellSmartScreenLevel" /t REG_SZ /d " " /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d "0" /f
	call :LGPO_APPLY
:NotGP
rem Фокус на программу
	nircmd win activate process cmd.exe
rem SmartScreen BX
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f >nul
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide cmd.exe /c reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f >nul
rem Уведомления от центра безопасности
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d "0" /f >nul
rem MSRT - Средство удаления вредоносных программ от Microsoft. [Не отправлять отчеты от MSRT/Отключить получение обновлений для MSRT]
	reg add "HKLM\Software\Policies\Microsoft\MRT" /v "DontReportInfectionInformation" /t REG_DWORD /d "1" /f >nul
	reg add "HKLM\Software\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /t REG_DWORD /d "1" /f >nul
	)
rem Пропуск Unlocker; DefenderStop, если защитник уже удалён
	if not exist "%AllUsersProfile%\Microsoft\Windows Defender" goto NotFuckWD
	if not exist "%SystemDrive%\Program Files\Windows Defender" goto NotFuckWD
rem                                                                   =================================
rem Если это вторая [повторная] проходка удаления, то пропускаем добавление в исключения
	if not defined RepeatDel (
	%ch%    {03} Добавляем Unlocker/DefenderStop в исключения{\n #}{\n #}
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide -Wait PowerShell "Add-MpPreference -ExclusionPath '%~dp0Work', '%LocalAppData%\Temp\RarSFX0', '%LocalAppData%\Temp\RarSFX1', '%LocalAppData%\Temp\RarSFX2', '%Temp%\RarSFX0', '%Temp%\RarSFX1', '%Temp%\RarSFX2'" >nul 2>&1)
rem Завершаем процессы Защитника
	nircmd killprocess MpCmdRun.exe
	nircmd killprocess MsMpEng.exe
	nircmd killprocess SecurityHealthSystray.exe
	nircmd killprocess SecurityHealthService.exe
	nircmd killprocess SecurityHealthHost.exe
	nircmd killprocess smartscreen.exe
	nircmd killprocess SgrmBroker.exe
	nircmd killprocess SecHealthUI.exe
	nircmd killprocess uhssvc.exe
	nircmd killprocess NisSrv.exe
	nircmd killprocess MPSigStub.exe
	if not exist DefenderStop.exe (
	ping www.google.nl -n 1 -w 1000 |>nul find /i "TTL=" && curl -g -k -L -# -o "DefenderStop.exe" "https://i.getspace.eu/cloud/s/GXAtGk7qLbHj2CS/download" >nul 2>&1
	) || %ch%    {0c} Невозможно скачать DefenderStop/Unlocker. Нет подключения к интернету{\n #}{\n #}&& goto NotFuckWD
	%ch%    {03} Используем DefenderStop{\n #}{\n #}
	nircmd exec hide DefenderStop.exe
	nircmd wait 3000
	nircmd exec hide DefenderStop.exe
rem                                                                   =================================
	if "%xOS%"=="x86" (
	%ch%    {04} Unlocker не работает на x32 системе.{\n #}
	%ch%    {04} После перезагрузки ПК необходимо повторное удаление.{\n #}
	goto NotFuckWD)
	if not exist FuckDefender.exe curl -g -k -L -# -o "FuckDefender.exe" "https://i.getspace.eu/cloud/s/Eb3sKTfwiamRAnt/download" >nul 2>&1
	%ch%    {0c} Выполняется удаление с помощью Unlocker{\n #}
	%ch%    {08} Время ожидания - 20 сек.{\n #}{\n #}
rem By XpucT/Vlado/Eject
	start FuckDefender
	timeout /t 3 /nobreak >nul
	qprocess Unlocker.exe >nul 2>&1 && echo >nul || goto NotFuckWD
rem Ждём 20 секунд, если Unlocker смог запуститься
(
	timeout /t 20 /nobreak
	taskkill /f /im Unlocker.exe
	taskkill /f /im FuckDefender.exe
	taskkill /f /im wscript.exe
	nircmd killprocess Unlocker.exe & nircmd killprocess FuckDefender.exe & nircmd killprocess wscript.exe
rem Удаляем Unlocker и драйвер. Восстановится сам, если используется IObitUnlocker - https://cdn.discordapp.com/attachments/1099332280629084163/1196482117383766138/IObitUnlocker_Test.mp4
	del /q FuckDefender.exe
	sc delete IObitUnlocker
	reg delete HKLM\System\CurrentControlset\Services\IObitUnlocker /f	
) >nul 2>&1
rem                                                                   =================================
:NotFuckWD
	%ch%    {03} Удаляем папки и файлы WD{\n #}{\n #}
(
rem ProgramData
	rmdir /s /q "%AllUsersProfile%\Microsoft\Windows Defender"
	rmdir /s /q "%AllUsersProfile%\Microsoft\Windows Defender Advanced Threat Protection"
	rmdir /s /q "%AllUsersProfile%\Microsoft\Windows Security Health"
	rmdir /s /q "%AllUsersProfile%\Microsoft\Storage Health"
rem SystemDrive - Program Files
	rmdir /s /q "%SystemDrive%\Program Files\Windows Defender"
	rmdir /s /q "%SystemDrive%\Program Files\Windows Defender Sleep"
	rmdir /s /q "%SystemDrive%\Program Files\Windows Defender Advanced Threat Protection"
	rmdir /s /q "%SystemDrive%\Program Files\Windows Security"
	rmdir /s /q "%SystemDrive%\Program Files\PCHealthCheck"
	rmdir /s /q "%SystemDrive%\Program Files\Microsoft Update Health Tools"
rem SystemDrive - Program Files 86
	rmdir /s /q "%SystemDrive%\Program Files (x86)\Windows Defender"
	rmdir /s /q "%SystemDrive%\Program Files (x86)\Windows Defender Advanced Threat Protection"
rem Windows
	rmdir /s /q "%SystemRoot%\security\database"
rem Windows - System32
	rmdir /s /q "%SystemRoot%\System32\HealthAttestationClient"
	rmdir /s /q "%SystemRoot%\System32\SecurityHealth"
	rmdir /s /q "%SystemRoot%\System32\WebThreatDefSvc"
	rmdir /s /q "%SystemRoot%\System32\Sgrm"
	rmdir /s /q "%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\Defender"
	rmdir /s /q "%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\DefenderPerformance"
	rmdir /s /q "%SystemRoot%\System32\Tasks_Migrated\Microsoft\Windows\Windows Defender"
	rmdir /s /q "%SystemRoot%\System32\drivers\wd"
rem Windows - SysWOW64
	rmdir /s /q "%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\Modules\Defender"
	rmdir /s /q "%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\Modules\DefenderPerformance"
rem Переименование файлов которые могут мешать удалению
	if exist "%AllUsersProfile%\Microsoft\Windows Defender\Platform" (
	for /r "%AllUsersProfile%\Microsoft\Windows Defender\Platform" %%i in ("MpOAV.dll") do ren "%%i" "MpOAV.dll_fuck" >nul 2>&1
	for /r "%AllUsersProfile%\Microsoft\Windows Defender\Platform" %%i in ("MpClient.dll") do ren "%%i" "MpClient.dll_fuck" >nul 2>&1
	for /r "%AllUsersProfile%\Microsoft\Windows Defender\Platform" %%i in ("MsMpEng.exe") do ren "%%i" "MsMpEng.exe_fuck" >nul 2>&1)
	if exist "%SystemDrive%\Program Files\Windows Defender" (
	ren "%SystemDrive%\Program Files\Windows Defender\MpOAV.dll" "MpOAV.dll_fuck" >nul 2>&1
	ren "%SystemDrive%\Program Files\Windows Defender\MpClient.dll" "MpClient.dll_fuck" >nul 2>&1
	ren "%SystemDrive%\Program Files\Windows Defender\MsMpEng.exe" "MsMpEng.exe_fuck" >nul 2>&1)
	ren "%SystemRoot%\System32\SecurityHealthService.exe" "SecurityHealthService.exe_fuck"
	ren "%SystemRoot%\System32\smartscreenps.dll" smartscreenps.dll_fuck
	ren "%SystemRoot%\System32\wscapi.dll" wscapi.dll_fuck
rem WindowsDefenderApplicationGuard.wim
	del /f /q "%SystemRoot%\Containers\WindowsDefenderApplicationGuard.wim"
	del /f /q "%SystemRoot%\Containers\serviced\WindowsDefenderApplicationGuard.wim"
rem Удаление файлов System32
	del /f /q "%SystemRoot%\System32\SecurityHealthService.exe"
	del /f /q "%SystemRoot%\System32\SecurityHealthService.exe_fuck"
	del /f /q "%SystemRoot%\System32\SecurityHealthSystray.exe"
	del /f /q "%SystemRoot%\System32\SecurityHealthHost.exe"
	del /f /q "%SystemRoot%\System32\SecurityHealthAgent.dll"
	del /f /q "%SystemRoot%\System32\SecurityHealthSSO.dll"
	del /f /q "%SystemRoot%\System32\SecurityHealthProxyStub.dll"
	del /f /q "%SystemRoot%\System32\LogFiles\WMI\RtBackup\EtwRTDefenderApiLogger.etl"
	del /f /q "%SystemRoot%\System32\LogFiles\WMI\RtBackup\EtwRTDefenderAuditLogger.etl"
	del /f /q "%SystemRoot%\System32\smartscreen.dll"
	del /f /q "%SystemRoot%\System32\wscisvif.dll"
	del /f /q "%SystemRoot%\System32\wscproxystub.dll"
	del /f /q "%SystemRoot%\System32\smartscreenps.dll"
	del /f /q "%SystemRoot%\System32\smartscreenps.dll_fuck"
	del /f /q "%SystemRoot%\System32\wscapi.dll"
	del /f /q "%SystemRoot%\System32\wscapi.dll_fuck"
	del /f /q "%SystemRoot%\System32\windowsdefenderapplicationguardcsp.dll"
	del /f /q "%SystemRoot%\System32\wscsvc.dll"
	del /f /q "%SystemRoot%\System32\SecurityHealthCore.dll"
	del /f /q "%SystemRoot%\System32\SecurityHealthSsoUdk.dll"
	del /f /q "%SystemRoot%\System32\SecurityHealthUdk.dll"
rem Удаление SmartScreen.exe
	taskkill /f /im smartscreen.exe
	ren "%SystemRoot%\System32\smartscreen.exe" "smartscreen.exedel"
	del /f /q "%SystemRoot%\System32\smartscreen.exe"
	del /f /q "%SystemRoot%\System32\smartscreen.exedel"
rem Удаление файлов SysWOW64
	del /f /q "%SystemRoot%\SysWOW64\smartscreen.dll"
	del /f /q "%SystemRoot%\SysWOW64\wscisvif.dll"
	del /f /q "%SystemRoot%\SysWOW64\wscproxystub.dll"
	del /f /q "%SystemRoot%\SysWOW64\smartscreenps.dll"
	del /f /q "%SystemRoot%\SysWOW64\wscapi.dll"
	del /f /q "%SystemRoot%\SysWOW64\windowsdefenderapplicationguardcsp.dll"
) >nul 2>&1
rem                                                                   =================================
	%ch%    {03} Удаляем службы{\n #}
	%ch%    {0a} WinDefend, SecurityHealthService, Sense, WdNisSvc, wscsvc, webthreatdefsvc{\n #}
	%ch%    {0a} webthreatdefusersvc{\n #}{\n #}
	if exist DefenderStop.exe nircmd exec hide DefenderStop.exe
(
rem Остановка служб
	sc stop WinDefend
	sc stop SecurityHealthService
	sc stop Sense
	sc stop WdNisSvc
	sc stop wscsvc
	sc stop SgrmBroker
	sc stop webthreatdefsvc
	sc stop webthreatdefusersvc
	sc stop %serviceswebmask%
rem Удаление служб
	sc delete WinDefend
	sc delete SecurityHealthService
	sc delete Sense
	sc delete WdNisSvc
	sc delete wscsvc
	sc delete SgrmBroker
	sc delete webthreatdefsvc
	sc delete webthreatdefusersvc
	sc delete %serviceswebmask%
	reg delete HKLM\System\ControlSet001\Services\EventLog\System\WinDefend /f 
	reg delete HKLM\System\ControlSet001\Services\SecurityHealthService /f
	reg delete HKLM\System\ControlSet001\Services\Sense /f
	reg delete HKLM\System\ControlSet001\Services\WdNisSvc /f
	reg delete HKLM\System\ControlSet001\Services\WinDefend /f
	reg delete HKLM\System\ControlSet001\Services\wscsvc /f
	reg delete HKLM\System\ControlSet001\Services\SgrmBroker /f
	reg delete HKLM\System\ControlSet001\Services\webthreatdefsvc /f
	reg delete HKLM\System\ControlSet001\Services\webthreatdefusersvc /f
	reg delete HKLM\System\CurrentControlSet\Services\EventLog\System\WinDefend /f
	reg delete HKLM\System\CurrentControlset\Services\SecurityHealthService /f
	reg delete HKLM\System\CurrentControlset\Services\Sense /f
	reg delete HKLM\System\CurrentControlset\Services\WdNisSvc /f
	reg delete HKLM\System\CurrentControlset\Services\WinDefend /f
	reg delete HKLM\System\CurrentControlset\Services\wscsvc /f
	reg delete HKLM\System\CurrentControlset\Services\SgrmBroker /f
	reg delete HKLM\System\CurrentControlset\Services\webthreatdefsvc /f
	reg delete HKLM\System\CurrentControlset\Services\webthreatdefusersvc /f
	del /q DefenderStop.exe
) >nul 2>&1
rem                                                                   =================================
	%ch%    {03} Удаляем драйвера{\n #}
	%ch%    {0a} WdNisDrv, WdBoot, WdFilter, SgrmAgent, wtd, MsSecWfp, MsSecFlt, MsSecCore{\n #}{\n #}
(
rem Отключение и удаление драйверов
	sc stop WdNisDrv
	sc stop WdBoot
	sc stop WdFilter
	sc stop SgrmAgent
	sc stop wtd
	sc stop MsSecWfp
	sc stop MsSecFlt
	sc stop MsSecCore
	sc delete WdNisDrv
	sc delete WdBoot
	sc delete WdFilter
	sc delete SgrmAgent
	sc delete wtd
	sc delete MsSecWfp
	sc delete MsSecFlt
	sc delete MsSecCore
	reg delete "HKLM\System\CurrentControlset\Services\WdNisDrv" /f
	reg delete "HKLM\System\CurrentControlset\Services\WdBoot" /f
	reg delete "HKLM\System\CurrentControlset\Services\WdFilter" /f
	reg delete "HKLM\System\CurrentControlset\Services\SgrmAgent" /f
	reg delete "HKLM\System\CurrentControlset\Services\wtd" /f
	reg delete "HKLM\System\CurrentControlset\Services\MsSecWfp" /f
	reg delete "HKLM\System\CurrentControlset\Services\MsSecFlt" /f
	reg delete "HKLM\System\CurrentControlset\Services\MsSecCore" /f
) >nul 2>&1
rem                                                                   =================================
	%ch%    {03} Удаляем задания из планировщика{\n #}
	rmdir /s /q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Windows Defender" >nul 2>&1
	schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /f >nul 2>&1 & %ch% {0a}    Windows Defender Cache Maintenance{\n #}
	schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /f >nul 2>&1 & %ch% {0a}    Windows Defender Cleanup{\n #}
	schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /f >nul 2>&1 & %ch% {0a}    Windows Defender Scheduled Scan{\n #}
	schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Verification" /f >nul 2>&1 & %ch% {0a}    Windows Defender Verification{\n #}
	schtasks /Delete /TN "Microsoft\Windows\AppID\SmartScreenSpecific" >nul 2>&1 & %ch% {0a}    SmartScreenSpecific{\n #}{\n #}
rem                                                                   =================================
(
rem Очистка контекстного меню
	reg delete "HKCR\*\shellex\ContextMenuHandlers\EPP" /f
	reg delete "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /f
	reg delete "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /f
	reg delete "HKLM\Software\Classes\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved" /v "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
rem Удаление из автозапуска
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth" /f
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Defender" /f
rem Удаление Windows Defender из реестра
	reg delete "HKLM\System\CurrentControlset\Control\WMI\Autologger\DefenderApiLogger" /f
	reg delete "HKLM\System\CurrentControlset\Control\WMI\Autologger\DefenderAuditLogger" /f
	reg delete "HKLM\Software\Microsoft\Windows Defender" /f
	reg delete "HKLM\Software\Microsoft\Windows Defender Security Center" /f
	reg delete "HKLM\Software\Microsoft\Windows Advanced Threat Protection" /f
	reg delete "HKLM\Software\Microsoft\Windows Security Health" /f
rem Удаление надписи в параметрах
	reg delete "HKLM\Software\Microsoft\SystemSettings\SettingId\SystemSettings_WindowsDefender_UseWindowsDefender" /f
rem Удаление журналов событий
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/WHC" /f
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\NIS-Driver-WFP/Diagnostic" /f
) >nul 2>&1
rem                                                                   =================================
rem Если удалялась эта ветка ранее, пропускаем удаление папок из WinSxS
	reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/Operational" >nul 2>&1 && (
	%ch%    {03} Удаляем папки из WinSxS{\n #}{\n #}
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%SystemRoot%\WinSxS\*windows-defender*" /S /B /A:D`) do rmdir "%%d" /s /q >nul 2>&1
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%SystemRoot%\WinSxS\*windows-senseclient-service*" /S /B /A:D`) do rmdir "%%d" /s /q >nul 2>&1
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%SystemRoot%\WinSxS\*windows-dynamic-image*" /S /B /A:D`) do rmdir "%%d" /s /q >nul 2>&1
	)
rem Файлы из WinSxS нельзя удалять, ломается скачивание обновлений Windows!
rem del /q /s %SystemRoot%\WinSxS\*defender* >nul 2>&1
rem Удаление ветки после удаления папок из WinSxS , выполняется СТРОГО после удаления папок из WinSxS чтобы 1 раз удаление папок произошло, но последующие удаления пропускалось
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/Operational" /f >nul 2>&1
rem                                                                   =================================
:SecHealthUI
	VER | FINDSTR /IL "6.3." > NUL && %ch%    {0c} Windows 8.1 не нуждается в удалении приложения 'Безопасность' и 'SmartScreen'{\n #}&&goto FinishDelete
rem Проверяем создавался ли бекап, если да - пропускаем удаление приложений
	reg query "HKLM\Software\DefenderKiller" >nul 2>&1 && 	%ch%    {0e} Было выбрано создание резервной копии, пропускаем удаление приложений{\n #}{\n #}&&goto FinishDelete
rem Проверка через PS
	rem PowerShell "Get-AppxPackage -AllUsers *SecHealth*" | find /i "PackageFullName" >nul
	%ch%    {09} Безопасность Windows{\n #}
	set "NameSecHealth="
rem Получаем имя приложения Безопасность
	for /F "usebackq delims=" %%n In (`2^>nul reg query "HKU\%SID%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages" /f "*SecHealthUI*" /k^|findstr ^H`) do set NameSecHealth=%%~nxn
	if not defined NameSecHealth %ch%    {02} Приложение Безопасность Windows удалено{\n #}{\n #}&goto AppRepSys
	%ch%    {0b} Удаляем приложение Безопасность Windows{\n #}
	%ch%    {08} %NameSecHealth%{\n #}{\n #}
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\S-1-5-18\%NameSecHealth%" /f >nul
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\%SID%\%NameSecHealth%" /f >nul
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide -Wait PowerShell "Get-AppxPackage -AllUsers *SecHealthUI* | Remove-AppxPackage"	
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\InboxApplications\%NameSecHealth%" /f >nul 2>&1
rem Эти папки можно удалять. Восстанавливаются сами, если восстановить приложение Безопасность.
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%ProgramData%\Microsoft\Windows\AppRepository\Packages\*SecHealth*" /S /B /A:D`) Do rmdir "%%d" /s /q
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%LocalAppData%\Packages\*SecHealth*" /S /B /A:D`) Do rmdir "%%d" /s /q
rem                                                                   =================================
:AppRepSys
	%ch%    {09} SmartScreen защитника Windows{\n #}
	set "NameAppRep="
rem Получаем имя приложения AppRep
	for /F "usebackq delims=" %%n In (`2^>nul reg query "HKU\%SID%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages" /f "*Apprep.ChxApp*" /k^|findstr ^H`) do set NameAppRep=%%~nxn
	if not defined NameAppRep %ch%    {02} Приложение SmartScreen защитника Windows удалено{\n #}&goto FinishDelete
	%ch%    {0b} Удаляем приложение SmartScreen защитника Windows{\n #}
	%ch%    {08} %NameAppRep%{\n #}
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\S-1-5-18\%NameAppRep%" /f >nul
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\%SID%\%NameAppRep%" /f >nul
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide -Wait PowerShell "Get-AppxPackage -AllUsers *Apprep.ChxApp* | Remove-AppxPackage"	
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\InboxApplications\%NameAppRep%" /f >nul 2>&1
rem Эти папки можно удалять, восстанавливаются сами, если восстановить приложение Apprep.ChxApp
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%ProgramData%\Microsoft\Windows\AppRepository\Packages\*Apprep.ChxApp*" /S /B /A:D`) Do rmdir "%%d" /s /q
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%LocalAppData%\Packages\*Apprep.ChxApp*" /S /B /A:D`) Do rmdir "%%d" /s /q
rem                                                                   =================================
:FinishDelete
rem Освобождённое место на диске
	for /f "usebackq tokens=2 delims==" %%i in (`wmic.exe LogicalDisk where "Name='c:'" get FreeSpace /value`) do set sFreeSize=%%i
	if defined sFreeSize (set sFreeSizePseudoMb1=%sFreeSize:~0,-7%)
	set /a Freed=%sFreeSizePseudoMb1% - %sFreeSizePseudoMb%
	echo.
	%ch%    {06} %Freed% Мегабайт места освобождено после удаления{\n #}
	if not exist "%AllUsersProfile%\Microsoft\Windows Defender" (
	%ch%    {02} Защитник Windows удален{\n #}{\n #}
	%ch%    {08} Ориентируйтесь на состояние папок [2]{\n #}   {08} Если что-то осталось, перезагрузите ПК и повторите удаление{\n #}
	%ch%    {08} Нажмите любую клавишу для продолжения{\n #}{\n #}
	) else (
	echo.
	nhmb "Защитник Windows НЕ удален.\nПовторить удаление защитника?\n\nЕсли после нескольких попыток удаления защитник не удаляется и появляется это сообщение, выполните перезагрузку компьютера и повторите попытку удаления." "DK" "Information|YesNo"
	if errorlevel 7 cls && goto Start
	if errorlevel 6 cls && set "RepeatDel=Yes" && goto DeleteDefender
	)
rem                                                                   =================================
:Catalogs
rem Размер окна в зависимости от наличия службы
	if defined serviceswebmask (Mode 82,45) else (Mode 80,45)
	%ch% {3f}%SystemRoot%\System32{\n #}
rem 14.03.23
	if not exist "%SystemRoot%\System32\HealthAttestationClient" (%ch% {0a} %SystemRoot%\System32\HealthAttestationClient{\n #}) else (%ch%  {0c}%SystemRoot%\System32\HealthAttestationClient{\n #})
	if not exist "%SystemRoot%\System32\SecurityHealth" (%ch% {0a} %SystemRoot%\System32\SecurityHealth{\n #}) else (%ch%  {0c}%SystemRoot%\System32\SecurityHealth{\n #})
	if not exist "%SystemRoot%\System32\WebThreatDefSvc" (%ch% {0a} %SystemRoot%\System32\WebThreatDefSvc{\n #}) else (%ch%  {0c}%SystemRoot%\System32\WebThreatDefSvc{\n #})
	if not exist "%SystemRoot%\System32\Sgrm" (%ch% {0a} %SystemRoot%\System32\Sgrm{\n #}) else (%ch%  {0c}%SystemRoot%\System32\Sgrm{\n #})
	if not exist "%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\Defender" (%ch% {0a} %SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\Defender{\n #}) else (%ch%  {0c}%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\Defender{\n #})
	if not exist "%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\DefenderPerformance" (%ch% {0a} %SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\DefenderPerformance{\n #}) else (%ch%  {0c}%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\DefenderPerformance{\n #})
	if not exist "%SystemRoot%\System32\Tasks_Migrated\Microsoft\Windows\Windows Defender" (%ch% {0a} %SystemRoot%\System32\Tasks_Migrated\Microsoft\Windows\Windows Defender{\n #}) else (%ch%  {0c}%SystemRoot%\System32\Tasks_Migrated\Microsoft\Windows\Windows Defender{\n #})
	echo.
	%ch% {3f}C:\Program Files{\n #}
	if not exist "%SystemDrive%\Program Files\Windows Defender" (%ch% {0a} C:\Program Files\Windows Defender {08}- основная папка защитника 1{\n #}) else (%ch%  {4f}C:\Program Files\Windows Defender{08} - основная папка защитника 1{\n #})
	if not exist "%SystemDrive%\Program Files\Windows Defender Sleep" (%ch% {0a} C:\Program Files\Windows Defender Sleep {\n #}) else (%ch%  {4f}C:\Program Files\Windows Defender Sleep{\n #})
	if not exist "%SystemDrive%\Program Files\Windows Defender Advanced Threat Protection" (%ch% {0a} C:\Program Files\Windows Defender Advanced Threat Protection{\n #}) else (%ch%  {0c}C:\Program Files\Windows Defender Advanced Threat Protection{\n #})
	if not exist "%SystemDrive%\Program Files\Windows Security" (%ch% {0a} C:\Program Files\Windows Security{\n #}) else (%ch%  {0c}C:\Program Files\Windows Security{\n #})
	if not exist "%SystemDrive%\Program Files\PCHealthCheck" (%ch% {0a} C:\Program Files\PCHealthCheck{\n #}) else (%ch%  {0c}C:\Program Files\PCHealthCheck{\n #})
	if not exist "%SystemDrive%\Program Files\Microsoft Update Health Tools" (%ch% {0a} C:\Program Files\Microsoft Update Health Tools{\n #}) else (%ch%  {0c}C:\Program Files\Microsoft Update Health Tools{\n #})
	echo.
	%ch% {3f}C:\Program Files (^x86^){\n #}
	if not exist "%ProgramFiles(x86)%\Windows Defender" (%ch% {0a} C:\Program Files (^x86^)\Windows Defender{\n #}) else (%ch%  {0c}C:\Program Files (^x86^)\Windows Defender{\n #})
	if not exist "%ProgramFiles(x86)%\Windows Defender Advanced Threat Protection" (%ch% {0a} C:\Program Files (^x86^)\Windows Defender Advanced Threat Protection{\n #}) else (%ch%  {0c}C:\Program Files (^x86^)\Windows Defender Advanced Threat Protection{\n #})
	echo.
	%ch% {3f}C:\ProgramData{\n #}
	if not exist "%AllUsersProfile%\Microsoft\Windows Defender" (%ch% {0a} C:\ProgramData\Microsoft\Windows Defender {08}- основная папка защитника 2{\n #}) else (%ch%  {4f}C:\ProgramData\Microsoft\Windows Defender{08} - основная папка защитника 2{\n #})
	if not exist "%AllUsersProfile%\Microsoft\Windows Defender Advanced Threat Protection" (%ch% {0a} C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection{\n #}) else (%ch%  {0c}C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection{\n #})
	if not exist "%AllUsersProfile%\Microsoft\Windows Security Health" (%ch% {0a} C:\ProgramData\Microsoft\Windows Security Health{\n #}) else (%ch%  {0c}C:\ProgramData\Microsoft\Windows Security Health{\n #})
	if not exist "%AllUsersProfile%\Microsoft\Storage Health" (%ch% {0a} C:\ProgramData\Microsoft\Storage Health{\n #}) else (%ch%  {0c}C:\ProgramData\Microsoft\Storage Health{\n #})
	echo.
	%ch% {3f}Папка задач планировщика защитника{\n #}
	if not exist "%SYSTEMROOT%\System32\Tasks\Microsoft\Windows\Windows Defender" (%ch% {0a} C:\Windows\System32\Tasks\Microsoft\Windows\Windows Defender{\n #}) else (%ch%  {0c}C:\Windows\System32\Tasks\Microsoft\Windows\Windows Defender{\n #})
	echo.
	%ch% {3f}Остальные файлы{\n #}
	if not exist "%SystemRoot%\Containers\WindowsDefenderApplicationGuard.wim" (%ch% {0a} C:\Windows\Containers\WindowsDefenderApplicationGuard.wim{\n #}) else (%ch%  {0c}C:\Windows\Containers\WindowsDefenderApplicationGuard.wim{\n #})
	if not exist "%SystemRoot%\Containers\serviced\WindowsDefenderApplicationGuard.wim" (%ch% {0a} C:\Windows\Containers\serviced\WindowsDefenderApplicationGuard.wim{\n #}) else (%ch%  {0c}C:\Windows\Containers\serviced\WindowsDefenderApplicationGuard.wim{\n #})
	echo.
	if not exist "%SystemRoot%\System32\SecurityHealthService.exe" (%ch% {02} SecurityHealthService.exe{#} ^| ) else (%ch% {0c} SecurityHealthService.exe {#}^| )
	if not exist "%SystemRoot%\System32\SecurityHealthSystray.exe" (%ch% {02}SecurityHealthSystray.exe{#} ^| ) else (%ch% {0c}SecurityHealthSystray.exe {#}^| )
	if not exist "%SystemRoot%\System32\SecurityHealthHost.exe" (%ch% {02}SecurityHealthHost.exe{\n #}) else (%ch% {0c}SecurityHealthHost.exe{\n #})
	if not exist "%SystemRoot%\System32\SecurityHealthAgent.dll" (%ch% {02} SecurityHealthAgent.dll{#} ^| ) else (%ch% {0c} SecurityHealthAgent.dll{#} ^| )
	if not exist "%SystemRoot%\System32\SecurityHealthSSO.dll" (%ch% {02}SecurityHealthSSO.dll{#} ^| ) else (%ch% {0c}SecurityHealthSSO.dll{#} ^| )
	if not exist "%SystemRoot%\System32\SecurityHealthProxyStub.dll" (%ch% {02}SecurityHealthProxyStub.dll{\n #}) else (%ch% {0c}SecurityHealthProxyStub.dll{\n #})
	if not exist "%SystemRoot%\System32\smartscreen.dll" (%ch% {02} smartscreen.dll{#} ^| ) else (%ch% {0c} smartscreen.dll{#} ^| )
	if not exist "%SystemRoot%\System32\wscisvif.dll" (%ch% {02}wscisvif.dll{#} ^| ) else (%ch% {0c}wscisvif.dll{#} ^| )
	if not exist "%SystemRoot%\System32\wscproxystub.dll" (%ch% {02}wscproxystub.dll{#} ^| ) else (%ch% {0c}wscproxystub.dll{#} ^| )
	if not exist "%SystemRoot%\System32\smartscreenps.dll" (%ch% {02}smartscreenps.dll{\n #}) else (%ch% {0c}smartscreenps.dll{\n #})
	if not exist "%SystemRoot%\System32\wscapi.dll" (%ch% {02} wscapi.dll{#} ^| ) else (%ch% {0c} wscapi.dll{#} ^| )
	if not exist "%SystemRoot%\System32\windowsdefenderapplicationguardcsp.dll" (%ch% {02} windowsdefenderapplicationguardcsp.dll{#} ^| ) else (%ch% {0c} windowsdefenderapplicationguardcsp.dll{#} ^| )
	if not exist "%SystemRoot%\System32\wscsvc.dll" (%ch% {02}wscsvc.dll{\n #}) else (%ch% {0c}wscsvc.dll{\n #})
	if not exist "%SystemRoot%\System32\SecurityHealthCore.dll"  (%ch% {02} SecurityHealthCore.dll{\n #}) else (%ch% {0c} SecurityHealthCore.dll{\n #})
	if not exist "%SystemRoot%\System32\SecurityHealthSsoUdk.dll"  (%ch% {02} SecurityHealthSsoUdk.dll{\n #}) else (%ch% {0c} SecurityHealthSsoUdk.dll{\n #})
	if not exist "%SystemRoot%\System32\SecurityHealthUdk.dll" (%ch% {02} SecurityHealthUdk.dll{\n #}) else (%ch% {0c} SecurityHealthUdk.dll{\n #})
	if not exist "%SystemRoot%\System32\SecurityHealthAgent.dll"  (%ch% {02} SecurityHealthAgent.dll{\n #}) else (%ch% {0c} SecurityHealthAgent.dll{\n #})
rem                                                                   =================================
:CreateBackupDefender
rem Проверяем наличие интернета, чтобы использовать DefenderStop перед созданием резервной копии [нужен, т.к. без него не копируется папка защитника, из-за включённых служб]
	if not exist DefenderStop.exe (
	ping www.google.nl -n 1 -w 1000 |>nul find /i "TTL=" && curl -g -k -L -# -o "DefenderStop.exe" "https://i.getspace.eu/cloud/s/GXAtGk7qLbHj2CS/download" >nul 2>&1
	) || (
	%ch%    {0c} Невозможно создать резервную копию, нет подключения к интернету{\n #}
	%ch%    {0c} Невозможно скачать DefenderStop{\n #}{\n #}
	%ch%    {08} https://i.getspace.eu/cloud/s/GXAtGk7qLbHj2CS/download{\n #}
rem Используем несколько раз для уверенности выполнения
	%ch%    {03} Используем DefenderStop для отключения служб защитника{\n #}{\n #}
	nircmd exec hide DefenderStop.exe
	nircmd wait 3000
	nircmd exec hide DefenderStop.exe
	nircmd exec hide DefenderStop.exe
	%ch%    {02} Создаём резервную копию папок из %AllUsersProfile%{\n #}
(
    xcopy /s /e /h /y /i "%AllUsersProfile%\Microsoft\Windows Defender" "%SystemDrive%\WDefenderBackup\Folder\ProgramData\Microsoft\Windows Defender"
    xcopy /s /e /h /y /i "%AllUsersProfile%\Microsoft\Windows Defender Advanced Threat Protection" "%SystemDrive%\WDefenderBackup\Folder\ProgramData\Microsoft\Windows Defender Advanced Threat Protection"
    xcopy /s /e /h /y /i "%AllUsersProfile%\Microsoft\Windows Security Health" "%SystemDrive%\WDefenderBackup\Folder\ProgramData\Microsoft\Windows Security Health"
    xcopy /s /e /h /y /i "%AllUsersProfile%\Microsoft\Storage Health" "%SystemDrive%\WDefenderBackup\Folder\ProgramData\Microsoft\Storage Health"
) >nul 2>&1
rem Проверка после копирования главной папки, скопировалась ли ...
	dir /b "%SystemDrive%\WDefenderBackup\Folder\ProgramData\Microsoft\Windows Defender" | findstr /r "^" >nul && (
	echo >nul
	) || (
	%ch% {04} Папку "%AllUsersProfile%\Microsoft\Windows Defender" скопировать не удалось{\n #}
	%ch% {04} Такое возможно, если у Вас не отработал DefenderStop и не отключились службы защитника{\n #}
	%ch% {04} Вы используете либо Win 11 Dev/Beta версию, либо Microsoft что-то изменила{\n #}{\n #}
	%ch% {08} Попробуйте еще раз повторить попытку...{\n #}
	rd /s /q "%SystemDrive%\WDefenderBackup" >nul 2>&1
	cls && goto Start
	)
	%ch%    {02} Создаём резервную копию папок из %ProgramFiles% и %ProgramFiles(x86)%{\n #}
(
rem Создаём раздел в реестре по которому будем проверять, что резервная копия создана. Требуется для пропуска удаления SysApps [Безопасность/AppRep]
	reg add "HKLM\Software\DefenderKiller" /f
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files\Windows Defender" "%SystemDrive%\WDefenderBackup\Folder\Program Files\Windows Defender"
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files\Windows Defender Sleep" "%SystemDrive%\WDefenderBackup\Folder\Program Files\Windows Defender Sleep"
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files\Windows Defender Advanced Threat Protection" "%SystemDrive%\WDefenderBackup\Folder\Program Files\Windows Defender Advanced Threat Protection"
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files\Windows Security" "%SystemDrive%\WDefenderBackup\Folder\Program Files\Windows Security"
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files\PCHealthCheck" "%SystemDrive%\WDefenderBackup\Folder\Program Files\PCHealthCheck"
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files\Microsoft Update Health Tools" "%SystemDrive%\WDefenderBackup\Folder\Program Files\Microsoft Update Health Tools"
rem ProgramFiles X86	
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files (x86)\Windows Defender" "%SystemDrive%\WDefenderBackup\Folder\Program Files (x86)\Windows Defender"
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files (x86)\Windows Defender Advanced Threat Protection" "%SystemDrive%\WDefenderBackup\Folder\Program Files (x86)\Windows Defender Advanced Threat Protection"
) >nul 2>&1
	%ch%    {02} Создаём резервную копию папок из System32 и SysWOW64{\n #}
(
rem Windows - System32
    xcopy /s /e /h /y /i "%SystemRoot%\security\database" "%SystemDrive%\WDefenderBackup\Folder\Windows\security\database"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\HealthAttestationClient" "%SystemDrive%\WDefenderBackup\Folder\System32\HealthAttestationClient"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\SecurityHealth" "%SystemDrive%\WDefenderBackup\Folder\System32\SecurityHealth"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\WebThreatDefSvc" "%SystemDrive%\WDefenderBackup\Folder\System32\WebThreatDefSvc"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\Sgrm" "%SystemDrive%\WDefenderBackup\Folder\System32\Sgrm"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\Defender" "%SystemDrive%\WDefenderBackup\Folder\System32\WindowsPowerShell\v1.0\Modules\Defender"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\DefenderPerformance" "%SystemDrive%\WDefenderBackup\Folder\System32\WindowsPowerShell\v1.0\Modules\DefenderPerformance"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\Tasks_Migrated\Microsoft\Windows\Windows Defender" "%SystemDrive%\WDefenderBackup\Folder\System32\Tasks_Migrated\Microsoft\Windows\Windows Defender"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\drivers\wd" "%SystemDrive%\WDefenderBackup\Folder\System32\drivers\wd"
rem Задачи защитника
	xcopy /s /e /h /y /i "%SystemRoot%\System32\Tasks\Microsoft\Windows\Windows Defender" "%SystemDrive%\WDefenderBackup\Folder\System32\Tasks\Microsoft\Windows\Windows Defender"
rem SysWOW64
    xcopy /s /e /h /y /i "%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\Modules\Defender" "%SystemDrive%\WDefenderBackup\Folder\SysWOW64\WindowsPowerShell\v1.0\Modules\Defender"
    xcopy /s /e /h /y /i "%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\Modules\DefenderPerformance" "%SystemDrive%\WDefenderBackup\Folder\SysWOW64\WindowsPowerShell\v1.0\Modules\DefenderPerformance"
) >nul 2>&1
	%ch%    {02} Создаём резервную копию файлов из System32 и SysWOW64{\n #}
(
	md "%SystemDrive%\WDefenderBackup\Files"
	md "%SystemDrive%\WDefenderBackup\Files\System32"
	md "%SystemDrive%\WDefenderBackup\Files\SysWOW64"
	md "%SystemDrive%\WDefenderBackup\Files\Windows\Containers"
	md "%SystemDrive%\WDefenderBackup\Files\Windows\Containers\serviced"
rem Копирование файлов из System32
	copy /Y "%SystemRoot%\System32\SecurityHealthService.exe" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthSystray.exe" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthHost.exe" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthAgent.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthSSO.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthProxyStub.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\LogFiles\WMI\RtBackup\EtwRTDefenderApiLogger.etl" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\LogFiles\WMI\RtBackup\EtwRTDefenderAuditLogger.etl" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\smartscreen.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\wscisvif.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\wscproxystub.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\smartscreenps.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\wscapi.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\windowsdefenderapplicationguardcsp.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\wscsvc.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthCore.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthSsoUdk.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthUdk.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\smartscreen.exe" "%SystemDrive%\WDefenderBackup\Files\System32\"
rem Копирование файлов из SysWow64
	copy /Y "%SystemRoot%\SysWOW64\smartscreen.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\SysWOW64\wscisvif.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\SysWOW64\wscproxystub.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\SysWOW64\smartscreenps.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\SysWOW64\wscapi.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\SysWOW64\windowsdefenderapplicationguardcsp.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\Containers\WindowsDefenderApplicationGuard.wim" "%SystemDrive%\WDefenderBackup\Files\Windows\Containers\"
	copy /Y "%SystemRoot%\Containers\serviced\WindowsDefenderApplicationGuard.wim" "%SystemDrive%\WDefenderBackup\Files\Windows\Containers\serviced"
) >nul 2>&1
	%ch%    {02} Создаём резервную копию папок из WinSxS{\n #}
(
	md "%SystemDrive%\WDefenderBackup\Folder\WinSxS"
	for /d %%i in ("%SystemRoot%\WinSxS\*windows-defender*") do xcopy "%%i" "%SystemDrive%\WDefenderBackup\Folder\WinSxS\%%~nxi" /I /E /H /Y
	for /d %%i in ("%SystemRoot%\WinSxS\*windows-senseclient-service*") do xcopy "%%i" "%SystemDrive%\WDefenderBackup\Folder\WinSxS\%%~nxi" /I /E /H /Y
	for /d %%i in ("%SystemRoot%\WinSxS\*windows-dynamic-image*") do xcopy "%%i" "%SystemDrive%\WDefenderBackup\Folder\WinSxS\%%~nxi" /I /E /H /Y
) >nul 2>&1
	md "%SystemDrive%\WDefenderBackup\ServicesDrivers"
	md "%SystemDrive%\WDefenderBackup\RegEdit"
	set "PathServDrive=%SystemDrive%\WDefenderBackup\ServicesDrivers"
	set "PathRegedit=%SystemDrive%\WDefenderBackup\RegEdit"
(	
rem Службы
	reg export "HKLM\System\CurrentControlSet\Services\EventLog\System\WinDefend" "%PathServDrive%\WinDefendEvent.reg"
	reg export "HKLM\System\CurrentControlSet\Services\SecurityHealthService" "%PathServDrive%\SecurityHealthService.reg"
	reg export "HKLM\System\CurrentControlSet\Services\Sense" "%PathServDrive%\Sense.reg"
	reg export "HKLM\System\CurrentControlSet\Services\WdNisSvc" "%PathServDrive%\WdNisSvc.reg"
	reg export "HKLM\System\CurrentControlSet\Services\WinDefend" "%PathServDrive%\WinDefend.reg"
	reg export "HKLM\System\CurrentControlSet\Services\wscsvc" "%PathServDrive%\wscsvc.reg"
	reg export "HKLM\System\CurrentControlSet\Services\SgrmBroker" "%PathServDrive%\SgrmBroker.reg"
	reg export "HKLM\System\CurrentControlSet\Services\webthreatdefsvc" "%PathServDrive%\webthreatdefsvc.reg"
	reg export "HKLM\System\CurrentControlSet\Services\webthreatdefusersvc" "%PathServDrive%\webthreatdefusersvc.reg"
rem Драйвера
	reg export "HKLM\System\CurrentControlSet\Services\WdNisDrv" "%PathServDrive%\WdNisDrv.reg"
	reg export "HKLM\System\CurrentControlSet\Services\WdBoot" "%PathServDrive%\WdBoot.reg"
	reg export "HKLM\System\CurrentControlSet\Services\WdFilter" "%PathServDrive%\WdFilter.reg"
	reg export "HKLM\System\CurrentControlSet\Services\SgrmAgent" "%PathServDrive%\SgrmAgent.reg"
	reg export "HKLM\System\CurrentControlSet\Services\wtd" "%PathServDrive%\wtd.reg"
	reg export "HKLM\System\CurrentControlSet\Services\MsSecWfp" "%PathServDrive%\MsSecWfp.reg"
	reg export "HKLM\System\CurrentControlSet\Services\MsSecFlt" "%PathServDrive%\MsSecFlt.reg"
	reg export "HKLM\System\CurrentControlSet\Services\MsSecCore" "%PathServDrive%\MsSecCore.reg"
rem Экспорт веток реестра
	reg export "HKCR\*\shellex\ContextMenuHandlers\EPP" "%PathRegedit%\1.reg"
	reg export "HKCR\Directory\shellex\ContextMenuHandlers\EPP" "%PathRegedit%\2.reg"
	reg export "HKCR\Drive\shellex\ContextMenuHandlers\EPP" "%PathRegedit%\3.reg"
	reg export "HKLM\Software\Classes\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}" "%PathRegedit%\4.reg"
	reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved" "%PathRegedit%\5.reg"
	reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" "%PathRegedit%\6.reg"
	reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" "%PathRegedit%\7.reg"
	reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Defender" "%PathRegedit%\8.reg"
	reg export "HKLM\System\CurrentControlset\Control\WMI\Autologger\DefenderApiLogger" "%PathRegedit%\9.reg"
	reg export "HKLM\System\CurrentControlset\Control\WMI\Autologger\DefenderAuditLogger" "%PathRegedit%\10.reg"
	reg export "HKLM\Software\Microsoft\Windows Defender" "%PathRegedit%\11.reg"
	reg export "HKLM\Software\Microsoft\Windows Defender Security Center" "%PathRegedit%\12.reg"
	reg export "HKLM\Software\Microsoft\Windows Advanced Threat Protection" "%PathRegedit%\13.reg"
	reg export "HKLM\Software\Microsoft\Windows Security Health" "%PathRegedit%\14.reg"
	reg export "HKLM\Software\Microsoft\SystemSettings\SettingId\SystemSettings_WindowsDefender_UseWindowsDefender" "%PathRegedit%\15.reg"
	reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/Operational" "%PathRegedit%\16.reg"
	reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/WHC" "%PathRegedit%\17.reg"
	reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\NIS-Driver-WFP/Diagnostic" "%PathRegedit%\18.reg"
) >nul 2>&1
	%ch%    {08} Резервная копия создана в {0b}%SystemDrive%\WDefenderBackup{\n #}{\n #}
:RestoreDefender
rem Для корректного отображения диалогового окна, т.к. программа запущена от TI
	if not exist "%SystemRoot%\System32\config\systemprofile\Desktop" md "%SystemRoot%\System32\config\systemprofile\Desktop"
	set "BackupFolder="
	for /f %%A in ('powershell -c "(New-Object -COM 'Shell.Application').BrowseForFolder(0, 'Выберите папку с ранее созданной резервной копией Windows Defender', 0, 0).Self.Path"') do set "BackupFolder=%%A"
	echo.
	if not defined BackupFolder cls && goto Start
	if not exist "%BackupFolder%\Folder" %ch%    {04} Неверная резервная копия. Выберите правильную резервную копию{\n #}&&timeout /t 3 >nul && cls && goto RestoreDefender
	if not exist "%BackupFolder%\ServicesDrivers" %ch%    {04} Неверная резервная копия. Выберите правильную резервную копию{\n #}&&timeout /t 3 >nul && cls && goto RestoreDefender
rem Задаём вопрос о восстановлении защитника
	%ch% {0f} Резервная копия выбрана - {04}%BackupFolder%{\n #}
	echo  1 - Восстановить защитник
	echo  2 - Отмена 
	choice /c 12 /n /m " "
	if errorlevel 2 cls && goto Start
rem Восстановление политик
	if not defined NoGP (
	%ch% {03} Восстановление групповых политик{\n #}
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender" /v "AllowFastServiceStartup" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableRealtimeMonitoring" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableBehaviorMonitoring" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableIOAVProtection" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Spynet" /v "LocalSettingOverrideSpynetReporting" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Spynet" /v "**del.SpynetReporting" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Spynet" /v "**del.SubmitSamplesConsent" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "RealtimeSignatureDelivery" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableUpdateOnStartupWithoutEngine" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "UpdateOnStartUp" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableScanOnUpdate" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Reporting" /v "DisableGenericRePorts" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableCatchupFullScan" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableCatchupQuickScan" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableRemovableDriveScanning" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableScanningNetworkFiles" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableScanningMappedNetworkDrivesForFullScan" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableArchiveScanning" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows\System" /v "**del.ShellSmartScreenLevel" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /f
	nircmd win activate process cmd.exe
	call :LGPO_APPLY
	nircmd win activate process cmd.exe
	)
rem Восстановление параметров реестра
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /f >nul 2>&1
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /f >nul 2>&1
	reg delete "HKLM\Software\Policies\Microsoft\MRT" /f >nul 2>&1
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide cmd.exe /c reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /f >nul 2>&1
	%ch% {03} Восстановление файлов/папок{\n #}{\n #}
	pushd "%BackupFolder%"
(
	copy /y "Files\System32" %SystemRoot%\System32
	copy /y "Files\SysWOW64" %SystemRoot%\SysWOW64
	copy /y "Files\Windows\Containers\WindowsDefenderApplicationGuard.wim" "%SystemRoot%\Containers\"
	copy /y "Files\Windows\Containers\serviced\WindowsDefenderApplicationGuard.wim" "%SystemRoot%\Containers\serviced"
	xcopy "Folder\Program Files\*" "%ProgramFiles%\" /E /H /K /Y
	xcopy "Folder\Program Files (x86)\*" "%ProgramFiles(x86)%\" /E /H /K /Y
	xcopy "Folder\ProgramData\*" "%ProgramData%\" /E /H /K /Y
	xcopy "Folder\System32\*" "%SystemRoot%\System32" /E /H /K /Y
	xcopy "Folder\SysWow64\*" "%SystemRoot%\SysWow64" /E /H /K /Y
	xcopy "Folder\Windows\*" "%SystemRoot%\" /E /H /K /Y
	xcopy "Folder\WinSxS\*" "%SystemRoot%\WinSxS\" /E /H /K /Y
rem Восстановление реестра/служб, драйверов
	for %%f in ("RegEdit\*.reg") do reg import "%%f"
	for %%f in ("ServicesDrivers\*.reg") do reg import "%%f"
rem Восстановление SmartScreen.exe
	if exist "%SystemRoot%\System32\smartscreen_disabled.exe" rename "%SystemRoot%\System32\smartscreen_disabled.exe" "smartscreen.exe"
rem Удаляем раздел по которому проверяется создана ли резервная копия. Теперь SysApps будут удаляться.
	reg delete "HKLM\Software\DefenderKiller" /f
) >nul 2>&1
	popd
	nhmb "Требуется перезапуск ПК" "DK" "Information|Ok"
	cls && goto Start
rem                                                                   =================================
:CheckUpdate
rem Windows 8.1 не поддерживает функционал обновлений
rem Удаляем файл, если тот остался...
	del /q "%SystemDrive%\latestVersion.bat" >nul 2>&1
rem Проверяем наличие интернет-соединения
	ping www.google.nl -n 1 -w 1000 |>nul find /i "TTL="||cls&&%ch% {04} Невозможно проверить обновления программы, отсутствует интернет{\n #}&&timeout /t 3 >nul&&cls&&goto Start
rem Проверка обновлений программы
	curl -g -k -L -# -o "%SystemDrive%\latestVersion.bat" "https://pastebin.com/raw/dnENFgmC" >nul 2>&1
	call "%SystemDrive%\latestVersion.bat"
	if "%Version%" lss "%latestVersion%" (cls) else (cls & %ch% {0a} Вы используете последнюю актуальную версию программы - {0e}%Version%{\n #}&timeout /t 4 >nul&goto Start)
rem Обновление программы
	%ch%  {0f} Найдена новая версия, нажмите любую клавишу чтобы обновить программу{\n #}
	curl -g -k -L -# -o %0 "https://github.com/oatmealcookiec/MyProgramm/releases/latest/download/DefenderKiller.bat" >nul 2>&1
	call %0
:Information
	nhmb "DefenderKiller - программа для удаления защитника Windows и его компонентов.\nВ программе имеется возможность восстановления (если создана резервная копия)\nКрасным цветом в меню - не удалено. Зеленым цветом - удалено.\n\nПри нажатии на кнопку ОК будет открыт сайт программы, где можно детально ознакомиться с программой, задать вопрос, высказать предложение или сообщить об ошибке.\n\nBy Vlado." "DK" "Information|Ok"
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide cmd.exe /c start https://win10tweaker.ru/forum/topic/defenderkiller 
	cls & goto Start
rem Создано WestLife AutoSettings
:LGPOFILE
	setlocal
	if /i "%~2" NEQ "delete" if /i "%~2" NEQ "add" (
	if /i "%~2" EQU "delete" if "%~7" NEQ "" (
	set "RegType=%~7:"
	set "RegType=%RegType:REG=%"
	set "RegType=%RegType:_=%"
	set "RegType=%RegType:PAND=%"
	if "%~3" NEQ "" for /f "tokens=1* delims=\" %%I in ("%~3") do ( set "RegKey=%%J"
	 if /i "%%I" EQU "HKEY_LOCAL_MACHINE" (set Config=Computer) else if /i "%%I" EQU "HKLM" (set Config=Computer
	 ) else if /i "%%I" EQU "HKEY_CURRENT_USER" (set Config=User) else if /i "%%I" EQU "HKCU" (set Config=User
	if "%~9" NEQ "" set "Action=%RegType%%~9"
	if /i "%~6" EQU "/d" set "Action=SZ:%~7"
	if /i "%~2" EQU "delete" set "Action=DELETE"
	if "%~5" EQU "" ( set "Action=DELETEALLVALUES" & set "ValueName=*" ) else ( set "ValueName=%~5" )
	if /i "%~2" EQU "add" if /i "%~4" EQU "/f" set "Action=CREATEKEY" & set "ValueName=*"
	(echo.%Config%& echo.%RegKey%& echo.%ValueName%& echo.%Action%& echo.)>>"%LGPOtemp%"
:LGPO_APPLY	
	%ch% {04} Применение параметров групповых политик{\n #}{\n #}&LGPO.exe /t "%LGPOtemp%" /q
	if exist "%LGPOtemp%" del /f /q "%LGPOtemp%"
rem Файл: Удалить Windows Defender от MartyFiles.bat
:Start
@ECHO OFF
reg query "HKU\S-1-5-19\Environment" >nul 2>&1 & cls
if "%Errorlevel%" NEQ "0" (
)
Rem Enable Delayed Expansion
setlocal EnableDelayedExpansion
REM ЋЎ­г«пҐ¬ §­ зҐ­ЁҐ ЇҐаҐ¬Ґ­­ле
set "sFreeSize="
set "sFreeSizePseudoMb1="
set "Freed="
cd /d "%~dp0WorkFiles"
Title DefenderKiller
@cmdow @ /SIZ 1000 700
set ch="cecho.exe"
qprocess "Win 10 Tweaker.exe">nul 2>&1 || nircmd.exe win center alltop
ConX.exe show
%ch% {0f}‡ ЇгйҐ­® б Їа ў ¬Ё: {04}%username%{\n #}
%ch% {0f}Delete Defender ‚ҐабЁп: {0b}6 By Vlado „«п W10T{\n #}
echo.
%ch% {0f}Windows Defender: 
if not exist "%ProgramFiles%\Windows Defender" (%ch% {2f}“¤ «Ґ­ Ё§ Windows{08} [Ї ЇЄ  Windows Defender ®вбгвбвўгҐв]{\n #}) else (%ch% {4f}ЌҐ г¤ «Ґ­^^^!{0c} [Ї ЇЄ  Windows Defender ­ ©¤Ґ­ ]{\n #})
rem ЋвЄ«озҐ­ «Ё § йЁв­ЁЄ
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" >nul 2>&1
if "%ERRORLEVEL%"=="0" (
%ch% {0f}Windows Defender: {0a}‡ йЁв­ЁЄ ®вЄ«озҐ­ {08}[зҐаҐ§ аҐҐбва: DisableAntiSpyware]{\n #}
)
if "%ERRORLEVEL%"=="1" (
%ch% {0f}Windows Defender: {0c}‡ йЁв­ЁЄ ўЄ«озҐ­ {08}[зҐаҐ§ аҐҐбва]{\n #}
)
echo.
%ch% {03}Џа®жҐббл § йЁв­ЁЄ :{\n #}
%ch% {0f}Џа®жҐбб AntimalwareService:   {#} 
qprocess "MsMpEng.exe">nul 2>&1 && %ch% {04}Џа®жҐбб § ЇгйҐ­{\n #}|| %ch% {0a}Џа®жҐбб ­Ґ § ЇгйҐ­{\n #}
%ch% {0f}Џа®жҐбб SecurityHealthService:{#} 
qprocess "SecurityHealthService.exe">nul 2>&1 && %ch% {04}Џа®жҐбб § ЇгйҐ­{\n #}|| %ch% {0a}Џа®жҐбб ­Ґ § ЇгйҐ­{\n #}
%ch% {0f}Џа®жҐбб SecurityHealthSystray:{#} 
qprocess "SecurityHealthSystray.exe">nul 2>&1 && %ch% {04}Џа®жҐбб § ЇгйҐ­{\n #}|| %ch% {0a}Џа®жҐбб ­Ґ § ЇгйҐ­{\n #}
%ch% {0f}Џа®жҐбб SecurityHealthHost:   {#} 
qprocess "SecurityHealthHost.exe">nul 2>&1 && %ch% {04}Џа®жҐбб § ЇгйҐ­{\n #}|| %ch% {0a}Џа®жҐбб ­Ґ § ЇгйҐ­{\n #}
%ch% {0f}Џа®жҐбб SmartScreen ‡ йЁв­ЁЄ :{#} 
qprocess "smartscreen.exe">nul 2>&1 && %ch% {04}Џа®жҐбб § ЇгйҐ­{\n #}|| %ch% {0a}Џа®жҐбб ­Ґ § ЇгйҐ­{\n #}
%ch% {0f}Џа®жҐбб Ўа®ЄҐа SgrmBroker:    {#} 
qprocess "SgrmBroker.exe">nul 2>&1 && %ch% {04}Џа®жҐбб § ЇгйҐ­{\n #}|| %ch% {0a}Џа®жҐбб ­Ґ § ЇгйҐ­{\n #}
%ch% {0f}Џа®жҐбб § йЁв­ЁЄ  SecHealthUI:{#} 
qprocess "SecHealthUI.exe">nul 2>&1 && %ch% {04}Џа®жҐбб § ЇгйҐ­{\n #}|| %ch% {0a}Џа®жҐбб ­Ґ § ЇгйҐ­{\n #}
%ch% {0f}Џа®жҐбб Update Health uhssvc: {#} 
qprocess "uhssvc.exe">nul 2>&1 && %ch% {04}Џа®жҐбб § ЇгйҐ­{\n #}|| %ch% {0a}Џа®жҐбб ­Ґ § ЇгйҐ­{\n #}
echo.
rem Џа®ўҐаЄ  б«г¦Ў Ё ¤а ©ўҐа®ў
%ch% {03}‘«г¦Ўл § йЁв­ЁЄ :{\n #}
%ch% {0f}WinDefend:     {#} 
sc query WinDefend >nul 2>&1
if ERRORLEVEL 1 (%ch% {0a}ЌҐ бгйҐбвўгҐв{\n #}) else (
sc query WinDefend | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}ЋвЄ«озҐ­ {\n #}) ELSE (%ch% {04}‡ ЇгйҐ­ {\n #}))
%ch% {0f}WdNisSvc:      {#} 
sc query WdNisSvc >nul 2>&1
if ERRORLEVEL 1 (%ch% {0a}ЌҐ бгйҐбвўгҐв{\n #}) else (
sc query WdNisSvc | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}ЋвЄ«озҐ­ {\n #}) ELSE (%ch% {04}‡ ЇгйҐ­ {\n #}))
%ch% {0f}Sense:         {#} 
sc query Sense >nul 2>&1
if ERRORLEVEL 1 (%ch% {0a}ЌҐ бгйҐбвўгҐв{\n #}) else (
sc query Sense | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}ЋвЄ«озҐ­ {\n #}) ELSE (%ch% {04}‡ ЇгйҐ­ {\n #}))
%ch% {0f}SecurityHealth:{#} 
sc query SecurityHealthService >nul 2>&1
if ERRORLEVEL 1 (%ch% {0a}ЌҐ бгйҐбвўгҐв{\n #}) else (
sc query SecurityHealthService | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}ЋвЄ«озҐ­ {\n #}) ELSE (%ch% {04}‡ ЇгйҐ­ {\n #}))
%ch% {0f}wscsvc:        {#} 
sc query wscsvc >nul 2>&1
if ERRORLEVEL 1 (%ch% {0a}ЌҐ бгйҐбвўгҐв{\n #}) else (
sc query wscsvc | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}ЋвЄ«озҐ­ {\n #}) ELSE (%ch% {04}‡ ЇгйҐ­ {\n #}))
%ch% {0f}SgrmBroker:     {#}
sc query SgrmBroker >nul 2>&1
if ERRORLEVEL 1 (%ch% {0a}ЌҐ бгйҐбвўгҐв{\n #}) else (
sc query SgrmBroker | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}ЋвЄ«озҐ­ {\n #}) ELSE (%ch% {04}‡ ЇгйҐ­ {\n #}))
echo.
%ch% {03}„а ©ўҐал § йЁв­ЁЄ :{\n #}
%ch% {0f}WdNisDrv:{#} 
sc query WdNisDrv >nul 2>&1
if ERRORLEVEL 1 (%ch% {08}ЌҐ бгйҐбвўгҐв{#} ) else (
sc query WdNisDrv | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}ЋвЄ«озҐ­{#} ) ELSE (%ch% {04}‡ ЇгйҐ­{#} ))
%ch% {0f}WdBoot:{#} 
sc query WdBoot >nul 2>&1
if ERRORLEVEL 1 (%ch% {08}ЌҐ бгйҐбвўгҐв{#} ) else (
sc query WdBoot | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}ЋвЄ«озҐ­{#} ) ELSE (%ch% {04}‡ ЇгйҐ­{#} ))
%ch% {0f}WdFilter:{#} 
sc query WdFilter >nul 2>&1
if ERRORLEVEL 1 (%ch% {08}ЌҐ бгйҐбвўгҐв{#} ) else (
sc query WdFilter | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}ЋвЄ«озҐ­{#} ) ELSE (%ch% {04}‡ ЇгйҐ­{#} ))
%ch% {0f}MsSecFlt:{#} 
sc query MsSecFlt >nul 2>&1
if ERRORLEVEL 1 (%ch% {08}ЌҐ бгйҐбвўгҐв{#} ) else (
sc query MsSecFlt | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}ЋвЄ«озҐ­{#} ) ELSE (%ch% {04}‡ ЇгйҐ­{#} ))
%ch% {0f}SgrmAgent:{#} 
sc query SgrmAgent >nul 2>&1
if ERRORLEVEL 1 (%ch% {08}ЌҐ бгйҐбвўгҐв{\n #}) else (
sc query SgrmAgent | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}ЋвЄ«озҐ­{\n #}) ELSE (%ch% {04}‡ ЇгйҐ­{\n #}))
rem Џа®ўҐаЄ  § ¤ з
set "taskpathDef1=Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance"
set "taskpathDef2=Microsoft\Windows\Windows Defender\Windows Defender Cleanup"
set "taskpathDef3=Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
set "taskpathDef4=Microsoft\Windows\Windows Defender\Windows Defender Verification"
for /f "delims=, tokens=3" %%I in (' 2^>nul SCHTASKS /QUERY /FO CSV /NH /TN "%taskpathDef1%" ') do set "replyTaskDef1=%%~I"
for /f "delims=, tokens=3" %%I in (' 2^>nul SCHTASKS /QUERY /FO CSV /NH /TN "%taskpathDef2%" ') do set "replyTaskDef2=%%~I"
for /f "delims=, tokens=3" %%I in (' 2^>nul SCHTASKS /QUERY /FO CSV /NH /TN "%taskpathDef3%" ') do set "replyTaskDef3=%%~I"
for /f "delims=, tokens=3" %%I in (' 2^>nul SCHTASKS /QUERY /FO CSV /NH /TN "%taskpathDef4%" ') do set "replyTaskDef4=%%~I"
if not "!replyTaskDef1!"=="" (
	if "!replyTaskDef1!"=="ЋвЄ«озҐ­ " ( set "TaskDefResult1={0a}ЋвЄ«озҐ­ {#}" ) else ( set "TaskDefResult1={04}‚Є«озҐ­ {#}" )
) else ( set "TaskDefResult1={0a}ЌҐ бгйҐбвўгҐв{#}" )
if not "!replyTaskDef2!"=="" (
	if "!replyTaskDef2!"=="ЋвЄ«озҐ­ " ( set "TaskDefResult2={0a}ЋвЄ«озҐ­ {#}" ) else ( set "TaskDefResult2={04}‚Є«озҐ­ {#}" )
) else ( set "TaskDefResult2={0a}ЌҐ бгйҐбвўгҐв{#}" )
if not "!replyTaskDef3!"=="" (
	if "!replyTaskDef3!"=="ЋвЄ«озҐ­ " ( set "TaskDefResult3={0a}ЋвЄ«озҐ­ {#}" ) else ( set "TaskDefResult3={04}‚Є«озҐ­ {#}" )
) else ( set "TaskDefResult3={0a}ЌҐ бгйҐбвўгҐв{#}" )
if not "!replyTaskDef4!"=="" (
	if "!replyTaskDef4!"=="ЋвЄ«озҐ­ " ( set "TaskDefResult4={0a}ЋвЄ«озҐ­ {#}" ) else ( set "TaskDefResult4={04}‚Є«озҐ­ {#}" )
) else ( set "TaskDefResult4={0a}ЌҐ бгйҐбвўгҐв{#}" )
echo.
%ch% {03}‡ ¤ зЁ ў Ї« ­Ёа®ўйЁЄҐ:{\n #}
%ch% {0f}1. Windows Defender Cache Maintenance: %TaskDefResult1%{\n #}
%ch% {0f}2. Windows Defender Cleanup:           %TaskDefResult2%{\n #}
%ch% {0f}3. Windows Defender Scheduled Scan:    %TaskDefResult3%{\n #}
%ch% {0f}4. Windows Defender Verification:      %TaskDefResult4%{\n #}
rem ‡ ¤ зЁ § йЁв­ЁЄ 
if not exist "%SYSTEMROOT%\System32\Tasks\Microsoft\Windows\Windows Defender" (set "TasksDefender={0a}‡ ¤ зЁ § йЁв­ЁЄ  г¤ «Ґ­л{#}") else (set "TasksDefender={4f}‡ ¤ зЁ ­Ґ г¤ «Ґ­л!{#}")
%ch% {04}^----^>{#} {0f}‡ ¤ зЁ (Ї ЇЄ  Tasks): %TasksDefender% {\n #}
echo.
%ch% {0f} 1{#} - {0a}“¤ «Ґ­ЁҐ {08}[ЎҐ§ў®§ўа в­®]{\n #}
%ch% {0f} 2{#} - {08}ЋвЄ«озҐ­ЁҐ/ўЄ«озҐ­ЁҐ {08}[ў § ўЁбЁ¬®бвЁ ®в б®бв®п­Ёп. ваҐЎгҐвбп ЇҐаҐ§ Јаг§Є ]{\n #}
%ch% {0f} 3{#} - {0c}Џ®¤а®Ў­®Ґ б®бв®п­ЁҐ Є в «®Ј®ў § йЁв­ЁЄ {\n #}
%ch% {08} 4{#} - {08}ChangeLog{\n #}
echo.
set "input="
set /p input=*   ‚ и ўлЎ®а: 
if "%input%"=="1"    ( cls && goto DeleteDefender)
if "%input%"=="2"    ( cls && goto OnOffDefender)
if "%input%"=="3"    ( cls && goto Catalogs)
if "%input%"=="4"    ( cls && goto ChangeLog )
) else (
	cls & goto Start
)
:DeleteDefender
rem ‘зЁв Ґ¬ ¬Ґбв® ­  ¤ЁбЄҐ ЇҐаҐ¤ г¤ «Ґ­ЁҐ¬
setlocal enableextensions enabledelayedexpansion
for /f "usebackq tokens=2 delims==" %%i in (`wmic.exe LogicalDisk where "Name='c:'" get FreeSpace /value`) do set sFreeSize=%%i
if defined sFreeSize (set sFreeSizePseudoMb=%sFreeSize:~0,-7%)
sc query WinDefend >nul 2>&1
if ERRORLEVEL 1 (
%ch% {0c} Љ ¦Ґвбп, § йЁв­ЁЄ г¦Ґ г¤ «Ґ­. ‚л е®вЁвҐ ўбҐ а ў­® Їа®ўҐбвЁ г¤ «Ґ­ЁҐ?{\n #}
%ch% {08} 1{#} - {0c}„ {\n #}
%ch% {08} 2{#} - {08}Ћв¬Ґ­ {\n #}
choice /c 12 /n /m " "
if ERRORLEVEL 2 cls && goto Start
)
if not exist FuckDefender.exe (
%ch% {04} FuckDefender ­Ґ ®Ў­ аг¦Ґ­ ў а Ў®зҐ© Ї ЇЄҐ{\n #}
echo  ‘Є®аҐҐ ўбҐЈ® ҐЈ® г¤ «Ё« § йЁв­ЁЄ ... 
echo  Ѓг¤Ґ¬ ўлЇ®«­пвм г¤ «Ґ­ЁҐ ЎҐ§ ­ҐЈ®
echo  Ћ¤­ Є®, Ї®б«Ґ г¤ «Ґ­Ёп ¤ ­­®© Їа®Ја ¬¬®©, ­Ґ®Ўе®¤Ё¬® ¤®Ї®«­ЁвҐ«м­® Їа®©вЁбм FuckDefender
echo  https://win10tweaker.ru/fwd
echo.
)
cls
rem Џ®ўҐае ўбҐе ®Є®­
@cmdow @ /TOP
rem ‡ ўҐаи Ґ¬ Їа®жҐббл § йЁв­ЁЄ 
%ch%    {0f} ‡ ўҐаи Ґ¬ Їа®жҐббл § йЁв­ЁЄ  ...{\n #}
powershell -command "Stop-Process -processname MsMpEng, SecurityHealthSystray, SecurityHealthService, SecurityHealthHost, smartscreen, SgrmBroker, SecHealthUI, uhssvc -Force" >nul
timeout /t 1 /nobreak>nul
taskkill /f /im MsMpEng.exe >nul 2>&1
taskkill /f /im SecurityHealthSystray.exe >nul 2>&1
taskkill /f /im SecurityHealthService.exe >nul 2>&1
taskkill /f /im SecurityHealthHost.exe >nul 2>&1
taskkill /f /im smartscreen.exe >nul 2>&1
taskkill /f /im SgrmBroker.exe >nul 2>&1
taskkill /f /im SecHealthUI.exe >nul 2>&1
taskkill /f /im uhssvc.exe >nul 2>&1
echo.
%ch%    {0e} ЋвЄ«оз Ґ¬ § йЁв­ЁЄ Ё smartscreen ...{\n #}
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t reg_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t reg_DWORD /d 0 /f >nul
ren "%SystemRoot%\System32\smartscreen.exe" "smartscreen_fuck.exe" >nul 2>&1
echo.
if not exist "%SystemDrive%\Program Files\Windows Defender" (
%ch%    {0c} Џа®ЇгбвЁвм г¤ «Ґ­ЁҐ FuckDefender'®¬ ? {\n #}
%ch% {0f} 1 - ЌҐв, ­Ґ Їа®ЇгбЄ вм{\n #}
%ch% {0f} 2 - „ , п г¦Ґ г¤ «п« 2 а §  Ё в®з­® гўҐаҐ­, зв® § йЁв­ЁЄ г¤ «Ґ­ Ё е®зг г¤ «Ёвм ®бв «м­лҐ Є®¬Ї®­Ґ­вл{\n #}
choice /c 12 /n /m " "
if ERRORLEVEL 2 goto NotFuckWD
if ERRORLEVEL 1 echo>nul
)
rem ‡ ЇгбЄ Ґ¬ FuckDefender
start FuckDefender.exe
:#
(
for /f %%i in ('"tasklist| findstr /bilc:"FuckDefender.exe""') do (%ch%    {04} Ќ з «®бм г¤ «Ґ­ЁҐ.{\n #} && echo. && %ch% {0e}    ‚лЇ®«­пҐвбп г¤ «Ґ­ЁҐ ...{\n #})
)|| goto #
timeout /t 1 /nobreak >nul
echo.
%ch%    {0f} ЌҐ¬­®Ј® ®¦Ё¤ ­Ёп ...{\n #}
timeout /t 1 /nobreak>nul
:reload
tasklist | find "FuckDefender.exe" >nul 2>&1
if ERRORLEVEL 1 goto NoRecord
goto reload
:NoRecord
echo.
%ch%    {0a} ЌҐ § Єалў ©вҐ ®Є­® Їа®Ја ¬¬л ...{\n #}
>nul 2>&1 taskkill /f /im Unlocker.exe
>nul 2>&1 taskkill /f /im FuckDefender.exe
>nul 2>&1 taskkill /f /im wscript.exe
echo.
start FuckDefender.exe
:#1
(
for /f %%i in ('"tasklist| findstr /bilc:"FuckDefender.exe""') do (echo>nul)
)|| goto #1
:reload1
tasklist | find "FuckDefender.exe" >nul 2>&1
if ERRORLEVEL 1 goto NoRecord1
goto reload1
:NoRecord1
>nul 2>&1 taskkill /f /im Unlocker.exe
>nul 2>&1 taskkill /f /im FuckDefender.exe
>nul 2>&1 taskkill /f /im wscript.exe
:NotFuckWD
%ch%    {0e} “¤ «пҐ¬ б«г¦Ўл Windows Defender ...{\n #}
sc delete SecurityHealthService >nul 2>&1
sc delete Sense >nul 2>&1
sc delete WdNisSvc >nul 2>&1
sc delete WinDefend >nul 2>&1
sc delete wscsvc >nul 2>&1
sc delete SgrmBroker >nul 2>&1
reg delete HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService /f >nul 2>&1
reg delete HKLM\SYSTEM\CurrentControlSet\Services\Sense /f >nul 2>&1
reg delete HKLM\SYSTEM\CurrentControlSet\Services\WdNisSvc /f >nul 2>&1
reg delete HKLM\SYSTEM\CurrentControlSet\Services\WinDefend /f >nul 2>&1
reg delete HKLM\SYSTEM\CurrentControlSet\Services\wscsvc /f >nul 2>&1
reg delete HKLM\SYSTEM\CurrentControlSet\Services\SgrmBroker /f >nul 2>&1
echo.
%ch%    {0e} “¤ «пҐ¬ § ¤ ­Ёп Ё§ Ї« ­Ёа®ўйЁЄ  ...{\n #}
powershell -command "Unregister-ScheduledTask -TaskName 'Windows Defender Cache Maintenance' -Confirm:$false" >nul
powershell -command "Unregister-ScheduledTask -TaskName 'Windows Defender Cleanup' -Confirm:$false" >nul
powershell -command "Unregister-ScheduledTask -TaskName 'Windows Defender Scheduled Scan' -Confirm:$false" >nul
powershell -command "Unregister-ScheduledTask -TaskName 'Windows Defender Verification' -Confirm:$false" >nul
schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /f >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /f >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /f >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Verification" /f >nul 2>&1
rd /s /q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Windows Defender" >nul 2>&1
echo.
%ch%    {0e} ЋвЄ«оз Ґ¬ ¤а ©ўҐа  Windows Defender ...{\n #}
sc stop WdNisDrv >nul 2>&1
sc stop WdBoot >nul 2>&1
sc stop WdFilter >nul 2>&1
sc stop MsSecFlt >nul 2>&1
sc stop SgrmAgent >nul 2>&1
reg add HKLM\SYSTEM\CurrentControlSet\Services\WdNisDrv /v Start /t reg_DWORD /d 4 /f >nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\WdBoot /v Start /t reg_DWORD /d 4 /f >nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\WdFilter /v Start /t reg_DWORD /d 4 /f >nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\MsSecFlt /v Start /t reg_DWORD /d 4 /f >nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\SgrmAgent /v Start /t reg_DWORD /d 4 /f >nul
echo.
%ch%    {0e} ЋзЁй Ґ¬ Є®­вҐЄбв­®Ґ ¬Ґ­о ®в Windows Defender ...{\n #}
reg delete "HKCR\*\shellex\ContextMenuHandlers\EPP" /f >nul 2>&1
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /f >nul 2>&1
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /f >nul 2>&1
echo.
rem “¤ «пҐ¬ ўбҐ Ї ЇЄЁ зҐаҐ§ CMD
%ch%    {0e} “¤ «пҐ¬ Ї ЇЄЁ Ё д ©«л Windows Defender ...{\n #}
RD /S /Q "%AllUsersProfile%\Microsoft\Windows Defender" >nul 2>&1
RD /S /Q "%AllUsersProfile%\Microsoft\Windows Defender Advanced Threat Protection" >nul 2>&1
RD /S /Q "%AllUsersProfile%\Microsoft\Windows Security Health" >nul 2>&1
RD /S /Q "%SystemDrive%\ProgramData\Microsoft\Windows Defender" >nul 2>&1
RD /S /Q "%SystemDrive%\ProgramData\Microsoft\Windows Security Health" >nul 2>&1
RD /S /Q "%SystemDrive%\Program Files\Windows Defender" >nul 2>&1
RD /S /Q "%SystemDrive%\Program Files\Windows Defender Advanced Threat Protection" >nul 2>&1
RD /S /Q "%SystemDrive%\Program Files\Windows Security" >nul 2>&1
RD /S /Q "%SystemDrive%\Program Files\PCHealthCheck" >nul 2>&1
RD /S /Q "%SystemDrive%\Program Files\Microsoft Update Health Tools" >nul 2>&1
RD /S /Q "%SystemDrive%\Program Files (x86)\Windows Defender" >nul 2>&1
RD /S /Q "%SystemDrive%\Program Files (x86)\Windows Defender Advanced Threat Protection" >nul 2>&1
RD /S /Q "%SystemRoot%\WinSxS\amd64_windows-defender-am-sigs_31bf3856ad364e35_10.0.19041.1_none_7275cb8fbafec5e1" >nul 2>&1
del /q /s "%SystemRoot%\Containers\WindowsDefenderApplicationGuard.wim" >nul 2>&1
del /q /s "%SystemRoot%\WinSxS\WindowsDefenderApplicationGuard.wim" >nul 2>&1
del /q "%SystemRoot%\security\database" >nul 2>&1
REM “¤ «Ґ­ЁҐ ўбҐе Ї Ї®Є Ё§ WinSxS
REM For /F "usebackq delims=" %%d In (`2^>nul Dir "C:\Windows\WinSxS\*windows-defender*" /S /B /A:D`) Do Rd "%%d" /s /q
wmic os get caption /Format:List | find /i "11" >nul 2>&1
if "%ERRORLEVEL%"=="0" (
%ch%    {0b} ќв® - Windows 11. “¤ «пҐ¬ § йЁв­ЁЄ ҐйҐ а §.
start /wait FuckDefender.exe
>nul 2>&1 taskkill /f /im Unlocker.exe
>nul 2>&1 taskkill /f /im FuckDefender.exe
>nul 2>&1 taskkill /f /im wscript.exe
)
rem Make window not always on top
@cmdow @ /NOT
rem Џ®¤бзҐв ¬Ґбв  ­  ¤ЁбЄҐ Ї®б«Ґ г¤ «Ґ­Ёп
for /f "usebackq tokens=2 delims==" %%i in (`wmic.exe LogicalDisk where "Name='c:'" get FreeSpace /value`) do set sFreeSize=%%i
if defined sFreeSize (set sFreeSizePseudoMb1=%sFreeSize:~0,-7%)
set /a Freed=!sFreeSizePseudoMb1! - !sFreeSizePseudoMb!
echo.
%ch%     {2f}!Freed! ЊҐЈ Ў ©в ®бў®Ў®¦¤Ґ­®{\n #}
echo.
powershell -command "[Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms');[Windows.Forms.MessageBox]::show('‡ йЁв­ЁЄ Windows г¤ «Ґ­ Ё§ бЁбвҐ¬л. ’аҐЎгҐвбп ЇҐаҐ§ Јаг§Є  ЏЉ .', 'DefenderKiller By Vlado')" >nul
%ch%    {0c} ‹оЎ п Є« ўЁи  ¤«п ўле®¤ .{\n #}
:OnOffDefender
if not exist "%ProgramFiles%\Windows Defender" (
powershell -command "[Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms');[Windows.Forms.MessageBox]::show('‡ йЁв­ЁЄ г¤ «Ґ­, ®вЄ«оз вм ­ҐзҐЈ®')" >nul
goto Start)
sc query SecurityHealthService | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (
%ch% {0e} ‚Є«оз Ґ¬ § йЁв­ЁЄ ...{\n #}
echo.
timeout /t 1 /nobreak>nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /t reg_EXPAND_SZ /d "C:\Windows\system32\SecurityHealthSystray.exe" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t reg_DWORD /d "0x3" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\Sense" /v "Start" /t reg_DWORD /d "0x3" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\WdBoot" /v "Start" /t reg_DWORD /d "0x0" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\WdFilter" /v "Start" /t reg_DWORD /d "0x0" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\WdNisDrv" /v "Start" /t reg_DWORD /d "0x3" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\WdNisSvc" /v "Start" /t reg_DWORD /d "0x2" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\WinDefend" /v "Start" /t reg_DWORD /d "0x2" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\wscsvc" /v "Start" /t reg_DWORD /d "0x2" /f >nul
reg delete "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /f >nul 2>&1
powershell -command "[Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms');[Windows.Forms.MessageBox]::show('‡ йЁв­ЁЄ Windows ўЄ«озҐ­. ’аҐЎгҐвбп ЇҐаҐ§ Јаг§Є  ЏЉ .', 'DefenderDisabler')" >nul
) else (
%ch% {0e} ЋвЄ«оз Ґ¬ § йЁв­ЁЄ ...{\n #}
echo.
timeout /t 1 /nobreak>nul
reg add "HKLM\System\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t reg_DWORD /d "0x4" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\Sense" /v "Start" /t reg_DWORD /d "0x4" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\WdBoot" /v "Start" /t reg_DWORD /d "0x4" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\WdFilter" /v "Start" /t reg_DWORD /d "0x4" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\WdNisDrv" /v "Start" /t reg_DWORD /d "0x4" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\WdNisSvc" /v "Start" /t reg_DWORD /d "0x4" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\WinDefend" /v "Start" /t reg_DWORD /d "0x4" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\wscsvc" /v "Start" /t reg_DWORD /d "0x4" /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t reg_DWORD /d 0 /f >nul
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f >nul 2>&1
powershell -command "[Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms');[Windows.Forms.MessageBox]::show('‡ йЁв­ЁЄ Windows ®вЄ«озҐ­. ’аҐЎгҐвбп ЇҐаҐ§ Јаг§Є  ЏЉ .', 'DefenderDisabler')" >nul
)
:ChangeLog
rem ChangeLog
%ch% {0c} v. 6{\n #}
echo -Їа ўЁ«м­®Ґ г¤ «Ґ­ЁҐ WindowsDefenderApplicationGuard.wim
echo -¤®Ў ў«Ґ­  ў®§¬®¦­®бвм гўЁ¤Ґвм вҐЄгйҐҐ б®бв®п­ЁҐ Є в «®Ј®ў § йЁв­ЁЄ 
echo -¤®Ў ў«Ґ­л Є в «®ЈЁ ¤«п г¤ «Ґ­Ёп ¤«п Ї®б«Ґ¤­Ёе ўҐабЁ© Windows 10 Ё 11
echo -¤®Ў ў«Ґ­® Ў®«ҐҐ вй вҐ«м­®Ґ г¤ «Ґ­ЁҐ § ¤ з Ё§ Ї« ­Ёа®ўйЁЄ  Ё ®вЄ«озҐ­ЁҐ Їа®жҐбб®ў
echo -Ё§¬Ґ­Ґ­л Їа®ўҐаЄЁ ­  ­ «ЁзЁҐ § йЁв­ЁЄ 
%ch% {0c} v. 5.2{\n #}
echo -¤®Ў ў«Ґ­® ®вЄ«озҐ­ЁҐ/ўЄ«озҐ­ЁҐ § йЁв­ЁЄ  ЎҐ§ г¤ «Ґ­Ёп. ваҐЎгҐвбп ЇҐаҐ§ Јаг§Є  ЇЄ
%ch% {0c} v. 5.1{\n #}
echo -­®¬Ґа  ўҐабЁ© Їа®Ја ¬¬л Ё§¬Ґ­Ґ­л б 26 ­  " ¤ҐЄў в­лҐ" , ­ зЁ­ п б 1 ўҐабЁЁ
echo -ЁбЇа ў«Ґ­ Ў Ј Ё­вҐадҐ©б , ў®§­ЁЄ ойЁ© Ё§-§  ®¤­®ўаҐ¬Ґ­­®Ј® § ЇгбЄ  вўЁЄҐа  Ё Їа®Ја ¬¬л
%ch% {0c} v. 5{\n #}
echo -­ҐЎ®«миЁҐ Їа ўЄЁ Ё­вҐадҐ©б  Ё бЄалвЁҐ ­ §ў ­Ёп ®Є­  ЇаЁ«®¦Ґ­Ёп
echo -smartscreen вҐЇҐам ®вЄ«оз Ґвбп Ё зҐаҐ§ аҐҐбва
echo -гзвҐ­  бЁвг жЁп, Є®Ј¤  FuckWD § ¤ҐвҐЄвЁ«бп  ­вЁўЁагб ¬Ё Ё г¤ «Ґ­ЁҐ ­Ґ®Ўе®¤Ё¬® Їа®Ё§ў®¤Ёвм ЎҐ§ ­ҐЈ®
%ch% {0c} v. 4{\n #}
echo -Ї®Їа ў«Ґ­ changelog
echo -¤®Ў ў«Ґ­  Їа®ўҐаЄ  ЇҐаҐ¤ г¤ «Ґ­ЁҐ¬ ­  ­ «ЁзЁҐ § йЁв­ЁЄ  ў бЁбвҐ¬Ґ Ё ўлў®¤ б®®вўҐвбвўгойҐЈ® б®®ЎйҐ­Ёп
echo -Ё§¬Ґ­Ґ­ а §¬Ґа Ј« ў­®Ј® ®Є­ , Ї®бЄ®«мЄг ­Ґ ўҐбм вҐЄбв ў¬Ґй «бп
echo -¤®Ў ў«Ґ­® г¤ «Ґ­ЁҐ Ї ЇЄЁ б § ¤ з ¬Ё § йЁв­ЁЄ 
echo -®ЎҐ§ўаҐ¦Ґ­ smartscreen
echo -¤®Ў ў«Ґ­  Їа®ўҐаЄ  ­  б®бв®п­ЁҐ § йЁв­ЁЄ  Ё ®вЄ«озҐ­ЁҐ § йЁв­ЁЄ , Ґб«Ё ­Ґ ®вЄ«озҐ­
%ch% {0c} v. 3{\n #}
echo -¤®Ў ў«Ґ­ ChangeLog
echo -¤®Ў ў«Ґ­  Їа®ўҐаЄ , Ґб«Ё гбв ­®ў«Ґ­  Windows 11 - Їа®е®¤Ё¬ ¤®Ї®«­ЁвҐ«м­л© а § FuckDefender
echo -¤®Ў ў«Ґ­  Їа®ўҐаЄ  ­  Їа ў  TI ЇҐаҐ¤ г¤ «Ґ­ЁҐ¬
echo -­ҐЎ®«миЁҐ Їа ўЄЁ Ё­вҐадҐ©б , Є®¤  Ё ®ЇЁб ­Ё© дг­ЄжЁ©
echo -Ё§¬Ґ­Ґ­ бЇ®б®Ў Ї®«гзҐ­Ёп Ё­д®а¬ жЁЁ ® § ЇгйҐ­­ле Їа®жҐбб е § йЁв­ЁЄ 
echo -г¤ «Ґ­л «Ёи­ЁҐ ЇҐаҐ¬Ґ­­лҐ
%ch% {0c} v. 2{\n #}
echo -¤®Ў ў«Ґ­л жўҐв 
echo -Ё§¬Ґ­Ґ­ Ї®¤е®¤ Є Ї®«гзҐ­Ёо  ¤¬Ё­Ёбва вЁў­ле Їа ў ЇаЁ § ЇгбЄҐ, Ґб«Ё ўЄ«озҐ­ UAC
%ch% {0c} v. 1{\n #}
echo -б®§¤ ­ЁҐ Ё Їа ўЄЁ Є®¤ 
echo.
%ch% {08} ‹оЎ п Є« ўЁи  ¤«п ў®§ўа в {\n #}
:Catalogs
%ch% {0e} C:\Program Files:{\n #}
if not exist "%SystemDrive%\Program Files\Windows Defender" (
%ch% {0f}C:\Program Files\Windows Defender {0a}“„Ђ‹…Ќ{\n #}
) else (
%ch% {0f}C:\Program Files\Windows Defender {4f}Ќ… “„Ђ‹…Ќ{\n #}
)
if not exist "%SystemDrive%\Program Files\Windows Defender Advanced Threat Protection" (
%ch% {0f}C:\Program Files\Windows Defender Advanced Threat Protection {0a}“„Ђ‹…Ќ{\n #}
) else (
%ch% {0f}C:\Program Files\Windows Defender Advanced Threat Protection {04}Ќ… “„Ђ‹…Ќ{\n #}
)
if not exist "%SystemDrive%\Program Files\Windows Security" (
%ch% {0f}C:\Program Files\Windows Security {0a}“„Ђ‹…Ќ{\n #}
) else (
%ch% {0f}C:\Program Files\Windows Security {04}Ќ… “„Ђ‹…Ќ{\n #}
)
if not exist "%SystemDrive%\Program Files\PCHealthCheck" (
%ch% {0f}C:\Program Files\PCHealthCheck {0a}“„Ђ‹…Ќ{\n #}
) else (
%ch% {0f}C:\Program Files\PCHealthCheck {04}Ќ… “„Ђ‹…Ќ{\n #}
)
if not exist "%SystemDrive%\Program Files\Microsoft Update Health Tools" (
%ch% {0f}C:\Program Files\Microsoft Update Health Tools {0a}“„Ђ‹…Ќ{\n #}
) else (
%ch% {0f}C:\Program Files\Microsoft Update Health Tools {04}Ќ… “„Ђ‹…Ќ{\n #}
)
echo.
%ch% {0e} C:\Program Files (^x86^):{\n #}
if not exist "%ProgramFiles(x86)%\Windows Defender" (
%ch% {0f}C:\Program Files (^x86^)\Windows Defender {0a}“„Ђ‹…Ќ{\n #}
) else (
%ch% {0f}C:\Program Files (^x86^)\Windows Defender {04}Ќ… “„Ђ‹…Ќ{\n #}
)
if not exist "%ProgramFiles(x86)%\Windows Defender Advanced Threat Protection" (
%ch% {0f}C:\Program Files (^x86^)\Windows Defender Advanced Threat Protection {0a}“„Ђ‹…Ќ{\n #}
) else (
%ch% {0f}C:\Program Files (^x86^)\Windows Defender Advanced Threat Protection {04}Ќ… “„Ђ‹…Ќ{\n #}
)
echo.
%ch% {0e} C:\ProgramData\Microsoft:{\n #}
if not exist "%AllUsersProfile%\Microsoft\Windows Defender" (
%ch% {0f}C:\ProgramData\Microsoft\Windows Defender {0a}“„Ђ‹…Ќ{\n #}
) else (
%ch% {0f}C:\ProgramData\Microsoft\Windows Defender {04}Ќ… “„Ђ‹…Ќ{\n #}
)
if not exist "%AllUsersProfile%\Microsoft\Windows Defender Advanced Threat Protection" (
%ch% {0f}C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection {0a}“„Ђ‹…Ќ{\n #}
) else (
%ch% {0f}C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection {04}Ќ… “„Ђ‹…Ќ{\n #}
)
if not exist "%AllUsersProfile%\Microsoft\Windows Security Health" (
%ch% {0f}C:\ProgramData\Microsoft\Windows Security Health {0a}“„Ђ‹…Ќ{\n #}
) else (
%ch% {0f}C:\ProgramData\Microsoft\Windows Security Health {04}Ќ… “„Ђ‹…Ќ{\n #}
)
echo.
%ch% {0e} WindowsDefenderApplicationGuard.wim:{\n #}
if not exist "%SystemRoot%\Containers\WindowsDefenderApplicationGuard.wim" (
%ch% {0f}C:\Windows\Containers\WindowsDefenderApplicationGuard.wim {0a}“„Ђ‹…Ќ{\n #}
) else (
%ch% {0f}C:\Windows\Containers\WindowsDefenderApplicationGuard.wim {04}Ќ… “„Ђ‹…Ќ{\n #}
)
if not exist "%SystemRoot%\Containers\serviced\WindowsDefenderApplicationGuard.wim" (
%ch% {0f}C:\Windows\Containers\serviced\WindowsDefenderApplicationGuard.wim {0a}“„Ђ‹…Ќ{\n #}
) else (
%ch% {0f}C:\Windows\Containers\serviced\WindowsDefenderApplicationGuard.wim {04}Ќ… “„Ђ‹…Ќ{\n #}
)
echo.
%ch% {08} ‹оЎ п Є« ўЁи  ¤«п ў®§ўа в {\n #}
rem Файл: Удалить Защитник Windows (MartyFiles).bat
:Start
@ECHO OFF
reg query "HKU\S-1-5-19\Environment" >nul 2>&1 & cls
if "%Errorlevel%" NEQ "0" (
)
Rem Enable Delayed Expansion
setlocal EnableDelayedExpansion
REM Обнуляем значение переменных
set "sFreeSize="
set "sFreeSizePseudoMb1="
set "Freed="
cd /d "%~dp0WorkFiles"
Title DefenderKiller
@cmdow @ /SIZ 1000 700
set ch="cecho.exe"
qprocess "Win 10 Tweaker.exe">nul 2>&1 || nircmd.exe win center alltop
ConX.exe show
%ch% {0f}Запущено с правами: {04}%username%{\n #}
%ch% {0f}Delete Defender Версия: {0b}6 By Vlado Для W10T{\n #}
echo.
%ch% {0f}Windows Defender: 
if not exist "%ProgramFiles%\Windows Defender" (%ch% {2f}Удален из Windows{08} [папка Windows Defender отсутствует]{\n #}) else (%ch% {4f}Не удален^^^!{0c} [папка Windows Defender найдена]{\n #})
rem Отключен ли защитник
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" >nul 2>&1
if "%ERRORLEVEL%"=="0" (
%ch% {0f}Windows Defender: {0a}Защитник отключен {08}[через реестр: DisableAntiSpyware]{\n #}
)
if "%ERRORLEVEL%"=="1" (
%ch% {0f}Windows Defender: {0c}Защитник включен {08}[через реестр]{\n #}
)
echo.
%ch% {03}Процессы защитника:{\n #}
%ch% {0f}Процесс AntimalwareService:   {#} 
qprocess "MsMpEng.exe">nul 2>&1 && %ch% {04}Процесс запущен{\n #}|| %ch% {0a}Процесс не запущен{\n #}
%ch% {0f}Процесс SecurityHealthService:{#} 
qprocess "SecurityHealthService.exe">nul 2>&1 && %ch% {04}Процесс запущен{\n #}|| %ch% {0a}Процесс не запущен{\n #}
%ch% {0f}Процесс SecurityHealthSystray:{#} 
qprocess "SecurityHealthSystray.exe">nul 2>&1 && %ch% {04}Процесс запущен{\n #}|| %ch% {0a}Процесс не запущен{\n #}
%ch% {0f}Процесс SecurityHealthHost:   {#} 
qprocess "SecurityHealthHost.exe">nul 2>&1 && %ch% {04}Процесс запущен{\n #}|| %ch% {0a}Процесс не запущен{\n #}
%ch% {0f}Процесс SmartScreen Защитника:{#} 
qprocess "smartscreen.exe">nul 2>&1 && %ch% {04}Процесс запущен{\n #}|| %ch% {0a}Процесс не запущен{\n #}
%ch% {0f}Процесс брокер SgrmBroker:    {#} 
qprocess "SgrmBroker.exe">nul 2>&1 && %ch% {04}Процесс запущен{\n #}|| %ch% {0a}Процесс не запущен{\n #}
%ch% {0f}Процесс защитника SecHealthUI:{#} 
qprocess "SecHealthUI.exe">nul 2>&1 && %ch% {04}Процесс запущен{\n #}|| %ch% {0a}Процесс не запущен{\n #}
%ch% {0f}Процесс Update Health uhssvc: {#} 
qprocess "uhssvc.exe">nul 2>&1 && %ch% {04}Процесс запущен{\n #}|| %ch% {0a}Процесс не запущен{\n #}
echo.
rem Проверка служб и драйверов
%ch% {03}Службы защитника:{\n #}
%ch% {0f}WinDefend:     {#} 
sc query WinDefend >nul 2>&1
if ERRORLEVEL 1 (%ch% {0a}Не существует{\n #}) else (
sc query WinDefend | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}Отключена{\n #}) ELSE (%ch% {04}Запущена{\n #}))
%ch% {0f}WdNisSvc:      {#} 
sc query WdNisSvc >nul 2>&1
if ERRORLEVEL 1 (%ch% {0a}Не существует{\n #}) else (
sc query WdNisSvc | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}Отключена{\n #}) ELSE (%ch% {04}Запущена{\n #}))
%ch% {0f}Sense:         {#} 
sc query Sense >nul 2>&1
if ERRORLEVEL 1 (%ch% {0a}Не существует{\n #}) else (
sc query Sense | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}Отключена{\n #}) ELSE (%ch% {04}Запущена{\n #}))
%ch% {0f}SecurityHealth:{#} 
sc query SecurityHealthService >nul 2>&1
if ERRORLEVEL 1 (%ch% {0a}Не существует{\n #}) else (
sc query SecurityHealthService | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}Отключена{\n #}) ELSE (%ch% {04}Запущена{\n #}))
%ch% {0f}wscsvc:        {#} 
sc query wscsvc >nul 2>&1
if ERRORLEVEL 1 (%ch% {0a}Не существует{\n #}) else (
sc query wscsvc | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}Отключена{\n #}) ELSE (%ch% {04}Запущена{\n #}))
%ch% {0f}SgrmBroker:     {#}
sc query SgrmBroker >nul 2>&1
if ERRORLEVEL 1 (%ch% {0a}Не существует{\n #}) else (
sc query SgrmBroker | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}Отключена{\n #}) ELSE (%ch% {04}Запущена{\n #}))
echo.
%ch% {03}Драйверы защитника:{\n #}
%ch% {0f}WdNisDrv:{#} 
sc query WdNisDrv >nul 2>&1
if ERRORLEVEL 1 (%ch% {08}Не существует{#} ) else (
sc query WdNisDrv | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}Отключен{#} ) ELSE (%ch% {04}Запущен{#} ))
%ch% {0f}WdBoot:{#} 
sc query WdBoot >nul 2>&1
if ERRORLEVEL 1 (%ch% {08}Не существует{#} ) else (
sc query WdBoot | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}Отключен{#} ) ELSE (%ch% {04}Запущен{#} ))
%ch% {0f}WdFilter:{#} 
sc query WdFilter >nul 2>&1
if ERRORLEVEL 1 (%ch% {08}Не существует{#} ) else (
sc query WdFilter | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}Отключен{#} ) ELSE (%ch% {04}Запущен{#} ))
%ch% {0f}MsSecFlt:{#} 
sc query MsSecFlt >nul 2>&1
if ERRORLEVEL 1 (%ch% {08}Не существует{#} ) else (
sc query MsSecFlt | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}Отключен{#} ) ELSE (%ch% {04}Запущен{#} ))
%ch% {0f}SgrmAgent:{#} 
sc query SgrmAgent >nul 2>&1
if ERRORLEVEL 1 (%ch% {08}Не существует{\n #}) else (
sc query SgrmAgent | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}Отключен{\n #}) ELSE (%ch% {04}Запущен{\n #}))
rem Проверка задач
set "taskpathDef1=Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance"
set "taskpathDef2=Microsoft\Windows\Windows Defender\Windows Defender Cleanup"
set "taskpathDef3=Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
set "taskpathDef4=Microsoft\Windows\Windows Defender\Windows Defender Verification"
for /f "delims=, tokens=3" %%I in (' 2^>nul SCHTASKS /QUERY /FO CSV /NH /TN "%taskpathDef1%" ') do set "replyTaskDef1=%%~I"
for /f "delims=, tokens=3" %%I in (' 2^>nul SCHTASKS /QUERY /FO CSV /NH /TN "%taskpathDef2%" ') do set "replyTaskDef2=%%~I"
for /f "delims=, tokens=3" %%I in (' 2^>nul SCHTASKS /QUERY /FO CSV /NH /TN "%taskpathDef3%" ') do set "replyTaskDef3=%%~I"
for /f "delims=, tokens=3" %%I in (' 2^>nul SCHTASKS /QUERY /FO CSV /NH /TN "%taskpathDef4%" ') do set "replyTaskDef4=%%~I"
if not "!replyTaskDef1!"=="" (
	if "!replyTaskDef1!"=="Отключена" ( set "TaskDefResult1={0a}Отключена{#}" ) else ( set "TaskDefResult1={04}Включена{#}" )
) else ( set "TaskDefResult1={0a}Не существует{#}" )
if not "!replyTaskDef2!"=="" (
	if "!replyTaskDef2!"=="Отключена" ( set "TaskDefResult2={0a}Отключена{#}" ) else ( set "TaskDefResult2={04}Включена{#}" )
) else ( set "TaskDefResult2={0a}Не существует{#}" )
if not "!replyTaskDef3!"=="" (
	if "!replyTaskDef3!"=="Отключена" ( set "TaskDefResult3={0a}Отключена{#}" ) else ( set "TaskDefResult3={04}Включена{#}" )
) else ( set "TaskDefResult3={0a}Не существует{#}" )
if not "!replyTaskDef4!"=="" (
	if "!replyTaskDef4!"=="Отключена" ( set "TaskDefResult4={0a}Отключена{#}" ) else ( set "TaskDefResult4={04}Включена{#}" )
) else ( set "TaskDefResult4={0a}Не существует{#}" )
echo.
%ch% {03}Задачи в планировщике:{\n #}
%ch% {0f}1. Windows Defender Cache Maintenance: %TaskDefResult1%{\n #}
%ch% {0f}2. Windows Defender Cleanup:           %TaskDefResult2%{\n #}
%ch% {0f}3. Windows Defender Scheduled Scan:    %TaskDefResult3%{\n #}
%ch% {0f}4. Windows Defender Verification:      %TaskDefResult4%{\n #}
rem Задачи защитника
if not exist "%SYSTEMROOT%\System32\Tasks\Microsoft\Windows\Windows Defender" (set "TasksDefender={0a}Задачи защитника удалены{#}") else (set "TasksDefender={4f}Задачи не удалены!{#}")
%ch% {04}^----^>{#} {0f}Задачи (папка Tasks): %TasksDefender% {\n #}
echo.
%ch% {0f} 1{#} - {0a}Удаление {08}[безвозвратно]{\n #}
%ch% {0f} 2{#} - {08}Отключение/включение {08}[в зависимости от состояния. требуется перезагрузка]{\n #}
%ch% {0f} 3{#} - {0c}Подробное состояние каталогов защитника{\n #}
%ch% {08} 4{#} - {08}ChangeLog{\n #}
echo.
set "input="
set /p input=*   Ваш выбор: 
if "%input%"=="1"    ( cls && goto DeleteDefender)
if "%input%"=="2"    ( cls && goto OnOffDefender)
if "%input%"=="3"    ( cls && goto Catalogs)
if "%input%"=="4"    ( cls && goto ChangeLog )
) else (
	cls & goto Start
)
:DeleteDefender
rem Считаем место на диске перед удалением
setlocal enableextensions enabledelayedexpansion
for /f "usebackq tokens=2 delims==" %%i in (`wmic.exe LogicalDisk where "Name='c:'" get FreeSpace /value`) do set sFreeSize=%%i
if defined sFreeSize (set sFreeSizePseudoMb=%sFreeSize:~0,-7%)
sc query WinDefend >nul 2>&1
if ERRORLEVEL 1 (
%ch% {0c} Кажется, защитник уже удален. Вы хотите все равно провести удаление?{\n #}
%ch% {08} 1{#} - {0c}Да{\n #}
%ch% {08} 2{#} - {08}Отмена{\n #}
choice /c 12 /n /m " "
if ERRORLEVEL 2 cls && goto Start
)
if not exist FuckDefender.exe (
%ch% {04} FuckDefender не обнаружен в рабочей папке{\n #}
echo  Скорее всего его удалил защитник ... 
echo  Будем выполнять удаление без него
echo  Однако, после удаления данной программой, необходимо дополнительно пройтись FuckDefender
echo  https://win10tweaker.ru/fwd
echo.
)
cls
rem Поверх всех окон
@cmdow @ /TOP
rem Завершаем процессы защитника
%ch%    {0f} Завершаем процессы защитника ...{\n #}
powershell -command "Stop-Process -processname MsMpEng, SecurityHealthSystray, SecurityHealthService, SecurityHealthHost, smartscreen, SgrmBroker, SecHealthUI, uhssvc -Force" >nul
timeout /t 1 /nobreak>nul
taskkill /f /im MsMpEng.exe >nul 2>&1
taskkill /f /im SecurityHealthSystray.exe >nul 2>&1
taskkill /f /im SecurityHealthService.exe >nul 2>&1
taskkill /f /im SecurityHealthHost.exe >nul 2>&1
taskkill /f /im smartscreen.exe >nul 2>&1
taskkill /f /im SgrmBroker.exe >nul 2>&1
taskkill /f /im SecHealthUI.exe >nul 2>&1
taskkill /f /im uhssvc.exe >nul 2>&1
echo.
%ch%    {0e} Отключаем защитник и smartscreen ...{\n #}
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t reg_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t reg_DWORD /d 0 /f >nul
ren "%SystemRoot%\System32\smartscreen.exe" "smartscreen_fuck.exe" >nul 2>&1
echo.
if not exist "%SystemDrive%\Program Files\Windows Defender" (
%ch%    {0c} Пропустить удаление FuckDefender'ом ? {\n #}
%ch% {0f} 1 - Нет, не пропускать{\n #}
%ch% {0f} 2 - Да, я уже удалял 2 раза и точно уверен, что защитник удален и хочу удалить остальные компоненты{\n #}
choice /c 12 /n /m " "
if ERRORLEVEL 2 goto NotFuckWD
if ERRORLEVEL 1 echo>nul
)
rem Запускаем FuckDefender
start FuckDefender.exe
:#
(
for /f %%i in ('"tasklist| findstr /bilc:"FuckDefender.exe""') do (%ch%    {04} Началось удаление.{\n #} && echo. && %ch% {0e}    Выполняется удаление ...{\n #})
)|| goto #
timeout /t 1 /nobreak >nul
echo.
%ch%    {0f} Немного ожидания ...{\n #}
timeout /t 1 /nobreak>nul
:reload
tasklist | find "FuckDefender.exe" >nul 2>&1
if ERRORLEVEL 1 goto NoRecord
goto reload
:NoRecord
echo.
%ch%    {0a} Не закрывайте окно программы ...{\n #}
>nul 2>&1 taskkill /f /im Unlocker.exe
>nul 2>&1 taskkill /f /im FuckDefender.exe
>nul 2>&1 taskkill /f /im wscript.exe
echo.
start FuckDefender.exe
:#1
(
for /f %%i in ('"tasklist| findstr /bilc:"FuckDefender.exe""') do (echo>nul)
)|| goto #1
:reload1
tasklist | find "FuckDefender.exe" >nul 2>&1
if ERRORLEVEL 1 goto NoRecord1
goto reload1
:NoRecord1
>nul 2>&1 taskkill /f /im Unlocker.exe
>nul 2>&1 taskkill /f /im FuckDefender.exe
>nul 2>&1 taskkill /f /im wscript.exe
:NotFuckWD
%ch%    {0e} Удаляем службы Windows Defender ...{\n #}
sc delete SecurityHealthService >nul 2>&1
sc delete Sense >nul 2>&1
sc delete WdNisSvc >nul 2>&1
sc delete WinDefend >nul 2>&1
sc delete wscsvc >nul 2>&1
sc delete SgrmBroker >nul 2>&1
reg delete HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService /f >nul 2>&1
reg delete HKLM\SYSTEM\CurrentControlSet\Services\Sense /f >nul 2>&1
reg delete HKLM\SYSTEM\CurrentControlSet\Services\WdNisSvc /f >nul 2>&1
reg delete HKLM\SYSTEM\CurrentControlSet\Services\WinDefend /f >nul 2>&1
reg delete HKLM\SYSTEM\CurrentControlSet\Services\wscsvc /f >nul 2>&1
reg delete HKLM\SYSTEM\CurrentControlSet\Services\SgrmBroker /f >nul 2>&1
echo.
%ch%    {0e} Удаляем задания из планировщика ...{\n #}
powershell -command "Unregister-ScheduledTask -TaskName 'Windows Defender Cache Maintenance' -Confirm:$false" >nul
powershell -command "Unregister-ScheduledTask -TaskName 'Windows Defender Cleanup' -Confirm:$false" >nul
powershell -command "Unregister-ScheduledTask -TaskName 'Windows Defender Scheduled Scan' -Confirm:$false" >nul
powershell -command "Unregister-ScheduledTask -TaskName 'Windows Defender Verification' -Confirm:$false" >nul
schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /f >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /f >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /f >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Verification" /f >nul 2>&1
rd /s /q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Windows Defender" >nul 2>&1
echo.
%ch%    {0e} Отключаем драйвера Windows Defender ...{\n #}
sc stop WdNisDrv >nul 2>&1
sc stop WdBoot >nul 2>&1
sc stop WdFilter >nul 2>&1
sc stop MsSecFlt >nul 2>&1
sc stop SgrmAgent >nul 2>&1
reg add HKLM\SYSTEM\CurrentControlSet\Services\WdNisDrv /v Start /t reg_DWORD /d 4 /f >nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\WdBoot /v Start /t reg_DWORD /d 4 /f >nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\WdFilter /v Start /t reg_DWORD /d 4 /f >nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\MsSecFlt /v Start /t reg_DWORD /d 4 /f >nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\SgrmAgent /v Start /t reg_DWORD /d 4 /f >nul
echo.
%ch%    {0e} Очищаем контекстное меню от Windows Defender ...{\n #}
reg delete "HKCR\*\shellex\ContextMenuHandlers\EPP" /f >nul 2>&1
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /f >nul 2>&1
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /f >nul 2>&1
echo.
rem Удаляем все папки через CMD
%ch%    {0e} Удаляем папки и файлы Windows Defender ...{\n #}
RD /S /Q "%AllUsersProfile%\Microsoft\Windows Defender" >nul 2>&1
RD /S /Q "%AllUsersProfile%\Microsoft\Windows Defender Advanced Threat Protection" >nul 2>&1
RD /S /Q "%AllUsersProfile%\Microsoft\Windows Security Health" >nul 2>&1
RD /S /Q "%SystemDrive%\ProgramData\Microsoft\Windows Defender" >nul 2>&1
RD /S /Q "%SystemDrive%\ProgramData\Microsoft\Windows Security Health" >nul 2>&1
RD /S /Q "%SystemDrive%\Program Files\Windows Defender" >nul 2>&1
RD /S /Q "%SystemDrive%\Program Files\Windows Defender Advanced Threat Protection" >nul 2>&1
RD /S /Q "%SystemDrive%\Program Files\Windows Security" >nul 2>&1
RD /S /Q "%SystemDrive%\Program Files\PCHealthCheck" >nul 2>&1
RD /S /Q "%SystemDrive%\Program Files\Microsoft Update Health Tools" >nul 2>&1
RD /S /Q "%SystemDrive%\Program Files (x86)\Windows Defender" >nul 2>&1
RD /S /Q "%SystemDrive%\Program Files (x86)\Windows Defender Advanced Threat Protection" >nul 2>&1
RD /S /Q "%SystemRoot%\WinSxS\amd64_windows-defender-am-sigs_31bf3856ad364e35_10.0.19041.1_none_7275cb8fbafec5e1" >nul 2>&1
del /q /s "%SystemRoot%\Containers\WindowsDefenderApplicationGuard.wim" >nul 2>&1
del /q /s "%SystemRoot%\WinSxS\WindowsDefenderApplicationGuard.wim" >nul 2>&1
del /q "%SystemRoot%\security\database" >nul 2>&1
REM Удаление всех папок из WinSxS
REM For /F "usebackq delims=" %%d In (`2^>nul Dir "C:\Windows\WinSxS\*windows-defender*" /S /B /A:D`) Do Rd "%%d" /s /q
wmic os get caption /Format:List | find /i "11" >nul 2>&1
if "%ERRORLEVEL%"=="0" (
%ch%    {0b} Это - Windows 11. Удаляем защитник еще раз.
start /wait FuckDefender.exe
>nul 2>&1 taskkill /f /im Unlocker.exe
>nul 2>&1 taskkill /f /im FuckDefender.exe
>nul 2>&1 taskkill /f /im wscript.exe
)
rem Make window not always on top
@cmdow @ /NOT
rem Подсчет места на диске после удаления
for /f "usebackq tokens=2 delims==" %%i in (`wmic.exe LogicalDisk where "Name='c:'" get FreeSpace /value`) do set sFreeSize=%%i
if defined sFreeSize (set sFreeSizePseudoMb1=%sFreeSize:~0,-7%)
set /a Freed=!sFreeSizePseudoMb1! - !sFreeSizePseudoMb!
echo.
%ch%     {2f}!Freed! Мегабайт освобождено{\n #}
echo.
powershell -command "[Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms');[Windows.Forms.MessageBox]::show('Защитник Windows удален из системы. Требуется перезагрузка ПК .', 'DefenderKiller By Vlado')" >nul
%ch%    {0c} Любая клавиша для выхода.{\n #}
:OnOffDefender
if not exist "%ProgramFiles%\Windows Defender" (
powershell -command "[Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms');[Windows.Forms.MessageBox]::show('Защитник удален, отключать нечего')" >nul
goto Start)
sc query SecurityHealthService | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (
%ch% {0e} Включаем защитник ...{\n #}
echo.
timeout /t 1 /nobreak>nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /t reg_EXPAND_SZ /d "C:\Windows\system32\SecurityHealthSystray.exe" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t reg_DWORD /d "0x3" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\Sense" /v "Start" /t reg_DWORD /d "0x3" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\WdBoot" /v "Start" /t reg_DWORD /d "0x0" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\WdFilter" /v "Start" /t reg_DWORD /d "0x0" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\WdNisDrv" /v "Start" /t reg_DWORD /d "0x3" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\WdNisSvc" /v "Start" /t reg_DWORD /d "0x2" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\WinDefend" /v "Start" /t reg_DWORD /d "0x2" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\wscsvc" /v "Start" /t reg_DWORD /d "0x2" /f >nul
reg delete "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /f >nul 2>&1
powershell -command "[Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms');[Windows.Forms.MessageBox]::show('Защитник Windows включен. Требуется перезагрузка ПК .', 'DefenderDisabler')" >nul
) else (
%ch% {0e} Отключаем защитник ...{\n #}
echo.
timeout /t 1 /nobreak>nul
reg add "HKLM\System\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t reg_DWORD /d "0x4" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\Sense" /v "Start" /t reg_DWORD /d "0x4" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\WdBoot" /v "Start" /t reg_DWORD /d "0x4" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\WdFilter" /v "Start" /t reg_DWORD /d "0x4" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\WdNisDrv" /v "Start" /t reg_DWORD /d "0x4" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\WdNisSvc" /v "Start" /t reg_DWORD /d "0x4" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\WinDefend" /v "Start" /t reg_DWORD /d "0x4" /f >nul
reg add "HKLM\System\CurrentControlSet\Services\wscsvc" /v "Start" /t reg_DWORD /d "0x4" /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t reg_DWORD /d 0 /f >nul
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f >nul 2>&1
powershell -command "[Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms');[Windows.Forms.MessageBox]::show('Защитник Windows отключен. Требуется перезагрузка ПК .', 'DefenderDisabler')" >nul
)
:ChangeLog
rem ChangeLog
%ch% {0c} v. 6{\n #}
echo -правильное удаление WindowsDefenderApplicationGuard.wim
echo -добавлена возможность увидеть текущее состояние каталогов защитника
echo -добавлены каталоги для удаления для последних версий Windows 10 и 11
echo -добавлено более тщательное удаление задач из планировщика и отключение процессов
echo -изменены проверки на наличие защитника
%ch% {0c} v. 5.2{\n #}
echo -добавлено отключение/включение защитника без удаления. требуется перезагрузка пк
%ch% {0c} v. 5.1{\n #}
echo -номера версий программы изменены с 26 на "адекватные" , начиная с 1 версии
echo -исправлен баг интерфейса, возникающий из-за одновременного запуска твикера и программы
%ch% {0c} v. 5{\n #}
echo -небольшие правки интерфейса и скрытие названия окна приложения
echo -smartscreen теперь отключается и через реестр
echo -учтена ситуация, когда FuckWD задетектился антивирусами и удаление необходимо производить без него
%ch% {0c} v. 4{\n #}
echo -поправлен changelog
echo -добавлена проверка перед удалением на наличие защитника в системе и вывод соответствующего сообщения
echo -изменен размер главного окна, поскольку не весь текст вмещался
echo -добавлено удаление папки с задачами защитника
echo -обезврежен smartscreen
echo -добавлена проверка на состояние защитника и отключение защитника, если не отключен
%ch% {0c} v. 3{\n #}
echo -добавлен ChangeLog
echo -добавлена проверка, если установлена Windows 11 - проходим дополнительный раз FuckDefender
echo -добавлена проверка на права TI перед удалением
echo -небольшие правки интерфейса, кода и описаний функций
echo -изменен способ получения информации о запущенных процессах защитника
echo -удалены лишние переменные
%ch% {0c} v. 2{\n #}
echo -добавлены цвета
echo -изменен подход к получению административных прав при запуске, если включен UAC
%ch% {0c} v. 1{\n #}
echo -создание и правки кода
echo.
%ch% {08} Любая клавиша для возврата{\n #}
:Catalogs
%ch% {0e} C:\Program Files:{\n #}
if not exist "%SystemDrive%\Program Files\Windows Defender" (
%ch% {0f}C:\Program Files\Windows Defender {0a}УДАЛЕН{\n #}
) else (
%ch% {0f}C:\Program Files\Windows Defender {4f}НЕ УДАЛЕН{\n #}
)
if not exist "%SystemDrive%\Program Files\Windows Defender Advanced Threat Protection" (
%ch% {0f}C:\Program Files\Windows Defender Advanced Threat Protection {0a}УДАЛЕН{\n #}
) else (
%ch% {0f}C:\Program Files\Windows Defender Advanced Threat Protection {04}НЕ УДАЛЕН{\n #}
)
if not exist "%SystemDrive%\Program Files\Windows Security" (
%ch% {0f}C:\Program Files\Windows Security {0a}УДАЛЕН{\n #}
) else (
%ch% {0f}C:\Program Files\Windows Security {04}НЕ УДАЛЕН{\n #}
)
if not exist "%SystemDrive%\Program Files\PCHealthCheck" (
%ch% {0f}C:\Program Files\PCHealthCheck {0a}УДАЛЕН{\n #}
) else (
%ch% {0f}C:\Program Files\PCHealthCheck {04}НЕ УДАЛЕН{\n #}
)
if not exist "%SystemDrive%\Program Files\Microsoft Update Health Tools" (
%ch% {0f}C:\Program Files\Microsoft Update Health Tools {0a}УДАЛЕН{\n #}
) else (
%ch% {0f}C:\Program Files\Microsoft Update Health Tools {04}НЕ УДАЛЕН{\n #}
)
echo.
%ch% {0e} C:\Program Files (^x86^):{\n #}
if not exist "%ProgramFiles(x86)%\Windows Defender" (
%ch% {0f}C:\Program Files (^x86^)\Windows Defender {0a}УДАЛЕН{\n #}
) else (
%ch% {0f}C:\Program Files (^x86^)\Windows Defender {04}НЕ УДАЛЕН{\n #}
)
if not exist "%ProgramFiles(x86)%\Windows Defender Advanced Threat Protection" (
%ch% {0f}C:\Program Files (^x86^)\Windows Defender Advanced Threat Protection {0a}УДАЛЕН{\n #}
) else (
%ch% {0f}C:\Program Files (^x86^)\Windows Defender Advanced Threat Protection {04}НЕ УДАЛЕН{\n #}
)
echo.
%ch% {0e} C:\ProgramData\Microsoft:{\n #}
if not exist "%AllUsersProfile%\Microsoft\Windows Defender" (
%ch% {0f}C:\ProgramData\Microsoft\Windows Defender {0a}УДАЛЕН{\n #}
) else (
%ch% {0f}C:\ProgramData\Microsoft\Windows Defender {04}НЕ УДАЛЕН{\n #}
)
if not exist "%AllUsersProfile%\Microsoft\Windows Defender Advanced Threat Protection" (
%ch% {0f}C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection {0a}УДАЛЕН{\n #}
) else (
%ch% {0f}C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection {04}НЕ УДАЛЕН{\n #}
)
if not exist "%AllUsersProfile%\Microsoft\Windows Security Health" (
%ch% {0f}C:\ProgramData\Microsoft\Windows Security Health {0a}УДАЛЕН{\n #}
) else (
%ch% {0f}C:\ProgramData\Microsoft\Windows Security Health {04}НЕ УДАЛЕН{\n #}
)
echo.
%ch% {0e} WindowsDefenderApplicationGuard.wim:{\n #}
if not exist "%SystemRoot%\Containers\WindowsDefenderApplicationGuard.wim" (
%ch% {0f}C:\Windows\Containers\WindowsDefenderApplicationGuard.wim {0a}УДАЛЕН{\n #}
) else (
%ch% {0f}C:\Windows\Containers\WindowsDefenderApplicationGuard.wim {04}НЕ УДАЛЕН{\n #}
)
if not exist "%SystemRoot%\Containers\serviced\WindowsDefenderApplicationGuard.wim" (
%ch% {0f}C:\Windows\Containers\serviced\WindowsDefenderApplicationGuard.wim {0a}УДАЛЕН{\n #}
) else (
%ch% {0f}C:\Windows\Containers\serviced\WindowsDefenderApplicationGuard.wim {04}НЕ УДАЛЕН{\n #}
)
echo.
%ch% {08} Любая клавиша для возврата{\n #}
rem Файл: Удалить все приложения Microsoft.bat
powershell -command "Get-AppxPackage *Microsoft* | Remove-AppxPackage" >nul
powershell -command "Get-AppxPackage *AdobeSystemsIncorporated.AdobePhotoshopExpress* | Remove-AppxPackage" >nul
powershell -command "Get-AppxPackage *CandyCrush* | Remove-AppxPackage" >nul
powershell -command "Get-AppxPackage *Duolingo-LearnLanguagesforFree* | Remove-AppxPackage" >nul
powershell -command "Get-AppxPackage *Facebook* | Remove-AppxPackage" >nul 2>&1
powershell -command "Get-AppxPackage *Flipboard* | Remove-AppxPackage" >nul 2>&1
powershell -command "Get-AppxPackage *AppUp.IntelGraphicsControlPanel* | Remove-AppxPackage" >nul
powershell -command "Get-AppxPackage *7EE7776C.LinkedInforWindows* | Remove-AppxPackage" >nul
powershell -command "Get-AppxPackage *Mirkat.Mirkat* | Remove-AppxPackage" >nul
powershell -command "Get-AppxPackage *Spotify* | Remove-AppxPackage" >nul
powershell -command "Get-AppxPackage *RealtekSemiconductorCorp.RealtekAudioControl* | Remove-AppxPackage" >nul
powershell -command "Get-AppxPackage *Twitter* | Remove-AppxPackage" >nul
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.3DBuilder | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.BingFinance | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.BingNews | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.Getstarted | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.MicrosoftOfficeHub | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.MicrosoftSolitaireCollection | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.Office.OneNote | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.SkypeApp | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.WindowsPhone | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.XboxApp | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.ZuneMusic | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.ZuneVideo | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxPackage *Microsoft* | Remove-AppxPackage"
PowerShell -Command "Get-AppXProvisionedPackage -online | Remove-AppxProvisionedPackage -online"
PowerShell -Command "Get-AppXPackage | Remove-AppxPackage"
PowerShell -Command "Get-AppXPackage -User  | Remove-AppxPackage"
PowerShell -Command "PowerShell -Command Get-AppxPackage -AllUsers | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *3dbuilder* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *bingsports* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.549981C3F5F10* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *zunemusic* | Remove-AppxPackage"
PowerShell -Command "Get-Package -Name "*Office*" | Uninstall-Package"
PowerShell -Command "Get-AppxPackage *Microsoft.OneConnect* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.MSPaint* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.Print3D* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *xboxapp* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.XboxGamingOverlay* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.XboxSpeechToTextOverlay* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *windowsalarms* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *windowsphone* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.YourPhone* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *bingfinance* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *soundrecorder* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *windowscalculator* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *windowscamera* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *windowsmaps* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *zunevideo* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *people* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.ScreenSketch* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *getstarted* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.MixedReality.Portal* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.HEIFImageExtension* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.WebpImageExtension* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.WebMediaExtensions* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.Microsoft3DViewer* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.GetHelp* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *photos* | Remove-AppxPackage"
PowerShell -Command "get-appxpackage *feedback* | remove-appxpackage"
PowerShell -Command "Disable-WindowsOptionalFeature -Online -NoRestart -FeatureName "Internet-Explorer-Optional-amd64"
PowerShell -Command "get-appxpackage *Internet-Explorer* | remove-appxpackage"
sc stop windefend & sc config windefend start=disabled
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "off" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SmartScreen" /v "ConfigureAppInstallControl" /t REG_SZ /d "Anywhere" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SmartScreen" /v "ConfigureAppInstallControlEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wscsvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f
setlocal enabledelayedexpansion
:: Get user SID
for /f "delims=" %%a in ('powershell "(New-Object System.Security.Principal.NTAccount($env:USERNAME)).Translate([System.Security.Principal.SecurityIdentifier]).Value"') do set "USER_SID=%%a"
:: Remove Edge Appx Packages
for /f "delims=" %%a in ('powershell -NoProfile -Command "PowerShell -Command Get-AppxPackage -AllUsers ^| Where-Object { $_.PackageFullName -like '*microsoftedge*' } ^| Select-Object -ExpandProperty PackageFullName"') do (
    if not "%%a"=="" (
        set "APP=%%a"
        reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\!USER_SID!\!APP!" /f >nul 2>&1
        reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\S-1-5-18\!APP!" /f >nul 2>&1
        reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned\!APP!" /f >nul 2>&1
        powershell -Command "Remove-AppxPackage -Package '!APP!'" 2>nul
        powershell -Command "Remove-AppxPackage -Package '!APP!' -AllUsers" 2>nul
    )
)
endlocal
:: DefenderKiller By Vlado -  https://win10tweaker.ru/forum/topic/defenderkiller
:: Thanks for test Eject - https://win10tweaker.ru/forum/profile/eject
:: StopDefender - https://github.com/lab52io/StopDefender
:: FuckDefender - http://win10tweaker.ru/fwd
:: NsudoLC - https://github.com/M2TeamArchived/NSudo/releases
:: nhmb - https://nhutils.ru/blog/nhmb/
:: LGPO - https://www.microsoft.com/en-us/download/details.aspx?id=55319
:: Last Version - https://pastebin.com/raw/dnENFgmC
:Start
	@echo off
	Title DK
	chcp 866 >nul
	SetLocal EnableDelayedExpansion
	Color 0f
	cd /d "%~dp0Work"
	reg query "HKU\S-1-5-19" >nul 2>&1
rem –ўҐв­®© вҐЄбв/lgpo
	set "ch=cecho.exe"
	set "LGPOtemp=LGPO-temp.txt"
	set "RepeatDel="
rem ‚ҐабЁп Їа®Ја ¬¬л/“¤ «пҐ¬ д ©«, Є®в®ал© ¬®¦Ґв ®бв ў вмбп Ї®б«Ґ ®Ў­®ў«Ґ­Ёп ў Є®а­Ґ ¤ЁбЄ 
	set Version=11.1.3
	set DateProgram=18.01.2024
	if exist "%SystemDrive%\latestVersion.bat" del /q "%SystemDrive%\latestVersion.bat"
rem …б«Ё ­Ґ бгйҐбвўгҐв WMIC/nhmb
rem Џ®«гзҐ­ЁҐ SID ЇҐаҐ¤ § ЇгбЄ®¬ ®в Ё¬Ґ­Ё TI
	for /f %%s in ('2^>nul wmic UserAccount where "Domain='%UserDomain%' and Name='%UserName%'" Get SID^|find "-"') do set SID=%%s
rem Џа®ўҐаЄ  а §ап¤­®бвЁ бЁбвҐ¬л
	set xOS=x64& (If "%PROCESSOR_ARCHITECTURE%"=="x86" If Not Defined PROCESSOR_ARCHITEW6432 Set xOS=x86)
rem ‡ ЇгбЄ ®в Ё¬Ґ­Ё TI
rem ђ §¬Ґа Їа®Ја ¬¬л ў § ўЁбЁ¬®бвЁ ®в ­ «ЁзЁп б«г¦Ўл, а бЇ®«®¦Ґ­ЁҐ Ї® жҐ­ваг нЄа ­  Ё ­ §ў ­ЁҐ
	set "serviceswebmask="
	for /f "usebackq delims=" %%n In (`2^>nul reg query "HKLM\System\CurrentControlSet\Services" /f "webthreatdefusersvc*" /k^|findstr ^H`) do set serviceswebmask=%%~nxn
	if defined serviceswebmask (Mode 82,45) else (Mode 80,45)
	nircmd win center process cmd.exe & nircmd win settext foreground "DK"
rem SmartScreen | Џа®жҐббл | ‘«г¦Ўл | „а ©ўҐа  | ‡ ¤ зЁ | Џа®ўҐаЄ  ­ «ЁзЁп GP [Home ўҐабЁп]
	set "ArgNsudo="
	reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" | find /i "0x0" >nul 2>&1 && set "ArgNsudo=C" || set "ArgNsudo=E"
	if not exist "%SystemRoot%\System32\smartscreen.exe" (set "SmartScreen=0a") else (set "SmartScreen=0c")
	if not exist "%SystemRoot%\System32\gpedit.msc" set "NoGP=Yes"
(
	qprocess "MsMpEng.exe" && set "MsMpEng=0c" || set "MsMpEng=0a"
	qprocess "SgrmBroker.exe" && set "SgrmBroker=0c" || set "SgrmBroker=0a"
	qprocess "uhssvc.exe" && set "uhssvc=0c" || set "uhssvc=0a"
	qprocess "NisSrv.exe" && set "NisSrv=0c" || set "NisSrv=0a"
	qprocess "MpCmdRun.exe" && set "MpCmdRun=0c" || set "MpCmdRun=0a"
	qprocess "MPSigStub.exe" && set "MPSigStub=0c" || set "MPSigStub=0a"
	qprocess "SecHealthUI.exe" && set "SecHealthUI=0c" || set "SecHealthUI=0a"
	qprocess "SecurityHealthSystray.exe" && set "SecurityHealthSystray=0c" || set "SecurityHealthSystray=0a"
	qprocess "SecurityHealthService.exe" && set "SecurityHealthService=0c" || set "SecurityHealthService=0a"
	qprocess "SecurityHealthHost.exe" && set "SecurityHealthHost=0c" || set "SecurityHealthHost=0a"
	sc query WinDefend && set "WinDefend=0c" || set "WinDefend=0a"
	sc query WdNisSvc && set "WdNisSvc=0c" || set "WdNisSvc=0a"
	sc query Sense && set "Sense=0c" || set "Sense=0a"
	sc query wscsvc && set "wscsvc=0c" || set "wscsvc=0a"
	sc query SgrmBroker && set "SgrmBroker=0c" || set "SgrmBroker=0a"
	sc query SecurityHealthService && set "SecurityHealthService=0c" || set "SecurityHealthService=0a"
	sc query webthreatdefsvc && set "webthreatdefsvc=0c" || set "webthreatdefsvc=0a"
	sc query webthreatdefusersvc && set "webthreatdefusersvc=0c" || set "webthreatdefusersvc=0a"
	sc query WdNisDrv && set "WdNisDrv=0c" || set "WdNisDrv=0a"
	sc query WdBoot && set "WdBoot=0c" || set "WdBoot=0a"
	sc query WdFilter && set "WdFilter=0c" || set "WdFilter=0a"
	sc query SgrmAgent && set "SgrmAgent=0c" || set "SgrmAgent=0a"
	sc query wtd && set "wtd=0c" || set "wtd=0a"
	sc query MsSecWfp && set "MsSecWfp=0c" || set "MsSecWfp=0a"
	sc query MsSecFlt && set "MsSecFlt=0c" || set "MsSecFlt=0a"
	sc query MsSecCore && set "MsSecCore=0c" || set "MsSecCore=0a"
) >nul 2>&1
	set PathTask=%SystemRoot%\System32\Tasks\Microsoft\Windows\Windows Defender
	if not exist "%PathTask%\Windows Defender Cache Maintenance" (set "Maintenance=0a") else (set "Maintenance=0c")
	if not exist "%PathTask%\Windows Defender Scheduled Scan" (set "Scan=0a") else (set "Scan=0c")
	if not exist "%PathTask%\Windows Defender Verification" (set "Verification=0a") else (set "Verification=0c")
	if not exist "%PathTask%\Windows Defender Cleanup" (set "Cleanup=0a") else (set "Cleanup=0c")
	if not exist "%SystemRoot%\System32\Tasks\Microsoft\Windows\AppID\SmartScreenSpecific" (set "SmartScreenSpecific=0a") else (set "SmartScreenSpecific=0c")
	%ch% {03}‘®бв®п­ЁҐ Їа®жҐбб®ў § йЁв­ЁЄ :{\n #}
	%ch% {%SmartScreen%}SmartScreen{\n #}
	%ch% {%MsMpEng%}MsMpEng{#}   {08} [Antimalware Service Executable]{\n #}
	%ch% {%SgrmBroker%}SgrmBroker{#} {08}[Ѓа®ЄҐа баҐ¤л ўлЇ®«­Ґ­Ёп System Guard]{\n #}
	%ch% {%uhssvc%}uhssvc{#}    {08} [Microsoft Update Health Service]{\n #}
	%ch% {%NisSrv%}NisSrv{#}    {08} [Network Realtime Inspection]{\n #}
	%ch% {%MpCmdRun%}MpCmdRun{#}  {08} [Microsoft malware protection]{\n #}
	%ch% {%MPSigStub%}MPSigStub{#}{08}  [Malware Protection Signature Update Stub]{\n #}
	%ch% {%SecHealthUI%}SHealthUI{#}{08}  [ЃҐ§®Ї б­®бвм Windows]{\n #}
	%ch% {%SecurityHealthSystray%}HealthTray{#}{08} [SecurityHealthSystray ЁЄ®­Є  ў ваҐҐ]{\n #}
	%ch% {%SecurityHealthService%}HealthServ{#}{08} [SecurityHealthService]{\n #}
	%ch% {%SecurityHealthHost%}HealthHost{#}{08} [SecurityHealthHost]{\n #}{\n #}
	%ch% {03}‘®бв®п­ЁҐ б«г¦Ў Ё ¤а ©ўҐа®ў § йЁв­ЁЄ :{\n #}
	%ch% {%webthreatdefsvc%}webthreat{#}  {08}[‘«г¦Ў  § йЁвл ®в ‚ҐЎ-гЈа®§ - webthreatdefsvc]{\n #}
	if defined serviceswebmask (
	%ch% {%webthreatdefusersvc%}webthreatu{#} {08}[‘«г¦Ў  § йЁвл Ї®«м§®ў в. ®в ‚ҐЎ-гЈа®§ - {04}%serviceswebmask%{08}]{\n #}
	) else (
	%ch% {%webthreatdefusersvc%}webthreatu{#} {08}[‘«г¦Ў  § йЁвл Ї®«м§®ў в. ®в ‚ҐЎ-гЈа®§ - webthreatdefusersvc]{\n #}
	)
	%ch% {%WinDefend%}WinDefend{#} {08} [‘«г¦Ў  Ђ­вЁўЁагб­ п Їа®Ја ¬¬  ‡ йЁв­ЁЄ  Windows]{\n #}
	%ch% {%WdNisSvc%}WdNisSvc{#} {08}  [‘«г¦Ў  Їа®ўҐаЄЁ бҐвЁ Windows Defender Antivirus]{\n #}
	%ch% {%Sense%}Sense{#}     {08} [‘«г¦Ў  Advanced Threat Protection]{\n #}
	%ch% {%wscsvc%}wscsvc{#}     {08}[‘«г¦Ў  –Ґ­ва ®ЎҐбЇҐзҐ­Ёп ЎҐ§®Ї б­®бвЁ]{\n #}
	%ch% {%SgrmBroker%}SgrmBroker{#} {08}[‘«г¦Ў  Ѓа®ЄҐа ¬®­Ёв®аЁ­Ј  баҐ¤л ўлЇ®«­Ґ­Ёп System Guard]{\n #}
	%ch% {%SecurityHealthService%}SHealthSer{#} {08}[‘«г¦Ў  –Ґ­ва ЎҐ§®Ї б­®бвЁ ‡ йЁв­ЁЄ  Windows]{\n #}
	%ch% {%WdNisDrv%}WdNisDrv{#}   {08}[„а ©ўҐа WD Network Inspection Driver]{\n #}
	%ch% {%WdBoot%}WdBoot{#}     {08}[„а ©ўҐа WD Antivirus Boot Driver]{\n #}
	%ch% {%WdFilter%}WdFilter{#}{08}   [„а ©ўҐа WD Antivirus Mini-Filter Driver]{\n #}
	%ch% {%SgrmAgent%}SgrmAgent{#}{08}  [„а ©ўҐа System Guard Runtime Monitor Agent Driver]{\n #}
	%ch% {%wtd%}wtd{#}{08}        [„а ©ўҐа WTD Driver]{\n #}
	%ch% {%MsSecWfp%}MsSecWfp{#}{08}   [„а ©ўҐа Microsoft Security WFP Callout Driver]{\n #}
	%ch% {%MsSecFlt%}MsSecFlt{#}{08}   [„а ©ўҐа Security Events Component Minifilter]{\n #}
	%ch% {%MsSecCore%}MsSecCore{#}{08}  [„а ©ўҐа Microsoft Security Core Boot Driver]{\n #}
	echo.
	%ch% {03}‘®бв®п­ЁҐ § ¤ ­Ё© ў Ї« ­Ёа®ўйЁЄҐ:{\n #}
	%ch% {%Maintenance%}Windows Defender Cache Maintenance{\n #}
	%ch% {%Scan%}Windows Defender Scheduled Scan{\n #}
	%ch% {%Verification%}Windows Defender Verification{\n #}
	%ch% {%Cleanup%}Windows Defender Cleanup{\n #}
	%ch% {%SmartScreenSpecific%}SmartScreenSpecific{\n #}
	echo.
	%ch% {0f}1{#} - {0c}“¤ «Ёвм ‡ йЁв­ЁЄ Windows{\n #}
	%ch% {0f}2{#} - {0f}‘®бв®п­ЁҐ Ї Ї®Є Ё д ©«®ў{\n #}
	%ch% {0f}3{#} - {03}Џа®ўҐаЁвм ®Ў­®ў«Ґ­Ёп DK {08}[вҐЄгй п  {09}%Version% {08}®в {03}%DateProgram% {08}^| By {02}Vlado{08}]{\n #}
	%ch% {0f}4{#} - {08}‚®ббв ­®ўЁвм ‡ йЁв­ЁЄ Windows{\n #}
	%ch% {0f}5{#} - {08}€­д®а¬ жЁп ® DK{\n #}
	set "input="
	set /p input=
	if not defined input cls && goto Start
	if "%input%"=="1"  cls && goto DeleteDefender
	if "%input%"=="2"  cls && goto Catalogs
	if "%input%"=="3"  cls && goto CheckUpdate
	if "%input%"=="4"  cls && goto RestoreDefender
	if "%input%"=="5"  cls && goto Information 
	) else (
	cls & %ch%    {0c}’ Є®© дг­ЄжЁЁ ­Ґ бгйҐбвўгҐв{\n #}
	timeout /t 1 >nul & endlocal & goto Start
	)
:DeleteDefender
rem Џа®ўҐаЄ  ¬Ґбв  ­  ¤ЁбЄҐ ЇҐаҐ¤ г¤ «Ґ­ЁҐ¬
	set "sFreeSize="
	set "sFreeSizePseudoMb="
	set "sFreeSizePseudoMb1="
	set "Freed="
	set "NameSecHealth="
	set "NotChangeUAC="
	for /f "usebackq tokens=2 delims==" %%i in (`wmic.exe LogicalDisk where "Name='c:'" get FreeSpace /value`) do set sFreeSize=%%i
	if defined sFreeSize set sFreeSizePseudoMb=%sFreeSize:~0,-7%
rem …б«Ё бгйҐбвўгҐв Ї ЇЄ  § йЁв­ЁЄ  ...
	if exist "%AllUsersProfile%\Microsoft\Windows Defender" (
rem Џа®ўҐапҐ¬ г¤ «п«бп «Ё § йЁв­ЁЄ а ­ҐҐ Ї® ўҐвЄҐ аҐҐбва , Є®в®а п г¤ «пҐвбп ў Їа®жҐббҐ г¤ «Ґ­Ёп. …б«Ё § йЁв­ЁЄ ­Ґ г¤ «с­ - Їа®ўҐапҐ¬ б®бв®п­ЁҐ ‡ йЁвл ®в Ї®¤¤Ґ«ЄЁ.
	reg query "HKLM\Software\Microsoft\Windows Defender\Features" >nul 2>&1 && echo >nul || goto NotTamper
rem Џа®ўҐапҐ¬ ­ «ЁзЁҐ ЇаЁ«®¦Ґ­Ёп ЃҐ§®Ї б­®бвм Windows
	for /F "usebackq delims=" %%n In (`2^>nul reg query "HKU\!SID!\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages" /f "*SecHealthUI*" /k^|findstr ^H`) do set NameSecHealth=%%~nxn
rem …б«Ё ЇаЁ«®¦Ґ­ЁҐ ЃҐ§®Ї б­®бвм ­Ґ г¤ «Ґ­®, Їа®ўҐапҐ¬ б®бв®п­ЁҐ § йЁвл ®в Ї®¤¤Ґ«ЄЁ
	if defined NameSecHealth (
	reg query "HKLM\Software\Microsoft\Windows Defender\Features" /v "TamperProtection" | find /i "0x4" >nul 2>&1 && (
	%ch%    {0a} ‡ йЁв  ®в Ї®¤¤Ґ«ЄЁ ®вЄ«озҐ­ ^^!{\n #}{\n #}
	) || (
	%ch%    {04} Ѓг¤гв ўлЄ«озҐ­л ўбҐ Ї а ¬Ґвал Defender ў  ўв®¬ вЁзҐбЄ®¬ аҐ¦Ё¬Ґ.{\n #}
	%ch%    {08} …б«Ё зв®-в® ­Ґ ®вЄ«озЁ«®бм - ®вЄ«озЁвҐ ўагз­го.{\n #}
	%ch%    {08} ѓ« ў­®Ґ, зв® ­Ґ®Ўе®¤Ё¬® ®вЄ«озЁвм - {04}‡ йЁв  ®в Ї®¤¤Ґ«ЄЁ{\n #}{\n #}
	%ch%    {0c} …б«Ё г ‚ б Windows 10 - ­Ґ®Ўе®¤Ё¬® ўагз­го ®вЄ«озЁвм "‡ йЁвг ®в Ї®¤¤Ґ«ЄЁ"{\n #}{\n #}
	%ch%    {08} Ќ ¦¬ЁвҐ «оЎго Є« ўЁиг ¤«п Їа®¤®«¦Ґ­Ёп{\n #}
rem ЋвЄ«оз Ґ¬ ўбЇ«лў ойҐҐ ®Є­® UAC, Ґб«Ё UAC ­Ґ ®вЄ«оз «бп а ­ҐҐ, зв®Ўл nircmd sendkeypress а Ў®в «® ЎҐ§ ®Є­  UAC
	reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" | find /i "0x0" >nul && set "NotChangeUAC=Yes"
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 0 /f >nul
rem ‡ ЇгбЄ Ґ¬ Ї а ¬Ґвал
	explorer windowsdefender://ThreatSettings
	timeout /t 2 /nobreak >nul
rem ‚лЄ«оз Ґ¬ ўбҐ Ї а ¬Ґвал б Ї®¬®ймо nircmd
	nircmd sendkeypress 0x20 0x09 0x20 0x09 0x20 0x09 0x09 0x20
:TamperProtectionStatus
rem Џа®ўҐапҐ¬ ­ «ЁзЁҐ Їа®жҐбб  ®Є­  ЎҐ§®Ї б­®бвЁ, Ґб«Ё Їа®жҐбб бгйҐбвўгҐв, Їа®ўҐапҐ¬ ®вЄ«озЁ« бм «Ё § йЁв  ®в Ї®¤¤Ґ«ЄЁ. …б«Ё Їа®жҐбб  ­Ґв - ўлў®¤Ё¬ б®®ЎйҐ­ЁҐ.
	qprocess SecHealthUI.exe >nul 2>&1 && (
	echo>nul) || (
	%ch%    {0c} ‡ йЁв  ®в Ї®¤¤Ґ«ЄЁ {4f}­Ґ{0c} ®вЄ«озҐ­ ^^!{\n #}{\n #}
	%ch%    {08} 1 - {0c}џ ­Ґ ¬®Јг ®вЄ«озЁвм § йЁвг ®в Ї®¤¤Ґ«ЄЁ{\n #}
	%ch%    {04} €бЇ®«м§г©вҐ, Ґб«Ё ¤Ґ©бвўЁвҐ«м­® ­Ґ ¬®¦ҐвҐ ®вЄ«озЁвм ¤ ­­го дг­ЄжЁо{\n #}{\n #}
	%ch%    {0c} ‚›ЏЋ‹Ќџџ ќ’Ћ’ Ђѓ, ‚› ЏђЋЏ“‘ЉЂ…’… ‘Ћ‡„ЂЌ€… ђ…‡…ђ‚ЌЋ‰ ЉЋЏ€€ ‡Ђ™€’Ќ€ЉЂ{\n #}{\n #}
	%ch%    {08} 2 - ‚Ґа­гвмбп ®Ўа в­®{\n #}
	choice /c 12 /n /m " "
	if errorlevel 2 cls && goto Start
	if errorlevel 1 cls && goto NotTamper)
rem Џа®ўҐаЄ  § йЁвл ®в Ї®¤¤Ґ«ЄЁ Ї®б«Ґ nircmd sendkeypress
	reg query "HKLM\Software\Microsoft\Windows Defender\Features" /v "TamperProtection" | find /i "0x4" >nul 2>&1 && cls && %ch%    {0a} ‡ йЁв  ®в Ї®¤¤Ґ«ЄЁ ®вЄ«озҐ­ ^^!{\n #}{\n #}|| goto TamperProtectionStatus
		)
	)
rem ”®Єгб ­  Їа®Ја ¬¬г
	nircmd win activate process cmd.exe
rem ‚®Їа®б ® б®§¤ ­ЁЁ аҐ§. Є®ЇЁЁ
	nhmb "‚л е®вЁвҐ б®§¤ вм аҐ§Ґаў­го Є®ЇЁо Windows Defender ЇҐаҐ¤ ўлЇ®«­Ґ­ЁҐ¬ г¤ «Ґ­Ёп?\nђҐ§Ґаў­ п Є®ЇЁп Ї®§ў®«пҐв ў®ббв ­®ўЁвм § йЁв­ЁЄ Ї®б«Ґ г¤ «Ґ­Ёп.\n‚®ббв ­®ў«Ґ­ЁҐ ¬®¦Ґв Ї®ваҐЎ®ў вмбп, Ґб«Ё ‚л ®Ў­®ў«пҐвҐ Windows.\n\n‚лЎЁа ©вҐ ­Ґв, в®«мЄ® ў в®¬ б«гз Ґ, Ґб«Ё ‚ ¬ Ќ… ­г¦­л ®Ў­®ў«Ґ­Ёп Windows, «ЁЎ® г ‚ б г¦Ґ Ґбвм аҐ§Ґаў­ п Є®ЇЁп § йЁв­ЁЄ  б нв®© ўҐабЁЁ Windows." "BackupDefender" "Warning|YesNo|DefButton2"
	if errorlevel 7 goto NotTamper
	if errorlevel 6 call :CreateBackupDefender
:NotTamper
rem ‚®ббв ­ ў«Ёў Ґ¬ Ї® г¬®«з ­Ёо, Ґб«Ё Ї а ¬Ґва ConsentPromptBehaviorAdmin ­Ґ Ё§¬Ґ­п«бп а ­ҐҐ [ў §­ зҐ­ЁҐ 5 Ї®-г¬®«з ­Ёо]
	if not defined NotChangeUAC reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 5 /f >nul
rem …б«Ё ­Ґв GP - Їа®ЇгбЄ [Home ўҐабЁп]
	if defined NoGP %ch%    {08}Џа®ЇгбЄ ®вЄ«озҐ­Ёп ѓЏ, в.Є. ­Ґ ­ ©¤Ґ­® ѓЏ{\n #}&&goto NotGP
	%ch%    {03} ЋвЄ«оз Ґ¬ § йЁв­ЁЄ [ѓЏ] ^>
rem €­д®а¬ жЁп Ї® Ї®«ЁвЁЄ ¬ : https://learn.microsoft.com/ru-ru/windows/client-management/mdm/policy-csp-admx-microsoftdefenderantivirus
rem ‚лЄ«озЁвм  ­вЁўЁагб­го Їа®Ја ¬¬г Microsoft Defender (ўЄ«озҐ­ ) [DisableAntiSpyware]
rem ђ §аҐиЁвм Ї®бв®п­­го а Ў®вг б«г¦Ўл § йЁвл ®в ўаҐ¤®­®б­ле Їа®Ја ¬¬ (®вЄ«озҐ­ ) [ServiceKeepAlive]
rem ‚лЄ«озЁвм Ї« ­®ў®Ґ ЁбЇа ў«Ґ­ЁҐ (ўЄ«озҐ­®) [DisableRoutinelyTakingAction]
rem ђ §аҐиЁвм § ЇгбЄ б«г¦Ўл § йЁвл ®в ўаҐ¤®­®б­ле Їа®Ја ¬¬ б ®Ўлз­л¬ ЇаЁ®аЁвҐв®¬ (®вЄ«озҐ­®) [AllowFastServiceStartup]
rem ‚лЄ«озЁвм § йЁвг ў аҐ «м­®¬ ўаҐ¬Ґ­Ё (ўЄ«озҐ­®) [DisableRealtimeMonitoring]
rem Џа®ўҐапвм ўбҐ § Јаг¦Ґ­­лҐ д ©«л Ё ў«®¦Ґ­Ёп (®вЄ«озҐ­®) [DisableIOAVProtection]
rem ‚Є«озЁвм ­ Ў«о¤Ґ­ЁҐ §  Ї®ўҐ¤Ґ­ЁҐ¬ (®вЄ«озҐ­®) [DisableBehaviorMonitoring]
rem ‚Є«озЁвм Їа®ўҐаЄг Їа®жҐбб®ў, Ґб«Ё ўЄ«озҐ­  § йЁв  ў аҐ¦Ё¬Ґ аҐ «м­®Ј® ўаҐ¬Ґ­Ё (®вЄ«озҐ­®) [DisableScanOnRealtimeEnable]
rem Ћвб«Ґ¦Ёў вм  ЄвЁў­®бвм Їа®Ја ¬¬ Ё д ©«®ў ­  Є®¬ЇмовҐаҐ (®вЄ«озҐ­®) [DisableOnAccessProtection]
rem Ќ бва®Ёвм «®Є «м­®Ґ ЇҐаҐ®ЇаҐ¤Ґ«Ґ­ЁҐ ¤«п ўЄ«озҐ­Ёп § йЁвл ў аҐ¦Ё¬Ґ аҐ «м­®Ј® ўаҐ¬Ґ­Ё (®вЄ«озҐ­®) [LocalSettingOverrideDisableRealtimeMonitoring]
rem Ќ бва®Ёвм «®Є «м­®Ґ ЇҐаҐ®ЇаҐ¤Ґ«Ґ­ЁҐ ¤«п ўЄ«озҐ­Ёп Є®­ва®«п Ї®ўҐ¤Ґ­Ёп (®вЄ«озҐ­®) [LocalSettingOverrideDisableBehaviorMonitoring]
rem Ќ бва®Ёвм «®Є «м­®Ґ ЇҐаҐ®ЇаҐ¤Ґ«Ґ­ЁҐ ¤«п Їа®ўҐаЄЁ ўбҐе § Јаг¦Ґ­­ле д ©«®ў Ё ў«®¦Ґ­Ё© (®вЄ«озҐ­®) [LocalSettingOverrideDisableIOAVProtection]
rem Ќ бва®Ёвм «®Є «м­®Ґ ЇҐаҐ®ЇаҐ¤Ґ«Ґ­ЁҐ ¤«п ®вЇа ўЄЁ ®взсв®ў ў MAPS (®вЄ«озҐ­®) [LocalSettingOverrideSpynetReporting]
rem ЏаЁб®Ґ¤Ё­Ёвбп Є Microsoft MAPS (®вЄ«озҐ­®) [**del.SpynetReporting]
rem ЋвЇа ў«пвм ®Ўа §жл д ©«®ў, Ґб«Ё ваҐЎгҐвбп ¤ «м­Ґ©иЁ©  ­ «Ё§ (ўЄ«озҐ­®) [SubmitSamplesConsent]
rem ђ §аҐиЁвм ®Ў­®ў«Ґ­Ёп б«г¦Ўл ЎҐ§®Ї б­®бвЁ ў аҐ «м­®¬ ўаҐ¬Ґ­Ё ­  ®б­®ўҐ ®взсв®ў ў Microsoft MAPS (®вЄ«озҐ­®) [RealtimeSignatureDelivery]
rem ‡ ЇгбЄ вм ®Ў­®ў«Ґ­Ёп б«г¦Ўл  ­ «Ё§  ЎҐ§®Ї б­®бвЁ ЇаЁ § ЇгбЄҐ (®вЄ«озҐ­®) [DisableUpdateOnStartupWithoutEngine]
rem Џа®ўҐапвм ­ «ЁзЁҐ Ї®б«Ґ¤­Ґ© ўҐабЁЁ б«г¦Ўл § йЁвл ЇаЁ § ЇгбЄҐ (®вЄ«озҐ­®) [UpdateOnStartUp]
rem ‚Є«озЁвм Їа®ўҐаЄг Ї®б«Ґ ®Ў­®ў«Ґ­Ёп б«г¦Ўл  ­ «Ё§  ЎҐ§®Ї б­®бвЁ (®вЄ«озҐ­®) [DisableScanOnUpdate]
rem Ќ бва®Ёвм б®ЎлвЁп Їа®Ја ¬¬л "„®Єв®а ‚ вб®­" (®вЇа ўЄ  ¤ ­­ле бЎ®айЁЄ®¬ ®иЁЎ®Є) (®вЄ«озҐ­®) [DisableGenericRePorts]
rem ‚Є«озЁвм ¤®Ї®«­ЁвҐ«м­го Їа®ўҐаЄг ¤«п Ї®«­ле/Ўлбвале Їа®ўҐа®Є (®вЄ«озҐ­®) [DisableCatchupFullScan/DisableCatchupQuickScan]
rem Џа®ўҐапвм бкҐ¬­лҐ ­®бЁвҐ«Ё ў® ўаҐ¬п Ўлбва®Ј® бЄ ­Ёа®ў ­Ёп (®вЄ«озҐ­®) [DisableRemovableDriveScanning]
rem Џа®ўҐапвм бҐвҐўлҐ д ©«л (®вЄ«озҐ­®) [DisableScanningNetworkFiles]
rem ‚лЇ®«­пвм Ї®«­го Їа®ўҐаЄг ­  Ї®¤Є«озҐ­­ле бҐвҐўле ¤ЁбЄ е (®вЄ«озҐ­®) [DisableScanningMappedNetworkDrivesForFullScan]
rem Џа®ўҐапвм  аеЁў­лҐ д ©«л (®вЄ«озҐ­®) [DisableArchiveScanning]
rem Ќ бва®Ёвм дг­ЄжЁо SmartScreen ‡ йЁв­ЁЄ  Windows (3 Ї®«ЁвЁЄЁ) (®вЄ«озҐ­л)
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "AllowFastServiceStartup" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableRealtimeMonitoring" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableBehaviorMonitoring" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableIOAVProtection" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Spynet" /v "LocalSettingOverrideSpynetReporting" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Spynet" /v "**del.SpynetReporting" /t REG_SZ /d " " /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d "2" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "RealtimeSignatureDelivery" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableUpdateOnStartupWithoutEngine" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "UpdateOnStartUp" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableScanOnUpdate" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Reporting" /v "DisableGenericRePorts" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableCatchupFullScan" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableCatchupQuickScan" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableRemovableDriveScanning" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableScanningNetworkFiles" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableScanningMappedNetworkDrivesForFullScan" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableArchiveScanning" /t REG_DWORD /d "1" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "**del.ShellSmartScreenLevel" /t REG_SZ /d " " /f
	call :LGPOFILE reg add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d "0" /f
	call :LGPO_APPLY
:NotGP
rem ”®Єгб ­  Їа®Ја ¬¬г
	nircmd win activate process cmd.exe
rem SmartScreen BX
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f >nul
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide cmd.exe /c reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f >nul
rem “ўҐ¤®¬«Ґ­Ёп ®в жҐ­ва  ЎҐ§®Ї б­®бвЁ
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d "0" /f >nul
rem MSRT - ‘аҐ¤бвў® г¤ «Ґ­Ёп ўаҐ¤®­®б­ле Їа®Ја ¬¬ ®в Microsoft. [ЌҐ ®вЇа ў«пвм ®взҐвл ®в MSRT/ЋвЄ«озЁвм Ї®«гзҐ­ЁҐ ®Ў­®ў«Ґ­Ё© ¤«п MSRT]
	reg add "HKLM\Software\Policies\Microsoft\MRT" /v "DontReportInfectionInformation" /t REG_DWORD /d "1" /f >nul
	reg add "HKLM\Software\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /t REG_DWORD /d "1" /f >nul
	)
rem Џа®ЇгбЄ Unlocker; DefenderStop, Ґб«Ё § йЁв­ЁЄ г¦Ґ г¤ «с­
	if not exist "%AllUsersProfile%\Microsoft\Windows Defender" goto NotFuckWD
	if not exist "%SystemDrive%\Program Files\Windows Defender" goto NotFuckWD
rem                                                                   =================================
rem …б«Ё нв® ўв®а п [Ї®ўв®а­ п] Їа®е®¤Є  г¤ «Ґ­Ёп, в® Їа®ЇгбЄ Ґ¬ ¤®Ў ў«Ґ­ЁҐ ў ЁбЄ«озҐ­Ёп
	if not defined RepeatDel (
	%ch%    {03} „®Ў ў«пҐ¬ Unlocker/DefenderStop ў ЁбЄ«озҐ­Ёп{\n #}{\n #}
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide -Wait PowerShell "Add-MpPreference -ExclusionPath '%~dp0Work', '%LocalAppData%\Temp\RarSFX0', '%LocalAppData%\Temp\RarSFX1', '%LocalAppData%\Temp\RarSFX2', '%Temp%\RarSFX0', '%Temp%\RarSFX1', '%Temp%\RarSFX2'" >nul 2>&1)
rem ‡ ўҐаи Ґ¬ Їа®жҐббл ‡ йЁв­ЁЄ 
	nircmd killprocess MpCmdRun.exe
	nircmd killprocess MsMpEng.exe
	nircmd killprocess SecurityHealthSystray.exe
	nircmd killprocess SecurityHealthService.exe
	nircmd killprocess SecurityHealthHost.exe
	nircmd killprocess smartscreen.exe
	nircmd killprocess SgrmBroker.exe
	nircmd killprocess SecHealthUI.exe
	nircmd killprocess uhssvc.exe
	nircmd killprocess NisSrv.exe
	nircmd killprocess MPSigStub.exe
	if not exist DefenderStop.exe (
	ping www.google.nl -n 1 -w 1000 |>nul find /i "TTL=" && curl -g -k -L -# -o "DefenderStop.exe" "https://i.getspace.eu/cloud/s/GXAtGk7qLbHj2CS/download" >nul 2>&1
	) || %ch%    {0c} ЌҐў®§¬®¦­® бЄ з вм DefenderStop/Unlocker. ЌҐв Ї®¤Є«озҐ­Ёп Є Ё­вҐа­Ґвг{\n #}{\n #}&& goto NotFuckWD
	%ch%    {03} €бЇ®«м§гҐ¬ DefenderStop{\n #}{\n #}
	nircmd exec hide DefenderStop.exe
	nircmd wait 3000
	nircmd exec hide DefenderStop.exe
rem                                                                   =================================
	if "%xOS%"=="x86" (
	%ch%    {04} Unlocker ­Ґ а Ў®в Ґв ­  x32 бЁбвҐ¬Ґ.{\n #}
	%ch%    {04} Џ®б«Ґ ЇҐаҐ§ Јаг§ЄЁ ЏЉ ­Ґ®Ўе®¤Ё¬® Ї®ўв®а­®Ґ г¤ «Ґ­ЁҐ.{\n #}
	goto NotFuckWD)
	if not exist FuckDefender.exe curl -g -k -L -# -o "FuckDefender.exe" "https://i.getspace.eu/cloud/s/Eb3sKTfwiamRAnt/download" >nul 2>&1
	%ch%    {0c} ‚лЇ®«­пҐвбп г¤ «Ґ­ЁҐ б Ї®¬®ймо Unlocker{\n #}
	%ch%    {08} ‚аҐ¬п ®¦Ё¤ ­Ёп - 20 бҐЄ.{\n #}{\n #}
rem By XpucT/Vlado/Eject
	start FuckDefender
	timeout /t 3 /nobreak >nul
	qprocess Unlocker.exe >nul 2>&1 && echo >nul || goto NotFuckWD
rem †¤с¬ 20 бҐЄг­¤, Ґб«Ё Unlocker б¬®Ј § ЇгбвЁвмбп
(
	timeout /t 20 /nobreak
	taskkill /f /im Unlocker.exe
	taskkill /f /im FuckDefender.exe
	taskkill /f /im wscript.exe
	nircmd killprocess Unlocker.exe & nircmd killprocess FuckDefender.exe & nircmd killprocess wscript.exe
rem “¤ «пҐ¬ Unlocker Ё ¤а ©ўҐа. ‚®ббв ­®ўЁвбп б ¬, Ґб«Ё ЁбЇ®«м§гҐвбп IObitUnlocker - https://cdn.discordapp.com/attachments/1099332280629084163/1196482117383766138/IObitUnlocker_Test.mp4
	del /q FuckDefender.exe
	sc delete IObitUnlocker
	reg delete HKLM\System\CurrentControlset\Services\IObitUnlocker /f	
) >nul 2>&1
rem                                                                   =================================
:NotFuckWD
	%ch%    {03} “¤ «пҐ¬ Ї ЇЄЁ Ё д ©«л WD{\n #}{\n #}
(
rem ProgramData
	rmdir /s /q "%AllUsersProfile%\Microsoft\Windows Defender"
	rmdir /s /q "%AllUsersProfile%\Microsoft\Windows Defender Advanced Threat Protection"
	rmdir /s /q "%AllUsersProfile%\Microsoft\Windows Security Health"
	rmdir /s /q "%AllUsersProfile%\Microsoft\Storage Health"
rem SystemDrive - Program Files
	rmdir /s /q "%SystemDrive%\Program Files\Windows Defender"
	rmdir /s /q "%SystemDrive%\Program Files\Windows Defender Sleep"
	rmdir /s /q "%SystemDrive%\Program Files\Windows Defender Advanced Threat Protection"
	rmdir /s /q "%SystemDrive%\Program Files\Windows Security"
	rmdir /s /q "%SystemDrive%\Program Files\PCHealthCheck"
	rmdir /s /q "%SystemDrive%\Program Files\Microsoft Update Health Tools"
rem SystemDrive - Program Files 86
	rmdir /s /q "%SystemDrive%\Program Files (x86)\Windows Defender"
	rmdir /s /q "%SystemDrive%\Program Files (x86)\Windows Defender Advanced Threat Protection"
rem Windows
	rmdir /s /q "%SystemRoot%\security\database"
rem Windows - System32
	rmdir /s /q "%SystemRoot%\System32\HealthAttestationClient"
	rmdir /s /q "%SystemRoot%\System32\SecurityHealth"
	rmdir /s /q "%SystemRoot%\System32\WebThreatDefSvc"
	rmdir /s /q "%SystemRoot%\System32\Sgrm"
	rmdir /s /q "%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\Defender"
	rmdir /s /q "%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\DefenderPerformance"
	rmdir /s /q "%SystemRoot%\System32\Tasks_Migrated\Microsoft\Windows\Windows Defender"
	rmdir /s /q "%SystemRoot%\System32\drivers\wd"
rem Windows - SysWOW64
	rmdir /s /q "%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\Modules\Defender"
	rmdir /s /q "%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\Modules\DefenderPerformance"
rem ЏҐаҐЁ¬Ґ­®ў ­ЁҐ д ©«®ў Є®в®алҐ ¬®Јгв ¬Ґи вм г¤ «Ґ­Ёо
	if exist "%AllUsersProfile%\Microsoft\Windows Defender\Platform" (
	for /r "%AllUsersProfile%\Microsoft\Windows Defender\Platform" %%i in ("MpOAV.dll") do ren "%%i" "MpOAV.dll_fuck" >nul 2>&1
	for /r "%AllUsersProfile%\Microsoft\Windows Defender\Platform" %%i in ("MpClient.dll") do ren "%%i" "MpClient.dll_fuck" >nul 2>&1
	for /r "%AllUsersProfile%\Microsoft\Windows Defender\Platform" %%i in ("MsMpEng.exe") do ren "%%i" "MsMpEng.exe_fuck" >nul 2>&1)
	if exist "%SystemDrive%\Program Files\Windows Defender" (
	ren "%SystemDrive%\Program Files\Windows Defender\MpOAV.dll" "MpOAV.dll_fuck" >nul 2>&1
	ren "%SystemDrive%\Program Files\Windows Defender\MpClient.dll" "MpClient.dll_fuck" >nul 2>&1
	ren "%SystemDrive%\Program Files\Windows Defender\MsMpEng.exe" "MsMpEng.exe_fuck" >nul 2>&1)
	ren "%SystemRoot%\System32\SecurityHealthService.exe" "SecurityHealthService.exe_fuck"
	ren "%SystemRoot%\System32\smartscreenps.dll" smartscreenps.dll_fuck
	ren "%SystemRoot%\System32\wscapi.dll" wscapi.dll_fuck
rem WindowsDefenderApplicationGuard.wim
	del /f /q "%SystemRoot%\Containers\WindowsDefenderApplicationGuard.wim"
	del /f /q "%SystemRoot%\Containers\serviced\WindowsDefenderApplicationGuard.wim"
rem “¤ «Ґ­ЁҐ д ©«®ў System32
	del /f /q "%SystemRoot%\System32\SecurityHealthService.exe"
	del /f /q "%SystemRoot%\System32\SecurityHealthService.exe_fuck"
	del /f /q "%SystemRoot%\System32\SecurityHealthSystray.exe"
	del /f /q "%SystemRoot%\System32\SecurityHealthHost.exe"
	del /f /q "%SystemRoot%\System32\SecurityHealthAgent.dll"
	del /f /q "%SystemRoot%\System32\SecurityHealthSSO.dll"
	del /f /q "%SystemRoot%\System32\SecurityHealthProxyStub.dll"
	del /f /q "%SystemRoot%\System32\LogFiles\WMI\RtBackup\EtwRTDefenderApiLogger.etl"
	del /f /q "%SystemRoot%\System32\LogFiles\WMI\RtBackup\EtwRTDefenderAuditLogger.etl"
	del /f /q "%SystemRoot%\System32\smartscreen.dll"
	del /f /q "%SystemRoot%\System32\wscisvif.dll"
	del /f /q "%SystemRoot%\System32\wscproxystub.dll"
	del /f /q "%SystemRoot%\System32\smartscreenps.dll"
	del /f /q "%SystemRoot%\System32\smartscreenps.dll_fuck"
	del /f /q "%SystemRoot%\System32\wscapi.dll"
	del /f /q "%SystemRoot%\System32\wscapi.dll_fuck"
	del /f /q "%SystemRoot%\System32\windowsdefenderapplicationguardcsp.dll"
	del /f /q "%SystemRoot%\System32\wscsvc.dll"
	del /f /q "%SystemRoot%\System32\SecurityHealthCore.dll"
	del /f /q "%SystemRoot%\System32\SecurityHealthSsoUdk.dll"
	del /f /q "%SystemRoot%\System32\SecurityHealthUdk.dll"
rem “¤ «Ґ­ЁҐ SmartScreen.exe
	taskkill /f /im smartscreen.exe
	ren "%SystemRoot%\System32\smartscreen.exe" "smartscreen.exedel"
	del /f /q "%SystemRoot%\System32\smartscreen.exe"
	del /f /q "%SystemRoot%\System32\smartscreen.exedel"
rem “¤ «Ґ­ЁҐ д ©«®ў SysWOW64
	del /f /q "%SystemRoot%\SysWOW64\smartscreen.dll"
	del /f /q "%SystemRoot%\SysWOW64\wscisvif.dll"
	del /f /q "%SystemRoot%\SysWOW64\wscproxystub.dll"
	del /f /q "%SystemRoot%\SysWOW64\smartscreenps.dll"
	del /f /q "%SystemRoot%\SysWOW64\wscapi.dll"
	del /f /q "%SystemRoot%\SysWOW64\windowsdefenderapplicationguardcsp.dll"
) >nul 2>&1
rem                                                                   =================================
	%ch%    {03} “¤ «пҐ¬ б«г¦Ўл{\n #}
	%ch%    {0a} WinDefend, SecurityHealthService, Sense, WdNisSvc, wscsvc, webthreatdefsvc{\n #}
	%ch%    {0a} webthreatdefusersvc{\n #}{\n #}
	if exist DefenderStop.exe nircmd exec hide DefenderStop.exe
(
rem Ћбв ­®ўЄ  б«г¦Ў
	sc stop WinDefend
	sc stop SecurityHealthService
	sc stop Sense
	sc stop WdNisSvc
	sc stop wscsvc
	sc stop SgrmBroker
	sc stop webthreatdefsvc
	sc stop webthreatdefusersvc
	sc stop %serviceswebmask%
rem “¤ «Ґ­ЁҐ б«г¦Ў
	sc delete WinDefend
	sc delete SecurityHealthService
	sc delete Sense
	sc delete WdNisSvc
	sc delete wscsvc
	sc delete SgrmBroker
	sc delete webthreatdefsvc
	sc delete webthreatdefusersvc
	sc delete %serviceswebmask%
	reg delete HKLM\System\ControlSet001\Services\EventLog\System\WinDefend /f 
	reg delete HKLM\System\ControlSet001\Services\SecurityHealthService /f
	reg delete HKLM\System\ControlSet001\Services\Sense /f
	reg delete HKLM\System\ControlSet001\Services\WdNisSvc /f
	reg delete HKLM\System\ControlSet001\Services\WinDefend /f
	reg delete HKLM\System\ControlSet001\Services\wscsvc /f
	reg delete HKLM\System\ControlSet001\Services\SgrmBroker /f
	reg delete HKLM\System\ControlSet001\Services\webthreatdefsvc /f
	reg delete HKLM\System\ControlSet001\Services\webthreatdefusersvc /f
	reg delete HKLM\System\CurrentControlSet\Services\EventLog\System\WinDefend /f
	reg delete HKLM\System\CurrentControlset\Services\SecurityHealthService /f
	reg delete HKLM\System\CurrentControlset\Services\Sense /f
	reg delete HKLM\System\CurrentControlset\Services\WdNisSvc /f
	reg delete HKLM\System\CurrentControlset\Services\WinDefend /f
	reg delete HKLM\System\CurrentControlset\Services\wscsvc /f
	reg delete HKLM\System\CurrentControlset\Services\SgrmBroker /f
	reg delete HKLM\System\CurrentControlset\Services\webthreatdefsvc /f
	reg delete HKLM\System\CurrentControlset\Services\webthreatdefusersvc /f
	del /q DefenderStop.exe
) >nul 2>&1
rem                                                                   =================================
	%ch%    {03} “¤ «пҐ¬ ¤а ©ўҐа {\n #}
	%ch%    {0a} WdNisDrv, WdBoot, WdFilter, SgrmAgent, wtd, MsSecWfp, MsSecFlt, MsSecCore{\n #}{\n #}
(
rem ЋвЄ«озҐ­ЁҐ Ё г¤ «Ґ­ЁҐ ¤а ©ўҐа®ў
	sc stop WdNisDrv
	sc stop WdBoot
	sc stop WdFilter
	sc stop SgrmAgent
	sc stop wtd
	sc stop MsSecWfp
	sc stop MsSecFlt
	sc stop MsSecCore
	sc delete WdNisDrv
	sc delete WdBoot
	sc delete WdFilter
	sc delete SgrmAgent
	sc delete wtd
	sc delete MsSecWfp
	sc delete MsSecFlt
	sc delete MsSecCore
	reg delete "HKLM\System\CurrentControlset\Services\WdNisDrv" /f
	reg delete "HKLM\System\CurrentControlset\Services\WdBoot" /f
	reg delete "HKLM\System\CurrentControlset\Services\WdFilter" /f
	reg delete "HKLM\System\CurrentControlset\Services\SgrmAgent" /f
	reg delete "HKLM\System\CurrentControlset\Services\wtd" /f
	reg delete "HKLM\System\CurrentControlset\Services\MsSecWfp" /f
	reg delete "HKLM\System\CurrentControlset\Services\MsSecFlt" /f
	reg delete "HKLM\System\CurrentControlset\Services\MsSecCore" /f
) >nul 2>&1
rem                                                                   =================================
	%ch%    {03} “¤ «пҐ¬ § ¤ ­Ёп Ё§ Ї« ­Ёа®ўйЁЄ {\n #}
	rmdir /s /q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Windows Defender" >nul 2>&1
	schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /f >nul 2>&1 & %ch% {0a}    Windows Defender Cache Maintenance{\n #}
	schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /f >nul 2>&1 & %ch% {0a}    Windows Defender Cleanup{\n #}
	schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /f >nul 2>&1 & %ch% {0a}    Windows Defender Scheduled Scan{\n #}
	schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Verification" /f >nul 2>&1 & %ch% {0a}    Windows Defender Verification{\n #}
	schtasks /Delete /TN "Microsoft\Windows\AppID\SmartScreenSpecific" >nul 2>&1 & %ch% {0a}    SmartScreenSpecific{\n #}{\n #}
rem                                                                   =================================
(
rem ЋзЁбвЄ  Є®­вҐЄбв­®Ј® ¬Ґ­о
	reg delete "HKCR\*\shellex\ContextMenuHandlers\EPP" /f
	reg delete "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /f
	reg delete "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /f
	reg delete "HKLM\Software\Classes\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved" /v "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
rem “¤ «Ґ­ЁҐ Ё§  ўв®§ ЇгбЄ 
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth" /f
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Defender" /f
rem “¤ «Ґ­ЁҐ Windows Defender Ё§ аҐҐбва 
	reg delete "HKLM\System\CurrentControlset\Control\WMI\Autologger\DefenderApiLogger" /f
	reg delete "HKLM\System\CurrentControlset\Control\WMI\Autologger\DefenderAuditLogger" /f
	reg delete "HKLM\Software\Microsoft\Windows Defender" /f
	reg delete "HKLM\Software\Microsoft\Windows Defender Security Center" /f
	reg delete "HKLM\Software\Microsoft\Windows Advanced Threat Protection" /f
	reg delete "HKLM\Software\Microsoft\Windows Security Health" /f
rem “¤ «Ґ­ЁҐ ­ ¤ЇЁбЁ ў Ї а ¬Ґва е
	reg delete "HKLM\Software\Microsoft\SystemSettings\SettingId\SystemSettings_WindowsDefender_UseWindowsDefender" /f
rem “¤ «Ґ­ЁҐ ¦га­ «®ў б®ЎлвЁ©
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/WHC" /f
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\NIS-Driver-WFP/Diagnostic" /f
) >nul 2>&1
rem                                                                   =================================
rem …б«Ё г¤ «п« бм нв  ўҐвЄ  а ­ҐҐ, Їа®ЇгбЄ Ґ¬ г¤ «Ґ­ЁҐ Ї Ї®Є Ё§ WinSxS
	reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/Operational" >nul 2>&1 && (
	%ch%    {03} “¤ «пҐ¬ Ї ЇЄЁ Ё§ WinSxS{\n #}{\n #}
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%SystemRoot%\WinSxS\*windows-defender*" /S /B /A:D`) do rmdir "%%d" /s /q >nul 2>&1
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%SystemRoot%\WinSxS\*windows-senseclient-service*" /S /B /A:D`) do rmdir "%%d" /s /q >nul 2>&1
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%SystemRoot%\WinSxS\*windows-dynamic-image*" /S /B /A:D`) do rmdir "%%d" /s /q >nul 2>&1
	)
rem ” ©«л Ё§ WinSxS ­Ґ«м§п г¤ «пвм, «®¬ Ґвбп бЄ зЁў ­ЁҐ ®Ў­®ў«Ґ­Ё© Windows!
rem del /q /s %SystemRoot%\WinSxS\*defender* >nul 2>&1
rem “¤ «Ґ­ЁҐ ўҐвЄЁ Ї®б«Ґ г¤ «Ґ­Ёп Ї Ї®Є Ё§ WinSxS , ўлЇ®«­пҐвбп ‘’ђЋѓЋ Ї®б«Ґ г¤ «Ґ­Ёп Ї Ї®Є Ё§ WinSxS зв®Ўл 1 а § г¤ «Ґ­ЁҐ Ї Ї®Є Їа®Ё§®и«®, ­® Ї®б«Ґ¤гойЁҐ г¤ «Ґ­Ёп Їа®ЇгбЄ «®бм
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/Operational" /f >nul 2>&1
rem                                                                   =================================
:SecHealthUI
	VER | FINDSTR /IL "6.3." > NUL && %ch%    {0c} Windows 8.1 ­Ґ ­г¦¤ Ґвбп ў г¤ «Ґ­ЁЁ ЇаЁ«®¦Ґ­Ёп 'ЃҐ§®Ї б­®бвм' Ё 'SmartScreen'{\n #}&&goto FinishDelete
rem Џа®ўҐапҐ¬ б®§¤ ў «бп «Ё ЎҐЄ Ї, Ґб«Ё ¤  - Їа®ЇгбЄ Ґ¬ г¤ «Ґ­ЁҐ ЇаЁ«®¦Ґ­Ё©
	reg query "HKLM\Software\DefenderKiller" >nul 2>&1 && 	%ch%    {0e} Ѓл«® ўлЎа ­® б®§¤ ­ЁҐ аҐ§Ґаў­®© Є®ЇЁЁ, Їа®ЇгбЄ Ґ¬ г¤ «Ґ­ЁҐ ЇаЁ«®¦Ґ­Ё©{\n #}{\n #}&&goto FinishDelete
rem Џа®ўҐаЄ  зҐаҐ§ PS
	rem PowerShell "PowerShell -Command Get-AppxPackage -AllUsers *SecHealth*" | find /i "PackageFullName" >nul
	%ch%    {09} ЃҐ§®Ї б­®бвм Windows{\n #}
	set "NameSecHealth="
rem Џ®«гз Ґ¬ Ё¬п ЇаЁ«®¦Ґ­Ёп ЃҐ§®Ї б­®бвм
	for /F "usebackq delims=" %%n In (`2^>nul reg query "HKU\%SID%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages" /f "*SecHealthUI*" /k^|findstr ^H`) do set NameSecHealth=%%~nxn
	if not defined NameSecHealth %ch%    {02} ЏаЁ«®¦Ґ­ЁҐ ЃҐ§®Ї б­®бвм Windows г¤ «Ґ­®{\n #}{\n #}&goto AppRepSys
	%ch%    {0b} “¤ «пҐ¬ ЇаЁ«®¦Ґ­ЁҐ ЃҐ§®Ї б­®бвм Windows{\n #}
	%ch%    {08} %NameSecHealth%{\n #}{\n #}
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\S-1-5-18\%NameSecHealth%" /f >nul
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\%SID%\%NameSecHealth%" /f >nul
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide -Wait PowerShell "PowerShell -Command Get-AppxPackage -AllUsers *SecHealthUI* | Remove-AppxPackage"	
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\InboxApplications\%NameSecHealth%" /f >nul 2>&1
rem ќвЁ Ї ЇЄЁ ¬®¦­® г¤ «пвм. ‚®ббв ­ ў«Ёў овбп б ¬Ё, Ґб«Ё ў®ббв ­®ўЁвм ЇаЁ«®¦Ґ­ЁҐ ЃҐ§®Ї б­®бвм.
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%ProgramData%\Microsoft\Windows\AppRepository\Packages\*SecHealth*" /S /B /A:D`) Do rmdir "%%d" /s /q
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%LocalAppData%\Packages\*SecHealth*" /S /B /A:D`) Do rmdir "%%d" /s /q
rem                                                                   =================================
:AppRepSys
	%ch%    {09} SmartScreen § йЁв­ЁЄ  Windows{\n #}
	set "NameAppRep="
rem Џ®«гз Ґ¬ Ё¬п ЇаЁ«®¦Ґ­Ёп AppRep
	for /F "usebackq delims=" %%n In (`2^>nul reg query "HKU\%SID%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages" /f "*Apprep.ChxApp*" /k^|findstr ^H`) do set NameAppRep=%%~nxn
	if not defined NameAppRep %ch%    {02} ЏаЁ«®¦Ґ­ЁҐ SmartScreen § йЁв­ЁЄ  Windows г¤ «Ґ­®{\n #}&goto FinishDelete
	%ch%    {0b} “¤ «пҐ¬ ЇаЁ«®¦Ґ­ЁҐ SmartScreen § йЁв­ЁЄ  Windows{\n #}
	%ch%    {08} %NameAppRep%{\n #}
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\S-1-5-18\%NameAppRep%" /f >nul
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\%SID%\%NameAppRep%" /f >nul
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide -Wait PowerShell "PowerShell -Command Get-AppxPackage -AllUsers *Apprep.ChxApp* | Remove-AppxPackage"	
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\InboxApplications\%NameAppRep%" /f >nul 2>&1
rem ќвЁ Ї ЇЄЁ ¬®¦­® г¤ «пвм, ў®ббв ­ ў«Ёў овбп б ¬Ё, Ґб«Ё ў®ббв ­®ўЁвм ЇаЁ«®¦Ґ­ЁҐ Apprep.ChxApp
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%ProgramData%\Microsoft\Windows\AppRepository\Packages\*Apprep.ChxApp*" /S /B /A:D`) Do rmdir "%%d" /s /q
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%LocalAppData%\Packages\*Apprep.ChxApp*" /S /B /A:D`) Do rmdir "%%d" /s /q
rem                                                                   =================================
:FinishDelete
rem Ћбў®Ў®¦¤с­­®Ґ ¬Ґбв® ­  ¤ЁбЄҐ
	for /f "usebackq tokens=2 delims==" %%i in (`wmic.exe LogicalDisk where "Name='c:'" get FreeSpace /value`) do set sFreeSize=%%i
	if defined sFreeSize (set sFreeSizePseudoMb1=%sFreeSize:~0,-7%)
	set /a Freed=%sFreeSizePseudoMb1% - %sFreeSizePseudoMb%
	echo.
	%ch%    {06} %Freed% ЊҐЈ Ў ©в ¬Ґбв  ®бў®Ў®¦¤Ґ­® Ї®б«Ґ г¤ «Ґ­Ёп{\n #}
	if not exist "%AllUsersProfile%\Microsoft\Windows Defender" (
	%ch%    {02} ‡ йЁв­ЁЄ Windows г¤ «Ґ­{\n #}{\n #}
	%ch%    {08} ЋаЁҐ­вЁаг©вҐбм ­  б®бв®п­ЁҐ Ї Ї®Є [2]{\n #}   {08} …б«Ё зв®-в® ®бв «®бм, ЇҐаҐ§ Јаг§ЁвҐ ЏЉ Ё Ї®ўв®аЁвҐ г¤ «Ґ­ЁҐ{\n #}
	%ch%    {08} Ќ ¦¬ЁвҐ «оЎго Є« ўЁиг ¤«п Їа®¤®«¦Ґ­Ёп{\n #}{\n #}
	) else (
	echo.
	nhmb "‡ йЁв­ЁЄ Windows Ќ… г¤ «Ґ­.\nЏ®ўв®аЁвм г¤ «Ґ­ЁҐ § йЁв­ЁЄ ?\n\n…б«Ё Ї®б«Ґ ­ҐбЄ®«мЄЁе Ї®Їлв®Є г¤ «Ґ­Ёп § йЁв­ЁЄ ­Ґ г¤ «пҐвбп Ё Ї®пў«пҐвбп нв® б®®ЎйҐ­ЁҐ, ўлЇ®«­ЁвҐ ЇҐаҐ§ Јаг§Єг Є®¬ЇмовҐа  Ё Ї®ўв®аЁвҐ Ї®ЇлвЄг г¤ «Ґ­Ёп." "DK" "Information|YesNo"
	if errorlevel 7 cls && goto Start
	if errorlevel 6 cls && set "RepeatDel=Yes" && goto DeleteDefender
	)
rem                                                                   =================================
:Catalogs
rem ђ §¬Ґа ®Є­  ў § ўЁбЁ¬®бвЁ ®в ­ «ЁзЁп б«г¦Ўл
	if defined serviceswebmask (Mode 82,45) else (Mode 80,45)
	%ch% {3f}%SystemRoot%\System32{\n #}
rem 14.03.23
	if not exist "%SystemRoot%\System32\HealthAttestationClient" (%ch% {0a} %SystemRoot%\System32\HealthAttestationClient{\n #}) else (%ch%  {0c}%SystemRoot%\System32\HealthAttestationClient{\n #})
	if not exist "%SystemRoot%\System32\SecurityHealth" (%ch% {0a} %SystemRoot%\System32\SecurityHealth{\n #}) else (%ch%  {0c}%SystemRoot%\System32\SecurityHealth{\n #})
	if not exist "%SystemRoot%\System32\WebThreatDefSvc" (%ch% {0a} %SystemRoot%\System32\WebThreatDefSvc{\n #}) else (%ch%  {0c}%SystemRoot%\System32\WebThreatDefSvc{\n #})
	if not exist "%SystemRoot%\System32\Sgrm" (%ch% {0a} %SystemRoot%\System32\Sgrm{\n #}) else (%ch%  {0c}%SystemRoot%\System32\Sgrm{\n #})
	if not exist "%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\Defender" (%ch% {0a} %SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\Defender{\n #}) else (%ch%  {0c}%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\Defender{\n #})
	if not exist "%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\DefenderPerformance" (%ch% {0a} %SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\DefenderPerformance{\n #}) else (%ch%  {0c}%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\DefenderPerformance{\n #})
	if not exist "%SystemRoot%\System32\Tasks_Migrated\Microsoft\Windows\Windows Defender" (%ch% {0a} %SystemRoot%\System32\Tasks_Migrated\Microsoft\Windows\Windows Defender{\n #}) else (%ch%  {0c}%SystemRoot%\System32\Tasks_Migrated\Microsoft\Windows\Windows Defender{\n #})
	echo.
	%ch% {3f}C:\Program Files{\n #}
	if not exist "%SystemDrive%\Program Files\Windows Defender" (%ch% {0a} C:\Program Files\Windows Defender {08}- ®б­®ў­ п Ї ЇЄ  § йЁв­ЁЄ  1{\n #}) else (%ch%  {4f}C:\Program Files\Windows Defender{08} - ®б­®ў­ п Ї ЇЄ  § йЁв­ЁЄ  1{\n #})
	if not exist "%SystemDrive%\Program Files\Windows Defender Sleep" (%ch% {0a} C:\Program Files\Windows Defender Sleep {\n #}) else (%ch%  {4f}C:\Program Files\Windows Defender Sleep{\n #})
	if not exist "%SystemDrive%\Program Files\Windows Defender Advanced Threat Protection" (%ch% {0a} C:\Program Files\Windows Defender Advanced Threat Protection{\n #}) else (%ch%  {0c}C:\Program Files\Windows Defender Advanced Threat Protection{\n #})
	if not exist "%SystemDrive%\Program Files\Windows Security" (%ch% {0a} C:\Program Files\Windows Security{\n #}) else (%ch%  {0c}C:\Program Files\Windows Security{\n #})
	if not exist "%SystemDrive%\Program Files\PCHealthCheck" (%ch% {0a} C:\Program Files\PCHealthCheck{\n #}) else (%ch%  {0c}C:\Program Files\PCHealthCheck{\n #})
	if not exist "%SystemDrive%\Program Files\Microsoft Update Health Tools" (%ch% {0a} C:\Program Files\Microsoft Update Health Tools{\n #}) else (%ch%  {0c}C:\Program Files\Microsoft Update Health Tools{\n #})
	echo.
	%ch% {3f}C:\Program Files (^x86^){\n #}
	if not exist "%ProgramFiles(x86)%\Windows Defender" (%ch% {0a} C:\Program Files (^x86^)\Windows Defender{\n #}) else (%ch%  {0c}C:\Program Files (^x86^)\Windows Defender{\n #})
	if not exist "%ProgramFiles(x86)%\Windows Defender Advanced Threat Protection" (%ch% {0a} C:\Program Files (^x86^)\Windows Defender Advanced Threat Protection{\n #}) else (%ch%  {0c}C:\Program Files (^x86^)\Windows Defender Advanced Threat Protection{\n #})
	echo.
	%ch% {3f}C:\ProgramData{\n #}
	if not exist "%AllUsersProfile%\Microsoft\Windows Defender" (%ch% {0a} C:\ProgramData\Microsoft\Windows Defender {08}- ®б­®ў­ п Ї ЇЄ  § йЁв­ЁЄ  2{\n #}) else (%ch%  {4f}C:\ProgramData\Microsoft\Windows Defender{08} - ®б­®ў­ п Ї ЇЄ  § йЁв­ЁЄ  2{\n #})
	if not exist "%AllUsersProfile%\Microsoft\Windows Defender Advanced Threat Protection" (%ch% {0a} C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection{\n #}) else (%ch%  {0c}C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection{\n #})
	if not exist "%AllUsersProfile%\Microsoft\Windows Security Health" (%ch% {0a} C:\ProgramData\Microsoft\Windows Security Health{\n #}) else (%ch%  {0c}C:\ProgramData\Microsoft\Windows Security Health{\n #})
	if not exist "%AllUsersProfile%\Microsoft\Storage Health" (%ch% {0a} C:\ProgramData\Microsoft\Storage Health{\n #}) else (%ch%  {0c}C:\ProgramData\Microsoft\Storage Health{\n #})
	echo.
	%ch% {3f}Џ ЇЄ  § ¤ з Ї« ­Ёа®ўйЁЄ  § йЁв­ЁЄ {\n #}
	if not exist "%SYSTEMROOT%\System32\Tasks\Microsoft\Windows\Windows Defender" (%ch% {0a} C:\Windows\System32\Tasks\Microsoft\Windows\Windows Defender{\n #}) else (%ch%  {0c}C:\Windows\System32\Tasks\Microsoft\Windows\Windows Defender{\n #})
	echo.
	%ch% {3f}Ћбв «м­лҐ д ©«л{\n #}
	if not exist "%SystemRoot%\Containers\WindowsDefenderApplicationGuard.wim" (%ch% {0a} C:\Windows\Containers\WindowsDefenderApplicationGuard.wim{\n #}) else (%ch%  {0c}C:\Windows\Containers\WindowsDefenderApplicationGuard.wim{\n #})
	if not exist "%SystemRoot%\Containers\serviced\WindowsDefenderApplicationGuard.wim" (%ch% {0a} C:\Windows\Containers\serviced\WindowsDefenderApplicationGuard.wim{\n #}) else (%ch%  {0c}C:\Windows\Containers\serviced\WindowsDefenderApplicationGuard.wim{\n #})
	echo.
	if not exist "%SystemRoot%\System32\SecurityHealthService.exe" (%ch% {02} SecurityHealthService.exe{#} ^| ) else (%ch% {0c} SecurityHealthService.exe {#}^| )
	if not exist "%SystemRoot%\System32\SecurityHealthSystray.exe" (%ch% {02}SecurityHealthSystray.exe{#} ^| ) else (%ch% {0c}SecurityHealthSystray.exe {#}^| )
	if not exist "%SystemRoot%\System32\SecurityHealthHost.exe" (%ch% {02}SecurityHealthHost.exe{\n #}) else (%ch% {0c}SecurityHealthHost.exe{\n #})
	if not exist "%SystemRoot%\System32\SecurityHealthAgent.dll" (%ch% {02} SecurityHealthAgent.dll{#} ^| ) else (%ch% {0c} SecurityHealthAgent.dll{#} ^| )
	if not exist "%SystemRoot%\System32\SecurityHealthSSO.dll" (%ch% {02}SecurityHealthSSO.dll{#} ^| ) else (%ch% {0c}SecurityHealthSSO.dll{#} ^| )
	if not exist "%SystemRoot%\System32\SecurityHealthProxyStub.dll" (%ch% {02}SecurityHealthProxyStub.dll{\n #}) else (%ch% {0c}SecurityHealthProxyStub.dll{\n #})
	if not exist "%SystemRoot%\System32\smartscreen.dll" (%ch% {02} smartscreen.dll{#} ^| ) else (%ch% {0c} smartscreen.dll{#} ^| )
	if not exist "%SystemRoot%\System32\wscisvif.dll" (%ch% {02}wscisvif.dll{#} ^| ) else (%ch% {0c}wscisvif.dll{#} ^| )
	if not exist "%SystemRoot%\System32\wscproxystub.dll" (%ch% {02}wscproxystub.dll{#} ^| ) else (%ch% {0c}wscproxystub.dll{#} ^| )
	if not exist "%SystemRoot%\System32\smartscreenps.dll" (%ch% {02}smartscreenps.dll{\n #}) else (%ch% {0c}smartscreenps.dll{\n #})
	if not exist "%SystemRoot%\System32\wscapi.dll" (%ch% {02} wscapi.dll{#} ^| ) else (%ch% {0c} wscapi.dll{#} ^| )
	if not exist "%SystemRoot%\System32\windowsdefenderapplicationguardcsp.dll" (%ch% {02} windowsdefenderapplicationguardcsp.dll{#} ^| ) else (%ch% {0c} windowsdefenderapplicationguardcsp.dll{#} ^| )
	if not exist "%SystemRoot%\System32\wscsvc.dll" (%ch% {02}wscsvc.dll{\n #}) else (%ch% {0c}wscsvc.dll{\n #})
	if not exist "%SystemRoot%\System32\SecurityHealthCore.dll"  (%ch% {02} SecurityHealthCore.dll{\n #}) else (%ch% {0c} SecurityHealthCore.dll{\n #})
	if not exist "%SystemRoot%\System32\SecurityHealthSsoUdk.dll"  (%ch% {02} SecurityHealthSsoUdk.dll{\n #}) else (%ch% {0c} SecurityHealthSsoUdk.dll{\n #})
	if not exist "%SystemRoot%\System32\SecurityHealthUdk.dll" (%ch% {02} SecurityHealthUdk.dll{\n #}) else (%ch% {0c} SecurityHealthUdk.dll{\n #})
	if not exist "%SystemRoot%\System32\SecurityHealthAgent.dll"  (%ch% {02} SecurityHealthAgent.dll{\n #}) else (%ch% {0c} SecurityHealthAgent.dll{\n #})
rem                                                                   =================================
:CreateBackupDefender
rem Џа®ўҐапҐ¬ ­ «ЁзЁҐ Ё­вҐа­Ґв , зв®Ўл ЁбЇ®«м§®ў вм DefenderStop ЇҐаҐ¤ б®§¤ ­ЁҐ¬ аҐ§Ґаў­®© Є®ЇЁЁ [­г¦Ґ­, в.Є. ЎҐ§ ­ҐЈ® ­Ґ Є®ЇЁагҐвбп Ї ЇЄ  § йЁв­ЁЄ , Ё§-§  ўЄ«озс­­ле б«г¦Ў]
	if not exist DefenderStop.exe (
	ping www.google.nl -n 1 -w 1000 |>nul find /i "TTL=" && curl -g -k -L -# -o "DefenderStop.exe" "https://i.getspace.eu/cloud/s/GXAtGk7qLbHj2CS/download" >nul 2>&1
	) || (
	%ch%    {0c} ЌҐў®§¬®¦­® б®§¤ вм аҐ§Ґаў­го Є®ЇЁо, ­Ґв Ї®¤Є«озҐ­Ёп Є Ё­вҐа­Ґвг{\n #}
	%ch%    {0c} ЌҐў®§¬®¦­® бЄ з вм DefenderStop{\n #}{\n #}
	%ch%    {08} https://i.getspace.eu/cloud/s/GXAtGk7qLbHj2CS/download{\n #}
rem €бЇ®«м§гҐ¬ ­ҐбЄ®«мЄ® а § ¤«п гўҐаҐ­­®бвЁ ўлЇ®«­Ґ­Ёп
	%ch%    {03} €бЇ®«м§гҐ¬ DefenderStop ¤«п ®вЄ«озҐ­Ёп б«г¦Ў § йЁв­ЁЄ {\n #}{\n #}
	nircmd exec hide DefenderStop.exe
	nircmd wait 3000
	nircmd exec hide DefenderStop.exe
	nircmd exec hide DefenderStop.exe
	%ch%    {02} ‘®§¤ с¬ аҐ§Ґаў­го Є®ЇЁо Ї Ї®Є Ё§ %AllUsersProfile%{\n #}
(
    xcopy /s /e /h /y /i "%AllUsersProfile%\Microsoft\Windows Defender" "%SystemDrive%\WDefenderBackup\Folder\ProgramData\Microsoft\Windows Defender"
    xcopy /s /e /h /y /i "%AllUsersProfile%\Microsoft\Windows Defender Advanced Threat Protection" "%SystemDrive%\WDefenderBackup\Folder\ProgramData\Microsoft\Windows Defender Advanced Threat Protection"
    xcopy /s /e /h /y /i "%AllUsersProfile%\Microsoft\Windows Security Health" "%SystemDrive%\WDefenderBackup\Folder\ProgramData\Microsoft\Windows Security Health"
    xcopy /s /e /h /y /i "%AllUsersProfile%\Microsoft\Storage Health" "%SystemDrive%\WDefenderBackup\Folder\ProgramData\Microsoft\Storage Health"
) >nul 2>&1
rem Џа®ўҐаЄ  Ї®б«Ґ Є®ЇЁа®ў ­Ёп Ј« ў­®© Ї ЇЄЁ, бЄ®ЇЁа®ў « бм «Ё ...
	dir /b "%SystemDrive%\WDefenderBackup\Folder\ProgramData\Microsoft\Windows Defender" | findstr /r "^" >nul && (
	echo >nul
	) || (
	%ch% {04} Џ ЇЄг "%AllUsersProfile%\Microsoft\Windows Defender" бЄ®ЇЁа®ў вм ­Ґ г¤ «®бм{\n #}
	%ch% {04} ’ Є®Ґ ў®§¬®¦­®, Ґб«Ё г ‚ б ­Ґ ®ва Ў®в « DefenderStop Ё ­Ґ ®вЄ«озЁ«Ёбм б«г¦Ўл § йЁв­ЁЄ {\n #}
	%ch% {04} ‚л ЁбЇ®«м§гҐвҐ «ЁЎ® Win 11 Dev/Beta ўҐабЁо, «ЁЎ® Microsoft зв®-в® Ё§¬Ґ­Ё« {\n #}{\n #}
	%ch% {08} Џ®Їа®Ўг©вҐ ҐйҐ а § Ї®ўв®аЁвм Ї®ЇлвЄг...{\n #}
	rd /s /q "%SystemDrive%\WDefenderBackup" >nul 2>&1
	cls && goto Start
	)
	%ch%    {02} ‘®§¤ с¬ аҐ§Ґаў­го Є®ЇЁо Ї Ї®Є Ё§ %ProgramFiles% Ё %ProgramFiles(x86)%{\n #}
(
rem ‘®§¤ с¬ а §¤Ґ« ў аҐҐбваҐ Ї® Є®в®а®¬г Ўг¤Ґ¬ Їа®ўҐапвм, зв® аҐ§Ґаў­ п Є®ЇЁп б®§¤ ­ . ’аҐЎгҐвбп ¤«п Їа®ЇгбЄ  г¤ «Ґ­Ёп SysApps [ЃҐ§®Ї б­®бвм/AppRep]
	reg add "HKLM\Software\DefenderKiller" /f
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files\Windows Defender" "%SystemDrive%\WDefenderBackup\Folder\Program Files\Windows Defender"
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files\Windows Defender Sleep" "%SystemDrive%\WDefenderBackup\Folder\Program Files\Windows Defender Sleep"
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files\Windows Defender Advanced Threat Protection" "%SystemDrive%\WDefenderBackup\Folder\Program Files\Windows Defender Advanced Threat Protection"
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files\Windows Security" "%SystemDrive%\WDefenderBackup\Folder\Program Files\Windows Security"
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files\PCHealthCheck" "%SystemDrive%\WDefenderBackup\Folder\Program Files\PCHealthCheck"
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files\Microsoft Update Health Tools" "%SystemDrive%\WDefenderBackup\Folder\Program Files\Microsoft Update Health Tools"
rem ProgramFiles X86	
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files (x86)\Windows Defender" "%SystemDrive%\WDefenderBackup\Folder\Program Files (x86)\Windows Defender"
    xcopy /s /e /h /y /i "%SystemDrive%\Program Files (x86)\Windows Defender Advanced Threat Protection" "%SystemDrive%\WDefenderBackup\Folder\Program Files (x86)\Windows Defender Advanced Threat Protection"
) >nul 2>&1
	%ch%    {02} ‘®§¤ с¬ аҐ§Ґаў­го Є®ЇЁо Ї Ї®Є Ё§ System32 Ё SysWOW64{\n #}
(
rem Windows - System32
    xcopy /s /e /h /y /i "%SystemRoot%\security\database" "%SystemDrive%\WDefenderBackup\Folder\Windows\security\database"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\HealthAttestationClient" "%SystemDrive%\WDefenderBackup\Folder\System32\HealthAttestationClient"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\SecurityHealth" "%SystemDrive%\WDefenderBackup\Folder\System32\SecurityHealth"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\WebThreatDefSvc" "%SystemDrive%\WDefenderBackup\Folder\System32\WebThreatDefSvc"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\Sgrm" "%SystemDrive%\WDefenderBackup\Folder\System32\Sgrm"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\Defender" "%SystemDrive%\WDefenderBackup\Folder\System32\WindowsPowerShell\v1.0\Modules\Defender"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\WindowsPowerShell\v1.0\Modules\DefenderPerformance" "%SystemDrive%\WDefenderBackup\Folder\System32\WindowsPowerShell\v1.0\Modules\DefenderPerformance"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\Tasks_Migrated\Microsoft\Windows\Windows Defender" "%SystemDrive%\WDefenderBackup\Folder\System32\Tasks_Migrated\Microsoft\Windows\Windows Defender"
    xcopy /s /e /h /y /i "%SystemRoot%\System32\drivers\wd" "%SystemDrive%\WDefenderBackup\Folder\System32\drivers\wd"
rem ‡ ¤ зЁ § йЁв­ЁЄ 
	xcopy /s /e /h /y /i "%SystemRoot%\System32\Tasks\Microsoft\Windows\Windows Defender" "%SystemDrive%\WDefenderBackup\Folder\System32\Tasks\Microsoft\Windows\Windows Defender"
rem SysWOW64
    xcopy /s /e /h /y /i "%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\Modules\Defender" "%SystemDrive%\WDefenderBackup\Folder\SysWOW64\WindowsPowerShell\v1.0\Modules\Defender"
    xcopy /s /e /h /y /i "%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\Modules\DefenderPerformance" "%SystemDrive%\WDefenderBackup\Folder\SysWOW64\WindowsPowerShell\v1.0\Modules\DefenderPerformance"
) >nul 2>&1
	%ch%    {02} ‘®§¤ с¬ аҐ§Ґаў­го Є®ЇЁо д ©«®ў Ё§ System32 Ё SysWOW64{\n #}
(
	md "%SystemDrive%\WDefenderBackup\Files"
	md "%SystemDrive%\WDefenderBackup\Files\System32"
	md "%SystemDrive%\WDefenderBackup\Files\SysWOW64"
	md "%SystemDrive%\WDefenderBackup\Files\Windows\Containers"
	md "%SystemDrive%\WDefenderBackup\Files\Windows\Containers\serviced"
rem Љ®ЇЁа®ў ­ЁҐ д ©«®ў Ё§ System32
	copy /Y "%SystemRoot%\System32\SecurityHealthService.exe" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthSystray.exe" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthHost.exe" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthAgent.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthSSO.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthProxyStub.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\LogFiles\WMI\RtBackup\EtwRTDefenderApiLogger.etl" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\LogFiles\WMI\RtBackup\EtwRTDefenderAuditLogger.etl" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\smartscreen.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\wscisvif.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\wscproxystub.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\smartscreenps.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\wscapi.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\windowsdefenderapplicationguardcsp.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\wscsvc.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthCore.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthSsoUdk.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\SecurityHealthUdk.dll" "%SystemDrive%\WDefenderBackup\Files\System32\"
	copy /Y "%SystemRoot%\System32\smartscreen.exe" "%SystemDrive%\WDefenderBackup\Files\System32\"
rem Љ®ЇЁа®ў ­ЁҐ д ©«®ў Ё§ SysWow64
	copy /Y "%SystemRoot%\SysWOW64\smartscreen.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\SysWOW64\wscisvif.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\SysWOW64\wscproxystub.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\SysWOW64\smartscreenps.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\SysWOW64\wscapi.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\SysWOW64\windowsdefenderapplicationguardcsp.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\Containers\WindowsDefenderApplicationGuard.wim" "%SystemDrive%\WDefenderBackup\Files\Windows\Containers\"
	copy /Y "%SystemRoot%\Containers\serviced\WindowsDefenderApplicationGuard.wim" "%SystemDrive%\WDefenderBackup\Files\Windows\Containers\serviced"
) >nul 2>&1
	%ch%    {02} ‘®§¤ с¬ аҐ§Ґаў­го Є®ЇЁо Ї Ї®Є Ё§ WinSxS{\n #}
(
	md "%SystemDrive%\WDefenderBackup\Folder\WinSxS"
	for /d %%i in ("%SystemRoot%\WinSxS\*windows-defender*") do xcopy "%%i" "%SystemDrive%\WDefenderBackup\Folder\WinSxS\%%~nxi" /I /E /H /Y
	for /d %%i in ("%SystemRoot%\WinSxS\*windows-senseclient-service*") do xcopy "%%i" "%SystemDrive%\WDefenderBackup\Folder\WinSxS\%%~nxi" /I /E /H /Y
	for /d %%i in ("%SystemRoot%\WinSxS\*windows-dynamic-image*") do xcopy "%%i" "%SystemDrive%\WDefenderBackup\Folder\WinSxS\%%~nxi" /I /E /H /Y
) >nul 2>&1
	md "%SystemDrive%\WDefenderBackup\ServicesDrivers"
	md "%SystemDrive%\WDefenderBackup\RegEdit"
	set "PathServDrive=%SystemDrive%\WDefenderBackup\ServicesDrivers"
	set "PathRegedit=%SystemDrive%\WDefenderBackup\RegEdit"
(	
rem ‘«г¦Ўл
	reg export "HKLM\System\CurrentControlSet\Services\EventLog\System\WinDefend" "%PathServDrive%\WinDefendEvent.reg"
	reg export "HKLM\System\CurrentControlSet\Services\SecurityHealthService" "%PathServDrive%\SecurityHealthService.reg"
	reg export "HKLM\System\CurrentControlSet\Services\Sense" "%PathServDrive%\Sense.reg"
	reg export "HKLM\System\CurrentControlSet\Services\WdNisSvc" "%PathServDrive%\WdNisSvc.reg"
	reg export "HKLM\System\CurrentControlSet\Services\WinDefend" "%PathServDrive%\WinDefend.reg"
	reg export "HKLM\System\CurrentControlSet\Services\wscsvc" "%PathServDrive%\wscsvc.reg"
	reg export "HKLM\System\CurrentControlSet\Services\SgrmBroker" "%PathServDrive%\SgrmBroker.reg"
	reg export "HKLM\System\CurrentControlSet\Services\webthreatdefsvc" "%PathServDrive%\webthreatdefsvc.reg"
	reg export "HKLM\System\CurrentControlSet\Services\webthreatdefusersvc" "%PathServDrive%\webthreatdefusersvc.reg"
rem „а ©ўҐа 
	reg export "HKLM\System\CurrentControlSet\Services\WdNisDrv" "%PathServDrive%\WdNisDrv.reg"
	reg export "HKLM\System\CurrentControlSet\Services\WdBoot" "%PathServDrive%\WdBoot.reg"
	reg export "HKLM\System\CurrentControlSet\Services\WdFilter" "%PathServDrive%\WdFilter.reg"
	reg export "HKLM\System\CurrentControlSet\Services\SgrmAgent" "%PathServDrive%\SgrmAgent.reg"
	reg export "HKLM\System\CurrentControlSet\Services\wtd" "%PathServDrive%\wtd.reg"
	reg export "HKLM\System\CurrentControlSet\Services\MsSecWfp" "%PathServDrive%\MsSecWfp.reg"
	reg export "HKLM\System\CurrentControlSet\Services\MsSecFlt" "%PathServDrive%\MsSecFlt.reg"
	reg export "HKLM\System\CurrentControlSet\Services\MsSecCore" "%PathServDrive%\MsSecCore.reg"
rem ќЄбЇ®ав ўҐв®Є аҐҐбва 
	reg export "HKCR\*\shellex\ContextMenuHandlers\EPP" "%PathRegedit%\1.reg"
	reg export "HKCR\Directory\shellex\ContextMenuHandlers\EPP" "%PathRegedit%\2.reg"
	reg export "HKCR\Drive\shellex\ContextMenuHandlers\EPP" "%PathRegedit%\3.reg"
	reg export "HKLM\Software\Classes\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}" "%PathRegedit%\4.reg"
	reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved" "%PathRegedit%\5.reg"
	reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" "%PathRegedit%\6.reg"
	reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" "%PathRegedit%\7.reg"
	reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Defender" "%PathRegedit%\8.reg"
	reg export "HKLM\System\CurrentControlset\Control\WMI\Autologger\DefenderApiLogger" "%PathRegedit%\9.reg"
	reg export "HKLM\System\CurrentControlset\Control\WMI\Autologger\DefenderAuditLogger" "%PathRegedit%\10.reg"
	reg export "HKLM\Software\Microsoft\Windows Defender" "%PathRegedit%\11.reg"
	reg export "HKLM\Software\Microsoft\Windows Defender Security Center" "%PathRegedit%\12.reg"
	reg export "HKLM\Software\Microsoft\Windows Advanced Threat Protection" "%PathRegedit%\13.reg"
	reg export "HKLM\Software\Microsoft\Windows Security Health" "%PathRegedit%\14.reg"
	reg export "HKLM\Software\Microsoft\SystemSettings\SettingId\SystemSettings_WindowsDefender_UseWindowsDefender" "%PathRegedit%\15.reg"
	reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/Operational" "%PathRegedit%\16.reg"
	reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/WHC" "%PathRegedit%\17.reg"
	reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\NIS-Driver-WFP/Diagnostic" "%PathRegedit%\18.reg"
) >nul 2>&1
	%ch%    {08} ђҐ§Ґаў­ п Є®ЇЁп б®§¤ ­  ў {0b}%SystemDrive%\WDefenderBackup{\n #}{\n #}
:RestoreDefender
rem „«п Є®ааҐЄв­®Ј® ®в®Ўа ¦Ґ­Ёп ¤Ё «®Ј®ў®Ј® ®Є­ , в.Є. Їа®Ја ¬¬  § ЇгйҐ­  ®в TI
	if not exist "%SystemRoot%\System32\config\systemprofile\Desktop" md "%SystemRoot%\System32\config\systemprofile\Desktop"
	set "BackupFolder="
	for /f %%A in ('powershell -c "(New-Object -COM 'Shell.Application').BrowseForFolder(0, '‚лЎҐаЁвҐ Ї ЇЄг б а ­ҐҐ б®§¤ ­­®© аҐ§Ґаў­®© Є®ЇЁҐ© Windows Defender', 0, 0).Self.Path"') do set "BackupFolder=%%A"
	echo.
	if not defined BackupFolder cls && goto Start
	if not exist "%BackupFolder%\Folder" %ch%    {04} ЌҐўҐа­ п аҐ§Ґаў­ п Є®ЇЁп. ‚лЎҐаЁвҐ Їа ўЁ«м­го аҐ§Ґаў­го Є®ЇЁо{\n #}&&timeout /t 3 >nul && cls && goto RestoreDefender
	if not exist "%BackupFolder%\ServicesDrivers" %ch%    {04} ЌҐўҐа­ п аҐ§Ґаў­ п Є®ЇЁп. ‚лЎҐаЁвҐ Їа ўЁ«м­го аҐ§Ґаў­го Є®ЇЁо{\n #}&&timeout /t 3 >nul && cls && goto RestoreDefender
rem ‡ ¤ с¬ ў®Їа®б ® ў®ббв ­®ў«Ґ­ЁЁ § йЁв­ЁЄ 
	%ch% {0f} ђҐ§Ґаў­ п Є®ЇЁп ўлЎа ­  - {04}%BackupFolder%{\n #}
	echo  1 - ‚®ббв ­®ўЁвм § йЁв­ЁЄ
	echo  2 - Ћв¬Ґ­  
	choice /c 12 /n /m " "
	if errorlevel 2 cls && goto Start
rem ‚®ббв ­®ў«Ґ­ЁҐ Ї®«ЁвЁЄ
	if not defined NoGP (
	%ch% {03} ‚®ббв ­®ў«Ґ­ЁҐ ЈагЇЇ®ўле Ї®«ЁвЁЄ{\n #}
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender" /v "AllowFastServiceStartup" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableRealtimeMonitoring" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableBehaviorMonitoring" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableIOAVProtection" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Spynet" /v "LocalSettingOverrideSpynetReporting" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Spynet" /v "**del.SpynetReporting" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Spynet" /v "**del.SubmitSamplesConsent" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "RealtimeSignatureDelivery" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableUpdateOnStartupWithoutEngine" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "UpdateOnStartUp" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableScanOnUpdate" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Reporting" /v "DisableGenericRePorts" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableCatchupFullScan" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableCatchupQuickScan" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableRemovableDriveScanning" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableScanningNetworkFiles" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableScanningMappedNetworkDrivesForFullScan" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Scan" /v "DisableArchiveScanning" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\Windows\System" /v "**del.ShellSmartScreenLevel" /f
	call :LGPOFILE reg delete "HKLM\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /f
	nircmd win activate process cmd.exe
	call :LGPO_APPLY
	nircmd win activate process cmd.exe
	)
rem ‚®ббв ­®ў«Ґ­ЁҐ Ї а ¬Ґва®ў аҐҐбва 
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /f >nul 2>&1
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /f >nul 2>&1
	reg delete "HKLM\Software\Policies\Microsoft\MRT" /f >nul 2>&1
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide cmd.exe /c reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /f >nul 2>&1
	%ch% {03} ‚®ббв ­®ў«Ґ­ЁҐ д ©«®ў/Ї Ї®Є{\n #}{\n #}
	pushd "%BackupFolder%"
(
	copy /y "Files\System32" %SystemRoot%\System32
	copy /y "Files\SysWOW64" %SystemRoot%\SysWOW64
	copy /y "Files\Windows\Containers\WindowsDefenderApplicationGuard.wim" "%SystemRoot%\Containers\"
	copy /y "Files\Windows\Containers\serviced\WindowsDefenderApplicationGuard.wim" "%SystemRoot%\Containers\serviced"
	xcopy "Folder\Program Files\*" "%ProgramFiles%\" /E /H /K /Y
	xcopy "Folder\Program Files (x86)\*" "%ProgramFiles(x86)%\" /E /H /K /Y
	xcopy "Folder\ProgramData\*" "%ProgramData%\" /E /H /K /Y
	xcopy "Folder\System32\*" "%SystemRoot%\System32" /E /H /K /Y
	xcopy "Folder\SysWow64\*" "%SystemRoot%\SysWow64" /E /H /K /Y
	xcopy "Folder\Windows\*" "%SystemRoot%\" /E /H /K /Y
	xcopy "Folder\WinSxS\*" "%SystemRoot%\WinSxS\" /E /H /K /Y
rem ‚®ббв ­®ў«Ґ­ЁҐ аҐҐбва /б«г¦Ў, ¤а ©ўҐа®ў
	for %%f in ("RegEdit\*.reg") do reg import "%%f"
	for %%f in ("ServicesDrivers\*.reg") do reg import "%%f"
rem ‚®ббв ­®ў«Ґ­ЁҐ SmartScreen.exe
	if exist "%SystemRoot%\System32\smartscreen_disabled.exe" rename "%SystemRoot%\System32\smartscreen_disabled.exe" "smartscreen.exe"
rem “¤ «пҐ¬ а §¤Ґ« Ї® Є®в®а®¬г Їа®ўҐапҐвбп б®§¤ ­  «Ё аҐ§Ґаў­ п Є®ЇЁп. ’ҐЇҐам SysApps Ўг¤гв г¤ «пвмбп.
	reg delete "HKLM\Software\DefenderKiller" /f
) >nul 2>&1
	popd
	nhmb "’аҐЎгҐвбп ЇҐаҐ§ ЇгбЄ ЏЉ" "DK" "Information|Ok"
	cls && goto Start
rem                                                                   =================================
:CheckUpdate
rem Windows 8.1 ­Ґ Ї®¤¤Ґа¦Ёў Ґв дг­ЄжЁ®­ « ®Ў­®ў«Ґ­Ё©
rem “¤ «пҐ¬ д ©«, Ґб«Ё в®в ®бв «бп...
	del /q "%SystemDrive%\latestVersion.bat" >nul 2>&1
rem Џа®ўҐапҐ¬ ­ «ЁзЁҐ Ё­вҐа­Ґв-б®Ґ¤Ё­Ґ­Ёп
	ping www.google.nl -n 1 -w 1000 |>nul find /i "TTL="||cls&&%ch% {04} ЌҐў®§¬®¦­® Їа®ўҐаЁвм ®Ў­®ў«Ґ­Ёп Їа®Ја ¬¬л, ®вбгвбвўгҐв Ё­вҐа­Ґв{\n #}&&timeout /t 3 >nul&&cls&&goto Start
rem Џа®ўҐаЄ  ®Ў­®ў«Ґ­Ё© Їа®Ја ¬¬л
	curl -g -k -L -# -o "%SystemDrive%\latestVersion.bat" "https://pastebin.com/raw/dnENFgmC" >nul 2>&1
	call "%SystemDrive%\latestVersion.bat"
	if "%Version%" lss "%latestVersion%" (cls) else (cls & %ch% {0a} ‚л ЁбЇ®«м§гҐвҐ Ї®б«Ґ¤­оо  Євг «м­го ўҐабЁо Їа®Ја ¬¬л - {0e}%Version%{\n #}&timeout /t 4 >nul&goto Start)
rem ЋЎ­®ў«Ґ­ЁҐ Їа®Ја ¬¬л
	%ch%  {0f} Ќ ©¤Ґ­  ­®ў п ўҐабЁп, ­ ¦¬ЁвҐ «оЎго Є« ўЁиг зв®Ўл ®Ў­®ўЁвм Їа®Ја ¬¬г{\n #}
	curl -g -k -L -# -o %0 "https://github.com/oatmealcookiec/MyProgramm/releases/latest/download/DefenderKiller.bat" >nul 2>&1
	call %0
:Information
	nhmb "DefenderKiller - Їа®Ја ¬¬  ¤«п г¤ «Ґ­Ёп § йЁв­ЁЄ  Windows Ё ҐЈ® Є®¬Ї®­Ґ­в®ў.\n‚ Їа®Ја ¬¬Ґ Ё¬ҐҐвбп ў®§¬®¦­®бвм ў®ббв ­®ў«Ґ­Ёп (Ґб«Ё б®§¤ ­  аҐ§Ґаў­ п Є®ЇЁп)\nЉа б­л¬ жўҐв®¬ ў ¬Ґ­о - ­Ґ г¤ «Ґ­®. ‡Ґ«Ґ­л¬ жўҐв®¬ - г¤ «Ґ­®.\n\nЏаЁ ­ ¦ вЁЁ ­  Є­®ЇЄг ЋЉ Ўг¤Ґв ®вЄалв б ©в Їа®Ја ¬¬л, Ј¤Ґ ¬®¦­® ¤Ґв «м­® ®§­ Є®¬Ёвмбп б Їа®Ја ¬¬®©, § ¤ вм ў®Їа®б, ўлбЄ § вм ЇаҐ¤«®¦Ґ­ЁҐ Ё«Ё б®®ЎйЁвм ®Ў ®иЁЎЄҐ.\n\nBy Vlado." "DK" "Information|Ok"
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide cmd.exe /c start https://win10tweaker.ru/forum/topic/defenderkiller 
	cls & goto Start
rem ‘®§¤ ­® WestLife AutoSettings
:LGPOFILE
	setlocal
	if /i "%~2" NEQ "delete" if /i "%~2" NEQ "add" (
	if /i "%~2" EQU "delete" if "%~7" NEQ "" (
	set "RegType=%~7:"
	set "RegType=%RegType:REG=%"
	set "RegType=%RegType:_=%"
	set "RegType=%RegType:PAND=%"
	if "%~3" NEQ "" for /f "tokens=1* delims=\" %%I in ("%~3") do ( set "RegKey=%%J"
	 if /i "%%I" EQU "HKEY_LOCAL_MACHINE" (set Config=Computer) else if /i "%%I" EQU "HKLM" (set Config=Computer
	 ) else if /i "%%I" EQU "HKEY_CURRENT_USER" (set Config=User) else if /i "%%I" EQU "HKCU" (set Config=User
	if "%~9" NEQ "" set "Action=%RegType%%~9"
	if /i "%~6" EQU "/d" set "Action=SZ:%~7"
	if /i "%~2" EQU "delete" set "Action=DELETE"
	if "%~5" EQU "" ( set "Action=DELETEALLVALUES" & set "ValueName=*" ) else ( set "ValueName=%~5" )
	if /i "%~2" EQU "add" if /i "%~4" EQU "/f" set "Action=CREATEKEY" & set "ValueName=*"
	(echo.%Config%& echo.%RegKey%& echo.%ValueName%& echo.%Action%& echo.)>>"%LGPOtemp%"
) else (
%ch% {0f}C:\Program Files\Microsoft Update Health Tools {04}Ќ… “„Ђ‹…Ќ{\n #}
)
echo.
%ch% {0e} C:\Program Files (^x86^):{\n #}
if not exist "%ProgramFiles(x86)%\Windows Defender" (
%ch% {0f}C:\Program Files (^x86^)\Windows Defender {0a}“„Ђ‹…Ќ{\n #}
) else (
%ch% {0f}C:\Program Files (^x86^)\Windows Defender {04}Ќ… “„Ђ‹…Ќ{\n #}
)
if not exist "%ProgramFiles(x86)%\Windows Defender Advanced Threat Protection" (
%ch% {0f}C:\Program Files (^x86^)\Windows Defender Advanced Threat Protection {0a}“„Ђ‹…Ќ{\n #}
) else (
%ch% {0f}C:\Program Files (^x86^)\Windows Defender Advanced Threat Protection {04}Ќ… “„Ђ‹…Ќ{\n #}
)
echo.
%ch% {0e} C:\ProgramData\Microsoft:{\n #}
if not exist "%AllUsersProfile%\Microsoft\Windows Defender" (
%ch% {0f}C:\ProgramData\Microsoft\Windows Defender {0a}“„Ђ‹…Ќ{\n #}
) else (
%ch% {0f}C:\ProgramData\Microsoft\Windows Defender {04}Ќ… “„Ђ‹…Ќ{\n #}
)
if not exist "%AllUsersProfile%\Microsoft\Windows Defender Advanced Threat Protection" (
%ch% {0f}C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection {0a}“„Ђ‹…Ќ{\n #}
) else (
%ch% {0f}C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection {04}Ќ… “„Ђ‹…Ќ{\n #}
)
if not exist "%AllUsersProfile%\Microsoft\Windows Security Health" (
%ch% {0f}C:\ProgramData\Microsoft\Windows Security Health {0a}“„Ђ‹…Ќ{\n #}
) else (
%ch% {0f}C:\ProgramData\Microsoft\Windows Security Health {04}Ќ… “„Ђ‹…Ќ{\n #}
)
echo.
%ch% {0e} WindowsDefenderApplicationGuard.wim:{\n #}
if not exist "%SystemRoot%\Containers\WindowsDefenderApplicationGuard.wim" (
%ch% {0f}C:\Windows\Containers\WindowsDefenderApplicationGuard.wim {0a}“„Ђ‹…Ќ{\n #}
) else (
%ch% {0f}C:\Windows\Containers\WindowsDefenderApplicationGuard.wim {04}Ќ… “„Ђ‹…Ќ{\n #}
)
if not exist "%SystemRoot%\Containers\serviced\WindowsDefenderApplicationGuard.wim" (
%ch% {0f}C:\Windows\Containers\serviced\WindowsDefenderApplicationGuard.wim {0a}“„Ђ‹…Ќ{\n #}
) else (
%ch% {0f}C:\Windows\Containers\serviced\WindowsDefenderApplicationGuard.wim {04}Ќ… “„Ђ‹…Ќ{\n #}
)
rem Файл: Удалить и другие приложения Metro.bat
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.3DBuilder | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.BingFinance | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.BingNews | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.Getstarted | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.MicrosoftOfficeHub | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.MicrosoftSolitaireCollection | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.Office.OneNote | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.SkypeApp | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.WindowsPhone | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.XboxApp | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.ZuneMusic | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq Microsoft.ZuneVideo | Remove-AppxProvisionedPackage -Online"
PowerShell -Command "Get-AppxPackage *Microsoft* | Remove-AppxPackage"
PowerShell -Command "Get-AppXProvisionedPackage -online | Remove-AppxProvisionedPackage -online"
PowerShell -Command "Get-AppXPackage | Remove-AppxPackage"
PowerShell -Command "Get-AppXPackage -User  | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -AllUsers | Remove-AppxPackage"
echo ==========================================
echo    Удалить приложения - ВЫПОЛНЕНО
echo ==========================================