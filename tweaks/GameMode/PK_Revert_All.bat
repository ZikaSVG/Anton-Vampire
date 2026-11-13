@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title VampireOS — PK: Revert All (Balanced)
cd /d "%~dp0"

net session >nul 2>&1 || ( echo [!] Запустите от администратора. & pause & exit /b 1 )

echo ============================================================
echo  VampireOS — PK: Revert All (Balanced)
echo ============================================================
echo.
rem --- Balanced ---
echo [*] Активация Balanced...
powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul 2>&1
if errorlevel 1 powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a >nul 2>&1

rem --- CPU на AC: дефолт ---
echo [*] CPU на AC: 5%%/100%%, idle on...
powercfg -setacvalueindex scheme_current sub_processor 893dee8e-2bef-41e0-89c6-b55d0929964c 5 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor bc5038f7-23e0-4960-96da-33abaf5935ec 100 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 0 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1
powercfg /setactive scheme_current >nul 2>&1

rem --- Гибернация on + Fast Startup on ---
echo [*] Гибернация и Fast Startup on...
powercfg /h on >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v HibernateEnabled /t REG_DWORD /d 1 /f >nul 2>&1

rem --- Power Throttling on ---
echo [*] Power Throttling on...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 0 /f >nul 2>&1

rem --- BCD: удалить disabledynamictick ---
echo [*] BCD: delete disabledynamictick...
bcdedit /deletevalue disabledynamictick >nul 2>&1

rem --- USB selective suspend on (удаляем значения) ---
echo [*] USB selective suspend on...
for %%a in (
    EnhancedPowerManagementEnabled
    AllowIdleIrpInD3
    EnableSelectiveSuspend
    DeviceSelectiveSuspended
    SelectiveSuspendEnabled
    SelectiveSuspendOn
    WaitWakeEnabled
    D3ColdSupported
    WdfDirectedPowerTransitionEnable
    EnableIdlePowerManagement
    IdleInWorkingState
    WakeEnabled
) do for /f "delims=" %%b in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "%%a" ^| findstr "HKEY"') do reg delete "%%b" /v "%%a" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v DisableLPM /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v D3ColdSupported /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v Ceip /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v DisableSelectiveSuspendUI /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\usbccgp\Parameters" /v D3ColdSupported /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v D3ColdSupported /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v D3ColdSupport /f >nul 2>&1

rem --- MSPower_DeviceEnable on ---
echo [*] MSPower_DeviceEnable on...
powershell -NoProfile -Command "Get-WmiObject MSPower_DeviceEnable -Namespace root\wmi -ErrorAction SilentlyContinue | ForEach-Object { try { $_.Enable = $true; $_.psbase.Put() | Out-Null } catch {} }" >nul 2>&1

rem --- Memory Compression on ---
echo [*] Memory Compression on...
powershell -NoProfile -Command "Enable-MMAgent -MemoryCompression -ErrorAction SilentlyContinue" >nul 2>&1

rem --- MSI mode off ---
echo [*] MSI mode off...
powershell -NoProfile -ExecutionPolicy Bypass -Command "function S($c){Get-WmiObject $c -ErrorAction SilentlyContinue | Where-Object {$_.PNPDeviceID -like 'PCI\VEN_*'} | ForEach-Object { try { $r='HKLM:\SYSTEM\CurrentControlSet\Enum\'+$_.PNPDeviceID+'\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties'; if(Test-Path $r){ Set-ItemProperty $r 'MSISupported' 0 -Type DWord -Force -ErrorAction SilentlyContinue } } catch {} }}; S 'Win32_IDEController'; S 'Win32_VideoController'; S 'Win32_NetworkAdapter'" >nul 2>&1

rem --- DMA remapping on ---
echo [*] DMA remapping on...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p='HKLM:\SOFTWARE\Microsoft\PolicyManager\default\DmaGuard\DeviceEnumerationPolicy'; if(Test-Path $p){ Set-ItemProperty $p 'value' 0 -Type DWord -Force -ErrorAction SilentlyContinue }; Get-ChildItem 'HKLM:\SYSTEM\CurrentControlSet\Services' -ErrorAction SilentlyContinue | ForEach-Object { $q=$_.PSPath+'\Parameters'; if(Test-Path $q){ $v=(Get-ItemProperty $q -Name DmaRemappingCompatible -ErrorAction SilentlyContinue).DmaRemappingCompatible; if($null -ne $v){ Set-ItemProperty $q 'DmaRemappingCompatible' 1 -Type DWord -Force -ErrorAction SilentlyContinue } } }" >nul 2>&1

rem --- MPO on ---
echo [*] MPO on...
reg delete "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v OverlayTestMode /f >nul 2>&1

rem --- CEIP on ---
echo [*] CEIP on...
reg add "HKLM\Software\Policies\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\SQMClient" /v UploadDisableFlag /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Teredo AllowLowPowerMode=1 ---
echo [*] Teredo AllowLowPowerMode=1...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\iphlpsvc\Teredo" /v AllowLowPowerMode /t REG_DWORD /d 1 /f >nul 2>&1

