@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title VampireOS — Power: Max Saver
cd /d "%~dp0"

net session >nul 2>&1 || ( echo [!] Запустите от администратора. & pause & exit /b 1 )

echo ============================================================
echo  VampireOS — Power: Maximum Energy Saving
echo ============================================================
echo.

rem --- Power Saver scheme ---
echo [*] Активация Power Saver...
powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a >nul 2>&1

rem --- CPU: 5% min / 50% max (AC + DC) ---
echo [*] CPU: 5%% / 50%% (AC + DC)...
powercfg -setacvalueindex scheme_current sub_processor 893dee8e-2bef-41e0-89c6-b55d0929964c 5 >nul 2>&1
powercfg -setdcvalueindex scheme_current sub_processor 893dee8e-2bef-41e0-89c6-b55d0929964c 5 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor bc5038f7-23e0-4960-96da-33abaf5935ec 50 >nul 2>&1
powercfg -setdcvalueindex scheme_current sub_processor bc5038f7-23e0-4960-96da-33abaf5935ec 50 >nul 2>&1

rem --- Idle on + aggressive core parking ---
echo [*] Idle on, core parking aggressive...
powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 0 >nul 2>&1
powercfg -setdcvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 0 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor 0cc5b647-c1df-4637-891a-dec35c318583 50 >nul 2>&1
powercfg -setdcvalueindex scheme_current sub_processor 0cc5b647-c1df-4637-891a-dec35c318583 50 >nul 2>&1

rem --- Boost mode disabled, cool policy passive ---
echo [*] Boost off, cool policy passive...
powercfg -setacvalueindex scheme_current sub_processor be337238-0d82-4146-a960-4f3749d470c7 0 >nul 2>&1
powercfg -setdcvalueindex scheme_current sub_processor be337238-0d82-4146-a960-4f3749d470c7 0 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor 94d3a615-a899-4ac5-ae2b-e4d8f634367f 0 >nul 2>&1
powercfg -setdcvalueindex scheme_current sub_processor 94d3a615-a899-4ac5-ae2b-e4d8f634367f 0 >nul 2>&1

rem --- Таймауты ---
echo [*] Таймауты: monitor 5, disk 5, sleep 15, hibernate 60...
powercfg /change monitor-timeout-ac 5 >nul 2>&1
powercfg /change monitor-timeout-dc 5 >nul 2>&1
powercfg /change disk-timeout-ac 5 >nul 2>&1
powercfg /change disk-timeout-dc 5 >nul 2>&1
powercfg /change standby-timeout-ac 15 >nul 2>&1
powercfg /change standby-timeout-dc 15 >nul 2>&1
powercfg /change hibernate-timeout-ac 60 >nul 2>&1
powercfg /change hibernate-timeout-dc 60 >nul 2>&1

rem --- Яркость 30% ---
echo [*] Яркость 30%%...
powercfg -setacvalueindex scheme_current sub_video aded5e82-b909-4619-9949-f5d71dac0bcb 30 >nul 2>&1
powercfg -setdcvalueindex scheme_current sub_video aded5e82-b909-4619-9949-f5d71dac0bcb 30 >nul 2>&1

rem --- Power Throttling ON ---
echo [*] Power Throttling on...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Гибернация on ---
echo [*] Гибернация on...
powercfg /h on >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v HibernateEnabled /t REG_DWORD /d 1 /f >nul 2>&1

rem --- USB selective suspend on ---
echo [*] USB selective suspend on...
for %%a in (
    EnhancedPowerManagementEnabled AllowIdleIrpInD3 EnableSelectiveSuspend
    DeviceSelectiveSuspended SelectiveSuspendEnabled SelectiveSuspendOn
    WaitWakeEnabled D3ColdSupported WdfDirectedPowerTransitionEnable
    EnableIdlePowerManagement IdleInWorkingState WakeEnabled
) do for /f "delims=" %%b in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "%%a" ^| findstr "HKEY"') do reg delete "%%b" /v "%%a" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v DisableLPM /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v D3ColdSupported /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v DisableSelectiveSuspendUI /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\usbccgp\Parameters" /v D3ColdSupported /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v D3ColdSupported /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v D3ColdSupport /f >nul 2>&1

rem --- NIC power saving on (Ethernet) ---
echo [*] NIC power saving on...
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
        ) do reg delete "%%a" /v "%%v" /f >nul 2>&1
        reg delete "%%a" /v PnPCapabilities /f >nul 2>&1
    )
) >nul 2>&1

rem --- Battery Saver threshold ---
echo [*] Battery saver threshold 20%%...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Power" /v BatterySaverThreshold /t REG_DWORD /d 20 /f >nul 2>&1

rem --- Wi-Fi power management on ---
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v fDisablePowerManagement /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy" /v fDisablePowerManagement /t REG_DWORD /d 0 /f >nul 2>&1

rem --- BCD: disabledynamictick удалить ---
echo [*] BCD: delete disabledynamictick...
bcdedit /deletevalue disabledynamictick >nul 2>&1

rem --- Memory Compression on ---
echo [*] Memory Compression on...
powershell -NoProfile -Command "Enable-MMAgent -MemoryCompression -ErrorAction SilentlyContinue" >nul 2>&1

powercfg /setactive scheme_current >nul 2>&1

echo.
echo ============================================================
echo  Готово. Power Saver активен.
echo  CPU 5%%/50%%, idle on, core parking aggressive, boost off,
echo  cool passive, monitor/disk 5 min, sleep 15 min, hibernate
echo  60 min, brightness 30%%, Power Throttling on, гибернация on,
echo  USB suspend on, NIC power saving on, battery saver 20%%.
echo  НЕ ТРОНУТЫ: Themes, UxSms, Bluetooth, CmBatt, HidBatt,
echo  acpiex, acpipagr, acpipmi, acpitime, GpuEnergyDrv.
echo ============================================================
echo.