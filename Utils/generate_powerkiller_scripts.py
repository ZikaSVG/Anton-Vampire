#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
generate_pk_bats.py
Генерирует все Power Killer .bat файлы в tweaks/GameMode/.

Использование:
    python generate_pk_bats.py [--out tweaks/GameMode]

Требует: Python 3.8+. Кодировка файлов — UTF-8 (chcp 65001 внутри).
"""

import argparse
import os
import sys

# ------------------------------------------------------------------
# Общие шаблоны
# ------------------------------------------------------------------

HEADER = """@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title {title}
cd /d "%~dp0"

net session >nul 2>&1 || ( echo [!] Запустите от администратора. & pause & exit /b 1 )

echo ============================================================
echo  {title}
echo ============================================================
echo.
"""

FOOTER = """
echo.
echo ============================================================
echo  Готово: {done_msg}
echo ============================================================
echo.
"""

# Список USB-параметров, которые нужно обнулить/удалить
USB_REGMARKS = [
    "EnhancedPowerManagementEnabled", "AllowIdleIrpInD3", "EnableSelectiveSuspend",
    "DeviceSelectiveSuspended", "SelectiveSuspendEnabled", "SelectiveSuspendOn",
    "WaitWakeEnabled", "D3ColdSupported", "WdfDirectedPowerTransitionEnable",
    "EnableIdlePowerManagement", "IdleInWorkingState", "WakeEnabled",
]

# Список NIC-параметров энергосбережения (только Ethernet)
NIC_PARAMS = [
    "EnablePME", "*DeviceSleepOnDisconnect", "*EEE", "AdvancedEEE", "*SipsEnabled",
    "EnableAspm", "ASPM", "*ModernStandbyWoLMagicPacket", "*SelectiveSuspend",
    "EnableGigaLite", "GigaLite", "*WakeOnMagicPacket", "*WakeOnPattern",
    "AutoPowerSaveModeEnabled", "EEELinkAdvertisement", "EeePhyEnable",
    "EnableGreenEthernet", "EnableModernStandby", "PowerDownPll", "PowerSavingMode",
    "ReduceSpeedOnPowerDown", "S5WakeOnLan", "SavePowerNowEnabled", "ULPMode",
    "WakeOnLink", "WakeOnSlot", "WakeOnLinkChg", "WakeOnLinkUp", "WakeUpModeCap",
    "*NicAutoPowerSaver", "PowerSaveEnable", "EnablePowerManagement",
    "ForceWakeFromMagicPacketOnModernStandby", "WakeFromS5", "WakeOn",
    "EnableSavePowerNow", "*EnableDynamicPowerGating", "DynamicPowerGating",
    "EnableD3ColdInS0", "WakeFromPowerOff", "LogLinkStateEvent",
]


def bat_header(title: str) -> str:
    return HEADER.format(title=title)


def bat_footer(done_msg: str) -> str:
    return FOOTER.format(done_msg=done_msg)


# ------------------------------------------------------------------
# 1. PK_Timeouts.bat
# ------------------------------------------------------------------
def make_timeouts() -> str:
    return bat_header("VampireOS — PK: Timeouts (AC/DC)") + """rem --- Таймауты «никогда» (AC + DC) ---
echo [*] Таймауты: monitor/disk/standby/hibernate = 0...
powercfg /x monitor-timeout-ac 0 >nul 2>&1
powercfg /x monitor-timeout-dc 0 >nul 2>&1
powercfg /x disk-timeout-ac 0    >nul 2>&1
powercfg /x disk-timeout-dc 0    >nul 2>&1
powercfg /x standby-timeout-ac 0 >nul 2>&1
powercfg /x standby-timeout-dc 0 >nul 2>&1
powercfg /x hibernate-timeout-ac 0 >nul 2>&1
powercfg /x hibernate-timeout-dc 0 >nul 2>&1

rem --- Гибернация off + Fast Startup off ---
echo [*] Гибернация и Fast Startup off...
powercfg /h off >nul 2>&1
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Control\\Power" /v HibernateEnabled /t REG_DWORD /d 0 /f >nul 2>&1

rem --- WaitToKillServiceTimeout ---
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Control" /v WaitToKillServiceTimeout /t REG_SZ /d 1500 /f >nul 2>&1
""" + bat_footer("Таймауты отключены, гибернация и Fast Startup выключены.")


# ------------------------------------------------------------------
# 2. PK_CPU_Throttle.bat
# ------------------------------------------------------------------
def make_cpu_throttle() -> str:
    return bat_header("VampireOS — PK: CPU Throttle off") + """rem --- Ultimate Performance ---
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
) do reg add "HKLM\\SYSTEM\\CurrentControlSet\\Control\\Power\\PowerSettings\\54533251-82be-4824-96c1-47b60b740d00\\%%G" /v Attributes /t REG_DWORD /d 0 /f >nul 2>&1

