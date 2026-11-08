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
rem ⭮ ⥪/lgpo
	set "ch=cecho.exe"
	set "LGPOtemp=LGPO-temp.txt"
	set "RepeatDel="
rem  ணࠬ/塞 䠩,   ⠢ ᫥   ୥ ᪠
	set Version=11.1.3
	set DateProgram=18.01.2024
	if exist "%SystemDrive%\latestVersion.bat" del /q "%SystemDrive%\latestVersion.bat"
rem ᫨   WMIC/nhmb
rem 祭 SID । ᪮   TI
	for /f %%s in ('2^>nul wmic UserAccount where "Domain='%UserDomain%' and Name='%UserName%'" Get SID^|find "-"') do set SID=%%s
rem ஢ઠ ࠧ來 ⥬
	set xOS=x64& (If "%PROCESSOR_ARCHITECTURE%"=="x86" If Not Defined PROCESSOR_ARCHITEW6432 Set xOS=x86)
rem    TI
rem  ணࠬ  ᨬ   㦡, ᯮ  業 ࠭  
	set "serviceswebmask="
	for /f "usebackq delims=" %%n In (`2^>nul reg query "HKLM\System\CurrentControlSet\Services" /f "webthreatdefusersvc*" /k^|findstr ^H`) do set serviceswebmask=%%~nxn
	if defined serviceswebmask (Mode 82,45) else (Mode 80,45)
	nircmd win center process cmd.exe & nircmd win settext foreground "DK"
