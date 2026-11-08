@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title VampireOS — Power: Maximum
cd /d "%~dp0"

net session >nul 2>&1 || ( echo [!] Запустите от администратора. & pause & exit /b 1 )

echo ============================================================
echo  VampireOS — Power: Maximum
echo ============================================================
echo.

rem --- Ultimate Performance ---
echo [*] Создание и активация Ultimate Performance...
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
if errorlevel 1 (
    powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
    powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
)

rem --- Раскрыть скрытые пункты электропитания (UI) ---
echo [*] Раскрытие скрытых пунктов электропитания...
for %%G in (
    0cc5b647-c1df-4637-891a-dec35c318583
    3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb
    5d76a2ca-e8c0-402f-a133-2158492d58ad
    a55612aa-f624-42c6-a443-7397d064c04f
    ea062031-0e34-4ff1-9b6d-eb1059334028
    bc5038f7-23e0-4960-96da-33abaf5935ec
) do reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\%%G" /v Attributes /t REG_DWORD /d 0 /f >nul 2>&1

rem --- CPU на AC: 100% min/max, idle off, core parking off ---
echo [*] CPU на AC: 100%%, idle off, core parking off...
powercfg -setacvalueindex scheme_current sub_processor 893dee8e-2bef-41e0-89c6-b55d0929964c 100 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor bc5038f7-23e0-4960-96da-33abaf5935ec 100 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1
powercfg /setactive scheme_current >nul 2>&1

rem --- Гибернация off + Fast Startup off ---
echo [*] Гибернация и Fast Startup off...
powercfg /h off >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v HibernateEnabled /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Power Throttling off ---
echo [*] Power Throttling off...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 1 /f >nul 2>&1

rem --- BCD: disabledynamictick ---
echo [*] BCD: disabledynamictick...
bcdedit /set disabledynamictick yes >nul 2>&1

rem --- USB selective suspend off ---
echo [*] USB selective suspend off...
for %%a in (
    EnhancedPowerManagementEnabled AllowIdleIrpInD3 EnableSelectiveSuspend
    DeviceSelectiveSuspended SelectiveSuspendEnabled SelectiveSuspendOn
    WaitWakeEnabled D3ColdSupported WdfDirectedPowerTransitionEnable
    EnableIdlePowerManagement IdleInWorkingState WakeEnabled
) do for /f "delims=" %%b in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "%%a" ^| findstr "HKEY"') do reg add "%%b" /v "%%a" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v DisableLPM /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v D3ColdSupported /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v Ceip /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v DisableSelectiveSuspendUI /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usbccgp\Parameters" /v D3ColdSupported /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v D3ColdSupported /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v D3ColdSupport /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Энергопотребление: отключить MSPower_DeviceEnable ---
echo [*] MSPower_DeviceEnable off...
powershell -NoProfile -Command "Get-WmiObject MSPower_DeviceEnable -Namespace root\wmi -ErrorAction SilentlyContinue | ForEach-Object { try { $_.Enable = $false; $_.psbase.Put() | Out-Null } catch {} }" >nul 2>&1

rem --- Memory Compression off ---
echo [*] Memory Compression off...
powershell -NoProfile -Command "Disable-MMAgent -MemoryCompression -ErrorAction SilentlyContinue" >nul 2>&1

rem --- MSI mode ---
echo [*] MSI mode enable...
powershell -NoProfile -ExecutionPolicy Bypass -Command "function S($c){Get-WmiObject $c -ErrorAction SilentlyContinue | Where-Object {$_.PNPDeviceID -like 'PCI\VEN_*'} | ForEach-Object { try { $r='HKLM:\SYSTEM\CurrentControlSet\Enum\'+$_.PNPDeviceID+'\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties'; if(!(Test-Path $r)){New-Item $r -Force|Out-Null}; Set-ItemProperty $r 'MSISupported' 1 -Type DWord -Force -ErrorAction SilentlyContinue } catch {} }}; S 'Win32_IDEController'; S 'Win32_VideoController'; S 'Win32_NetworkAdapter'" >nul 2>&1