rem --- CPU на AC: 100% min/max, idle off, core parking off ---
echo [*] CPU на AC: 100%%, idle off, core parking off...
powercfg -setacvalueindex scheme_current sub_processor 893dee8e-2bef-41e0-89c6-b55d0929964c 100 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor bc5038f7-23e0-4960-96da-33abaf5935ec 100 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1
powercfg /setactive scheme_current >nul 2>&1

rem --- Контекстное меню: Disable Idle / Enable Idle ---
echo [*] Контекстное меню: Disable Idle / Enable Idle...
reg add "HKCR\\DesktopBackground\\Shell\\PowerPlan\\shell\\05menu" /v MUIVerb /t REG_SZ /d "Disable Idle" /f >nul 2>&1
reg add "HKCR\\DesktopBackground\\Shell\\PowerPlan\\shell\\05menu" /v Icon /t REG_SZ /d "powercpl.dll" /f >nul 2>&1
reg add "HKCR\\DesktopBackground\\Shell\\PowerPlan\\shell\\05menu" /v CommandFlags /t REG_DWORD /d 32 /f >nul 2>&1
reg add "HKCR\\DesktopBackground\\Shell\\PowerPlan\\shell\\05menu\\command" /ve /t REG_SZ /d "cmd.exe /c powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 && powercfg -setactive scheme_current" /f >nul 2>&1
reg add "HKCR\\DesktopBackground\\Shell\\PowerPlan\\shell\\06menu" /v MUIVerb /t REG_SZ /d "Enable Idle" /f >nul 2>&1
reg add "HKCR\\DesktopBackground\\Shell\\PowerPlan\\shell\\06menu" /v Icon /t REG_SZ /d "powercpl.dll" /f >nul 2>&1
reg add "HKCR\\DesktopBackground\\Shell\\PowerPlan\\shell\\06menu\\command" /ve /t REG_SZ /d "cmd.exe /c powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 0 && powercfg -setactive scheme_current" /f >nul 2>&1
""" + bat_footer("CPU throttle отключён, Ultimate Performance активен, idle off, core parking off.")


# ------------------------------------------------------------------
# 3. PK_Power_Throttling_DynamicTick.bat
# ------------------------------------------------------------------
def make_power_throttling() -> str:
    return bat_header("VampireOS — PK: Power Throttling & Dynamic Tick") + """rem --- Power Throttling off ---
echo [*] Power Throttling off...
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Control\\Power\\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 1 /f >nul 2>&1

rem --- BCD: disabledynamictick ---
echo [*] BCD: disabledynamictick...
bcdedit /set disabledynamictick yes >nul 2>&1

rem --- Memory Compression off ---
echo [*] Memory Compression off...
powershell -NoProfile -Command "Disable-MMAgent -MemoryCompression -ErrorAction SilentlyContinue" >nul 2>&1
""" + bat_footer("Power Throttling off, disabledynamictick yes, Memory Compression off.")


# ------------------------------------------------------------------
# 4. PK_USB_Power.bat
# ------------------------------------------------------------------
def make_usb_power() -> str:
    marks = "\n".join(f"    {m}" for m in USB_REGMARKS)
    return bat_header("VampireOS — PK: USB Power (LPM / D3Cold)") + f"""rem --- USB selective suspend off ---
echo [*] USB selective suspend off...
for %%a in (
{marks}
) do for /f "delims=" %%b in ('reg query "HKLM\\SYSTEM\\CurrentControlSet\\Enum" /s /f "%%a" ^| findstr "HKEY"') do reg add "%%b" /v "%%a" /t REG_DWORD /d 0 /f >nul 2>&1

rem --- USBHUB3 / usbccgp / pci ---
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Services\\USBHUB3\\Parameters" /v DisableLPM /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Services\\USBHUB3\\Parameters" /v D3ColdSupported /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Services\\USBHUB3\\Parameters" /v Ceip /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Services\\USBHUB3\\Parameters" /v DisableSelectiveSuspendUI /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Services\\usbccgp\\Parameters" /v D3ColdSupported /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Энергопотребление: отключить MSPower_DeviceEnable ---
echo [*] MSPower_DeviceEnable off...
powershell -NoProfile -Command "Get-WmiObject MSPower_DeviceEnable -Namespace root\\wmi -ErrorAction SilentlyContinue | ForEach-Object {{ try {{ $_.Enable = $false; $_.psbase.Put() | Out-Null }} catch {{}} }}" >nul 2>&1
""" + bat_footer("USB LPM / D3Cold / selective suspend отключены.")


# ------------------------------------------------------------------
# 5. PK_PCI_D3Cold.bat
# ------------------------------------------------------------------
def make_pci_d3cold() -> str:
    return bat_header("VampireOS — PK: PCI D3Cold / MSI mode / DMA remapping") + """rem --- PCI D3Cold off ---
