:Start
@ECHO OFF
reg query "HKU\S-1-5-19\Environment" >nul 2>&1 & cls
if "%Errorlevel%" NEQ "0" (
)
Rem Enable Delayed Expansion
setlocal EnableDelayedExpansion
REM 塞 祭 ६
set "sFreeSize="
set "sFreeSizePseudoMb1="
set "Freed="
cd /d "%~dp0WorkFiles"
Title DefenderKiller
@cmdow @ /SIZ 1000 700
set ch="cecho.exe"
qprocess "Win 10 Tweaker.exe">nul 2>&1 || nircmd.exe win center alltop
ConX.exe show
%ch% {0f}饭  ࠢ: {04}%username%{\n #}
%ch% {0f}Delete Defender : {0b}6 By Vlado  W10T{\n #}
echo.
%ch% {0f}Windows Defender: 
if not exist "%ProgramFiles%\Windows Defender" (%ch% {2f}  Windows{08} [ Windows Defender ]{\n #}) else (%ch% {4f} 㤠^^^!{0c} [ Windows Defender ]{\n #})
rem ⪫祭  ⭨
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" >nul 2>&1
if "%ERRORLEVEL%"=="0" (
%ch% {0f}Windows Defender: {0a}⭨ ⪫祭 {08}[१ ॥: DisableAntiSpyware]{\n #}
)
if "%ERRORLEVEL%"=="1" (
%ch% {0f}Windows Defender: {0c}⭨ 祭 {08}[१ ॥]{\n #}
)
echo.
%ch% {03} ⭨:{\n #}
%ch% {0f} AntimalwareService:   {#} 
qprocess "MsMpEng.exe">nul 2>&1 && %ch% {04} 饭{\n #}|| %ch% {0a}  饭{\n #}
%ch% {0f} SecurityHealthService:{#} 
qprocess "SecurityHealthService.exe">nul 2>&1 && %ch% {04} 饭{\n #}|| %ch% {0a}  饭{\n #}
%ch% {0f} SecurityHealthSystray:{#} 
qprocess "SecurityHealthSystray.exe">nul 2>&1 && %ch% {04} 饭{\n #}|| %ch% {0a}  饭{\n #}
%ch% {0f} SecurityHealthHost:   {#} 
qprocess "SecurityHealthHost.exe">nul 2>&1 && %ch% {04} 饭{\n #}|| %ch% {0a}  饭{\n #}
%ch% {0f} SmartScreen ⭨:{#} 
qprocess "smartscreen.exe">nul 2>&1 && %ch% {04} 饭{\n #}|| %ch% {0a}  饭{\n #}
%ch% {0f} ப SgrmBroker:    {#} 
qprocess "SgrmBroker.exe">nul 2>&1 && %ch% {04} 饭{\n #}|| %ch% {0a}  饭{\n #}
%ch% {0f} ⭨ SecHealthUI:{#} 
qprocess "SecHealthUI.exe">nul 2>&1 && %ch% {04} 饭{\n #}|| %ch% {0a}  饭{\n #}
%ch% {0f} Update Health uhssvc: {#} 
qprocess "uhssvc.exe">nul 2>&1 && %ch% {04} 饭{\n #}|| %ch% {0a}  饭{\n #}
echo.
rem ஢ઠ 㦡  ࠩ஢
%ch% {03}㦡 ⭨:{\n #}
%ch% {0f}WinDefend:     {#} 
sc query WinDefend >nul 2>&1
if ERRORLEVEL 1 (%ch% {0a} {\n #}) else (
sc query WinDefend | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}⪫祭{\n #}) ELSE (%ch% {04}饭{\n #}))
%ch% {0f}WdNisSvc:      {#} 
sc query WdNisSvc >nul 2>&1
if ERRORLEVEL 1 (%ch% {0a} {\n #}) else (
sc query WdNisSvc | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}⪫祭{\n #}) ELSE (%ch% {04}饭{\n #}))
%ch% {0f}Sense:         {#} 
sc query Sense >nul 2>&1
if ERRORLEVEL 1 (%ch% {0a} {\n #}) else (
sc query Sense | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}⪫祭{\n #}) ELSE (%ch% {04}饭{\n #}))
%ch% {0f}SecurityHealth:{#} 
sc query SecurityHealthService >nul 2>&1
if ERRORLEVEL 1 (%ch% {0a} {\n #}) else (
sc query SecurityHealthService | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}⪫祭{\n #}) ELSE (%ch% {04}饭{\n #}))
%ch% {0f}wscsvc:        {#} 
sc query wscsvc >nul 2>&1
if ERRORLEVEL 1 (%ch% {0a} {\n #}) else (
sc query wscsvc | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}⪫祭{\n #}) ELSE (%ch% {04}饭{\n #}))
%ch% {0f}SgrmBroker:     {#}
sc query SgrmBroker >nul 2>&1
if ERRORLEVEL 1 (%ch% {0a} {\n #}) else (
sc query SgrmBroker | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}⪫祭{\n #}) ELSE (%ch% {04}饭{\n #}))
echo.
%ch% {03}ࠩ ⭨:{\n #}
%ch% {0f}WdNisDrv:{#} 
sc query WdNisDrv >nul 2>&1
if ERRORLEVEL 1 (%ch% {08} {#} ) else (
sc query WdNisDrv | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}⪫祭{#} ) ELSE (%ch% {04}饭{#} ))
%ch% {0f}WdBoot:{#} 
sc query WdBoot >nul 2>&1
if ERRORLEVEL 1 (%ch% {08} {#} ) else (
sc query WdBoot | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}⪫祭{#} ) ELSE (%ch% {04}饭{#} ))
%ch% {0f}WdFilter:{#} 
sc query WdFilter >nul 2>&1
if ERRORLEVEL 1 (%ch% {08} {#} ) else (
sc query WdFilter | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}⪫祭{#} ) ELSE (%ch% {04}饭{#} ))
%ch% {0f}MsSecFlt:{#} 
sc query MsSecFlt >nul 2>&1
if ERRORLEVEL 1 (%ch% {08} {#} ) else (
sc query MsSecFlt | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}⪫祭{#} ) ELSE (%ch% {04}饭{#} ))
%ch% {0f}SgrmAgent:{#} 
sc query SgrmAgent >nul 2>&1
if ERRORLEVEL 1 (%ch% {08} {\n #}) else (
sc query SgrmAgent | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (%ch% {0a}⪫祭{\n #}) ELSE (%ch% {04}饭{\n #}))
rem ஢ઠ 
set "taskpathDef1=Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance"
set "taskpathDef2=Microsoft\Windows\Windows Defender\Windows Defender Cleanup"
set "taskpathDef3=Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
set "taskpathDef4=Microsoft\Windows\Windows Defender\Windows Defender Verification"
for /f "delims=, tokens=3" %%I in (' 2^>nul SCHTASKS /QUERY /FO CSV /NH /TN "%taskpathDef1%" ') do set "replyTaskDef1=%%~I"
for /f "delims=, tokens=3" %%I in (' 2^>nul SCHTASKS /QUERY /FO CSV /NH /TN "%taskpathDef2%" ') do set "replyTaskDef2=%%~I"
for /f "delims=, tokens=3" %%I in (' 2^>nul SCHTASKS /QUERY /FO CSV /NH /TN "%taskpathDef3%" ') do set "replyTaskDef3=%%~I"
for /f "delims=, tokens=3" %%I in (' 2^>nul SCHTASKS /QUERY /FO CSV /NH /TN "%taskpathDef4%" ') do set "replyTaskDef4=%%~I"
if not "!replyTaskDef1!"=="" (
	if "!replyTaskDef1!"=="⪫祭" ( set "TaskDefResult1={0a}⪫祭{#}" ) else ( set "TaskDefResult1={04}祭{#}" )
) else ( set "TaskDefResult1={0a} {#}" )
if not "!replyTaskDef2!"=="" (
	if "!replyTaskDef2!"=="⪫祭" ( set "TaskDefResult2={0a}⪫祭{#}" ) else ( set "TaskDefResult2={04}祭{#}" )
) else ( set "TaskDefResult2={0a} {#}" )
if not "!replyTaskDef3!"=="" (
	if "!replyTaskDef3!"=="⪫祭" ( set "TaskDefResult3={0a}⪫祭{#}" ) else ( set "TaskDefResult3={04}祭{#}" )
) else ( set "TaskDefResult3={0a} {#}" )
if not "!replyTaskDef4!"=="" (
	if "!replyTaskDef4!"=="⪫祭" ( set "TaskDefResult4={0a}⪫祭{#}" ) else ( set "TaskDefResult4={04}祭{#}" )
) else ( set "TaskDefResult4={0a} {#}" )
echo.
%ch% {03}  ஢騪:{\n #}
%ch% {0f}1. Windows Defender Cache Maintenance: %TaskDefResult1%{\n #}
%ch% {0f}2. Windows Defender Cleanup:           %TaskDefResult2%{\n #}
%ch% {0f}3. Windows Defender Scheduled Scan:    %TaskDefResult3%{\n #}
%ch% {0f}4. Windows Defender Verification:      %TaskDefResult4%{\n #}
rem  ⭨
if not exist "%SYSTEMROOT%\System32\Tasks\Microsoft\Windows\Windows Defender" (set "TasksDefender={0a} ⭨ 㤠{#}") else (set "TasksDefender={4f}  㤠!{#}")
%ch% {04}^----^>{#} {0f} ( Tasks): %TasksDefender% {\n #}
echo.
%ch% {0f} 1{#} - {0a} {08}[⭮]{\n #}
%ch% {0f} 2{#} - {08}⪫祭/祭 {08}[ ᨬ  ﭨ. ॡ १㧪]{\n #}
%ch% {0f} 3{#} - {0c}஡ ﭨ ⠫ ⭨{\n #}
%ch% {08} 4{#} - {08}ChangeLog{\n #}
echo.
set "input="
set /p input=*    롮: 
if "%input%"=="1"    ( cls && goto DeleteDefender)
if "%input%"=="2"    ( cls && goto OnOffDefender)
if "%input%"=="3"    ( cls && goto Catalogs)
if "%input%"=="4"    ( cls && goto ChangeLog )
) else (
	cls & goto Start
)
:DeleteDefender
rem ⠥   ᪥ । 㤠
setlocal enableextensions enabledelayedexpansion
for /f "usebackq tokens=2 delims==" %%i in (`wmic.exe LogicalDisk where "Name='c:'" get FreeSpace /value`) do set sFreeSize=%%i
if defined sFreeSize (set sFreeSizePseudoMb=%sFreeSize:~0,-7%)
sc query WinDefend >nul 2>&1
if ERRORLEVEL 1 (
%ch% {0c} , ⭨ 㦥 㤠.    ࠢ ஢ 㤠?{\n #}
%ch% {08} 1{#} - {0c}{\n #}
%ch% {08} 2{#} - {08}⬥{\n #}
choice /c 12 /n /m " "
if ERRORLEVEL 2 cls && goto Start
)
if not exist FuckDefender.exe (
%ch% {04} FuckDefender  㦥  ࠡ祩 {\n #}
echo  ॥ ᥣ  㤠 ⭨ ... 
echo  㤥 믮 㤠  
echo  , ᫥ 㤠  ணࠬ, 室 ⥫쭮 ன FuckDefender
echo  https://win10tweaker.ru/fwd
echo.
)
cls
rem   
@cmdow @ /TOP
rem 蠥  ⭨
%ch%    {0f} 蠥  ⭨ ...{\n #}
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
%ch%    {0e} ⪫砥 ⭨  smartscreen ...{\n #}
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t reg_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t reg_DWORD /d 0 /f >nul
ren "%SystemRoot%\System32\smartscreen.exe" "smartscreen_fuck.exe" >nul 2>&1
echo.
if not exist "%SystemDrive%\Program Files\Windows Defender" (
%ch%    {0c} ய 㤠 FuckDefender' ? {\n #}
%ch% {0f} 1 - ,  ய᪠{\n #}
%ch% {0f} 2 - ,  㦥 㤠 2 ࠧ  筮 㢥७,  ⭨ 㤠   㤠 ⠫ {\n #}
choice /c 12 /n /m " "
if ERRORLEVEL 2 goto NotFuckWD
if ERRORLEVEL 1 echo>nul
)
rem ᪠ FuckDefender
start FuckDefender.exe
:#
(
for /f %%i in ('"tasklist| findstr /bilc:"FuckDefender.exe""') do (%ch%    {04} 砫 㤠.{\n #} && echo. && %ch% {0e}    믮 㤠 ...{\n #})
)|| goto #
timeout /t 1 /nobreak >nul
echo.
%ch%    {0f}   ...{\n #}
timeout /t 1 /nobreak>nul
:reload
tasklist | find "FuckDefender.exe" >nul 2>&1
if ERRORLEVEL 1 goto NoRecord
goto reload
:NoRecord
echo.
%ch%    {0a}  뢠  ணࠬ ...{\n #}
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
%ch%    {0e} 塞 㦡 Windows Defender ...{\n #}
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
%ch%    {0e} 塞   ஢騪 ...{\n #}
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
%ch%    {0e} ⪫砥 ࠩ Windows Defender ...{\n #}
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
%ch%    {0e} 頥 ⥪⭮   Windows Defender ...{\n #}
reg delete "HKCR\*\shellex\ContextMenuHandlers\EPP" /f >nul 2>&1
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /f >nul 2>&1
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /f >nul 2>&1
echo.
rem 塞   १ CMD
%ch%    {0e} 塞   䠩 Windows Defender ...{\n #}
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
REM     WinSxS
REM For /F "usebackq delims=" %%d In (`2^>nul Dir "C:\Windows\WinSxS\*windows-defender*" /S /B /A:D`) Do Rd "%%d" /s /q
wmic os get caption /Format:List | find /i "11" >nul 2>&1
if "%ERRORLEVEL%"=="0" (
%ch%    {0b}  - Windows 11. 塞 ⭨  ࠧ.
start /wait FuckDefender.exe
>nul 2>&1 taskkill /f /im Unlocker.exe
>nul 2>&1 taskkill /f /im FuckDefender.exe
>nul 2>&1 taskkill /f /im wscript.exe
)
rem Make window not always on top
@cmdow @ /NOT
rem    ᪥ ᫥ 㤠
for /f "usebackq tokens=2 delims==" %%i in (`wmic.exe LogicalDisk where "Name='c:'" get FreeSpace /value`) do set sFreeSize=%%i
if defined sFreeSize (set sFreeSizePseudoMb1=%sFreeSize:~0,-7%)
set /a Freed=!sFreeSizePseudoMb1! - !sFreeSizePseudoMb!
echo.
%ch%     {2f}!Freed!  ᢮{\n #}
echo.
powershell -command "[Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms');[Windows.Forms.MessageBox]::show('⭨ Windows 㤠  ⥬. ॡ १㧪  .', 'DefenderKiller By Vlado')" >nul
%ch%    {0c}    室.{\n #}
:OnOffDefender
if not exist "%ProgramFiles%\Windows Defender" (
powershell -command "[Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms');[Windows.Forms.MessageBox]::show('⭨ 㤠, ⪫ 祣')" >nul
goto Start)
sc query SecurityHealthService | find /i "RUNNING" >nul 2>&1
IF ERRORLEVEL 1 (
%ch% {0e} 砥 ⭨ ...{\n #}
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
powershell -command "[Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms');[Windows.Forms.MessageBox]::show('⭨ Windows 祭. ॡ १㧪  .', 'DefenderDisabler')" >nul
) else (
%ch% {0e} ⪫砥 ⭨ ...{\n #}
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
powershell -command "[Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms');[Windows.Forms.MessageBox]::show('⭨ Windows ⪫祭. ॡ १㧪  .', 'DefenderDisabler')" >nul
)
:ChangeLog
rem ChangeLog
%ch% {0c} v. 6{\n #}
echo -ࠢ쭮 㤠 WindowsDefenderApplicationGuard.wim
echo -  㢨 ⥪饥 ﭨ ⠫ ⭨
echo - ⠫  㤠  ᫥ ᨩ Windows 10  11
echo -  ⥫쭮 㤠   ஢騪  ⪫祭 ᮢ
echo - ஢ન  稥 ⭨
%ch% {0c} v. 5.2{\n #}
echo - ⪫祭/祭 ⭨  㤠. ॡ १㧪 
%ch% {0c} v. 5.1{\n #}
echo - ᨩ ணࠬ   26  "" , 稭  1 ᨨ
echo -ࠢ  䥩, 騩 - ६ ᪠ ⢨  ணࠬ
%ch% {0c} v. 5{\n #}
echo -訥 ࠢ 䥩  ⨥   ਫ
echo -smartscreen ⥯ ⪫砥  १ ॥
echo -⥭ ,  FuckWD ⥪⨫ ⨢ᠬ  㤠 室 ந  
%ch% {0c} v. 4{\n #}
echo -ࠢ changelog
echo - ஢ઠ । 㤠  稥 ⭨  ⥬  뢮 ᮮ⢥饣 ᮮ饭
echo - ࠧ  , ᪮   ⥪ 頫
echo - 㤠   砬 ⭨
echo -० smartscreen
echo - ஢ઠ  ﭨ ⭨  ⪫祭 ⭨, ᫨  ⪫祭
%ch% {0c} v. 3{\n #}
echo - ChangeLog
echo - ஢ઠ, ᫨ ⠭ Windows 11 - 室 ⥫ ࠧ FuckDefender
echo - ஢ઠ  ࠢ TI । 㤠
echo -訥 ࠢ 䥩,   ᠭ 㭪権
echo - ᯮᮡ 祭 ଠ樨  饭  ⭨
echo -㤠 譨 ६
%ch% {0c} v. 2{\n #}
echo - 梥
echo - 室  祭 ⨢ ࠢ  ᪥, ᫨ 祭 UAC
%ch% {0c} v. 1{\n #}
echo -ᮧ  ࠢ 
echo.
%ch% {08}    {\n #}
:Catalogs
%ch% {0e} C:\Program Files:{\n #}
if not exist "%SystemDrive%\Program Files\Windows Defender" (
%ch% {0f}C:\Program Files\Windows Defender {0a}{\n #}
) else (
%ch% {0f}C:\Program Files\Windows Defender {4f} {\n #}
)
if not exist "%SystemDrive%\Program Files\Windows Defender Advanced Threat Protection" (
%ch% {0f}C:\Program Files\Windows Defender Advanced Threat Protection {0a}{\n #}
) else (
%ch% {0f}C:\Program Files\Windows Defender Advanced Threat Protection {04} {\n #}
)
if not exist "%SystemDrive%\Program Files\Windows Security" (
%ch% {0f}C:\Program Files\Windows Security {0a}{\n #}
) else (
%ch% {0f}C:\Program Files\Windows Security {04} {\n #}
)
if not exist "%SystemDrive%\Program Files\PCHealthCheck" (
%ch% {0f}C:\Program Files\PCHealthCheck {0a}{\n #}
) else (
%ch% {0f}C:\Program Files\PCHealthCheck {04} {\n #}
)
if not exist "%SystemDrive%\Program Files\Microsoft Update Health Tools" (
%ch% {0f}C:\Program Files\Microsoft Update Health Tools {0a}{\n #}
) else (
%ch% {0f}C:\Program Files\Microsoft Update Health Tools {04} {\n #}
)
echo.
%ch% {0e} C:\Program Files (^x86^):{\n #}
if not exist "%ProgramFiles(x86)%\Windows Defender" (
%ch% {0f}C:\Program Files (^x86^)\Windows Defender {0a}{\n #}
) else (
%ch% {0f}C:\Program Files (^x86^)\Windows Defender {04} {\n #}
)
if not exist "%ProgramFiles(x86)%\Windows Defender Advanced Threat Protection" (
%ch% {0f}C:\Program Files (^x86^)\Windows Defender Advanced Threat Protection {0a}{\n #}
) else (
%ch% {0f}C:\Program Files (^x86^)\Windows Defender Advanced Threat Protection {04} {\n #}
)
echo.
%ch% {0e} C:\ProgramData\Microsoft:{\n #}
if not exist "%AllUsersProfile%\Microsoft\Windows Defender" (
%ch% {0f}C:\ProgramData\Microsoft\Windows Defender {0a}{\n #}
) else (
%ch% {0f}C:\ProgramData\Microsoft\Windows Defender {04} {\n #}
)
if not exist "%AllUsersProfile%\Microsoft\Windows Defender Advanced Threat Protection" (
%ch% {0f}C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection {0a}{\n #}
) else (
%ch% {0f}C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection {04} {\n #}
)
if not exist "%AllUsersProfile%\Microsoft\Windows Security Health" (
%ch% {0f}C:\ProgramData\Microsoft\Windows Security Health {0a}{\n #}
) else (
%ch% {0f}C:\ProgramData\Microsoft\Windows Security Health {04} {\n #}
)
echo.
%ch% {0e} WindowsDefenderApplicationGuard.wim:{\n #}
if not exist "%SystemRoot%\Containers\WindowsDefenderApplicationGuard.wim" (
%ch% {0f}C:\Windows\Containers\WindowsDefenderApplicationGuard.wim {0a}{\n #}
) else (
%ch% {0f}C:\Windows\Containers\WindowsDefenderApplicationGuard.wim {04} {\n #}
)
if not exist "%SystemRoot%\Containers\serviced\WindowsDefenderApplicationGuard.wim" (
%ch% {0f}C:\Windows\Containers\serviced\WindowsDefenderApplicationGuard.wim {0a}{\n #}
) else (
%ch% {0f}C:\Windows\Containers\serviced\WindowsDefenderApplicationGuard.wim {04} {\n #}
)
echo.
%ch% {08}    {\n #}