rem SmartScreen |  | 㦡 | ࠩ |  | ஢ઠ  GP [Home ]
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
	%ch% {03}ﭨ ᮢ ⭨:{\n #}
	%ch% {%SmartScreen%}SmartScreen{\n #}
	%ch% {%MsMpEng%}MsMpEng{#}   {08} [Antimalware Service Executable]{\n #}
	%ch% {%SgrmBroker%}SgrmBroker{#} {08}[ப । 믮 System Guard]{\n #}
	%ch% {%uhssvc%}uhssvc{#}    {08} [Microsoft Update Health Service]{\n #}
	%ch% {%NisSrv%}NisSrv{#}    {08} [Network Realtime Inspection]{\n #}
	%ch% {%MpCmdRun%}MpCmdRun{#}  {08} [Microsoft malware protection]{\n #}
	%ch% {%MPSigStub%}MPSigStub{#}{08}  [Malware Protection Signature Update Stub]{\n #}
	%ch% {%SecHealthUI%}SHealthUI{#}{08}  [᭮ Windows]{\n #}
	%ch% {%SecurityHealthSystray%}HealthTray{#}{08} [SecurityHealthSystray   ॥]{\n #}
	%ch% {%SecurityHealthService%}HealthServ{#}{08} [SecurityHealthService]{\n #}
	%ch% {%SecurityHealthHost%}HealthHost{#}{08} [SecurityHealthHost]{\n #}{\n #}
	%ch% {03}ﭨ 㦡  ࠩ஢ ⭨:{\n #}
	%ch% {%webthreatdefsvc%}webthreat{#}  {08}[㦡   -஧ - webthreatdefsvc]{\n #}
	if defined serviceswebmask (
	%ch% {%webthreatdefusersvc%}webthreatu{#} {08}[㦡  짮.  -஧ - {04}%serviceswebmask%{08}]{\n #}
	) else (
	%ch% {%webthreatdefusersvc%}webthreatu{#} {08}[㦡  짮.  -஧ - webthreatdefusersvc]{\n #}
	)
	%ch% {%WinDefend%}WinDefend{#} {08} [㦡 ⨢᭠ ணࠬ ⭨ Windows]{\n #}
	%ch% {%WdNisSvc%}WdNisSvc{#} {08}  [㦡 ஢ન  Windows Defender Antivirus]{\n #}
	%ch% {%Sense%}Sense{#}     {08} [㦡 Advanced Threat Protection]{\n #}
	%ch% {%wscsvc%}wscsvc{#}     {08}[㦡  ᯥ祭 ᭮]{\n #}
	%ch% {%SgrmBroker%}SgrmBroker{#} {08}[㦡 ப ਭ । 믮 System Guard]{\n #}
	%ch% {%SecurityHealthService%}SHealthSer{#} {08}[㦡  ᭮ ⭨ Windows]{\n #}
	%ch% {%WdNisDrv%}WdNisDrv{#}   {08}[ࠩ WD Network Inspection Driver]{\n #}
	%ch% {%WdBoot%}WdBoot{#}     {08}[ࠩ WD Antivirus Boot Driver]{\n #}
	%ch% {%WdFilter%}WdFilter{#}{08}   [ࠩ WD Antivirus Mini-Filter Driver]{\n #}
	%ch% {%SgrmAgent%}SgrmAgent{#}{08}  [ࠩ System Guard Runtime Monitor Agent Driver]{\n #}
	%ch% {%wtd%}wtd{#}{08}        [ࠩ WTD Driver]{\n #}
	%ch% {%MsSecWfp%}MsSecWfp{#}{08}   [ࠩ Microsoft Security WFP Callout Driver]{\n #}
	%ch% {%MsSecFlt%}MsSecFlt{#}{08}   [ࠩ Security Events Component Minifilter]{\n #}
	%ch% {%MsSecCore%}MsSecCore{#}{08}  [ࠩ Microsoft Security Core Boot Driver]{\n #}
	echo.
	%ch% {03}ﭨ   ஢騪:{\n #}
	%ch% {%Maintenance%}Windows Defender Cache Maintenance{\n #}
	%ch% {%Scan%}Windows Defender Scheduled Scan{\n #}
	%ch% {%Verification%}Windows Defender Verification{\n #}
	%ch% {%Cleanup%}Windows Defender Cleanup{\n #}
	%ch% {%SmartScreenSpecific%}SmartScreenSpecific{\n #}
	echo.
	%ch% {0f}1{#} - {0c} ⭨ Windows{\n #}
	%ch% {0f}2{#} - {0f}ﭨ   䠩{\n #}
	%ch% {0f}3{#} - {03}஢  DK {08}[⥪  {09}%Version% {08} {03}%DateProgram% {08}^| By {02}Vlado{08}]{\n #}
	%ch% {0f}4{#} - {08}⠭ ⭨ Windows{\n #}
	%ch% {0f}5{#} - {08}ଠ  DK{\n #}
	set "input="
	set /p input=
	if not defined input cls && goto Start
	if "%input%"=="1"  cls && goto DeleteDefender
	if "%input%"=="2"  cls && goto Catalogs
	if "%input%"=="3"  cls && goto CheckUpdate
	if "%input%"=="4"  cls && goto RestoreDefender
	if "%input%"=="5"  cls && goto Information 
	) else (
	cls & %ch%    {0c} 㭪樨  {\n #}
	timeout /t 1 >nul & endlocal & goto Start
	)
:DeleteDefender
rem ஢ઠ   ᪥ । 㤠
	set "sFreeSize="
	set "sFreeSizePseudoMb="
	set "sFreeSizePseudoMb1="
	set "Freed="
	set "NameSecHealth="
	set "NotChangeUAC="
	for /f "usebackq tokens=2 delims==" %%i in (`wmic.exe LogicalDisk where "Name='c:'" get FreeSpace /value`) do set sFreeSize=%%i
	if defined sFreeSize set sFreeSizePseudoMb=%sFreeSize:~0,-7%
rem ᫨   ⭨ ...
	if exist "%AllUsersProfile%\Microsoft\Windows Defender" (
rem ஢塞 㤠  ⭨ ࠭  ⪥ ॥,  㤠   㤠. ᫨ ⭨  㤠 - ஢塞 ﭨ   .
	reg query "HKLM\Software\Microsoft\Windows Defender\Features" >nul 2>&1 && echo >nul || goto NotTamper
rem ஢塞 稥 ਫ ᭮ Windows
	for /F "usebackq delims=" %%n In (`2^>nul reg query "HKU\!SID!\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages" /f "*SecHealthUI*" /k^|findstr ^H`) do set NameSecHealth=%%~nxn
rem ᫨ ਫ ᭮  㤠, ஢塞 ﭨ   
	if defined NameSecHealth (
	reg query "HKLM\Software\Microsoft\Windows Defender\Features" /v "TamperProtection" | find /i "0x4" >nul 2>&1 && (
	%ch%    {0a}    ⪫祭^^!{\n #}{\n #}
	) || (
	%ch%    {04}  몫祭  ࠬ Defender  ⮬᪮ ०.{\n #}
	%ch%    {08} ᫨ -  ⪫稫 - ⪫ .{\n #}
	%ch%    {08} ,  室 ⪫ - {04}  {\n #}{\n #}
	%ch%    {0c} ᫨   Windows 10 - 室  ⪫ "  "{\n #}{\n #}
	%ch%    {08}     த{\n #}
rem ⪫砥 ᯫ뢠饥  UAC, ᫨ UAC  ⪫砫 ࠭, ⮡ nircmd sendkeypress ࠡ⠫   UAC
	reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" | find /i "0x0" >nul && set "NotChangeUAC=Yes"
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 0 /f >nul
rem ᪠ ࠬ
	explorer windowsdefender://ThreatSettings
	timeout /t 2 /nobreak >nul
rem 몫砥  ࠬ   nircmd
	nircmd sendkeypress 0x20 0x09 0x20 0x09 0x20 0x09 0x09 0x20
:TamperProtectionStatus
rem ஢塞 稥   ᭮, ᫨  , ஢塞 ⪫稫    . ᫨   - 뢮 ᮮ饭.
	qprocess SecHealthUI.exe >nul 2>&1 && (
	echo>nul) || (
	%ch%    {0c}    {4f}{0c} ⪫祭^^!{\n #}{\n #}
	%ch%    {08} 1 - {0c}   ⪫   {\n #}
	%ch%    {04} ᯮ, ᫨ ⢨⥫쭮   ⪫  㭪{\n #}{\n #}
	%ch%    {0c}   ,      {\n #}{\n #}
	%ch%    {08} 2 -  ⭮{\n #}
	choice /c 12 /n /m " "
	if errorlevel 2 cls && goto Start
	if errorlevel 1 cls && goto NotTamper)
rem ஢ઠ    ᫥ nircmd sendkeypress
	reg query "HKLM\Software\Microsoft\Windows Defender\Features" /v "TamperProtection" | find /i "0x4" >nul 2>&1 && cls && %ch%    {0a}    ⪫祭^^!{\n #}{\n #}|| goto TamperProtectionStatus
		)
	)
rem   ணࠬ
	nircmd win activate process cmd.exe
rem   ᮧ १. 
	nhmb "  ᮧ १ࢭ  Windows Defender । 믮 㤠?\nࢭ   ⠭ ⭨ ᫥ 㤠.\n⠭  ॡ, ᫨   Windows.\n\n롨ࠩ , ⮫쪮  ⮬ 砥, ᫨   㦭  Windows,    㦥  १ࢭ  ⭨  ⮩ ᨨ Windows." "BackupDefender" "Warning|YesNo|DefButton2"
	if errorlevel 7 goto NotTamper
	if errorlevel 6 call :CreateBackupDefender
:NotTamper
rem ⠭  㬮砭, ᫨ ࠬ ConsentPromptBehaviorAdmin   ࠭ [ 祭 5 -㬮砭]
	if not defined NotChangeUAC reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 5 /f >nul
rem ᫨  GP - ய [Home ]
	if defined NoGP %ch%    {08}ய ⪫祭 , ..   {\n #}&&goto NotGP
	%ch%    {03} ⪫砥 ⭨ [] ^>
rem ଠ  ⨪ : https://learn.microsoft.com/ru-ru/windows/client-management/mdm/policy-csp-admx-microsoftdefenderantivirus
rem 몫 ⨢ ணࠬ Microsoft Defender (祭) [DisableAntiSpyware]
rem  ﭭ ࠡ 㦡   । ணࠬ (⪫祭) [ServiceKeepAlive]
rem 몫  ࠢ (祭) [DisableRoutinelyTakingAction]
rem   㦡   । ணࠬ   ਮ⮬ (⪫祭) [AllowFastServiceStartup]
rem 몫   ॠ쭮 ६ (祭) [DisableRealtimeMonitoring]
rem ஢  㦥 䠩   (⪫祭) [DisableIOAVProtection]
rem     (⪫祭) [DisableBehaviorMonitoring]
rem  ஢ ᮢ, ᫨ 祭   ० ॠ쭮 ६ (⪫祭) [DisableScanOnRealtimeEnable]
rem ᫥ ⨢ ணࠬ  䠩   (⪫祭) [DisableOnAccessProtection]
rem ந 쭮 ८।  祭   ० ॠ쭮 ६ (⪫祭) [LocalSettingOverrideDisableRealtimeMonitoring]
rem ந 쭮 ८।  祭 ஫  (⪫祭) [LocalSettingOverrideDisableBehaviorMonitoring]
rem ந 쭮 ८।  ஢ન  㦥 䠩   (⪫祭) [LocalSettingOverrideDisableIOAVProtection]
rem ந 쭮 ८।  ࠢ ⮢  MAPS (⪫祭) [LocalSettingOverrideSpynetReporting]
rem ᮥ  Microsoft MAPS (⪫祭) [**del.SpynetReporting]
rem ࠢ ࠧ 䠩, ᫨ ॡ 쭥訩  (祭) [SubmitSamplesConsent]
rem   㦡 ᭮  ॠ쭮 ६  ᭮ ⮢  Microsoft MAPS (⪫祭) [RealtimeSignatureDelivery]
rem ᪠  㦡  ᭮  ᪥ (⪫祭) [DisableUpdateOnStartupWithoutEngine]
rem ஢ 稥 ᫥ ᨨ 㦡   ᪥ (⪫祭) [UpdateOnStartUp]
rem  ஢ ᫥  㦡  ᭮ (⪫祭) [DisableScanOnUpdate]
rem ந ᮡ ணࠬ " ᮭ" (ࠢ  ᡮ騪 訡) (⪫祭) [DisableGenericRePorts]
rem  ⥫ ஢  / ஢ப (⪫祭) [DisableCatchupFullScan/DisableCatchupQuickScan]
rem ஢ ꥬ ⥫  ६ ண ᪠஢ (⪫祭) [DisableRemovableDriveScanning]
rem ஢ ⥢ 䠩 (⪫祭) [DisableScanningNetworkFiles]
rem 믮  ஢  祭 ⥢ ᪠ (⪫祭) [DisableScanningMappedNetworkDrivesForFullScan]
rem ஢ 娢 䠩 (⪫祭) [DisableArchiveScanning]
rem ந 㭪 SmartScreen ⭨ Windows (3 ⨪) (⪫祭)
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
rem   ணࠬ
	nircmd win activate process cmd.exe
rem SmartScreen BX
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f >nul
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide cmd.exe /c reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f >nul
rem   業 ᭮
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d "0" /f >nul
rem MSRT - ।⢮ 㤠 । ணࠬ  Microsoft. [ ࠢ   MSRT/⪫ 祭   MSRT]
	reg add "HKLM\Software\Policies\Microsoft\MRT" /v "DontReportInfectionInformation" /t REG_DWORD /d "1" /f >nul
	reg add "HKLM\Software\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /t REG_DWORD /d "1" /f >nul
	)
rem ய Unlocker; DefenderStop, ᫨ ⭨ 㦥 㤠
	if not exist "%AllUsersProfile%\Microsoft\Windows Defender" goto NotFuckWD
	if not exist "%SystemDrive%\Program Files\Windows Defender" goto NotFuckWD
rem                                                                   =================================
rem ᫨   [ୠ] 室 㤠,  ய᪠   ᪫祭
	if not defined RepeatDel (
	%ch%    {03} 塞 Unlocker/DefenderStop  ᪫祭{\n #}{\n #}
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide -Wait PowerShell "Add-MpPreference -ExclusionPath '%~dp0Work', '%LocalAppData%\Temp\RarSFX0', '%LocalAppData%\Temp\RarSFX1', '%LocalAppData%\Temp\RarSFX2', '%Temp%\RarSFX0', '%Temp%\RarSFX1', '%Temp%\RarSFX2'" >nul 2>&1)
rem 蠥  ⭨
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
	) || %ch%    {0c}  ᪠ DefenderStop/Unlocker.  祭  ୥{\n #}{\n #}&& goto NotFuckWD
	%ch%    {03} ᯮ㥬 DefenderStop{\n #}{\n #}
	nircmd exec hide DefenderStop.exe
	nircmd wait 3000
	nircmd exec hide DefenderStop.exe
rem                                                                   =================================
	if "%xOS%"=="x86" (
	%ch%    {04} Unlocker  ࠡ⠥  x32 ⥬.{\n #}
	%ch%    {04} ᫥ १㧪  室 ୮ 㤠.{\n #}
	goto NotFuckWD)
	if not exist FuckDefender.exe curl -g -k -L -# -o "FuckDefender.exe" "https://i.getspace.eu/cloud/s/Eb3sKTfwiamRAnt/download" >nul 2>&1
	%ch%    {0c} 믮 㤠   Unlocker{\n #}
	%ch%    {08} ६  - 20 ᥪ.{\n #}{\n #}
rem By XpucT/Vlado/Eject
	start FuckDefender
	timeout /t 3 /nobreak >nul
	qprocess Unlocker.exe >nul 2>&1 && echo >nul || goto NotFuckWD
rem  20 ᥪ㭤, ᫨ Unlocker ᬮ 
(
	timeout /t 20 /nobreak
	taskkill /f /im Unlocker.exe
	taskkill /f /im FuckDefender.exe
	taskkill /f /im wscript.exe
	nircmd killprocess Unlocker.exe & nircmd killprocess FuckDefender.exe & nircmd killprocess wscript.exe
rem 塞 Unlocker  ࠩ. ⠭ ᠬ, ᫨ ᯮ IObitUnlocker - https://cdn.discordapp.com/attachments/1099332280629084163/1196482117383766138/IObitUnlocker_Test.mp4
	del /q FuckDefender.exe
	sc delete IObitUnlocker
	reg delete HKLM\System\CurrentControlset\Services\IObitUnlocker /f	
) >nul 2>&1
rem                                                                   =================================
:NotFuckWD
	%ch%    {03} 塞   䠩 WD{\n #}{\n #}
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
rem २ 䠩    㤠
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
rem  䠩 System32
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
rem  SmartScreen.exe
	taskkill /f /im smartscreen.exe
	ren "%SystemRoot%\System32\smartscreen.exe" "smartscreen.exedel"
	del /f /q "%SystemRoot%\System32\smartscreen.exe"
	del /f /q "%SystemRoot%\System32\smartscreen.exedel"
rem  䠩 SysWOW64
	del /f /q "%SystemRoot%\SysWOW64\smartscreen.dll"
	del /f /q "%SystemRoot%\SysWOW64\wscisvif.dll"
	del /f /q "%SystemRoot%\SysWOW64\wscproxystub.dll"
	del /f /q "%SystemRoot%\SysWOW64\smartscreenps.dll"
	del /f /q "%SystemRoot%\SysWOW64\wscapi.dll"
	del /f /q "%SystemRoot%\SysWOW64\windowsdefenderapplicationguardcsp.dll"
) >nul 2>&1
rem                                                                   =================================
	%ch%    {03} 塞 㦡{\n #}
	%ch%    {0a} WinDefend, SecurityHealthService, Sense, WdNisSvc, wscsvc, webthreatdefsvc{\n #}
	%ch%    {0a} webthreatdefusersvc{\n #}{\n #}
	if exist DefenderStop.exe nircmd exec hide DefenderStop.exe
(
rem ⠭ 㦡
	sc stop WinDefend
	sc stop SecurityHealthService
	sc stop Sense
	sc stop WdNisSvc
	sc stop wscsvc
	sc stop SgrmBroker
	sc stop webthreatdefsvc
	sc stop webthreatdefusersvc
	sc stop %serviceswebmask%
rem  㦡
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
	%ch%    {03} 塞 ࠩ{\n #}
	%ch%    {0a} WdNisDrv, WdBoot, WdFilter, SgrmAgent, wtd, MsSecWfp, MsSecFlt, MsSecCore{\n #}{\n #}
(
rem ⪫祭  㤠 ࠩ஢
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
	%ch%    {03} 塞   ஢騪{\n #}
	rmdir /s /q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Windows Defender" >nul 2>&1
	schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /f >nul 2>&1 & %ch% {0a}    Windows Defender Cache Maintenance{\n #}
	schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /f >nul 2>&1 & %ch% {0a}    Windows Defender Cleanup{\n #}
	schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /f >nul 2>&1 & %ch% {0a}    Windows Defender Scheduled Scan{\n #}
	schtasks /Delete /TN "Microsoft\Windows\Windows Defender\Windows Defender Verification" /f >nul 2>&1 & %ch% {0a}    Windows Defender Verification{\n #}
	schtasks /Delete /TN "Microsoft\Windows\AppID\SmartScreenSpecific" >nul 2>&1 & %ch% {0a}    SmartScreenSpecific{\n #}{\n #}
rem                                                                   =================================
(
rem ⪠ ⥪⭮ 
	reg delete "HKCR\*\shellex\ContextMenuHandlers\EPP" /f
	reg delete "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /f
	reg delete "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /f
	reg delete "HKLM\Software\Classes\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved" /v "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
rem   ⮧᪠
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth" /f
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Defender" /f
rem  Windows Defender  ॥
	reg delete "HKLM\System\CurrentControlset\Control\WMI\Autologger\DefenderApiLogger" /f
	reg delete "HKLM\System\CurrentControlset\Control\WMI\Autologger\DefenderAuditLogger" /f
	reg delete "HKLM\Software\Microsoft\Windows Defender" /f
	reg delete "HKLM\Software\Microsoft\Windows Defender Security Center" /f
	reg delete "HKLM\Software\Microsoft\Windows Advanced Threat Protection" /f
	reg delete "HKLM\Software\Microsoft\Windows Security Health" /f
rem    ࠬ
	reg delete "HKLM\Software\Microsoft\SystemSettings\SettingId\SystemSettings_WindowsDefender_UseWindowsDefender" /f
rem  ୠ ᮡ⨩
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/WHC" /f
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\NIS-Driver-WFP/Diagnostic" /f
) >nul 2>&1
rem                                                                   =================================
rem ᫨ 㤠﫠  ⪠ ࠭, ய᪠ 㤠   WinSxS
	reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/Operational" >nul 2>&1 && (
	%ch%    {03} 塞   WinSxS{\n #}{\n #}
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%SystemRoot%\WinSxS\*windows-defender*" /S /B /A:D`) do rmdir "%%d" /s /q >nul 2>&1
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%SystemRoot%\WinSxS\*windows-senseclient-service*" /S /B /A:D`) do rmdir "%%d" /s /q >nul 2>&1
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%SystemRoot%\WinSxS\*windows-dynamic-image*" /S /B /A:D`) do rmdir "%%d" /s /q >nul 2>&1
	)
rem   WinSxS  㤠,  ᪠稢  Windows!
rem del /q /s %SystemRoot%\WinSxS\*defender* >nul 2>&1
rem  ⪨ ᫥ 㤠   WinSxS , 믮  ᫥ 㤠   WinSxS ⮡ 1 ࠧ 㤠  ந諮,  ᫥騥 㤠 ய᪠
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/Operational" /f >nul 2>&1
rem                                                                   =================================
:SecHealthUI
	VER | FINDSTR /IL "6.3." > NUL && %ch%    {0c} Windows 8.1  㦤  㤠 ਫ '᭮'  'SmartScreen'{\n #}&&goto FinishDelete
rem ஢塞 ᮧ  , ᫨  - ய᪠ 㤠 ਫ
	reg query "HKLM\Software\DefenderKiller" >nul 2>&1 && 	%ch%    {0e} 뫮 ࠭ ᮧ १ࢭ , ய᪠ 㤠 ਫ{\n #}{\n #}&&goto FinishDelete
rem ஢ઠ १ PS
	rem PowerShell "Get-AppxPackage -AllUsers *SecHealth*" | find /i "PackageFullName" >nul
	%ch%    {09} ᭮ Windows{\n #}
	set "NameSecHealth="
rem 砥  ਫ ᭮
	for /F "usebackq delims=" %%n In (`2^>nul reg query "HKU\%SID%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages" /f "*SecHealthUI*" /k^|findstr ^H`) do set NameSecHealth=%%~nxn
	if not defined NameSecHealth %ch%    {02} ਫ ᭮ Windows 㤠{\n #}{\n #}&goto AppRepSys
	%ch%    {0b} 塞 ਫ ᭮ Windows{\n #}
	%ch%    {08} %NameSecHealth%{\n #}{\n #}
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\S-1-5-18\%NameSecHealth%" /f >nul
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\%SID%\%NameSecHealth%" /f >nul
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide -Wait PowerShell "Get-AppxPackage -AllUsers *SecHealthUI* | Remove-AppxPackage"	
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\InboxApplications\%NameSecHealth%" /f >nul 2>&1
rem    㤠. ⠭ ᠬ, ᫨ ⠭ ਫ ᭮.
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%ProgramData%\Microsoft\Windows\AppRepository\Packages\*SecHealth*" /S /B /A:D`) Do rmdir "%%d" /s /q
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%LocalAppData%\Packages\*SecHealth*" /S /B /A:D`) Do rmdir "%%d" /s /q
rem                                                                   =================================
:AppRepSys
	%ch%    {09} SmartScreen ⭨ Windows{\n #}
	set "NameAppRep="
rem 砥  ਫ AppRep
	for /F "usebackq delims=" %%n In (`2^>nul reg query "HKU\%SID%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages" /f "*Apprep.ChxApp*" /k^|findstr ^H`) do set NameAppRep=%%~nxn
	if not defined NameAppRep %ch%    {02} ਫ SmartScreen ⭨ Windows 㤠{\n #}&goto FinishDelete
	%ch%    {0b} 塞 ਫ SmartScreen ⭨ Windows{\n #}
	%ch%    {08} %NameAppRep%{\n #}
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\S-1-5-18\%NameAppRep%" /f >nul
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\%SID%\%NameAppRep%" /f >nul
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide -Wait PowerShell "Get-AppxPackage -AllUsers *Apprep.ChxApp* | Remove-AppxPackage"	
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\InboxApplications\%NameAppRep%" /f >nul 2>&1
rem    㤠, ⠭ ᠬ, ᫨ ⠭ ਫ Apprep.ChxApp
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%ProgramData%\Microsoft\Windows\AppRepository\Packages\*Apprep.ChxApp*" /S /B /A:D`) Do rmdir "%%d" /s /q
	For /F "usebackq delims=" %%d In (`2^>nul Dir "%LocalAppData%\Packages\*Apprep.ChxApp*" /S /B /A:D`) Do rmdir "%%d" /s /q
rem                                                                   =================================
:FinishDelete
rem ᢮񭭮   ᪥
	for /f "usebackq tokens=2 delims==" %%i in (`wmic.exe LogicalDisk where "Name='c:'" get FreeSpace /value`) do set sFreeSize=%%i
	if defined sFreeSize (set sFreeSizePseudoMb1=%sFreeSize:~0,-7%)
	set /a Freed=%sFreeSizePseudoMb1% - %sFreeSizePseudoMb%
	echo.
	%ch%    {06} %Freed%   ᢮ ᫥ 㤠{\n #}
	if not exist "%AllUsersProfile%\Microsoft\Windows Defender" (
	%ch%    {02} ⭨ Windows 㤠{\n #}{\n #}
	%ch%    {08} ਥ  ﭨ  [2]{\n #}   {08} ᫨ - ⠫, १㧨    㤠{\n #}
	%ch%    {08}     த{\n #}{\n #}
	) else (
	echo.
	nhmb "⭨ Windows  㤠.\n 㤠 ⭨?\n\n᫨ ᫥ ᪮쪨 ⮪ 㤠 ⭨  㤠    ᮮ饭, 믮 १㧪     㤠." "DK" "Information|YesNo"
	if errorlevel 7 cls && goto Start
	if errorlevel 6 cls && set "RepeatDel=Yes" && goto DeleteDefender
	)
rem                                                                   =================================
:Catalogs
rem    ᨬ   㦡
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
	if not exist "%SystemDrive%\Program Files\Windows Defender" (%ch% {0a} C:\Program Files\Windows Defender {08}- ᭮  ⭨ 1{\n #}) else (%ch%  {4f}C:\Program Files\Windows Defender{08} - ᭮  ⭨ 1{\n #})
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
	if not exist "%AllUsersProfile%\Microsoft\Windows Defender" (%ch% {0a} C:\ProgramData\Microsoft\Windows Defender {08}- ᭮  ⭨ 2{\n #}) else (%ch%  {4f}C:\ProgramData\Microsoft\Windows Defender{08} - ᭮  ⭨ 2{\n #})
	if not exist "%AllUsersProfile%\Microsoft\Windows Defender Advanced Threat Protection" (%ch% {0a} C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection{\n #}) else (%ch%  {0c}C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection{\n #})
	if not exist "%AllUsersProfile%\Microsoft\Windows Security Health" (%ch% {0a} C:\ProgramData\Microsoft\Windows Security Health{\n #}) else (%ch%  {0c}C:\ProgramData\Microsoft\Windows Security Health{\n #})
	if not exist "%AllUsersProfile%\Microsoft\Storage Health" (%ch% {0a} C:\ProgramData\Microsoft\Storage Health{\n #}) else (%ch%  {0c}C:\ProgramData\Microsoft\Storage Health{\n #})
	echo.
	%ch% {3f}  ஢騪 ⭨{\n #}
	if not exist "%SYSTEMROOT%\System32\Tasks\Microsoft\Windows\Windows Defender" (%ch% {0a} C:\Windows\System32\Tasks\Microsoft\Windows\Windows Defender{\n #}) else (%ch%  {0c}C:\Windows\System32\Tasks\Microsoft\Windows\Windows Defender{\n #})
	echo.
	%ch% {3f}⠫ 䠩{\n #}
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
rem ஢塞 稥 ୥, ⮡ ᯮ짮 DefenderStop । ᮧ १ࢭ  [㦥, ..      ⭨, -  㦡]
	if not exist DefenderStop.exe (
	ping www.google.nl -n 1 -w 1000 |>nul find /i "TTL=" && curl -g -k -L -# -o "DefenderStop.exe" "https://i.getspace.eu/cloud/s/GXAtGk7qLbHj2CS/download" >nul 2>&1
	) || (
	%ch%    {0c}  ᮧ १ࢭ ,  祭  ୥{\n #}
	%ch%    {0c}  ᪠ DefenderStop{\n #}{\n #}
	%ch%    {08} https://i.getspace.eu/cloud/s/GXAtGk7qLbHj2CS/download{\n #}
rem ᯮ㥬 ᪮쪮 ࠧ  㢥७ 믮
	%ch%    {03} ᯮ㥬 DefenderStop  ⪫祭 㦡 ⭨{\n #}{\n #}
	nircmd exec hide DefenderStop.exe
	nircmd wait 3000
	nircmd exec hide DefenderStop.exe
	nircmd exec hide DefenderStop.exe
	%ch%    {02}  १ࢭ    %AllUsersProfile%{\n #}
(
    xcopy /s /e /h /y /i "%AllUsersProfile%\Microsoft\Windows Defender" "%SystemDrive%\WDefenderBackup\Folder\ProgramData\Microsoft\Windows Defender"
    xcopy /s /e /h /y /i "%AllUsersProfile%\Microsoft\Windows Defender Advanced Threat Protection" "%SystemDrive%\WDefenderBackup\Folder\ProgramData\Microsoft\Windows Defender Advanced Threat Protection"
    xcopy /s /e /h /y /i "%AllUsersProfile%\Microsoft\Windows Security Health" "%SystemDrive%\WDefenderBackup\Folder\ProgramData\Microsoft\Windows Security Health"
    xcopy /s /e /h /y /i "%AllUsersProfile%\Microsoft\Storage Health" "%SystemDrive%\WDefenderBackup\Folder\ProgramData\Microsoft\Storage Health"
) >nul 2>&1
rem ஢ઠ ᫥ ஢  , ᪮஢  ...
	dir /b "%SystemDrive%\WDefenderBackup\Folder\ProgramData\Microsoft\Windows Defender" | findstr /r "^" >nul && (
	echo >nul
	) || (
	%ch% {04}  "%AllUsersProfile%\Microsoft\Windows Defender" ᪮஢  㤠{\n #}
	%ch% {04}  , ᫨    ࠡ⠫ DefenderStop   ⪫稫 㦡 ⭨{\n #}
	%ch% {04}  ᯮ  Win 11 Dev/Beta ,  Microsoft - {\n #}{\n #}
	%ch% {08} ஡  ࠧ  ...{\n #}
	rd /s /q "%SystemDrive%\WDefenderBackup" >nul 2>&1
	cls && goto Start
	)
	%ch%    {02}  १ࢭ    %ProgramFiles%  %ProgramFiles(x86)%{\n #}
(
rem  ࠧ  ॥  ஬ 㤥 ஢,  १ࢭ  ᮧ. ॡ  ய᪠ 㤠 SysApps [᭮/AppRep]
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
	%ch%    {02}  १ࢭ    System32  SysWOW64{\n #}
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
rem  ⭨
	xcopy /s /e /h /y /i "%SystemRoot%\System32\Tasks\Microsoft\Windows\Windows Defender" "%SystemDrive%\WDefenderBackup\Folder\System32\Tasks\Microsoft\Windows\Windows Defender"
rem SysWOW64
    xcopy /s /e /h /y /i "%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\Modules\Defender" "%SystemDrive%\WDefenderBackup\Folder\SysWOW64\WindowsPowerShell\v1.0\Modules\Defender"
    xcopy /s /e /h /y /i "%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\Modules\DefenderPerformance" "%SystemDrive%\WDefenderBackup\Folder\SysWOW64\WindowsPowerShell\v1.0\Modules\DefenderPerformance"
) >nul 2>&1
	%ch%    {02}  १ࢭ  䠩  System32  SysWOW64{\n #}
(
	md "%SystemDrive%\WDefenderBackup\Files"
	md "%SystemDrive%\WDefenderBackup\Files\System32"
	md "%SystemDrive%\WDefenderBackup\Files\SysWOW64"
	md "%SystemDrive%\WDefenderBackup\Files\Windows\Containers"
	md "%SystemDrive%\WDefenderBackup\Files\Windows\Containers\serviced"
rem ஢ 䠩  System32
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
rem ஢ 䠩  SysWow64
	copy /Y "%SystemRoot%\SysWOW64\smartscreen.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\SysWOW64\wscisvif.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\SysWOW64\wscproxystub.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\SysWOW64\smartscreenps.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\SysWOW64\wscapi.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\SysWOW64\windowsdefenderapplicationguardcsp.dll" "%SystemDrive%\WDefenderBackup\Files\SysWow64\"
	copy /Y "%SystemRoot%\Containers\WindowsDefenderApplicationGuard.wim" "%SystemDrive%\WDefenderBackup\Files\Windows\Containers\"
	copy /Y "%SystemRoot%\Containers\serviced\WindowsDefenderApplicationGuard.wim" "%SystemDrive%\WDefenderBackup\Files\Windows\Containers\serviced"
) >nul 2>&1
	%ch%    {02}  १ࢭ    WinSxS{\n #}
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
rem 㦡
	reg export "HKLM\System\CurrentControlSet\Services\EventLog\System\WinDefend" "%PathServDrive%\WinDefendEvent.reg"
	reg export "HKLM\System\CurrentControlSet\Services\SecurityHealthService" "%PathServDrive%\SecurityHealthService.reg"
	reg export "HKLM\System\CurrentControlSet\Services\Sense" "%PathServDrive%\Sense.reg"
	reg export "HKLM\System\CurrentControlSet\Services\WdNisSvc" "%PathServDrive%\WdNisSvc.reg"
	reg export "HKLM\System\CurrentControlSet\Services\WinDefend" "%PathServDrive%\WinDefend.reg"
	reg export "HKLM\System\CurrentControlSet\Services\wscsvc" "%PathServDrive%\wscsvc.reg"
	reg export "HKLM\System\CurrentControlSet\Services\SgrmBroker" "%PathServDrive%\SgrmBroker.reg"
	reg export "HKLM\System\CurrentControlSet\Services\webthreatdefsvc" "%PathServDrive%\webthreatdefsvc.reg"
	reg export "HKLM\System\CurrentControlSet\Services\webthreatdefusersvc" "%PathServDrive%\webthreatdefusersvc.reg"
rem ࠩ
	reg export "HKLM\System\CurrentControlSet\Services\WdNisDrv" "%PathServDrive%\WdNisDrv.reg"
	reg export "HKLM\System\CurrentControlSet\Services\WdBoot" "%PathServDrive%\WdBoot.reg"
	reg export "HKLM\System\CurrentControlSet\Services\WdFilter" "%PathServDrive%\WdFilter.reg"
	reg export "HKLM\System\CurrentControlSet\Services\SgrmAgent" "%PathServDrive%\SgrmAgent.reg"
	reg export "HKLM\System\CurrentControlSet\Services\wtd" "%PathServDrive%\wtd.reg"
	reg export "HKLM\System\CurrentControlSet\Services\MsSecWfp" "%PathServDrive%\MsSecWfp.reg"
	reg export "HKLM\System\CurrentControlSet\Services\MsSecFlt" "%PathServDrive%\MsSecFlt.reg"
	reg export "HKLM\System\CurrentControlSet\Services\MsSecCore" "%PathServDrive%\MsSecCore.reg"
rem ᯮ ⮪ ॥
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
	%ch%    {08} ࢭ  ᮧ  {0b}%SystemDrive%\WDefenderBackup{\n #}{\n #}
:RestoreDefender
rem  ४⭮ ⮡ࠦ  , .. ணࠬ 饭  TI
	if not exist "%SystemRoot%\System32\config\systemprofile\Desktop" md "%SystemRoot%\System32\config\systemprofile\Desktop"
	set "BackupFolder="
	for /f %%A in ('powershell -c "(New-Object -COM 'Shell.Application').BrowseForFolder(0, '롥   ࠭ ᮧ १ࢭ  Windows Defender', 0, 0).Self.Path"') do set "BackupFolder=%%A"
	echo.
	if not defined BackupFolder cls && goto Start
	if not exist "%BackupFolder%\Folder" %ch%    {04} ୠ १ࢭ . 롥 ࠢ १ࢭ {\n #}&&timeout /t 3 >nul && cls && goto RestoreDefender
	if not exist "%BackupFolder%\ServicesDrivers" %ch%    {04} ୠ १ࢭ . 롥 ࠢ १ࢭ {\n #}&&timeout /t 3 >nul && cls && goto RestoreDefender
rem    ⠭ ⭨
	%ch% {0f} ࢭ  ࠭ - {04}%BackupFolder%{\n #}
	echo  1 - ⠭ ⭨
	echo  2 - ⬥ 
	choice /c 12 /n /m " "
	if errorlevel 2 cls && goto Start
rem ⠭ ⨪
	if not defined NoGP (
	%ch% {03} ⠭ 㯯 ⨪{\n #}
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
rem ⠭ ࠬ஢ ॥
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /f >nul 2>&1
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /f >nul 2>&1
	reg delete "HKLM\Software\Policies\Microsoft\MRT" /f >nul 2>&1
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide cmd.exe /c reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /f >nul 2>&1
	%ch% {03} ⠭ 䠩/{\n #}{\n #}
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
rem ⠭ ॥/㦡, ࠩ஢
	for %%f in ("RegEdit\*.reg") do reg import "%%f"
	for %%f in ("ServicesDrivers\*.reg") do reg import "%%f"
rem ⠭ SmartScreen.exe
	if exist "%SystemRoot%\System32\smartscreen_disabled.exe" rename "%SystemRoot%\System32\smartscreen_disabled.exe" "smartscreen.exe"
rem 塞 ࠧ  ஬ ஢ ᮧ  १ࢭ .  SysApps  㤠.
	reg delete "HKLM\Software\DefenderKiller" /f
) >nul 2>&1
	popd
	nhmb "ॡ १ " "DK" "Information|Ok"
	cls && goto Start
rem                                                                   =================================
:CheckUpdate
rem Windows 8.1  ন 㭪樮 
rem 塞 䠩, ᫨  ⠫...
	del /q "%SystemDrive%\latestVersion.bat" >nul 2>&1
rem ஢塞 稥 ୥-ᮥ
	ping www.google.nl -n 1 -w 1000 |>nul find /i "TTL="||cls&&%ch% {04}  ஢  ணࠬ,  ୥{\n #}&&timeout /t 3 >nul&&cls&&goto Start
rem ஢ઠ  ணࠬ
	curl -g -k -L -# -o "%SystemDrive%\latestVersion.bat" "https://pastebin.com/raw/dnENFgmC" >nul 2>&1
	call "%SystemDrive%\latestVersion.bat"
	if "%Version%" lss "%latestVersion%" (cls) else (cls & %ch% {0a}  ᯮ ᫥ 㠫  ணࠬ - {0e}%Version%{\n #}&timeout /t 4 >nul&goto Start)
rem  ணࠬ
	%ch%  {0f}   ,    ⮡  ணࠬ{\n #}
	curl -g -k -L -# -o %0 "https://github.com/oatmealcookiec/MyProgramm/releases/latest/download/DefenderKiller.bat" >nul 2>&1
	call %0
:Information
	nhmb "DefenderKiller - ணࠬ  㤠 ⭨ Windows   ⮢.\n ணࠬ   ⠭ (᫨ ᮧ १ࢭ )\n 梥⮬   -  㤠.  梥⮬ - 㤠.\n\n ⨨    㤥  ᠩ ணࠬ,   ⠫쭮   ணࠬ,  , ᪠ ।  ᮮ  訡.\n\nBy Vlado." "DK" "Information|Ok"
	NSudoLC -U:%ArgNsudo% -ShowWindowMode:Hide cmd.exe /c start https://win10tweaker.ru/forum/topic/defenderkiller 
	cls & goto Start
rem  WestLife AutoSettings
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
	%ch% {04} ਬ ࠬ஢ 㯯 ⨪{\n #}{\n #}&LGPO.exe /t "%LGPOtemp%" /q
	if exist "%LGPOtemp%" del /f /q "%LGPOtemp%"