echo [*] PCI D3Cold off...
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Services\\pci\\Parameters" /v D3ColdSupported /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Services\\pci\\Parameters" /v D3ColdSupport /t REG_DWORD /d 0 /f >nul 2>&1

rem --- MSI mode enable ---
echo [*] MSI mode enable...
powershell -NoProfile -ExecutionPolicy Bypass -Command "function S($c){{Get-WmiObject $c -ErrorAction SilentlyContinue | Where-Object {{$_.PNPDeviceID -like 'PCI\\VEN_*'}} | ForEach-Object {{ try {{ $r='HKLM:\\SYSTEM\\CurrentControlSet\\Enum\\'+$_.PNPDeviceID+'\\Device Parameters\\Interrupt Management\\MessageSignaledInterruptProperties'; if(!(Test-Path $r)){{New-Item $r -Force|Out-Null}}; Set-ItemProperty $r 'MSISupported' 1 -Type DWord -Force -ErrorAction SilentlyContinue }} catch {{}} }}}}; S 'Win32_IDEController'; S 'Win32_VideoController'; S 'Win32_NetworkAdapter'" >nul 2>&1

rem --- DMA remapping off ---
echo [*] DMA remapping off...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p='HKLM:\\SOFTWARE\\Microsoft\\PolicyManager\\default\\DmaGuard\\DeviceEnumerationPolicy'; if(!(Test-Path $p)){{New-Item $p -Force|Out-Null}}; Set-ItemProperty $p 'value' 2 -Type DWord -Force -ErrorAction SilentlyContinue; Get-ChildItem 'HKLM:\\SYSTEM\\CurrentControlSet\\Services' -ErrorAction SilentlyContinue | ForEach-Object {{ $q=$_.PSPath+'\\Parameters'; if(Test-Path $q){{ $v=(Get-ItemProperty $q -Name DmaRemappingCompatible -ErrorAction SilentlyContinue).DmaRemappingCompatible; if($null -ne $v){{ Set-ItemProperty $q 'DmaRemappingCompatible' 0 -Type DWord -Force -ErrorAction SilentlyContinue }} }} }}" >nul 2>&1

rem --- MPO off ---
echo [*] MPO off...
reg add "HKLM\\SOFTWARE\\Microsoft\\Windows\\Dwm" /v OverlayTestMode /t REG_DWORD /d 5 /f >nul 2>&1
""" + bat_footer("PCI D3Cold off, MSI mode on, DMA remapping off, MPO off.")


# ------------------------------------------------------------------
# 6. PK_Disable_Logs.bat
# ------------------------------------------------------------------
def make_logs() -> str:
    return bat_header("VampireOS — PK: Disable power diagnostic logs") + """rem --- wevtutil sl power diagnostic logs off ---
echo [*] Отключение диагностических журналов питания...
wevtutil sl Microsoft-Windows-SleepStudy/Diagnostic /e:false >nul 2>&1
wevtutil sl Microsoft-Windows-Kernel-Processor-Power/Diagnostic /e:false >nul 2>&1
wevtutil sl Microsoft-Windows-UserModePowerService/Diagnostic /e:false >nul 2>&1

rem --- CEIP off ---
reg add "HKLM\\Software\\Policies\\Microsoft\\SQMClient\\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\\Software\\Microsoft\\SQMClient\\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\\Software\\Microsoft\\SQMClient" /v UploadDisableFlag /t REG_DWORD /d 1 /f >nul 2>&1

rem --- Teredo AllowLowPowerMode=0 ---
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Services\\iphlpsvc\\Teredo" /v AllowLowPowerMode /t REG_DWORD /d 0 /f >nul 2>&1

rem --- NoMobilityCenter ---
reg add "HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\MobilityCenter" /v NoMobilityCenter /t REG_DWORD /d 1 /f >nul 2>&1