rem --- NoMobilityCenter=0 ---
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\MobilityCenter" /v NoMobilityCenter /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Сеть: DisableCoalescing=0, fDisablePowerManagement=0, TCPNoDelay=0 ---
echo [*] Сеть: DisableCoalescing=0, fDisablePowerManagement=0, TCPNoDelay=0...
reg add "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v DisableCoalescing /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v fDisablePowerManagement /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy" /v fDisablePowerManagement /t REG_DWORD /d 0 /f >nul 2>&1
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" 2^>nul ^| findstr "HKEY"') do (
    reg delete "%%i" /v "TcpAckFrequency" /f >nul 2>&1
    reg delete "%%i" /v "TCPNoDelay" /f >nul 2>&1
)

rem --- NIC power saving on (удаляем значения, только Ethernet) ---
echo [*] NIC power saving on (Ethernet)...
for /f %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /v "*SpeedDuplex" /s ^| findstr "HKEY"') do (
    reg query "%%a" /v "*PhyType" >nul 2>&1
    if !errorlevel! equ 0 (
    ) else (
        for %%v in (
            EnablePME
            *DeviceSleepOnDisconnect
            *EEE
            AdvancedEEE
            *SipsEnabled
            EnableAspm
            ASPM
            *ModernStandbyWoLMagicPacket
            *SelectiveSuspend
            EnableGigaLite
            GigaLite
            *WakeOnMagicPacket
            *WakeOnPattern
            AutoPowerSaveModeEnabled
            EEELinkAdvertisement
            EeePhyEnable
            EnableGreenEthernet
            EnableModernStandby
            PowerDownPll
            PowerSavingMode
            ReduceSpeedOnPowerDown
            S5WakeOnLan
            SavePowerNowEnabled
            ULPMode
            WakeOnLink
            WakeOnSlot
            WakeOnLinkChg
            WakeOnLinkUp
            WakeUpModeCap
            *NicAutoPowerSaver
            PowerSaveEnable
            EnablePowerManagement
            ForceWakeFromMagicPacketOnModernStandby
            WakeFromS5
            WakeOn
            EnableSavePowerNow
            *EnableDynamicPowerGating
            DynamicPowerGating
            EnableD3ColdInS0
            WakeFromPowerOff
            LogLinkStateEvent
        ) do reg delete "%%a" /v "%%v" /f >nul 2>&1
        reg delete "%%a" /v PnPCapabilities /f >nul 2>&1
        reg delete "%%a" /v WakeOnMagicPacketFromS5 /f >nul 2>&1
        reg delete "%%a" /v WolShutdownLinkSpeed /f >nul 2>&1
    )
) >nul 2>&1

rem --- InsightsEnabled=1 ---
for /f "usebackq delims=" %%s in (`reg query HKU 2^>nul ^| findstr /r "S-1-5-21-[0-9]*-[0-9]*-[0-9]*$"`) do reg delete "%%s\Software\Microsoft\input\Settings" /v InsightsEnabled /f >nul 2>&1

rem --- wevtutil sl power diagnostic logs on ---
wevtutil sl Microsoft-Windows-SleepStudy/Diagnostic /e:true >nul 2>&1
wevtutil sl Microsoft-Windows-Kernel-Processor-Power/Diagnostic /e:true >nul 2>&1
wevtutil sl Microsoft-Windows-UserModePowerService/Diagnostic /e:true >nul 2>&1

rem --- WaitToKillServiceTimeout=5000 ---
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v WaitToKillServiceTimeout /t REG_SZ /d 5000 /f >nul 2>&1

rem --- Таймауты default (отмена «0» из MAX) ---
echo [*] Таймауты: monitor 10/5, disk 20/10, sleep 30/15, hibernate 180/60...
powercfg /x monitor-timeout-ac 10    >nul 2>&1
powercfg /x monitor-timeout-dc 5     >nul 2>&1
powercfg /x disk-timeout-ac 20       >nul 2>&1
powercfg /x disk-timeout-dc 10       >nul 2>&1
powercfg /x standby-timeout-ac 30    >nul 2>&1
powercfg /x standby-timeout-dc 15    >nul 2>&1
powercfg /x hibernate-timeout-ac 180 >nul 2>&1
powercfg /x hibernate-timeout-dc 60  >nul 2>&1

rem --- Службы: serial/sermouse/serenum/wlansvc/wmiacpi → auto ---
echo [*] Службы serial/sermouse/serenum/wlansvc/wmiacpi → auto...
sc config serial   start= auto >nul 2>&1
sc config sermouse start= auto >nul 2>&1
sc config serenum  start= auto >nul 2>&1
sc config wlansvc  start= auto >nul 2>&1
sc config wmiacpi  start= auto >nul 2>&1

echo.
echo ============================================================
echo  Готово: Откат к Balanced выполнен. Все настройки питания сброшены.
echo ============================================================
echo.