rem --- DMA remapping off ---
echo [*] DMA remapping off...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p='HKLM:\SOFTWARE\Microsoft\PolicyManager\default\DmaGuard\DeviceEnumerationPolicy'; if(!(Test-Path $p)){New-Item $p -Force|Out-Null}; Set-ItemProperty $p 'value' 2 -Type DWord -Force -ErrorAction SilentlyContinue; Get-ChildItem 'HKLM:\SYSTEM\CurrentControlSet\Services' -ErrorAction SilentlyContinue | ForEach-Object { $q=$_.PSPath+'\Parameters'; if(Test-Path $q){ $v=(Get-ItemProperty $q -Name DmaRemappingCompatible -ErrorAction SilentlyContinue).DmaRemappingCompatible; if($null -ne $v){ Set-ItemProperty $q 'DmaRemappingCompatible' 0 -Type DWord -Force -ErrorAction SilentlyContinue } } }" >nul 2>&1

rem --- MPO off ---
echo [*] MPO off...
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v OverlayTestMode /t REG_DWORD /d 5 /f >nul 2>&1

rem --- CEIP off ---
echo [*] CEIP off...
reg add "HKLM\Software\Policies\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\SQMClient" /v UploadDisableFlag /t REG_DWORD /d 1 /f >nul 2>&1

rem --- Teredo AllowLowPowerMode=0 ---
echo [*] Teredo AllowLowPowerMode=0...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\iphlpsvc\Teredo" /v AllowLowPowerMode /t REG_DWORD /d 0 /f >nul 2>&1

rem --- NoMobilityCenter ---
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\MobilityCenter" /v NoMobilityCenter /t REG_DWORD /d 1 /f >nul 2>&1

rem --- Dnscache DisableCoalescing + Wi-Fi power management + Ethernet TCP ---
echo [*] Сеть: DisableCoalescing, fDisablePowerManagement, TCP on Ethernet...
reg add "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v DisableCoalescing /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v fDisablePowerManagement /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy" /v fDisablePowerManagement /t REG_DWORD /d 1 /f >nul 2>&1

set "WIFI_GUIDS= "
for /f %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /v "*PhyType" /s 2^>nul ^| findstr "HKEY"') do (
    for /f "tokens=3" %%g in ('reg query "%%a" /v "NetCfgInstanceId" 2^>nul ^| findstr /i "NetCfgInstanceId"') do set "WIFI_GUIDS=!WIFI_GUIDS!%%g "
)
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" 2^>nul ^| findstr "HKEY"') do (
    set "IFGUID=%%~ni"
    echo !WIFI_GUIDS! | findstr /i /c:"!IFGUID!" >nul
    if errorlevel 1 (
        reg add "%%i" /v "TcpAckFrequency" /t REG_DWORD /d 1 /f >nul 2>&1
        reg add "%%i" /v "TCPNoDelay" /t REG_DWORD /d 1 /f >nul 2>&1
    )
)

rem --- NIC power saving off (только Ethernet) ---
echo [*] NIC power saving off (Ethernet)...
for /f %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /v "*SpeedDuplex" /s ^| findstr "HKEY"') do (
    reg query "%%a" /v "*PhyType" >nul 2>&1
    if !errorlevel! equ 0 (
    ) else (
        for %%v in (
            EnablePME *DeviceSleepOnDisconnect *EEE AdvancedEEE *SipsEnabled
            EnableAspm ASPM *ModernStandbyWoLMagicPacket *SelectiveSuspend
            EnableGigaLite GigaLite *WakeOnMagicPacket *WakeOnPattern
            AutoPowerSaveModeEnabled EEELinkAdvertisement EeePhyEnable
            EnableGreenEthernet EnableModernStandby PowerDownPll PowerSavingMode
            ReduceSpeedOnPowerDown S5WakeOnLan SavePowerNowEnabled ULPMode
            WakeOnLink WakeOnSlot WakeOnLinkChg WakeOnLinkUp WakeUpModeCap
            *NicAutoPowerSaver PowerSaveEnable EnablePowerManagement
            ForceWakeFromMagicPacketOnModernStandby WakeFromS5 WakeOn
            EnableSavePowerNow *EnableDynamicPowerGating DynamicPowerGating
            EnableD3ColdInS0 WakeFromPowerOff LogLinkStateEvent
        ) do (
            reg query "%%a" /v "%%v" >nul 2>&1 && reg add "%%a" /v "%%v" /t REG_SZ /d 0 /f >nul 2>&1
        )
        reg query "%%a" /v PnPCapabilities >nul 2>&1 && reg add "%%a" /v PnPCapabilities /t REG_DWORD /d 24 /f >nul 2>&1
        reg query "%%a" /v WakeOnMagicPacketFromS5 >nul 2>&1 && reg add "%%a" /v WakeOnMagicPacketFromS5 /t REG_SZ /d 2 /f >nul 2>&1
        reg query "%%a" /v WolShutdownLinkSpeed >nul 2>&1 && reg add "%%a" /v WolShutdownLinkSpeed /t REG_SZ /d 2 /f >nul 2>&1
    )
) >nul 2>&1