rem --- InsightsEnabled off ---
for /f "usebackq delims=" %%s in (`reg query HKU 2^>nul ^| findstr /r "S-1-5-21-[0-9]*-[0-9]*-[0-9]*$"`) do reg add "%%s\\Software\\Microsoft\\input\\Settings" /v InsightsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
""" + bat_footer("Диагностические журналы питания отключены, CEIP off, Teredo low power off.")


# ------------------------------------------------------------------
# 7. PK_Maximum.bat — ВСЁ СРАЗУ (объединение всех фич)
# ------------------------------------------------------------------
def make_maximum() -> str:
    marks = "\n".join(f"    {m}" for m in USB_REGMARKS)
    nic = "\n".join(f"            {p}" for p in NIC_PARAMS)
    return bat_header("VampireOS — PK: MAXIMUM (all-in-one)") + f"""rem ============================================================
rem  Этот скрипт объединяет ВСЁ из PK_Timeouts / CPU_Throttle /
rem  Power_Throttling / USB_Power / PCI_D3Cold / Logs.
rem ============================================================
echo.

rem --- Ultimate Performance ---
echo [*] Создание и активация Ultimate Performance...
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
if errorlevel 1 (
    powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
    powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
)

rem --- Раскрыть скрытые пункты электропитания ---
for %%G in (
    0cc5b647-c1df-4637-891a-dec35c318583
    3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb
    5d76a2ca-e8c0-402f-a133-2158492d58ad
    a55612aa-f624-42c6-a443-7397d064c04f
    ea062031-0e34-4ff1-9b6d-eb1059334028
    bc5038f7-23e0-4960-96da-33abaf5935ec
) do reg add "HKLM\\SYSTEM\\CurrentControlSet\\Control\\Power\\PowerSettings\\54533251-82be-4824-96c1-47b60b740d00\\%%G" /v Attributes /t REG_DWORD /d 0 /f >nul 2>&1

rem --- CPU на AC: 100% min/max, idle off, core parking off ---
echo [*] CPU на AC: 100%%, idle off, core parking off...
powercfg -setacvalueindex scheme_current sub_processor 893dee8e-2bef-41e0-89c6-b55d0929964c 100 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor bc5038f7-23e0-4960-96da-33abaf5935ec 100 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1
powercfg /setactive scheme_current >nul 2>&1

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

rem --- Гибернация off + Fast Startup off ---
echo [*] Гибернация и Fast Startup off...
powercfg /h off >nul 2>&1
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Control\\Power" /v HibernateEnabled /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Power Throttling off ---
echo [*] Power Throttling off...
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Control\\Power\\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 1 /f >nul 2>&1

rem --- BCD: disabledynamictick ---
echo [*] BCD: disabledynamictick...
bcdedit /set disabledynamictick yes >nul 2>&1

rem --- USB selective suspend off ---
echo [*] USB selective suspend off...
for %%a in (
{marks}
) do for /f "delims=" %%b in ('reg query "HKLM\\SYSTEM\\CurrentControlSet\\Enum" /s /f "%%a" ^| findstr "HKEY"') do reg add "%%b" /v "%%a" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Services\\USBHUB3\\Parameters" /v DisableLPM /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Services\\USBHUB3\\Parameters" /v D3ColdSupported /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Services\\USBHUB3\\Parameters" /v Ceip /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Services\\USBHUB3\\Parameters" /v DisableSelectiveSuspendUI /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Services\\usbccgp\\Parameters" /v D3ColdSupported /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Services\\pci\\Parameters" /v D3ColdSupported /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Services\\pci\\Parameters" /v D3ColdSupport /t REG_DWORD /d 0 /f >nul 2>&1

rem --- MSPower_DeviceEnable off ---
echo [*] MSPower_DeviceEnable off...
powershell -NoProfile -Command "Get-WmiObject MSPower_DeviceEnable -Namespace root\\wmi -ErrorAction SilentlyContinue | ForEach-Object {{ try {{ $_.Enable = $false; $_.psbase.Put() | Out-Null }} catch {{}} }}" >nul 2>&1

rem --- Memory Compression off ---
echo [*] Memory Compression off...
powershell -NoProfile -Command "Disable-MMAgent -MemoryCompression -ErrorAction SilentlyContinue" >nul 2>&1

rem --- MSI mode enable ---
echo [*] MSI mode enable...
powershell -NoProfile -ExecutionPolicy Bypass -Command "function S($c){{Get-WmiObject $c -ErrorAction SilentlyContinue | Where-Object {{$_.PNPDeviceID -like 'PCI\\VEN_*'}} | ForEach-Object {{ try {{ $r='HKLM:\\SYSTEM\\CurrentControlSet\\Enum\\'+$_.PNPDeviceID+'\\Device Parameters\\Interrupt Management\\MessageSignaledInterruptProperties'; if(!(Test-Path $r)){{New-Item $r -Force|Out-Null}}; Set-ItemProperty $r 'MSISupported' 1 -Type DWord -Force -ErrorAction SilentlyContinue }} catch {{}} }}}}; S 'Win32_IDEController'; S 'Win32_VideoController'; S 'Win32_NetworkAdapter'" >nul 2>&1

