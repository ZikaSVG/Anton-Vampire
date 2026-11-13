@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title VampireOS — PK: PCI D3Cold / MSI mode / DMA remapping
cd /d "%~dp0"

net session >nul 2>&1 || ( echo [!] Запустите от администратора. & pause & exit /b 1 )

echo ============================================================
echo  VampireOS — PK: PCI D3Cold / MSI mode / DMA remapping
echo ============================================================
echo.
rem --- PCI D3Cold off ---
echo [*] PCI D3Cold off...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v D3ColdSupported /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v D3ColdSupport /t REG_DWORD /d 0 /f >nul 2>&1

rem --- MSI mode enable ---
echo [*] MSI mode enable...
powershell -NoProfile -ExecutionPolicy Bypass -Command "function S($c){{Get-WmiObject $c -ErrorAction SilentlyContinue | Where-Object {{$_.PNPDeviceID -like 'PCI\VEN_*'}} | ForEach-Object {{ try {{ $r='HKLM:\SYSTEM\CurrentControlSet\Enum\'+$_.PNPDeviceID+'\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties'; if(!(Test-Path $r)){{New-Item $r -Force|Out-Null}}; Set-ItemProperty $r 'MSISupported' 1 -Type DWord -Force -ErrorAction SilentlyContinue }} catch {{}} }}}}; S 'Win32_IDEController'; S 'Win32_VideoController'; S 'Win32_NetworkAdapter'" >nul 2>&1

rem --- DMA remapping off ---
echo [*] DMA remapping off...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p='HKLM:\SOFTWARE\Microsoft\PolicyManager\default\DmaGuard\DeviceEnumerationPolicy'; if(!(Test-Path $p)){{New-Item $p -Force|Out-Null}}; Set-ItemProperty $p 'value' 2 -Type DWord -Force -ErrorAction SilentlyContinue; Get-ChildItem 'HKLM:\SYSTEM\CurrentControlSet\Services' -ErrorAction SilentlyContinue | ForEach-Object {{ $q=$_.PSPath+'\Parameters'; if(Test-Path $q){{ $v=(Get-ItemProperty $q -Name DmaRemappingCompatible -ErrorAction SilentlyContinue).DmaRemappingCompatible; if($null -ne $v){{ Set-ItemProperty $q 'DmaRemappingCompatible' 0 -Type DWord -Force -ErrorAction SilentlyContinue }} }} }}" >nul 2>&1

rem --- MPO off ---
echo [*] MPO off...
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v OverlayTestMode /t REG_DWORD /d 5 /f >nul 2>&1

echo.
echo ============================================================
echo  Готово: PCI D3Cold off, MSI mode on, DMA remapping off, MPO off.
echo ============================================================
echo.