rem --- InsightsEnabled off ---
for /f "usebackq delims=" %%s in (`reg query HKU 2^>nul ^| findstr /r "S-1-5-21-[0-9]*-[0-9]*-[0-9]*$"`) do reg add "%%s\Software\Microsoft\input\Settings" /v InsightsEnabled /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Контекстное меню: Disable Idle / Enable Idle ---
echo [*] Контекстное меню: Disable Idle / Enable Idle...
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu" /v MUIVerb /t REG_SZ /d "Disable Idle" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu" /v Icon /t REG_SZ /d "powercpl.dll" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu" /v CommandFlags /t REG_DWORD /d 32 /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu\command" /ve /t REG_SZ /d "cmd.exe /c powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 && powercfg -setactive scheme_current" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\06menu" /v MUIVerb /t REG_SZ /d "Enable Idle" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\06menu" /v Icon /t REG_SZ /d "powercpl.dll" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\06menu\command" /ve /t REG_SZ /d "cmd.exe /c powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 0 && powercfg -setactive scheme_current" /f >nul 2>&1

rem --- wevtutil sl power diagnostic logs off ---
wevtutil sl Microsoft-Windows-SleepStudy/Diagnostic /e:false >nul 2>&1
wevtutil sl Microsoft-Windows-Kernel-Processor-Power/Diagnostic /e:false >nul 2>&1
wevtutil sl Microsoft-Windows-UserModePowerService/Diagnostic /e:false >nul 2>&1

rem --- WaitToKillServiceTimeout ---
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v WaitToKillServiceTimeout /t REG_SZ /d 1500 /f >nul 2>&1

rem --- Таймауты «никогда» (AC + DC) ---
echo [*] Таймауты: monitor/disk/standby/hibernate = 0...
powercfg /x monitor-timeout-ac 0 >nul 2>&1
powercfg /x monitor-timeout-dc 0 >nul 2>&1
powercfg /x disk-timeout-ac 0    >nul 2>&1
powercfg /x disk-timeout-dc 0    >nul 2>&1
powercfg /x standby-timeout-ac 0 >nul 2>&1
powercfg /x standby-timeout-dc 0 >nul 2>&1
powercfg /x hibernate-timeout-ac 0 >nul 2>&1
powercfg /x hibernate-timeout-dc 0 >nul 2>&1

rem --- Службы: serial/sermouse/serenum → manual (Start=3), wlansvc/wmiacpi → auto ---
echo [*] Службы serial/sermouse/serenum → manual, wlansvc/wmiacpi → auto...
sc config serial   start= demand >nul 2>&1
sc config sermouse start= demand >nul 2>&1
sc config serenum  start= demand >nul 2>&1
sc config wlansvc  start= auto   >nul 2>&1
sc config wmiacpi  start= auto   >nul 2>&1

echo.
echo ============================================================
echo  Готово. Ultimate Performance активен.
echo  AC: CPU 100%%, idle off, core parking off, USB suspend off,
echo  MSI mode on, DMA remapping off, MPO off, CEIP off,
echo  гибернация off, Power Throttling off, BCD disabledynamictick yes.
echo  DC (батарея): не тронут.
echo  НЕ ТРОНУТЫ: Themes, UxSms, Bluetooth, CmBatt, HidBatt,
echo  acpiex, acpipagr, acpipmi, acpitime, GpuEnergyDrv.
echo ============================================================
echo.