rem --- DMA remapping off ---
echo [*] DMA remapping off...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p='HKLM:\\SOFTWARE\\Microsoft\\PolicyManager\\default\\DmaGuard\\DeviceEnumerationPolicy'; if(!(Test-Path $p)){{New-Item $p -Force|Out-Null}}; Set-ItemProperty $p 'value' 2 -Type DWord -Force -ErrorAction SilentlyContinue; Get-ChildItem 'HKLM:\\SYSTEM\\CurrentControlSet\\Services' -ErrorAction SilentlyContinue | ForEach-Object {{ $q=$_.PSPath+'\\Parameters'; if(Test-Path $q){{ $v=(Get-ItemProperty $q -Name DmaRemappingCompatible -ErrorAction SilentlyContinue).DmaRemappingCompatible; if($null -ne $v){{ Set-ItemProperty $q 'DmaRemappingCompatible' 0 -Type DWord -Force -ErrorAction SilentlyContinue }} }} }}" >nul 2>&1

rem --- MPO off ---
echo [*] MPO off...
reg add "HKLM\\SOFTWARE\\Microsoft\\Windows\\Dwm" /v OverlayTestMode /t REG_DWORD /d 5 /f >nul 2>&1

rem --- CEIP off ---
echo [*] CEIP off...
reg add "HKLM\\Software\\Policies\\Microsoft\\SQMClient\\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\\Software\\Microsoft\\SQMClient\\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\\Software\\Microsoft\\SQMClient" /v UploadDisableFlag /t REG_DWORD /d 1 /f >nul 2>&1

rem --- Teredo AllowLowPowerMode=0 ---
echo [*] Teredo AllowLowPowerMode=0...
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Services\\iphlpsvc\\Teredo" /v AllowLowPowerMode /t REG_DWORD /d 0 /f >nul 2>&1

rem --- NoMobilityCenter ---
reg add "HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\MobilityCenter" /v NoMobilityCenter /t REG_DWORD /d 1 /f >nul 2>&1

rem --- Сеть: Dnscache DisableCoalescing + Wi-Fi power management + Ethernet TCP ---
echo [*] Сеть: DisableCoalescing, fDisablePowerManagement, TCP on Ethernet...
reg add "HKLM\\System\\CurrentControlSet\\Services\\Dnscache\\Parameters" /v DisableCoalescing /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\WcmSvc\\Local" /v fDisablePowerManagement /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\WcmSvc\\GroupPolicy" /v fDisablePowerManagement /t REG_DWORD /d 1 /f >nul 2>&1

set "WIFI_GUIDS= "
for /f %%a in ('reg query "HKLM\\SYSTEM\\CurrentControlSet\\Control\\Class\\{{4d36e972-e325-11ce-bfc1-08002be10318}}" /v "*PhyType" /s 2^>nul ^| findstr "HKEY"') do (
    for /f "tokens=3" %%g in ('reg query "%%a" /v "NetCfgInstanceId" 2^>nul ^| findstr /i "NetCfgInstanceId"') do set "WIFI_GUIDS=!WIFI_GUIDS!%%g "
)
for /f %%i in ('reg query "HKLM\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters\\Interfaces" 2^>nul ^| findstr "HKEY"') do (
    set "IFGUID=%%~ni"
    echo !WIFI_GUIDS! | findstr /i /c:"!IFGUID!" >nul
    if errorlevel 1 (
        reg add "%%i" /v "TcpAckFrequency" /t REG_DWORD /d 1 /f >nul 2>&1
        reg add "%%i" /v "TCPNoDelay" /t REG_DWORD /d 1 /f >nul 2>&1
    )
)

rem --- NIC power saving off (только Ethernet) ---
echo [*] NIC power saving off (Ethernet)...
for /f %%a in ('reg query "HKLM\\SYSTEM\\CurrentControlSet\\Control\\Class\\{{4d36e972-e325-11ce-bfc1-08002be10318}}" /v "*SpeedDuplex" /s ^| findstr "HKEY"') do (
    reg query "%%a" /v "*PhyType" >nul 2>&1
    if !errorlevel! equ 0 (
    ) else (
        for %%v in (
{nic}
        ) do (
            reg query "%%a" /v "%%v" >nul 2>&1 && reg add "%%a" /v "%%v" /t REG_SZ /d 0 /f >nul 2>&1
        )
        reg query "%%a" /v PnPCapabilities >nul 2>&1 && reg add "%%a" /v PnPCapabilities /t REG_DWORD /d 24 /f >nul 2>&1
        reg query "%%a" /v WakeOnMagicPacketFromS5 >nul 2>&1 && reg add "%%a" /v WakeOnMagicPacketFromS5 /t REG_SZ /d 2 /f >nul 2>&1
        reg query "%%a" /v WolShutdownLinkSpeed >nul 2>&1 && reg add "%%a" /v WolShutdownLinkSpeed /t REG_SZ /d 2 /f >nul 2>&1
    )
) >nul 2>&1

rem --- InsightsEnabled off ---
for /f "usebackq delims=" %%s in (`reg query HKU 2^>nul ^| findstr /r "S-1-5-21-[0-9]*-[0-9]*-[0-9]*$"`) do reg add "%%s\\Software\\Microsoft\\input\\Settings" /v InsightsEnabled /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Контекстное меню: Disable Idle / Enable Idle ---
echo [*] Контекстное меню: Disable Idle / Enable Idle...
reg add "HKCR\\DesktopBackground\\Shell\\PowerPlan\\shell\\05menu" /v MUIVerb /t REG_SZ /d "Disable Idle" /f >nul 2>&1
reg add "HKCR\\DesktopBackground\\Shell\\PowerPlan\\shell\\05menu" /v Icon /t REG_SZ /d "powercpl.dll" /f >nul 2>&1
reg add "HKCR\\DesktopBackground\\Shell\\PowerPlan\\shell\\05menu" /v CommandFlags /t REG_DWORD /d 32 /f >nul 2>&1
reg add "HKCR\\DesktopBackground\\Shell\\PowerPlan\\shell\\05menu\\command" /ve /t REG_SZ /d "cmd.exe /c powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 && powercfg -setactive scheme_current" /f >nul 2>&1
reg add "HKCR\\DesktopBackground\\Shell\\PowerPlan\\shell\\06menu" /v MUIVerb /t REG_SZ /d "Enable Idle" /f >nul 2>&1
reg add "HKCR\\DesktopBackground\\Shell\\PowerPlan\\shell\\06menu" /v Icon /t REG_SZ /d "powercpl.dll" /f >nul 2>&1
reg add "HKCR\\DesktopBackground\\Shell\\PowerPlan\\shell\\06menu\\command" /ve /t REG_SZ /d "cmd.exe /c powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 0 && powercfg -setactive scheme_current" /f >nul 2>&1

rem --- wevtutil sl power diagnostic logs off ---
wevtutil sl Microsoft-Windows-SleepStudy/Diagnostic /e:false >nul 2>&1
wevtutil sl Microsoft-Windows-Kernel-Processor-Power/Diagnostic /e:false >nul 2>&1
wevtutil sl Microsoft-Windows-UserModePowerService/Diagnostic /e:false >nul 2>&1

rem --- WaitToKillServiceTimeout ---
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Control" /v WaitToKillServiceTimeout /t REG_SZ /d 1500 /f >nul 2>&1

rem --- Службы: serial/sermouse/serenum → manual, wlansvc/wmiacpi → auto ---
echo [*] Службы serial/sermouse/serenum → manual, wlansvc/wmiacpi → auto...
sc config serial   start= demand >nul 2>&1
sc config sermouse start= demand >nul 2>&1
sc config serenum  start= demand >nul 2>&1
sc config wlansvc  start= auto   >nul 2>&1
sc config wmiacpi  start= auto   >nul 2>&1
""" + bat_footer("Power Killer MAXIMUM применён: Ultimate Performance активен, все настройки питания применены.")


# ------------------------------------------------------------------
# 8. PK_Revert_All.bat — полный откат к Balanced
# ------------------------------------------------------------------
def make_revert() -> str:
    marks = "\n".join(f"    {m}" for m in USB_REGMARKS)
    nic = "\n".join(f"            {p}" for p in NIC_PARAMS)
    return bat_header("VampireOS — PK: Revert All (Balanced)") + f"""rem --- Balanced ---
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
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Power" /v HiberbootEnabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Control\\Power" /v HibernateEnabled /t REG_DWORD /d 1 /f >nul 2>&1

rem --- Power Throttling on ---
echo [*] Power Throttling on...
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Control\\Power\\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 0 /f >nul 2>&1

rem --- BCD: удалить disabledynamictick ---
echo [*] BCD: delete disabledynamictick...
bcdedit /deletevalue disabledynamictick >nul 2>&1

rem --- USB selective suspend on (удаляем значения) ---
echo [*] USB selective suspend on...
for %%a in (
{marks}
) do for /f "delims=" %%b in ('reg query "HKLM\\SYSTEM\\CurrentControlSet\\Enum" /s /f "%%a" ^| findstr "HKEY"') do reg delete "%%b" /v "%%a" /f >nul 2>&1
reg delete "HKLM\\SYSTEM\\CurrentControlSet\\Services\\USBHUB3\\Parameters" /v DisableLPM /f >nul 2>&1
reg delete "HKLM\\SYSTEM\\CurrentControlSet\\Services\\USBHUB3\\Parameters" /v D3ColdSupported /f >nul 2>&1
reg delete "HKLM\\SYSTEM\\CurrentControlSet\\Services\\USBHUB3\\Parameters" /v Ceip /f >nul 2>&1
reg delete "HKLM\\SYSTEM\\CurrentControlSet\\Services\\USBHUB3\\Parameters" /v DisableSelectiveSuspendUI /f >nul 2>&1
reg delete "HKLM\\SYSTEM\\CurrentControlSet\\Services\\usbccgp\\Parameters" /v D3ColdSupported /f >nul 2>&1
reg delete "HKLM\\SYSTEM\\CurrentControlSet\\Services\\pci\\Parameters" /v D3ColdSupported /f >nul 2>&1
reg delete "HKLM\\SYSTEM\\CurrentControlSet\\Services\\pci\\Parameters" /v D3ColdSupport /f >nul 2>&1

rem --- MSPower_DeviceEnable on ---
echo [*] MSPower_DeviceEnable on...
powershell -NoProfile -Command "Get-WmiObject MSPower_DeviceEnable -Namespace root\\wmi -ErrorAction SilentlyContinue | ForEach-Object {{ try {{ $_.Enable = $true; $_.psbase.Put() | Out-Null }} catch {{}} }}" >nul 2>&1

rem --- Memory Compression on ---
echo [*] Memory Compression on...
powershell -NoProfile -Command "Enable-MMAgent -MemoryCompression -ErrorAction SilentlyContinue" >nul 2>&1

rem --- MSI mode off ---
echo [*] MSI mode off...
powershell -NoProfile -ExecutionPolicy Bypass -Command "function S($c){{Get-WmiObject $c -ErrorAction SilentlyContinue | Where-Object {{$_.PNPDeviceID -like 'PCI\\VEN_*'}} | ForEach-Object {{ try {{ $r='HKLM:\\SYSTEM\\CurrentControlSet\\Enum\\'+$_.PNPDeviceID+'\\Device Parameters\\Interrupt Management\\MessageSignaledInterruptProperties'; if(Test-Path $r){{ Set-ItemProperty $r 'MSISupported' 0 -Type DWord -Force -ErrorAction SilentlyContinue }} }} catch {{}} }}}}; S 'Win32_IDEController'; S 'Win32_VideoController'; S 'Win32_NetworkAdapter'" >nul 2>&1

rem --- DMA remapping on ---
echo [*] DMA remapping on...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p='HKLM:\\SOFTWARE\\Microsoft\\PolicyManager\\default\\DmaGuard\\DeviceEnumerationPolicy'; if(Test-Path $p){{ Set-ItemProperty $p 'value' 0 -Type DWord -Force -ErrorAction SilentlyContinue }}; Get-ChildItem 'HKLM:\\SYSTEM\\CurrentControlSet\\Services' -ErrorAction SilentlyContinue | ForEach-Object {{ $q=$_.PSPath+'\\Parameters'; if(Test-Path $q){{ $v=(Get-ItemProperty $q -Name DmaRemappingCompatible -ErrorAction SilentlyContinue).DmaRemappingCompatible; if($null -ne $v){{ Set-ItemProperty $q 'DmaRemappingCompatible' 1 -Type DWord -Force -ErrorAction SilentlyContinue }} }} }}" >nul 2>&1

rem --- MPO on ---
echo [*] MPO on...
reg delete "HKLM\\SOFTWARE\\Microsoft\\Windows\\Dwm" /v OverlayTestMode /f >nul 2>&1

rem --- CEIP on ---
echo [*] CEIP on...
reg add "HKLM\\Software\\Policies\\Microsoft\\SQMClient\\Windows" /v CEIPEnable /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\\Software\\Microsoft\\SQMClient\\Windows" /v CEIPEnable /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\\Software\\Microsoft\\SQMClient" /v UploadDisableFlag /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Teredo AllowLowPowerMode=1 ---
echo [*] Teredo AllowLowPowerMode=1...
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Services\\iphlpsvc\\Teredo" /v AllowLowPowerMode /t REG_DWORD /d 1 /f >nul 2>&1

rem --- NoMobilityCenter=0 ---
reg add "HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\MobilityCenter" /v NoMobilityCenter /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Сеть: DisableCoalescing=0, fDisablePowerManagement=0, TCPNoDelay=0 ---
echo [*] Сеть: DisableCoalescing=0, fDisablePowerManagement=0, TCPNoDelay=0...
reg add "HKLM\\System\\CurrentControlSet\\Services\\Dnscache\\Parameters" /v DisableCoalescing /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\WcmSvc\\Local" /v fDisablePowerManagement /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\WcmSvc\\GroupPolicy" /v fDisablePowerManagement /t REG_DWORD /d 0 /f >nul 2>&1
for /f %%i in ('reg query "HKLM\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters\\Interfaces" 2^>nul ^| findstr "HKEY"') do (
    reg delete "%%i" /v "TcpAckFrequency" /f >nul 2>&1
    reg delete "%%i" /v "TCPNoDelay" /f >nul 2>&1
)

rem --- NIC power saving on (удаляем значения, только Ethernet) ---
echo [*] NIC power saving on (Ethernet)...
for /f %%a in ('reg query "HKLM\\SYSTEM\\CurrentControlSet\\Control\\Class\\{{4d36e972-e325-11ce-bfc1-08002be10318}}" /v "*SpeedDuplex" /s ^| findstr "HKEY"') do (
    reg query "%%a" /v "*PhyType" >nul 2>&1
    if !errorlevel! equ 0 (
    ) else (
        for %%v in (
{nic}
        ) do reg delete "%%a" /v "%%v" /f >nul 2>&1
        reg delete "%%a" /v PnPCapabilities /f >nul 2>&1
        reg delete "%%a" /v WakeOnMagicPacketFromS5 /f >nul 2>&1
        reg delete "%%a" /v WolShutdownLinkSpeed /f >nul 2>&1
    )
) >nul 2>&1

rem --- InsightsEnabled=1 ---
for /f "usebackq delims=" %%s in (`reg query HKU 2^>nul ^| findstr /r "S-1-5-21-[0-9]*-[0-9]*-[0-9]*$"`) do reg delete "%%s\\Software\\Microsoft\\input\\Settings" /v InsightsEnabled /f >nul 2>&1

rem --- wevtutil sl power diagnostic logs on ---
wevtutil sl Microsoft-Windows-SleepStudy/Diagnostic /e:true >nul 2>&1
wevtutil sl Microsoft-Windows-Kernel-Processor-Power/Diagnostic /e:true >nul 2>&1
wevtutil sl Microsoft-Windows-UserModePowerService/Diagnostic /e:true >nul 2>&1

rem --- WaitToKillServiceTimeout=5000 ---
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Control" /v WaitToKillServiceTimeout /t REG_SZ /d 5000 /f >nul 2>&1

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
""" + bat_footer("Откат к Balanced выполнен. Все настройки питания сброшены.")


# ------------------------------------------------------------------
# Main
# ------------------------------------------------------------------

GENERATORS = {
    "PK_Timeouts.bat": make_timeouts,
    "PK_CPU_Throttle.bat": make_cpu_throttle,
    "PK_Power_Throttling_DynamicTick.bat": make_power_throttling,
    "PK_USB_Power.bat": make_usb_power,
    "PK_PCI_D3Cold.bat": make_pci_d3cold,
    "PK_Disable_Logs.bat": make_logs,
    "PK_Maximum.bat": make_maximum,
    "PK_Revert_All.bat": make_revert,
}


def main():
    parser = argparse.ArgumentParser(description="Генератор Power Killer .bat файлов")
    parser.add_argument(
        "--out",
        default=os.path.join("tweaks", "GameMode"),
        help="Папка назначения (по умолчанию: tweaks/GameMode)",
    )
    args = parser.parse_args()

    out_dir = os.path.abspath(args.out)
    os.makedirs(out_dir, exist_ok=True)

    print(f"📂 Папка назначения: {out_dir}")
    print(f"📦 Будет создано {len(GENERATORS)} файлов\n")

    for name, gen in GENERATORS.items():
        path = os.path.join(out_dir, name)
        content = gen()

        # Все файлы пишем в UTF-8 (внутри уже есть chcp 65001)
        with open(path, "w", encoding="utf-8", newline="\r\n") as f:
            f.write(content)

        size = os.path.getsize(path)
        print(f"  ✅ {name:<40} ({size:>5} bytes)")

    print(f"\n🎉 Готово. Все .bat файлы созданы в:\n   {out_dir}")
    print("\n💡 Не забудьте: файлы должны лежать в tweaks/GameMode/,")
    print("   чтобы gameMode.js мог их запустить через window.api.tweaks.run().")


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n⚠️ Прервано пользователем.")
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ Ошибка: {e}", file=sys.stderr)
        sys.exit(1)