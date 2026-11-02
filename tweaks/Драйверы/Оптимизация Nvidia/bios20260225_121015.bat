@echo off
title Объединенный пакетный файл
color 0F
:: ==================================================
:: Объединенный файл создан: 25.02.2026 12:10:15
:: Исходная директория: D:\Projects\Extreme\dist\tweaks\Драйверы\Оптимизация Nvidia
:: Всего файлов: 45
:: ==================================================
chcp 1251 >nul
setlocal enabledelayedexpansion
cls
echo.
echo ==================================================
echo ОБЪЕДИНЕННЫЙ ПАКЕТНЫЙ ФАЙЛ
echo ==================================================
echo.
echo Всего секций: 45
echo.
echo Выберите действие:
echo [1] Выполнить все секции подряд
echo [2] Выполнить секции с подтверждением
echo [3] Показать список секций
echo.
set /p mode=Введите номер (1/2/3): 
echo.
if "%mode%"=="3" goto :show_list
if "%mode%"=="2" goto :confirm_mode
if "%mode%"=="1" goto :auto_mode
echo Неверный выбор, используется режим 1
goto :auto_mode

:show_list
cls
echo ==================================================
echo СПИСОК СЕКЦИЙ
echo ==================================================
echo.
echo [001] BIOS Nvidia.bat - Без описания
echo [002] Dynamic Pstate\Включить динамический Pstate.bat - Без описания
echo [003] Dynamic Pstate\Отключить динамическое Pstate.bat - Без описания
echo [004] Gpu твик.bat - Без описания
echo [005] GpuEnergyDriver.bat - Без описания
echo [006] HDCP\Включить HDCP.bat - Без описания
echo [007] HDCP\Отключить HDCP.bat - Без описания
echo [008] N ECC.bat - Без описания
echo [009] Nvidia аудио.bat - Без описания
echo [010] Nvidia телеметрия отключение.bat - Без описания
echo [011] Nvidia.bat - Без описания
echo [012] P0-состояние.bat - Без описания
echo [013] merged_batch_20260215_153308.bat - Без описания
echo [014] Включить HDCP.bat - Без описания
echo [015] Включить динамический Pstate.bat - Без описания
echo [016] Включить объеденение глобальной памяти Nvidia.bat - Без описания
echo [017] Загрузка драйверов NVIDIA.bat - Без описания
echo [018] Оптимизация графики.bat - Без описания
echo [019] Отключите GeForceExp.Телеметрия.bat - Без описания
echo [020] Отключить HDCP.bat - Без описания
echo [021] Отключить Nvidia Dynamic P-STATE.cmd - Без описания
echo [022] Отключить МПО.bat - Без описания
echo [023] Отключить динамическое Pstate.bat - Без описания
echo [024] Отключить масштабирование.bat - Без описания
echo [025] Отключить оптимизацию доставки.bat - Без описания
echo [026] Отключить телеметрию.bat - Без описания
echo [027] Отключить упреждение.bat - Без описания
echo [028] ОтключитьЗаписьОбъединение.bat - Без описания
echo [029] Очистить кеш Nvidia.bat - Без описания
echo [030] Показать шелковистость.bat - Без описания
echo [031] Политика неограниченного времени.bat - Без описания
echo [032] Принудительное P-состояние.bat - Без описания
echo [033] Принудительное состояние P0.bat - Без описания
echo [034] Расширенные скрытые настройки графического процессора Nvidia.bat - Без описания
echo [035] Твики графического процессора Nvidia.bat - Без описания
echo [036] Удалить ECC.bat - Без описания
echo [037] Удалить телеметрию Nvidia .bat - https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
echo [038] Удалить телеметрию Nvidia 2.bat - https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
echo [039] Удалить телеметрию Nvidia 3.bat - Без описания
echo [040] Удалить телеметрию Nvidia.bat - Без описания
echo [041] Удалить телеметрию Windows.bat - Без описания
echo [042] Удалить телеметрию.bat - Без описания
echo [043] Узнать модель видеокарты.bat - Без описания
echo [044] Уменьшение задержек для Nvidia.bat - Без описания
echo [045] УнКП.bat - Без описания
echo.
pause
exit /b

:confirm_mode
cls
echo ==================================================
echo РЕЖИМ С ПОДТВЕРЖДЕНИЕМ
echo ==================================================
echo.
echo.
echo [001] BIOS Nvidia.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: BIOS Nvidia.bat ---
    echo.
@chcp 65001 >nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f
REM Define download folder
set DOWNLOAD_FOLDER=C:\Downloads
REM Ensure the download folder exists
if not exist "%DOWNLOAD_FOLDER%" mkdir "%DOWNLOAD_FOLDER%"
REM Log file for debugging
set LOGFILE="%DOWNLOAD_FOLDER%\download_log.txt"
REM Clear the log file before writing new logs
if exist "%LOGFILE%" del "%LOGFILE%"
REM Download files to the defined download folder with logging
echo Downloading SCEWIN_64.exe...
start /MIN /WAIT powershell -Command "Invoke-WebRequest -Uri 'https://github.com/agalievvv/ickurdaneteboli/raw/main/SCEWIN_64.exe' -OutFile '%DOWNLOAD_FOLDER%\SCEWIN_64.exe' 2>&1 | Tee-Object -FilePath '%LOGFILE%'"
echo Downloading amifldrv64.sys...
start /MIN /WAIT powershell -Command "Invoke-WebRequest -Uri 'https://github.com/agalievvv/ickurdaneteboli/raw/main/amifldrv64.sys' -OutFile '%DOWNLOAD_FOLDER%\amifldrv64.sys' 2>&1 | Tee-Object -FilePath '%LOGFILE%'"
echo Downloading amigendrv64.sys...
start /MIN /WAIT powershell -Command "Invoke-WebRequest -Uri 'https://github.com/agalievvv/ickurdaneteboli/raw/main/amigendrv64.sys' -OutFile '%DOWNLOAD_FOLDER%\amigendrv64.sys' 2>&1 | Tee-Object -FilePath '%LOGFILE%'"
REM Check if the downloads were successful and move the files
if exist "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" (
    echo SCEWIN_64.exe downloaded successfully.
) else (
    echo SCEWIN_64.exe was not downloaded. Check the log file at "%LOGFILE%" for errors.
)
if exist "%DOWNLOAD_FOLDER%\amifldrv64.sys" (
    echo amifldrv64.sys downloaded successfully.
) else (
    echo amifldrv64.sys was not downloaded. Check the log file at "%LOGFILE%" for errors.
)
if exist "%DOWNLOAD_FOLDER%\amigendrv64.sys" (
    echo amigendrv64.sys downloaded successfully.
) else (
    echo amigendrv64.sys was not downloaded. Check the log file at "%LOGFILE%" for errors.
)
REM Proceed with executing the downloaded executable if it exists
if exist "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" (
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ACPI Notify on TBT Hot-plug" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ACPI Standby State" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ACPI T-States" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ALS Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "AP threads Idle Manner" /qv 0x03
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ARI Forwarding" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ASPM" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BCLK Aware Adaptive Voltage" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Bi-directional PROCHOT#" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BIOS Hot-Plug Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BIOS Lock" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BIST Enable" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEG0 Hotplug" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP enumerated SATA ports" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP GNA" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP I2C6" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP I2C7" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP IPU" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP LAN(GBE)" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe DG1" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe GFX" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe LAN" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe Other" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe Storage" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe WLAN" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PEG0" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP SATA" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP SDXC" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP SPI" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP TBT RP" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP TCSS" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP THC0" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP THC1" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "SW Guard Extensions SGX" /qv 0x02
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "System Acceleration with Intel(R) Optane(TM) Memory" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Tcc Offset Lock Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB DbC Enable Mode" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB Overcurrent Override for DbC" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB S5 Wakeup Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB Standby Power at S4/S5" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB2 PHY Sus Well Power Gating" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB3 Type-C UFP2DFP Kernel/Platform Debug Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB3" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "VDD Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Vmax Stress" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Voltage Optimization" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Wake From Thunderbolt(TM) Devices" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Wake on LAN Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Wake on WLAN and BT Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "WatchDog" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "WDT Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Windows 10 Thunderbolt support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "WoV (Wake on Voice)" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Snoop Latency Override" /qv 0x02
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Non Snoop Latency Multiplier" /qv 0x01
)    echo.
    echo --- Выполнено ---
)
echo.
echo [002] Dynamic Pstate\Включить динамический Pstate.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Dynamic Pstate\Включить динамический Pstate.bat ---
    echo.
for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
for /f %%c in ('echo %%b ^| findstr "{"') do (
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /f
)
)
)    echo.
    echo --- Выполнено ---
)
echo.
echo [003] Dynamic Pstate\Отключить динамическое Pstate.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Dynamic Pstate\Отключить динамическое Pstate.bat ---
    echo.
for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
for /f %%c in ('echo %%b ^| findstr "{"') do (
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f
)
)
)    echo.
    echo --- Выполнено ---
)
echo.
echo [004] Gpu твик.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Gpu твик.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler --> [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers
:: ------------------------------------------------------------------------------------------------------------------------------------------------
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InterruptSteeringDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighestPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MinimumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumPerformancePercent" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitialUnparkCount" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f
REM "
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Acceleration.Level" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DesktopStereoShortcuts" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "FeatureControl" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NVDeviceSupportKFilter" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmCacheLoc" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmDisableInst2Sys" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmFbsrPagedDMA" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMGpuId" /t REG_DWORD /d "256" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmProfilingAdminOnly" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TCCSupported" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TrackResetEngine" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "UseBestResolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ValidateBlitSubRects" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PlatformSupportMiracast" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof    echo.
    echo --- Выполнено ---
)
echo.
echo [005] GpuEnergyDriver.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: GpuEnergyDriver.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof    echo.
    echo --- Выполнено ---
)
echo.
echo [006] HDCP\Включить HDCP.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: HDCP\Включить HDCP.bat ---
    echo.
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMHdcpKeyglobZero" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /f
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
for /f %%i in ('echo %%a ^| findstr "{"') do (
Reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "RMHdcpKeyglobZero" /f >nul 2>&1
)
)
)    echo.
    echo --- Выполнено ---
)
echo.
echo [007] HDCP\Отключить HDCP.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: HDCP\Отключить HDCP.bat ---
    echo.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMHdcpKeyglobZero" /t REG_DWORD /d "1" /f
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
for /f %%i in ('echo %%a ^| findstr "{"') do (
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "RMHdcpKeyglobZero" /t REG_DWORD /d "1" /f >nul 2>&1			 
)
)
)    echo.
    echo --- Выполнено ---
)
echo.
echo [008] N ECC.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: N ECC.bat ---
    echo.
C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -e 0    echo.
    echo --- Выполнено ---
)
echo.
echo [009] Nvidia аудио.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Nvidia аудио.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\***\0000\PowerSettings" /v "ConservationIdleTime" /t REG_BINARY /d "00000000" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\***\0000\PowerSettings" /v "IdlePowerState" /t REG_BINARY /d "00000000" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\***\0000\PowerSettings" /v "PerformanceIdleTime" /t REG_BINARY /d "00000000" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof    echo.
    echo --- Выполнено ---
)
echo.
echo [010] Nvidia телеметрия отключение.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Nvidia телеметрия отключение.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NvTelemetryContainer" /v "Start" /t REG_DWORD /d "4" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof    echo.
    echo --- Выполнено ---
)
echo.
echo [011] Nvidia.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Nvidia.bat ---
    echo.
rmdir /s /q "C:\Windows\System32\drivers\NVIDIA Corporation"
cd /d "C:\Windows\System32\DriverStore\FileRepository\"
dir NvTelemetry64.dll /a /b /s
del NvTelemetry64.dll /a /s
reg add "HKCU\SOFTWARE\NVIDIA Corporation\NVControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d "0" /f >nul 2>&1    echo.
    echo --- Выполнено ---
)
echo.
echo [012] P0-состояние.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: P0-состояние.bat ---
    echo.
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f > nul 2>&1
                   )
                )
             )    echo.
    echo --- Выполнено ---
)
echo.
echo [013] merged_batch_20260215_153308.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: merged_batch_20260215_153308.bat ---
    echo.
:: ==================================================
::   : 15.02.2026 15:33:08
::  : D:\Projects\Extreme\dist\tweaks\\ Nvidia
::  : 40
:: ==================================================
chcp 1251 >nul
setlocal enabledelayedexpansion
cls
echo.
echo ==================================================
echo   
echo ==================================================
echo.
echo  : 40
echo.
echo  :
echo [1]    
echo [2]    
echo [3]   
echo.
set /p mode=  (1/2/3): 
echo.
if "%mode%"=="3" goto :show_list
if "%mode%"=="2" goto :confirm_mode
if "%mode%"=="1" goto :auto_mode
echo  ,   1
goto :auto_mode
:show_list
cls
echo ==================================================
echo  
echo ==================================================
echo.
echo [001] BIOS Nvidia.bat -  
echo [002] Gpu .bat -  
echo [003] GpuEnergyDriver.bat -  
echo [004] N ECC.bat -  
echo [005] Nvidia .bat -  
echo [006] Nvidia  .bat -  
echo [007] Nvidia.bat -  
echo [008] P0-.bat -  
echo [009]  HDCP.bat -  
echo [010]   Pstate.bat -  
echo [011]     Nvidia.bat -  
echo [012]   NVIDIA.bat -  
echo [013]  .bat -  
echo [014]  GeForceExp..bat -  
echo [015]  HDCP.bat -  
echo [016]  Nvidia Dynamic P-STATE.cmd -  
echo [017]  .bat -  
echo [018]   Pstate.bat -  
echo [019]  .bat -  
echo [020]   .bat -  
echo [021]  .bat -  
echo [022]  .bat -  
echo [023] .bat -  
echo [024]   Nvidia.bat -  
echo [025]  .bat -  
echo [026]   .bat -  
echo [027]  P-.bat -  
echo [028]   P0.bat -  
echo [029]      Nvidia.bat -  
echo [030]    Nvidia.bat -  
echo [031]  ECC.bat -  
echo [032]   Nvidia .bat - https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
echo [033]   Nvidia 2.bat - https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
echo [034]   Nvidia 3.bat -  
echo [035]   Nvidia.bat -  
echo [036]   Windows.bat -  
echo [037]  .bat -  
echo [038]   .bat -  
echo [039]    Nvidia.bat -  
echo [040] .bat -  
echo.
 /b
:confirm_mode
cls
echo ==================================================
echo   
echo ==================================================
echo.
echo.
echo [001] BIOS Nvidia.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- : BIOS Nvidia.bat ---
    echo.
@chcp 65001 >nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f
REM Define download folder
set DOWNLOAD_FOLDER=C:\Downloads
REM Ensure the download folder exists
if not exist "%DOWNLOAD_FOLDER%" mkdir "%DOWNLOAD_FOLDER%"
REM Log file for debugging
set LOGFILE="%DOWNLOAD_FOLDER%\download_log.txt"
REM Clear the log file before writing new logs
if exist "%LOGFILE%" del "%LOGFILE%"
REM Download files to the defined download folder with logging
echo Downloading SCEWIN_64.exe...
start /MIN /WAIT powershell -Command "Invoke-WebRequest -Uri 'https://github.com/agalievvv/ickurdaneteboli/raw/main/SCEWIN_64.exe' -OutFile '%DOWNLOAD_FOLDER%\SCEWIN_64.exe' 2>&1 | Tee-Object -FilePath '%LOGFILE%'"
echo Downloading amifldrv64.sys...
start /MIN /WAIT powershell -Command "Invoke-WebRequest -Uri 'https://github.com/agalievvv/ickurdaneteboli/raw/main/amifldrv64.sys' -OutFile '%DOWNLOAD_FOLDER%\amifldrv64.sys' 2>&1 | Tee-Object -FilePath '%LOGFILE%'"
echo Downloading amigendrv64.sys...
start /MIN /WAIT powershell -Command "Invoke-WebRequest -Uri 'https://github.com/agalievvv/ickurdaneteboli/raw/main/amigendrv64.sys' -OutFile '%DOWNLOAD_FOLDER%\amigendrv64.sys' 2>&1 | Tee-Object -FilePath '%LOGFILE%'"
REM Check if the downloads were successful and move the files
if exist "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" (
    echo SCEWIN_64.exe downloaded successfully.
) else (
    echo SCEWIN_64.exe was not downloaded. Check the log file at "%LOGFILE%" for errors.
)
if exist "%DOWNLOAD_FOLDER%\amifldrv64.sys" (
    echo amifldrv64.sys downloaded successfully.
) else (
    echo amifldrv64.sys was not downloaded. Check the log file at "%LOGFILE%" for errors.
)
if exist "%DOWNLOAD_FOLDER%\amigendrv64.sys" (
    echo amigendrv64.sys downloaded successfully.
) else (
    echo amigendrv64.sys was not downloaded. Check the log file at "%LOGFILE%" for errors.
)
REM Proceed with executing the downloaded executable if it exists
if exist "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" (
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ACPI Notify on TBT Hot-plug" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ACPI Standby State" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ACPI T-States" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ALS Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "AP threads Idle Manner" /qv 0x03
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ARI Forwarding" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ASPM" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BCLK Aware Adaptive Voltage" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Bi-directional PROCHOT#" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BIOS Hot-Plug Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BIOS Lock" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BIST Enable" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEG0 Hotplug" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP enumerated SATA ports" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP GNA" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP I2C6" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP I2C7" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP IPU" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP LAN(GBE)" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe DG1" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe GFX" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe LAN" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe Other" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe Storage" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe WLAN" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PEG0" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP SATA" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP SDXC" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP SPI" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP TBT RP" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP TCSS" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP THC0" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP THC1" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "SW Guard Extensions SGX" /qv 0x02
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "System Acceleration with Intel(R) Optane(TM) Memory" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Tcc Offset Lock Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB DbC Enable Mode" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB Overcurrent Override for DbC" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB S5 Wakeup Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB Standby Power at S4/S5" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB2 PHY Sus Well Power Gating" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB3 Type-C UFP2DFP Kernel/Platform Debug Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB3" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "VDD Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Vmax Stress" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Voltage Optimization" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Wake From Thunderbolt(TM) Devices" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Wake on LAN Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Wake on WLAN and BT Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "WatchDog" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "WDT Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Windows 10 Thunderbolt support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "WoV (Wake on Voice)" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Snoop Latency Override" /qv 0x02
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Non Snoop Latency Multiplier" /qv 0x01
)
    echo.
    echo ---  ---
)
echo.
echo [002] Gpu .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- : Gpu .bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler --> [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers
:: ------------------------------------------------------------------------------------------------------------------------------------------------
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InterruptSteeringDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighestPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MinimumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumPerformancePercent" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitialUnparkCount" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f
REM "
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Acceleration.Level" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DesktopStereoShortcuts" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "FeatureControl" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NVDeviceSupportKFilter" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmCacheLoc" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmDisableInst2Sys" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmFbsrPagedDMA" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMGpuId" /t REG_DWORD /d "256" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmProfilingAdminOnly" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TCCSupported" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TrackResetEngine" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "UseBestResolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ValidateBlitSubRects" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PlatformSupportMiracast" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [003] GpuEnergyDriver.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- : GpuEnergyDriver.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [004] N ECC.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- : N ECC.bat ---
    echo.
C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -e 0    echo.
    echo ---  ---
)
echo.
echo [005] Nvidia .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- : Nvidia .bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\***\0000\PowerSettings" /v "ConservationIdleTime" /t REG_BINARY /d "00000000" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\***\0000\PowerSettings" /v "IdlePowerState" /t REG_BINARY /d "00000000" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\***\0000\PowerSettings" /v "PerformanceIdleTime" /t REG_BINARY /d "00000000" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [006] Nvidia  .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- : Nvidia  .bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NvTelemetryContainer" /v "Start" /t REG_DWORD /d "4" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [007] Nvidia.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- : Nvidia.bat ---
    echo.
rmdir /s /q "C:\Windows\System32\drivers\NVIDIA Corporation"
cd /d "C:\Windows\System32\DriverStore\FileRepository\"
dir NvTelemetry64.dll /a /b /s
del NvTelemetry64.dll /a /s
reg add "HKCU\SOFTWARE\NVIDIA Corporation\NVControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d "0" /f >nul 2>&1    echo.
    echo ---  ---
)
echo.
echo [008] P0-.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- : P0-.bat ---
    echo.
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f > nul 2>&1
                   )
                )
             )    echo.
    echo ---  ---
)
echo.
echo [009]  HDCP.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  HDCP.bat ---
    echo.
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMHdcpKeyglobZero" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /f
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "RMHdcpKeyglobZero" /f >nul 2>&1
                   )
                )
             )    echo.
    echo ---  ---
)
echo.
echo [010]   Pstate.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   Pstate.bat ---
    echo.
for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
    for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
        for /f %%c in ('echo %%b ^| findstr "{"') do (
            Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /f
        )
    )
)    echo.
    echo ---  ---
)
echo.
echo [011]     Nvidia.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :     Nvidia.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMDisableLRCCoalescing" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [012]   NVIDIA.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   NVIDIA.bat ---
    echo.
start "https://www.nvidia.com/ru-ru/geforce/drivers/"    echo.
    echo ---  ---
)
echo.
echo [013]  .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  .bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "StreamType" /t REG_DWORD /d "0" /f
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "WriteCapture" /t REG_DWORD /d "0" /f
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "WriteCaptureDir" /t REG_SZ /d "c:\dm.capture\\" /f
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "WriteCapturePath" /t REG_SZ /d "" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [014]  GeForceExp..bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  GeForceExp..bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
DevManView.exe /disable "NvModuleTracker Device" >nul 2>&1
DevManView.exe /disable "NVIDIA Virtual Audio Device (Wave Extensible) (WDM)" >nul 2>&1
for %%i in (NvTmMon NvTmRep NvProfile NvNodeLauncher NvDriverUpdateCheckDaily "NVIDIA GeForce Experience SelfUpdate*") do for /f "tokens=1 delims=," %%a in ('schtasks /query /fo csv ^| findstr /v "TaskName" ^| findstr "%%~i"') do schtasks /change /tn "%%a" /disable >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\NVIDIA Corporation\Global\GFExperience" /v "NotifyNewDisplayUpdates" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\NVIDIA Corporation\NvTray" /v "StartOnLogin" /t REG_DWORD /d "0" /f >nul 2>&1
    echo.
    echo ---  ---
)
echo.
echo [015]  HDCP.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  HDCP.bat ---
    echo.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMHdcpKeyglobZero" /t REG_DWORD /d "1" /f
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "RMHdcpKeyglobZero" /t REG_DWORD /d "1" /f >nul 2>&1			 
                   )
                )
             )    echo.
    echo ---  ---
)
echo.
echo [016]  Nvidia Dynamic P-STATE.cmd
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  Nvidia Dynamic P-STATE.cmd ---
    echo.
for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
    for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
        for /f %%c in ('echo %%b ^| findstr "{"') do (
            Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f
        )
    )
)
    echo.
    echo ---  ---
)
echo.
echo [017]  .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  .bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d "5" /f
    echo.
    echo ---  ---
)
echo.
echo [018]   Pstate.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   Pstate.bat ---
    echo.
for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
    for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
        for /f %%c in ('echo %%b ^| findstr "{"') do (
            Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f
        )
    )
)    echo.
    echo ---  ---
)
echo.
echo [019]  .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  .bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /s /f "Scaling"^| findstr "HKEY"') do reg.exe add "%%i" /v "Scaling" /t REG_DWORD /d "1" /f >nul 2>&1    echo.
    echo ---  ---
)
echo.
echo [020]   .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   .bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ;Disable Delivery Optimization
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v "DownloadMode" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [021]  .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  .bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\diagsvc" /v "Start" /t REG_DWORD /d "4" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [022]  .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  .bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler --> [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers
:: ------------------------------------------------------------------------------------------------------------------------------------------------
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisablePreemption" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PlatformSupportMiracast" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [023] .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- : .bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE																										made by konex#8100
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableWriteCombining" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [024]   Nvidia.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   Nvidia.bat ---
    echo.
@echo BESPLATNO! from Reborn FREE PC Optimization (RU) - https://discord.gg/hgBQRsrDRu
@echo made by FrazE-
@echo Clearing NVIDIA DirectX Cache...
REM РџРµСЂРµС…РѕРґ Рє РїР°РїРєРµ DXCache СЃ РёСЃРїРѕР»СЊР·РѕРІР°РЅРёРµРј РїРµСЂРµРјРµРЅРЅС‹С… СЃСЂРµРґС‹
set DXCachePath=%LOCALAPPDATA%\..\LocalLow\NVIDIA\PerDriverVersion\DXCache
REM РџСЂРѕРІРµСЂРєР° СЃСѓС‰РµСЃС‚РІРѕРІР°РЅРёСЏ РїР°РїРєРё
if exist "%DXCachePath%" (
    @echo Found directory: %DXCachePath%
    @echo Deleting cache files...
    del /q "%DXCachePath%\*.*"
    @echo Cache cleared successfully.
) else (
    @echo Directory not found: %DXCachePath%
)
@echo Completed.
@pause
    echo.
    echo ---  ---
)
echo.
echo [025]  .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  .bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "EnableRID61684" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [026]   .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   .bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -acp 0    echo.
    echo ---  ---
)
echo.
echo [027]  P-.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  P-.bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f > nul 2>&1
                   )
                )
             )    echo.
    echo ---  ---
)
echo.
echo [028]   P0.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   P0.bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f > nul 2>&1
                   )
                )
             )    echo.
    echo ---  ---
)
echo.
echo [029]      Nvidia.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :      Nvidia.bat ---
    echo.
echo.
echo.
echo.                 -----------------------------------------------------------------------------------------------------------------
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A 
:::                
:::                   $$$$$$$$\ $$\   $$\ $$\      $$\       $$$$$$$$\ $$\      $$\ $$$$$$$$\  $$$$$$\  $$\   $$\ $$$$$$$$\ $$$$$$$\  
:::                   $$  _____|$$ |  $$ |$$$\    $$$ |      \__$$  __|$$ | $\  $$ |$$  _____|$$  __$$\ $$ | $$  |$$  _____|$$  __$$\ 
:::                   $$ |      \$$\ $$  |$$$$\  $$$$ |         $$ |   $$ |$$$\ $$ |$$ |      $$ /  $$ |$$ |$$  / $$ |      $$ |  $$ |
:::                   $$$$$\     \$$$$  / $$\$$\$$ $$ |         $$ |   $$ $$ $$\$$ |$$$$$\    $$$$$$$$ |$$$$$  /  $$$$$\    $$$$$$$  |
:::                   $$  __|    $$  $$<  $$ \$$$  $$ |         $$ |   $$$$  _$$$$ |$$  __|   $$  __$$ |$$  $$<   $$  __|   $$  __$$< 
:::                   $$ |      $$  /\$$\ $$ |\$  /$$ |         $$ |   $$$  / \$$$ |$$ |      $$ |  $$ |$$ |\$$\  $$ |      $$ |  $$ |
:::                   $$$$$$$$\ $$ /  $$ |$$ | \_/ $$ |         $$ |   $$  /   \$$ |$$$$$$$$\ $$ |  $$ |$$ | \$$\ $$$$$$$$\ $$ |  $$ |
:::                   \________|\__|  \__|\__|     \__|         \__|   \__/     \__|\________|\__|  \__|\__|  \__|\________|\__|  \__|   
:::                                                                                                                 	
echo.                -----------------------------------------------------------------------------------------------------------------	
echo.  
echo.
echo.
echo 
echo.
echo                                                        Press Any Key To Continue...     
 >nul  						
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InterruptSteeringDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighestPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MinimumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumPerformancePercent" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitialUnparkCount" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnablePreemption" /t REG_DWORD /d "0" /f
echo.
echo 
echo.
echo                                                        Press any key to exit...     
 >nul
cls
    echo.
    echo ---  ---
)
echo.
echo [030]    Nvidia.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :    Nvidia.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler --> [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers
:: ------------------------------------------------------------------------------------------------------------------------------------------------
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InterruptSteeringDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighestPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MinimumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumPerformancePercent" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitialUnparkCount" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f
REM "
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Acceleration.Level" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DesktopStereoShortcuts" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "FeatureControl" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NVDeviceSupportKFilter" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmCacheLoc" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmDisableInst2Sys" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmFbsrPagedDMA" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMGpuId" /t REG_DWORD /d "256" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmProfilingAdminOnly" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TCCSupported" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TrackResetEngine" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "UseBestResolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ValidateBlitSubRects" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PlatformSupportMiracast" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [031]  ECC.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  ECC.bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -e 0    echo.
    echo ---  ---
)
echo.
echo [032]   Nvidia .bat
echo : https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   Nvidia .bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
:: https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
 & exit 1
    )
 0
)
:: Initialize environment
setlocal EnableExtensions DisableDelayedExpansion
:: ----------------------------------------------------------
:: ----------Disable "NVIDIA Telemetry Report" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report" task
:: Disable scheduled task(s): `\NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable "NVIDIA Telemetry Report on Logon" task------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report on Logon" task
:: Disable scheduled task(s): `\NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---------Disable "NVIDIA telemetry monitor" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA telemetry monitor" task
:: Disable scheduled task(s): `\NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Remove Nvidia telemetry packages-------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry packages
if exist "%ProgramFiles%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL" (
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetryContainer
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetry
)
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------------Remove Nvidia telemetry components------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry components
:: Soft delete files matching pattern  : "%PROGRAMFILES(X86)%\NVIDIA Corporation\NvTelemetry\*"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%PROGRAMFILES(X86)%\NVIDIA Corporation\NvTelemetry\*"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $renamedCount   = 0; $skippedCount   = 0; $failedCount    = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping folder (not its contents): `"^""$path`"^""."^""; $skippedCount++; continue; }; if($revert -eq $true) {; if (-not $path.EndsWith('.OLD')) {; Write-Host "^""Skipping non-backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; } else {; if ($path.EndsWith('.OLD')) {; Write-Host "^""Skipping backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; }; $originalFilePath = $path; Write-Host "^""Processing file: `"^""$originalFilePath`"^""."^""; if (-Not (Test-Path $originalFilePath)) {; Write-Host "^""Skipping, file `"^""$originalFilePath`"^"" not found."^""; $skippedCount++; exit 0; }; if ($revert -eq $true) {; $newFilePath = $originalFilePath.Substring(0, $originalFilePath.Length - 4); } else {; $newFilePath = "^""$($originalFilePath).OLD"^""; }; try {; Move-Item -LiteralPath "^""$($originalFilePath)"^"" -Destination "^""$newFilePath"^"" -Force -ErrorAction Stop; Write-Host "^""Successfully processed `"^""$originalFilePath`"^""."^""; $renamedCount++; } catch {; Write-Error "^""Failed to rename `"^""$originalFilePath`"^"" to `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; $failedCount++; }; }; if (($renamedCount -gt 0) -or ($skippedCount -gt 0)) {; Write-Host "^""Successfully processed $renamedCount items and skipped $skippedCount items."^""; }; if ($failedCount -gt 0) {; Write-Warning "^""Failed to processed $($failedCount) items."^""; }"
:: Soft delete files matching pattern  : "%PROGRAMFILES%\NVIDIA Corporation\NvTelemetry\*"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%PROGRAMFILES%\NVIDIA Corporation\NvTelemetry\*"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $renamedCount   = 0; $skippedCount   = 0; $failedCount    = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping folder (not its contents): `"^""$path`"^""."^""; $skippedCount++; continue; }; if($revert -eq $true) {; if (-not $path.EndsWith('.OLD')) {; Write-Host "^""Skipping non-backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; } else {; if ($path.EndsWith('.OLD')) {; Write-Host "^""Skipping backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; }; $originalFilePath = $path; Write-Host "^""Processing file: `"^""$originalFilePath`"^""."^""; if (-Not (Test-Path $originalFilePath)) {; Write-Host "^""Skipping, file `"^""$originalFilePath`"^"" not found."^""; $skippedCount++; exit 0; }; if ($revert -eq $true) {; $newFilePath = $originalFilePath.Substring(0, $originalFilePath.Length - 4); } else {; $newFilePath = "^""$($originalFilePath).OLD"^""; }; try {; Move-Item -LiteralPath "^""$($originalFilePath)"^"" -Destination "^""$newFilePath"^"" -Force -ErrorAction Stop; Write-Host "^""Successfully processed `"^""$originalFilePath`"^""."^""; $renamedCount++; } catch {; Write-Error "^""Failed to rename `"^""$originalFilePath`"^"" to `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; $failedCount++; }; }; if (($renamedCount -gt 0) -or ($skippedCount -gt 0)) {; Write-Host "^""Successfully processed $renamedCount items and skipped $skippedCount items."^""; }; if ($failedCount -gt 0) {; Write-Warning "^""Failed to processed $($failedCount) items."^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Disable Nvidia telemetry drivers-------------
:: ----------------------------------------------------------
echo --- Disable Nvidia telemetry drivers
:: Soft delete files matching pattern  : "%SYSTEMROOT%\System32\DriverStore\FileRepository\NvTelemetry*.dll"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\System32\DriverStore\FileRepository\NvTelemetry*.dll"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $renamedCount   = 0; $skippedCount   = 0; $failedCount    = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping folder (not its contents): `"^""$path`"^""."^""; $skippedCount++; continue; }; if($revert -eq $true) {; if (-not $path.EndsWith('.OLD')) {; Write-Host "^""Skipping non-backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; } else {; if ($path.EndsWith('.OLD')) {; Write-Host "^""Skipping backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; }; $originalFilePath = $path; Write-Host "^""Processing file: `"^""$originalFilePath`"^""."^""; if (-Not (Test-Path $originalFilePath)) {; Write-Host "^""Skipping, file `"^""$originalFilePath`"^"" not found."^""; $skippedCount++; exit 0; }; if ($revert -eq $true) {; $newFilePath = $originalFilePath.Substring(0, $originalFilePath.Length - 4); } else {; $newFilePath = "^""$($originalFilePath).OLD"^""; }; try {; Move-Item -LiteralPath "^""$($originalFilePath)"^"" -Destination "^""$newFilePath"^"" -Force -ErrorAction Stop; Write-Host "^""Successfully processed `"^""$originalFilePath`"^""."^""; $renamedCount++; } catch {; Write-Error "^""Failed to rename `"^""$originalFilePath`"^"" to `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; $failedCount++; }; }; if (($renamedCount -gt 0) -or ($skippedCount -gt 0)) {; Write-Host "^""Successfully processed $renamedCount items and skipped $skippedCount items."^""; }; if ($failedCount -gt 0) {; Write-Warning "^""Failed to processed $($failedCount) items."^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable participation in Nvidia telemetry---------
:: ----------------------------------------------------------
echo --- Disable participation in Nvidia telemetry
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client' /v 'OptInOrOutPreference' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID44231' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID64640' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID66610' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup' /v 'SendTelemetryData' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Disable "Nvidia Telemetry Container" service-------
:: ----------------------------------------------------------
echo --- Disable "Nvidia Telemetry Container" service
:: Disable service(s): `NvTelemetryContainer`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'NvTelemetryContainer'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: ----------------------------------------------------------
:: Pause the script to view the final state
:: Restore previous environment settings
endlocal
:: Exit the script successfully
 /b 0    echo.
    echo ---  ---
)
echo.
echo [033]   Nvidia 2.bat
echo : https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   Nvidia 2.bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
:: https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
    )
)
:: Initialize environment
setlocal EnableExtensions DisableDelayedExpansion
:: ----------------------------------------------------------
:: ----------Disable "NVIDIA Telemetry Report" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report" task
:: Disable scheduled task(s): `\NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable "NVIDIA Telemetry Report on Logon" task------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report on Logon" task
:: Disable scheduled task(s): `\NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---------Disable "NVIDIA telemetry monitor" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA telemetry monitor" task
:: Disable scheduled task(s): `\NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Remove Nvidia telemetry packages-------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry packages
if exist "%ProgramFiles%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL" (
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetryContainer
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetry
)
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------------Remove Nvidia telemetry components------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry components
:: Soft delete files matching pattern  : "%PROGRAMFILES(X86)%\NVIDIA Corporation\NvTelemetry\*"
:: Soft delete files matching pattern  : "%PROGRAMFILES%\NVIDIA Corporation\NvTelemetry\*"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Disable Nvidia telemetry drivers-------------
:: ----------------------------------------------------------
echo --- Disable Nvidia telemetry drivers
:: Soft delete files matching pattern  : "%SYSTEMROOT%\System32\DriverStore\FileRepository\NvTelemetry*.dll"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable participation in Nvidia telemetry---------
:: ----------------------------------------------------------
echo --- Disable participation in Nvidia telemetry
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client' /v 'OptInOrOutPreference' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID44231' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID64640' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID66610' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup' /v 'SendTelemetryData' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Disable "Nvidia Telemetry Container" service-------
:: ----------------------------------------------------------
echo --- Disable "Nvidia Telemetry Container" service
:: Disable service(s): `NvTelemetryContainer`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'NvTelemetryContainer'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: ----------------------------------------------------------
:: Pause the script to view the final state
:: Restore previous environment settings
endlocal
:: Exit the script successfully
    echo.
    echo ---  ---
)
echo.
echo [034]   Nvidia 3.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   Nvidia 3.bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID66610" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID64640" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID44231" /t REG_DWORD /d "0" /f
schtasks /change /disable /tn "NvTmRep_CrashReport1_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmRep_CrashReport2_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmRep_CrashReport3_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmRep_CrashReport4_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvDriverUpdateCheckDaily_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NVIDIA GeForce Experience SelfUpdate_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
echo Completed.
    echo.
    echo ---  ---
)
echo.
echo [035]   Nvidia.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   Nvidia.bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
echo аЄ  вҐ«аЁЁ NVIDIA
sc stop NvTelemetryContainer > NUL 2>&1
sc config NvTelemetryContainer start= disabled > NUL 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvTmMon"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvTmRep"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvTmRepOnLogon"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvProfileUpdaterDaily"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvProfileUpdaterOnLogon"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
reg add "HKCU\SOFTWARE\NVIDIA Corporation\NVControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d 0 /f > NUL 2>&1
echo бЇҐи­®!
    echo.
    echo ---  ---
)
echo.
echo [036]   Windows.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   Windows.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLua" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_SZ /d "00000000" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowSharedUserAppData" /v "value" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowStore" /v "value" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [037]  .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  .bat ---
    echo.
reg add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup" /v "SendTelemetryData" /t REG_DWORD /d "0" /f
echo Execution is done.
    echo.
    echo ---  ---
)
echo.
echo [038]   .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   .bat ---
    echo.
start "" "C:\Windows\System32\msinfo32.exe"    echo.
    echo ---  ---
)
echo.
echo [039]    Nvidia.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :    Nvidia.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DpiMapIommuContiguous" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [040] .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- : .bat ---
    echo.
C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -acp 0    echo.
    echo ---  ---
)
goto :end
:auto_mode
cls
echo ==================================================
echo  
echo ==================================================
echo.
echo.
echo [001] : BIOS Nvidia.bat
echo --------------------------------------------
@chcp 65001 >nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f
REM Define download folder
set DOWNLOAD_FOLDER=C:\Downloads
REM Ensure the download folder exists
if not exist "%DOWNLOAD_FOLDER%" mkdir "%DOWNLOAD_FOLDER%"
REM Log file for debugging
set LOGFILE="%DOWNLOAD_FOLDER%\download_log.txt"
REM Clear the log file before writing new logs
if exist "%LOGFILE%" del "%LOGFILE%"
REM Download files to the defined download folder with logging
echo Downloading SCEWIN_64.exe...
start /MIN /WAIT powershell -Command "Invoke-WebRequest -Uri 'https://github.com/agalievvv/ickurdaneteboli/raw/main/SCEWIN_64.exe' -OutFile '%DOWNLOAD_FOLDER%\SCEWIN_64.exe' 2>&1 | Tee-Object -FilePath '%LOGFILE%'"
echo Downloading amifldrv64.sys...
start /MIN /WAIT powershell -Command "Invoke-WebRequest -Uri 'https://github.com/agalievvv/ickurdaneteboli/raw/main/amifldrv64.sys' -OutFile '%DOWNLOAD_FOLDER%\amifldrv64.sys' 2>&1 | Tee-Object -FilePath '%LOGFILE%'"
echo Downloading amigendrv64.sys...
start /MIN /WAIT powershell -Command "Invoke-WebRequest -Uri 'https://github.com/agalievvv/ickurdaneteboli/raw/main/amigendrv64.sys' -OutFile '%DOWNLOAD_FOLDER%\amigendrv64.sys' 2>&1 | Tee-Object -FilePath '%LOGFILE%'"
REM Check if the downloads were successful and move the files
if exist "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" (
    echo SCEWIN_64.exe downloaded successfully.
) else (
    echo SCEWIN_64.exe was not downloaded. Check the log file at "%LOGFILE%" for errors.
)
if exist "%DOWNLOAD_FOLDER%\amifldrv64.sys" (
    echo amifldrv64.sys downloaded successfully.
) else (
    echo amifldrv64.sys was not downloaded. Check the log file at "%LOGFILE%" for errors.
)
if exist "%DOWNLOAD_FOLDER%\amigendrv64.sys" (
    echo amigendrv64.sys downloaded successfully.
) else (
    echo amigendrv64.sys was not downloaded. Check the log file at "%LOGFILE%" for errors.
)
REM Proceed with executing the downloaded executable if it exists
if exist "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" (
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ACPI Notify on TBT Hot-plug" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ACPI Standby State" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ACPI T-States" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ALS Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "AP threads Idle Manner" /qv 0x03
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ARI Forwarding" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ASPM" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BCLK Aware Adaptive Voltage" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Bi-directional PROCHOT#" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BIOS Hot-Plug Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BIOS Lock" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BIST Enable" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEG0 Hotplug" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP enumerated SATA ports" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP GNA" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP I2C6" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP I2C7" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP IPU" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP LAN(GBE)" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe DG1" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe GFX" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe LAN" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe Other" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe Storage" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe WLAN" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PEG0" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP SATA" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP SDXC" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP SPI" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP TBT RP" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP TCSS" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP THC0" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP THC1" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "SW Guard Extensions SGX" /qv 0x02
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "System Acceleration with Intel(R) Optane(TM) Memory" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Tcc Offset Lock Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB DbC Enable Mode" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB Overcurrent Override for DbC" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB S5 Wakeup Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB Standby Power at S4/S5" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB2 PHY Sus Well Power Gating" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB3 Type-C UFP2DFP Kernel/Platform Debug Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB3" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "VDD Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Vmax Stress" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Voltage Optimization" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Wake From Thunderbolt(TM) Devices" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Wake on LAN Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Wake on WLAN and BT Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "WatchDog" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "WDT Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Windows 10 Thunderbolt support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "WoV (Wake on Voice)" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Snoop Latency Override" /qv 0x02
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Non Snoop Latency Multiplier" /qv 0x01
)
echo --------------------------------------------
echo [OK]  1 
echo.
echo.
echo [002] : Gpu .bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler --> [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers
:: ------------------------------------------------------------------------------------------------------------------------------------------------
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InterruptSteeringDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighestPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MinimumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumPerformancePercent" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitialUnparkCount" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f
REM "
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Acceleration.Level" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DesktopStereoShortcuts" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "FeatureControl" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NVDeviceSupportKFilter" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmCacheLoc" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmDisableInst2Sys" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmFbsrPagedDMA" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMGpuId" /t REG_DWORD /d "256" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmProfilingAdminOnly" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TCCSupported" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TrackResetEngine" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "UseBestResolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ValidateBlitSubRects" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PlatformSupportMiracast" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  2 
echo.
echo.
echo [003] : GpuEnergyDriver.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  3 
echo.
echo.
echo [004] : N ECC.bat
echo --------------------------------------------
C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -e 0echo --------------------------------------------
echo [OK]  4 
echo.
echo.
echo [005] : Nvidia .bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\***\0000\PowerSettings" /v "ConservationIdleTime" /t REG_BINARY /d "00000000" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\***\0000\PowerSettings" /v "IdlePowerState" /t REG_BINARY /d "00000000" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\***\0000\PowerSettings" /v "PerformanceIdleTime" /t REG_BINARY /d "00000000" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  5 
echo.
echo.
echo [006] : Nvidia  .bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NvTelemetryContainer" /v "Start" /t REG_DWORD /d "4" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  6 
echo.
echo.
echo [007] : Nvidia.bat
echo --------------------------------------------
rmdir /s /q "C:\Windows\System32\drivers\NVIDIA Corporation"
cd /d "C:\Windows\System32\DriverStore\FileRepository\"
dir NvTelemetry64.dll /a /b /s
del NvTelemetry64.dll /a /s
reg add "HKCU\SOFTWARE\NVIDIA Corporation\NVControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d "0" /f >nul 2>&1echo --------------------------------------------
echo [OK]  7 
echo.
echo.
echo [008] : P0-.bat
echo --------------------------------------------
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f > nul 2>&1
                   )
                )
             )echo --------------------------------------------
echo [OK]  8 
echo.
echo.
echo [009] :  HDCP.bat
echo --------------------------------------------
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMHdcpKeyglobZero" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /f
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "RMHdcpKeyglobZero" /f >nul 2>&1
                   )
                )
             )echo --------------------------------------------
echo [OK]  9 
echo.
echo.
echo [010] :   Pstate.bat
echo --------------------------------------------
for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
    for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
        for /f %%c in ('echo %%b ^| findstr "{"') do (
            Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /f
        )
    )
)echo --------------------------------------------
echo [OK]  10 
echo.
echo.
echo [011] :     Nvidia.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMDisableLRCCoalescing" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  11 
echo.
echo.
echo [012] :   NVIDIA.bat
echo --------------------------------------------
start "https://www.nvidia.com/ru-ru/geforce/drivers/"echo --------------------------------------------
echo [OK]  12 
echo.
echo.
echo [013] :  .bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "StreamType" /t REG_DWORD /d "0" /f
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "WriteCapture" /t REG_DWORD /d "0" /f
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "WriteCaptureDir" /t REG_SZ /d "c:\dm.capture\\" /f
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "WriteCapturePath" /t REG_SZ /d "" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  13 
echo.
echo.
echo [014] :  GeForceExp..bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
DevManView.exe /disable "NvModuleTracker Device" >nul 2>&1
DevManView.exe /disable "NVIDIA Virtual Audio Device (Wave Extensible) (WDM)" >nul 2>&1
for %%i in (NvTmMon NvTmRep NvProfile NvNodeLauncher NvDriverUpdateCheckDaily "NVIDIA GeForce Experience SelfUpdate*") do for /f "tokens=1 delims=," %%a in ('schtasks /query /fo csv ^| findstr /v "TaskName" ^| findstr "%%~i"') do schtasks /change /tn "%%a" /disable >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\NVIDIA Corporation\Global\GFExperience" /v "NotifyNewDisplayUpdates" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\NVIDIA Corporation\NvTray" /v "StartOnLogin" /t REG_DWORD /d "0" /f >nul 2>&1
exitecho --------------------------------------------
echo [OK]  14 
echo.
echo.
echo [015] :  HDCP.bat
echo --------------------------------------------
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMHdcpKeyglobZero" /t REG_DWORD /d "1" /f
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "RMHdcpKeyglobZero" /t REG_DWORD /d "1" /f >nul 2>&1			 
                   )
                )
             )echo --------------------------------------------
echo [OK]  15 
echo.
echo.
echo [016] :  Nvidia Dynamic P-STATE.cmd
echo --------------------------------------------
for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
    for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
        for /f %%c in ('echo %%b ^| findstr "{"') do (
            Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f
        )
    )
)
exitecho --------------------------------------------
echo [OK]  16 
echo.
echo.
echo [017] :  .bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d "5" /f
exitecho --------------------------------------------
echo [OK]  17 
echo.
echo.
echo [018] :   Pstate.bat
echo --------------------------------------------
for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
    for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
        for /f %%c in ('echo %%b ^| findstr "{"') do (
            Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f
        )
    )
)echo --------------------------------------------
echo [OK]  18 
echo.
echo.
echo [019] :  .bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /s /f "Scaling"^| findstr "HKEY"') do reg.exe add "%%i" /v "Scaling" /t REG_DWORD /d "1" /f >nul 2>&1echo --------------------------------------------
echo [OK]  19 
echo.
echo.
echo [020] :   .bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ;Disable Delivery Optimization
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v "DownloadMode" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  20 
echo.
echo.
echo [021] :  .bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\diagsvc" /v "Start" /t REG_DWORD /d "4" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  21 
echo.
echo.
echo [022] :  .bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler --> [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers
:: ------------------------------------------------------------------------------------------------------------------------------------------------
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisablePreemption" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PlatformSupportMiracast" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  22 
echo.
echo.
echo [023] : .bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE																										made by konex#8100
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableWriteCombining" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  23 
echo.
echo.
echo [024] :   Nvidia.bat
echo --------------------------------------------
@echo BESPLATNO! from Reborn FREE PC Optimization (RU) - https://discord.gg/hgBQRsrDRu
@echo made by FrazE-
@echo Clearing NVIDIA DirectX Cache...
REM РџРµСЂРµС…РѕРґ Рє РїР°РїРєРµ DXCache СЃ РёСЃРїРѕР»СЊР·РѕРІР°РЅРёРµРј РїРµСЂРµРјРµРЅРЅС‹С… СЃСЂРµРґС‹
set DXCachePath=%LOCALAPPDATA%\..\LocalLow\NVIDIA\PerDriverVersion\DXCache
REM РџСЂРѕРІРµСЂРєР° СЃСѓС‰РµСЃС‚РІРѕРІР°РЅРёСЏ РїР°РїРєРё
if exist "%DXCachePath%" (
    @echo Found directory: %DXCachePath%
    @echo Deleting cache files...
    del /q "%DXCachePath%\*.*"
    @echo Cache cleared successfully.
) else (
    @echo Directory not found: %DXCachePath%
)
@echo Completed.
@pause
echo --------------------------------------------
echo [OK]  24 
echo.
echo.
echo [025] :  .bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "EnableRID61684" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  25 
echo.
echo.
echo [026] :   .bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -acp 0echo --------------------------------------------
echo [OK]  26 
echo.
echo.
echo [027] :  P-.bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f > nul 2>&1
                   )
                )
             )echo --------------------------------------------
echo [OK]  27 
echo.
echo.
echo [028] :   P0.bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f > nul 2>&1
                   )
                )
             )echo --------------------------------------------
echo [OK]  28 
echo.
echo.
echo [029] :      Nvidia.bat
echo --------------------------------------------
echo.
echo.
echo.                 -----------------------------------------------------------------------------------------------------------------
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A 
:::                
:::                   $$$$$$$$\ $$\   $$\ $$\      $$\       $$$$$$$$\ $$\      $$\ $$$$$$$$\  $$$$$$\  $$\   $$\ $$$$$$$$\ $$$$$$$\  
:::                   $$  _____|$$ |  $$ |$$$\    $$$ |      \__$$  __|$$ | $\  $$ |$$  _____|$$  __$$\ $$ | $$  |$$  _____|$$  __$$\ 
:::                   $$ |      \$$\ $$  |$$$$\  $$$$ |         $$ |   $$ |$$$\ $$ |$$ |      $$ /  $$ |$$ |$$  / $$ |      $$ |  $$ |
:::                   $$$$$\     \$$$$  / $$\$$\$$ $$ |         $$ |   $$ $$ $$\$$ |$$$$$\    $$$$$$$$ |$$$$$  /  $$$$$\    $$$$$$$  |
:::                   $$  __|    $$  $$<  $$ \$$$  $$ |         $$ |   $$$$  _$$$$ |$$  __|   $$  __$$ |$$  $$<   $$  __|   $$  __$$< 
:::                   $$ |      $$  /\$$\ $$ |\$  /$$ |         $$ |   $$$  / \$$$ |$$ |      $$ |  $$ |$$ |\$$\  $$ |      $$ |  $$ |
:::                   $$$$$$$$\ $$ /  $$ |$$ | \_/ $$ |         $$ |   $$  /   \$$ |$$$$$$$$\ $$ |  $$ |$$ | \$$\ $$$$$$$$\ $$ |  $$ |
:::                   \________|\__|  \__|\__|     \__|         \__|   \__/     \__|\________|\__|  \__|\__|  \__|\________|\__|  \__|   
:::                                                                                                                 	
echo.                -----------------------------------------------------------------------------------------------------------------	
echo.  
echo.
echo.
echo 
echo.
echo                                                        Press Any Key To Continue...     
 >nul  						
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InterruptSteeringDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighestPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MinimumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumPerformancePercent" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitialUnparkCount" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnablePreemption" /t REG_DWORD /d "0" /f
echo.
echo 
echo.
echo                                                        Press any key to exit...     
 >nul
cls
echo --------------------------------------------
echo [OK]  29 
echo.
echo.
echo [030] :    Nvidia.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler --> [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers
:: ------------------------------------------------------------------------------------------------------------------------------------------------
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InterruptSteeringDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighestPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MinimumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumPerformancePercent" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitialUnparkCount" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f
REM "
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Acceleration.Level" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DesktopStereoShortcuts" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "FeatureControl" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NVDeviceSupportKFilter" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmCacheLoc" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmDisableInst2Sys" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmFbsrPagedDMA" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMGpuId" /t REG_DWORD /d "256" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmProfilingAdminOnly" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TCCSupported" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TrackResetEngine" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "UseBestResolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ValidateBlitSubRects" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PlatformSupportMiracast" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  30 
echo.
echo.
echo [031] :  ECC.bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -e 0echo --------------------------------------------
echo [OK]  31 
echo.
echo.
echo [032] :   Nvidia .bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
:: https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
 & exit 1
    )
 0
)
:: Initialize environment
setlocal EnableExtensions DisableDelayedExpansion
:: ----------------------------------------------------------
:: ----------Disable "NVIDIA Telemetry Report" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report" task
:: Disable scheduled task(s): `\NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable "NVIDIA Telemetry Report on Logon" task------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report on Logon" task
:: Disable scheduled task(s): `\NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---------Disable "NVIDIA telemetry monitor" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA telemetry monitor" task
:: Disable scheduled task(s): `\NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Remove Nvidia telemetry packages-------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry packages
if exist "%ProgramFiles%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL" (
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetryContainer
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetry
)
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------------Remove Nvidia telemetry components------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry components
:: Soft delete files matching pattern  : "%PROGRAMFILES(X86)%\NVIDIA Corporation\NvTelemetry\*"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%PROGRAMFILES(X86)%\NVIDIA Corporation\NvTelemetry\*"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $renamedCount   = 0; $skippedCount   = 0; $failedCount    = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping folder (not its contents): `"^""$path`"^""."^""; $skippedCount++; continue; }; if($revert -eq $true) {; if (-not $path.EndsWith('.OLD')) {; Write-Host "^""Skipping non-backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; } else {; if ($path.EndsWith('.OLD')) {; Write-Host "^""Skipping backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; }; $originalFilePath = $path; Write-Host "^""Processing file: `"^""$originalFilePath`"^""."^""; if (-Not (Test-Path $originalFilePath)) {; Write-Host "^""Skipping, file `"^""$originalFilePath`"^"" not found."^""; $skippedCount++; exit 0; }; if ($revert -eq $true) {; $newFilePath = $originalFilePath.Substring(0, $originalFilePath.Length - 4); } else {; $newFilePath = "^""$($originalFilePath).OLD"^""; }; try {; Move-Item -LiteralPath "^""$($originalFilePath)"^"" -Destination "^""$newFilePath"^"" -Force -ErrorAction Stop; Write-Host "^""Successfully processed `"^""$originalFilePath`"^""."^""; $renamedCount++; } catch {; Write-Error "^""Failed to rename `"^""$originalFilePath`"^"" to `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; $failedCount++; }; }; if (($renamedCount -gt 0) -or ($skippedCount -gt 0)) {; Write-Host "^""Successfully processed $renamedCount items and skipped $skippedCount items."^""; }; if ($failedCount -gt 0) {; Write-Warning "^""Failed to processed $($failedCount) items."^""; }"
:: Soft delete files matching pattern  : "%PROGRAMFILES%\NVIDIA Corporation\NvTelemetry\*"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%PROGRAMFILES%\NVIDIA Corporation\NvTelemetry\*"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $renamedCount   = 0; $skippedCount   = 0; $failedCount    = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping folder (not its contents): `"^""$path`"^""."^""; $skippedCount++; continue; }; if($revert -eq $true) {; if (-not $path.EndsWith('.OLD')) {; Write-Host "^""Skipping non-backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; } else {; if ($path.EndsWith('.OLD')) {; Write-Host "^""Skipping backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; }; $originalFilePath = $path; Write-Host "^""Processing file: `"^""$originalFilePath`"^""."^""; if (-Not (Test-Path $originalFilePath)) {; Write-Host "^""Skipping, file `"^""$originalFilePath`"^"" not found."^""; $skippedCount++; exit 0; }; if ($revert -eq $true) {; $newFilePath = $originalFilePath.Substring(0, $originalFilePath.Length - 4); } else {; $newFilePath = "^""$($originalFilePath).OLD"^""; }; try {; Move-Item -LiteralPath "^""$($originalFilePath)"^"" -Destination "^""$newFilePath"^"" -Force -ErrorAction Stop; Write-Host "^""Successfully processed `"^""$originalFilePath`"^""."^""; $renamedCount++; } catch {; Write-Error "^""Failed to rename `"^""$originalFilePath`"^"" to `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; $failedCount++; }; }; if (($renamedCount -gt 0) -or ($skippedCount -gt 0)) {; Write-Host "^""Successfully processed $renamedCount items and skipped $skippedCount items."^""; }; if ($failedCount -gt 0) {; Write-Warning "^""Failed to processed $($failedCount) items."^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Disable Nvidia telemetry drivers-------------
:: ----------------------------------------------------------
echo --- Disable Nvidia telemetry drivers
:: Soft delete files matching pattern  : "%SYSTEMROOT%\System32\DriverStore\FileRepository\NvTelemetry*.dll"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\System32\DriverStore\FileRepository\NvTelemetry*.dll"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $renamedCount   = 0; $skippedCount   = 0; $failedCount    = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping folder (not its contents): `"^""$path`"^""."^""; $skippedCount++; continue; }; if($revert -eq $true) {; if (-not $path.EndsWith('.OLD')) {; Write-Host "^""Skipping non-backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; } else {; if ($path.EndsWith('.OLD')) {; Write-Host "^""Skipping backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; }; $originalFilePath = $path; Write-Host "^""Processing file: `"^""$originalFilePath`"^""."^""; if (-Not (Test-Path $originalFilePath)) {; Write-Host "^""Skipping, file `"^""$originalFilePath`"^"" not found."^""; $skippedCount++; exit 0; }; if ($revert -eq $true) {; $newFilePath = $originalFilePath.Substring(0, $originalFilePath.Length - 4); } else {; $newFilePath = "^""$($originalFilePath).OLD"^""; }; try {; Move-Item -LiteralPath "^""$($originalFilePath)"^"" -Destination "^""$newFilePath"^"" -Force -ErrorAction Stop; Write-Host "^""Successfully processed `"^""$originalFilePath`"^""."^""; $renamedCount++; } catch {; Write-Error "^""Failed to rename `"^""$originalFilePath`"^"" to `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; $failedCount++; }; }; if (($renamedCount -gt 0) -or ($skippedCount -gt 0)) {; Write-Host "^""Successfully processed $renamedCount items and skipped $skippedCount items."^""; }; if ($failedCount -gt 0) {; Write-Warning "^""Failed to processed $($failedCount) items."^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable participation in Nvidia telemetry---------
:: ----------------------------------------------------------
echo --- Disable participation in Nvidia telemetry
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client' /v 'OptInOrOutPreference' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID44231' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID64640' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID66610' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup' /v 'SendTelemetryData' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Disable "Nvidia Telemetry Container" service-------
:: ----------------------------------------------------------
echo --- Disable "Nvidia Telemetry Container" service
:: Disable service(s): `NvTelemetryContainer`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'NvTelemetryContainer'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: ----------------------------------------------------------
:: Pause the script to view the final state
:: Restore previous environment settings
endlocal
:: Exit the script successfully
 /b 0echo --------------------------------------------
echo [OK]  32 
echo.
echo.
echo [033] :   Nvidia 2.bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
:: https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
    )
)
:: Initialize environment
setlocal EnableExtensions DisableDelayedExpansion
:: ----------------------------------------------------------
:: ----------Disable "NVIDIA Telemetry Report" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report" task
:: Disable scheduled task(s): `\NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable "NVIDIA Telemetry Report on Logon" task------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report on Logon" task
:: Disable scheduled task(s): `\NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---------Disable "NVIDIA telemetry monitor" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA telemetry monitor" task
:: Disable scheduled task(s): `\NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Remove Nvidia telemetry packages-------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry packages
if exist "%ProgramFiles%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL" (
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetryContainer
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetry
)
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------------Remove Nvidia telemetry components------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry components
:: Soft delete files matching pattern  : "%PROGRAMFILES(X86)%\NVIDIA Corporation\NvTelemetry\*"
:: Soft delete files matching pattern  : "%PROGRAMFILES%\NVIDIA Corporation\NvTelemetry\*"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Disable Nvidia telemetry drivers-------------
:: ----------------------------------------------------------
echo --- Disable Nvidia telemetry drivers
:: Soft delete files matching pattern  : "%SYSTEMROOT%\System32\DriverStore\FileRepository\NvTelemetry*.dll"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable participation in Nvidia telemetry---------
:: ----------------------------------------------------------
echo --- Disable participation in Nvidia telemetry
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client' /v 'OptInOrOutPreference' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID44231' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID64640' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID66610' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup' /v 'SendTelemetryData' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Disable "Nvidia Telemetry Container" service-------
:: ----------------------------------------------------------
echo --- Disable "Nvidia Telemetry Container" service
:: Disable service(s): `NvTelemetryContainer`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'NvTelemetryContainer'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: ----------------------------------------------------------
:: Pause the script to view the final state
:: Restore previous environment settings
endlocal
:: Exit the script successfully
echo --------------------------------------------
echo [OK]  33 
echo.
echo.
echo [034] :   Nvidia 3.bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID66610" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID64640" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID44231" /t REG_DWORD /d "0" /f
schtasks /change /disable /tn "NvTmRep_CrashReport1_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmRep_CrashReport2_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmRep_CrashReport3_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmRep_CrashReport4_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvDriverUpdateCheckDaily_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NVIDIA GeForce Experience SelfUpdate_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
echo Completed.
echo --------------------------------------------
echo [OK]  34 
echo.
echo.
echo [035] :   Nvidia.bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
echo аЄ  вҐ«аЁЁ NVIDIA
sc stop NvTelemetryContainer > NUL 2>&1
sc config NvTelemetryContainer start= disabled > NUL 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvTmMon"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvTmRep"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvTmRepOnLogon"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvProfileUpdaterDaily"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvProfileUpdaterOnLogon"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
reg add "HKCU\SOFTWARE\NVIDIA Corporation\NVControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d 0 /f > NUL 2>&1
echo бЇҐи­®!
pauseecho --------------------------------------------
echo [OK]  35 
echo.
echo.
echo [036] :   Windows.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLua" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_SZ /d "00000000" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowSharedUserAppData" /v "value" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowStore" /v "value" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  36 
echo.
echo.
echo [037] :  .bat
echo --------------------------------------------
reg add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup" /v "SendTelemetryData" /t REG_DWORD /d "0" /f
echo Execution is done.
echo --------------------------------------------
echo [OK]  37 
echo.
echo.
echo [038] :   .bat
echo --------------------------------------------
start "" "C:\Windows\System32\msinfo32.exe"echo --------------------------------------------
echo [OK]  38 
echo.
echo.
echo [039] :    Nvidia.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DpiMapIommuContiguous" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  39 
echo.
echo.
echo [040] : .bat
echo --------------------------------------------
C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -acp 0echo --------------------------------------------
echo [OK]  40 
echo.
:end
echo.
echo ==================================================
echo   
echo ==================================================    echo.
    echo --- Выполнено ---
)
echo.
echo [014] Включить HDCP.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Включить HDCP.bat ---
    echo.
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMHdcpKeyglobZero" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /f
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
for /f %%i in ('echo %%a ^| findstr "{"') do (
Reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "RMHdcpKeyglobZero" /f >nul 2>&1
)
)
)    echo.
    echo --- Выполнено ---
)
echo.
echo [015] Включить динамический Pstate.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Включить динамический Pstate.bat ---
    echo.
for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
for /f %%c in ('echo %%b ^| findstr "{"') do (
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /f
)
)
)    echo.
    echo --- Выполнено ---
)
echo.
echo [016] Включить объеденение глобальной памяти Nvidia.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Включить объеденение глобальной памяти Nvidia.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMDisableLRCCoalescing" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof    echo.
    echo --- Выполнено ---
)
echo.
echo [017] Загрузка драйверов NVIDIA.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Загрузка драйверов NVIDIA.bat ---
    echo.
start "https://www.nvidia.com/ru-ru/geforce/drivers/"    echo.
    echo --- Выполнено ---
)
echo.
echo [018] Оптимизация графики.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Оптимизация графики.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "StreamType" /t REG_DWORD /d "0" /f
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "WriteCapture" /t REG_DWORD /d "0" /f
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "WriteCaptureDir" /t REG_SZ /d "c:\dm.capture\\" /f
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "WriteCapturePath" /t REG_SZ /d "" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof    echo.
    echo --- Выполнено ---
)
echo.
echo [019] Отключите GeForceExp.Телеметрия.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Отключите GeForceExp.Телеметрия.bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.

DevManView.exe /disable "NvModuleTracker Device" >nul 2>&1
DevManView.exe /disable "NVIDIA Virtual Audio Device (Wave Extensible) (WDM)" >nul 2>&1

for %%i in (NvTmMon NvTmRep NvProfile NvNodeLauncher NvDriverUpdateCheckDaily "NVIDIA GeForce Experience SelfUpdate*") do for /f "tokens=1 delims=," %%a in ('schtasks /query /fo csv ^| findstr /v "TaskName" ^| findstr "%%~i"') do schtasks /change /tn "%%a" /disable >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\NVIDIA Corporation\Global\GFExperience" /v "NotifyNewDisplayUpdates" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\NVIDIA Corporation\NvTray" /v "StartOnLogin" /t REG_DWORD /d "0" /f >nul 2>&1

exit    echo.
    echo --- Выполнено ---
)
echo.
echo [020] Отключить HDCP.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Отключить HDCP.bat ---
    echo.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMHdcpKeyglobZero" /t REG_DWORD /d "1" /f
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
for /f %%i in ('echo %%a ^| findstr "{"') do (
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "RMHdcpKeyglobZero" /t REG_DWORD /d "1" /f >nul 2>&1			 
)
)
)    echo.
    echo --- Выполнено ---
)
echo.
echo [021] Отключить Nvidia Dynamic P-STATE.cmd
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Отключить Nvidia Dynamic P-STATE.cmd ---
    echo.
for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
    for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
        for /f %%c in ('echo %%b ^| findstr "{"') do (
            Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f
        )
    )
)
pause
exit    echo.
    echo --- Выполнено ---
)
echo.
echo [022] Отключить МПО.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Отключить МПО.bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d "5" /f

exit    echo.
    echo --- Выполнено ---
)
echo.
echo [023] Отключить динамическое Pstate.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Отключить динамическое Pstate.bat ---
    echo.
for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
for /f %%c in ('echo %%b ^| findstr "{"') do (
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f
)
)
)    echo.
    echo --- Выполнено ---
)
echo.
echo [024] Отключить масштабирование.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Отключить масштабирование.bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.

for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /s /f "Scaling"^| findstr "HKEY"') do reg.exe add "%%i" /v "Scaling" /t REG_DWORD /d "1" /f >nul 2>&1    echo.
    echo --- Выполнено ---
)
echo.
echo [025] Отключить оптимизацию доставки.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Отключить оптимизацию доставки.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ;Disable Delivery Optimization
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v "DownloadMode" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof    echo.
    echo --- Выполнено ---
)
echo.
echo [026] Отключить телеметрию.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Отключить телеметрию.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\diagsvc" /v "Start" /t REG_DWORD /d "4" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof    echo.
    echo --- Выполнено ---
)
echo.
echo [027] Отключить упреждение.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Отключить упреждение.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler --> [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers
:: ------------------------------------------------------------------------------------------------------------------------------------------------
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisablePreemption" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PlatformSupportMiracast" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof    echo.
    echo --- Выполнено ---
)
echo.
echo [028] ОтключитьЗаписьОбъединение.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: ОтключитьЗаписьОбъединение.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE																										made by konex#8100
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableWriteCombining" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof    echo.
    echo --- Выполнено ---
)
echo.
echo [029] Очистить кеш Nvidia.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Очистить кеш Nvidia.bat ---
    echo.
@echo BESPLATNO! from Reborn FREE PC Optimization (RU) - https://discord.gg/hgBQRsrDRu
@echo made by FrazE-
@echo Clearing NVIDIA DirectX Cache...

REM РџРµСЂРµС…РѕРґ Рє РїР°РїРєРµ DXCache СЃ РёСЃРїРѕР»СЊР·РѕРІР°РЅРёРµРј РїРµСЂРµРјРµРЅРЅС‹С… СЃСЂРµРґС‹
set DXCachePath=%LOCALAPPDATA%\..\LocalLow\NVIDIA\PerDriverVersion\DXCache

REM РџСЂРѕРІРµСЂРєР° СЃСѓС‰РµСЃС‚РІРѕРІР°РЅРёСЏ РїР°РїРєРё
if exist "%DXCachePath%" (
    @echo Found directory: %DXCachePath%
    @echo Deleting cache files...
    del /q "%DXCachePath%\*.*"
    @echo Cache cleared successfully.
) else (
    @echo Directory not found: %DXCachePath%
)
@echo Completed.
@pause
    echo.
    echo --- Выполнено ---
)
echo.
echo [030] Показать шелковистость.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Показать шелковистость.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "EnableRID61684" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof    echo.
    echo --- Выполнено ---
)
echo.
echo [031] Политика неограниченного времени.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Политика неограниченного времени.bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.

C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -acp 0    echo.
    echo --- Выполнено ---
)
echo.
echo [032] Принудительное P-состояние.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Принудительное P-состояние.bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f > nul 2>&1
                   )
                )
             )    echo.
    echo --- Выполнено ---
)
echo.
echo [033] Принудительное состояние P0.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Принудительное состояние P0.bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f > nul 2>&1
                   )
                )
             )    echo.
    echo --- Выполнено ---
)
echo.
echo [034] Расширенные скрытые настройки графического процессора Nvidia.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Расширенные скрытые настройки графического процессора Nvidia.bat ---
    echo.
echo.
echo.
echo.                 -----------------------------------------------------------------------------------------------------------------
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A 
:::                
:::                   $$$$$$$$\ $$\   $$\ $$\      $$\       $$$$$$$$\ $$\      $$\ $$$$$$$$\  $$$$$$\  $$\   $$\ $$$$$$$$\ $$$$$$$\  
:::                   $$  _____|$$ |  $$ |$$$\    $$$ |      \__$$  __|$$ | $\  $$ |$$  _____|$$  __$$\ $$ | $$  |$$  _____|$$  __$$\ 
:::                   $$ |      \$$\ $$  |$$$$\  $$$$ |         $$ |   $$ |$$$\ $$ |$$ |      $$ /  $$ |$$ |$$  / $$ |      $$ |  $$ |
:::                   $$$$$\     \$$$$  / $$\$$\$$ $$ |         $$ |   $$ $$ $$\$$ |$$$$$\    $$$$$$$$ |$$$$$  /  $$$$$\    $$$$$$$  |
:::                   $$  __|    $$  $$<  $$ \$$$  $$ |         $$ |   $$$$  _$$$$ |$$  __|   $$  __$$ |$$  $$<   $$  __|   $$  __$$< 
:::                   $$ |      $$  /\$$\ $$ |\$  /$$ |         $$ |   $$$  / \$$$ |$$ |      $$ |  $$ |$$ |\$$\  $$ |      $$ |  $$ |
:::                   $$$$$$$$\ $$ /  $$ |$$ | \_/ $$ |         $$ |   $$  /   \$$ |$$$$$$$$\ $$ |  $$ |$$ | \$$\ $$$$$$$$\ $$ |  $$ |
:::                   \________|\__|  \__|\__|     \__|         \__|   \__/     \__|\________|\__|  \__|\__|  \__|\________|\__|  \__|   
:::                                                                                                                 	
echo.                -----------------------------------------------------------------------------------------------------------------	
echo.  
echo.
echo.
echo 
echo.
echo                                                        Press Any Key To Continue...     
pause >nul  						
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InterruptSteeringDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighestPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MinimumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumPerformancePercent" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitialUnparkCount" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnablePreemption" /t REG_DWORD /d "0" /f
echo.
echo 
echo.
echo                                                        Press any key to exit...     
pause >nul
cls
exit
    echo.
    echo --- Выполнено ---
)
echo.
echo [035] Твики графического процессора Nvidia.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Твики графического процессора Nvidia.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler --> [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers
:: ------------------------------------------------------------------------------------------------------------------------------------------------
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InterruptSteeringDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighestPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MinimumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumPerformancePercent" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitialUnparkCount" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f
REM "
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Acceleration.Level" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DesktopStereoShortcuts" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "FeatureControl" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NVDeviceSupportKFilter" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmCacheLoc" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmDisableInst2Sys" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmFbsrPagedDMA" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMGpuId" /t REG_DWORD /d "256" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmProfilingAdminOnly" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TCCSupported" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TrackResetEngine" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "UseBestResolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ValidateBlitSubRects" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PlatformSupportMiracast" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof    echo.
    echo --- Выполнено ---
)
echo.
echo [036] Удалить ECC.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Удалить ECC.bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.

C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -e 0    echo.
    echo --- Выполнено ---
)
echo.
echo [037] Удалить телеметрию Nvidia .bat
echo Описание: https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Удалить телеметрию Nvidia .bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.

:: https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
        pause & exit 1
    )
    exit 0
)
:: Initialize environment
setlocal EnableExtensions DisableDelayedExpansion


:: ----------------------------------------------------------
:: ----------Disable "NVIDIA Telemetry Report" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report" task
:: Disable scheduled task(s): `\NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----Disable "NVIDIA Telemetry Report on Logon" task------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report on Logon" task
:: Disable scheduled task(s): `\NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------Disable "NVIDIA telemetry monitor" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA telemetry monitor" task
:: Disable scheduled task(s): `\NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------Remove Nvidia telemetry packages-------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry packages
if exist "%ProgramFiles%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL" (
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetryContainer
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetry
)
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------Remove Nvidia telemetry components------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry components
:: Soft delete files matching pattern  : "%PROGRAMFILES(X86)%\NVIDIA Corporation\NvTelemetry\*"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%PROGRAMFILES(X86)%\NVIDIA Corporation\NvTelemetry\*"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $renamedCount   = 0; $skippedCount   = 0; $failedCount    = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping folder (not its contents): `"^""$path`"^""."^""; $skippedCount++; continue; }; if($revert -eq $true) {; if (-not $path.EndsWith('.OLD')) {; Write-Host "^""Skipping non-backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; } else {; if ($path.EndsWith('.OLD')) {; Write-Host "^""Skipping backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; }; $originalFilePath = $path; Write-Host "^""Processing file: `"^""$originalFilePath`"^""."^""; if (-Not (Test-Path $originalFilePath)) {; Write-Host "^""Skipping, file `"^""$originalFilePath`"^"" not found."^""; $skippedCount++; exit 0; }; if ($revert -eq $true) {; $newFilePath = $originalFilePath.Substring(0, $originalFilePath.Length - 4); } else {; $newFilePath = "^""$($originalFilePath).OLD"^""; }; try {; Move-Item -LiteralPath "^""$($originalFilePath)"^"" -Destination "^""$newFilePath"^"" -Force -ErrorAction Stop; Write-Host "^""Successfully processed `"^""$originalFilePath`"^""."^""; $renamedCount++; } catch {; Write-Error "^""Failed to rename `"^""$originalFilePath`"^"" to `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; $failedCount++; }; }; if (($renamedCount -gt 0) -or ($skippedCount -gt 0)) {; Write-Host "^""Successfully processed $renamedCount items and skipped $skippedCount items."^""; }; if ($failedCount -gt 0) {; Write-Warning "^""Failed to processed $($failedCount) items."^""; }"
:: Soft delete files matching pattern  : "%PROGRAMFILES%\NVIDIA Corporation\NvTelemetry\*"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%PROGRAMFILES%\NVIDIA Corporation\NvTelemetry\*"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $renamedCount   = 0; $skippedCount   = 0; $failedCount    = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping folder (not its contents): `"^""$path`"^""."^""; $skippedCount++; continue; }; if($revert -eq $true) {; if (-not $path.EndsWith('.OLD')) {; Write-Host "^""Skipping non-backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; } else {; if ($path.EndsWith('.OLD')) {; Write-Host "^""Skipping backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; }; $originalFilePath = $path; Write-Host "^""Processing file: `"^""$originalFilePath`"^""."^""; if (-Not (Test-Path $originalFilePath)) {; Write-Host "^""Skipping, file `"^""$originalFilePath`"^"" not found."^""; $skippedCount++; exit 0; }; if ($revert -eq $true) {; $newFilePath = $originalFilePath.Substring(0, $originalFilePath.Length - 4); } else {; $newFilePath = "^""$($originalFilePath).OLD"^""; }; try {; Move-Item -LiteralPath "^""$($originalFilePath)"^"" -Destination "^""$newFilePath"^"" -Force -ErrorAction Stop; Write-Host "^""Successfully processed `"^""$originalFilePath`"^""."^""; $renamedCount++; } catch {; Write-Error "^""Failed to rename `"^""$originalFilePath`"^"" to `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; $failedCount++; }; }; if (($renamedCount -gt 0) -or ($skippedCount -gt 0)) {; Write-Host "^""Successfully processed $renamedCount items and skipped $skippedCount items."^""; }; if ($failedCount -gt 0) {; Write-Warning "^""Failed to processed $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------Disable Nvidia telemetry drivers-------------
:: ----------------------------------------------------------
echo --- Disable Nvidia telemetry drivers
:: Soft delete files matching pattern  : "%SYSTEMROOT%\System32\DriverStore\FileRepository\NvTelemetry*.dll"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\System32\DriverStore\FileRepository\NvTelemetry*.dll"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $renamedCount   = 0; $skippedCount   = 0; $failedCount    = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping folder (not its contents): `"^""$path`"^""."^""; $skippedCount++; continue; }; if($revert -eq $true) {; if (-not $path.EndsWith('.OLD')) {; Write-Host "^""Skipping non-backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; } else {; if ($path.EndsWith('.OLD')) {; Write-Host "^""Skipping backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; }; $originalFilePath = $path; Write-Host "^""Processing file: `"^""$originalFilePath`"^""."^""; if (-Not (Test-Path $originalFilePath)) {; Write-Host "^""Skipping, file `"^""$originalFilePath`"^"" not found."^""; $skippedCount++; exit 0; }; if ($revert -eq $true) {; $newFilePath = $originalFilePath.Substring(0, $originalFilePath.Length - 4); } else {; $newFilePath = "^""$($originalFilePath).OLD"^""; }; try {; Move-Item -LiteralPath "^""$($originalFilePath)"^"" -Destination "^""$newFilePath"^"" -Force -ErrorAction Stop; Write-Host "^""Successfully processed `"^""$originalFilePath`"^""."^""; $renamedCount++; } catch {; Write-Error "^""Failed to rename `"^""$originalFilePath`"^"" to `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; $failedCount++; }; }; if (($renamedCount -gt 0) -or ($skippedCount -gt 0)) {; Write-Host "^""Successfully processed $renamedCount items and skipped $skippedCount items."^""; }; if ($failedCount -gt 0) {; Write-Warning "^""Failed to processed $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------Disable participation in Nvidia telemetry---------
:: ----------------------------------------------------------
echo --- Disable participation in Nvidia telemetry
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client' /v 'OptInOrOutPreference' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID44231' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID64640' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID66610' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup' /v 'SendTelemetryData' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------Disable "Nvidia Telemetry Container" service-------
:: ----------------------------------------------------------
echo --- Disable "Nvidia Telemetry Container" service
:: Disable service(s): `NvTelemetryContainer`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'NvTelemetryContainer'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: ----------------------------------------------------------


:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0    echo.
    echo --- Выполнено ---
)
echo.
echo [038] Удалить телеметрию Nvidia 2.bat
echo Описание: https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Удалить телеметрию Nvidia 2.bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
:: https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
    )
)
:: Initialize environment
setlocal EnableExtensions DisableDelayedExpansion
:: ----------------------------------------------------------
:: ----------Disable "NVIDIA Telemetry Report" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report" task
:: Disable scheduled task(s): `\NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable "NVIDIA Telemetry Report on Logon" task------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report on Logon" task
:: Disable scheduled task(s): `\NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---------Disable "NVIDIA telemetry monitor" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA telemetry monitor" task
:: Disable scheduled task(s): `\NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Remove Nvidia telemetry packages-------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry packages
if exist "%ProgramFiles%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL" (
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetryContainer
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetry
)
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------------Remove Nvidia telemetry components------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry components
:: Soft delete files matching pattern  : "%PROGRAMFILES(X86)%\NVIDIA Corporation\NvTelemetry\*"
:: Soft delete files matching pattern  : "%PROGRAMFILES%\NVIDIA Corporation\NvTelemetry\*"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Disable Nvidia telemetry drivers-------------
:: ----------------------------------------------------------
echo --- Disable Nvidia telemetry drivers
:: Soft delete files matching pattern  : "%SYSTEMROOT%\System32\DriverStore\FileRepository\NvTelemetry*.dll"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable participation in Nvidia telemetry---------
:: ----------------------------------------------------------
echo --- Disable participation in Nvidia telemetry
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client' /v 'OptInOrOutPreference' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID44231' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID64640' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID66610' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup' /v 'SendTelemetryData' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Disable "Nvidia Telemetry Container" service-------
:: ----------------------------------------------------------
echo --- Disable "Nvidia Telemetry Container" service
:: Disable service(s): `NvTelemetryContainer`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'NvTelemetryContainer'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: ----------------------------------------------------------
:: Pause the script to view the final state
:: Restore previous environment settings
endlocal
:: Exit the script successfully    echo.
    echo --- Выполнено ---
)
echo.
echo [039] Удалить телеметрию Nvidia 3.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Удалить телеметрию Nvidia 3.bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID66610" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID64640" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID44231" /t REG_DWORD /d "0" /f
schtasks /change /disable /tn "NvTmRep_CrashReport1_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmRep_CrashReport2_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmRep_CrashReport3_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmRep_CrashReport4_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvDriverUpdateCheckDaily_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NVIDIA GeForce Experience SelfUpdate_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
echo Completed.    echo.
    echo --- Выполнено ---
)
echo.
echo [040] Удалить телеметрию Nvidia.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Удалить телеметрию Nvidia.bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.

echo “Ў®аЄ  вҐ«Ґ¬ҐваЁЁ NVIDIA
sc stop NvTelemetryContainer > NUL 2>&1
sc config NvTelemetryContainer start= disabled > NUL 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvTmMon"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvTmRep"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvTmRepOnLogon"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvProfileUpdaterDaily"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvProfileUpdaterOnLogon"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
reg add "HKCU\SOFTWARE\NVIDIA Corporation\NVControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d 0 /f > NUL 2>&1
echo “бЇҐи­®!
pause    echo.
    echo --- Выполнено ---
)
echo.
echo [041] Удалить телеметрию Windows.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Удалить телеметрию Windows.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLua" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_SZ /d "00000000" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowSharedUserAppData" /v "value" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowStore" /v "value" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof    echo.
    echo --- Выполнено ---
)
echo.
echo [042] Удалить телеметрию.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Удалить телеметрию.bat ---
    echo.
reg add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup" /v "SendTelemetryData" /t REG_DWORD /d "0" /f
echo Execution is done.    echo.
    echo --- Выполнено ---
)
echo.
echo [043] Узнать модель видеокарты.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Узнать модель видеокарты.bat ---
    echo.
start "" "C:\Windows\System32\msinfo32.exe"    echo.
    echo --- Выполнено ---
)
echo.
echo [044] Уменьшение задержек для Nvidia.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: Уменьшение задержек для Nvidia.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DpiMapIommuContiguous" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof    echo.
    echo --- Выполнено ---
)
echo.
echo [045] УнКП.bat
echo Описание: Без описания
echo.
set /p confirm=Выполнить? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- Выполняется: УнКП.bat ---
    echo.
C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -acp 0    echo.
    echo --- Выполнено ---
)
goto :end

:auto_mode
cls
echo ==================================================
echo АВТОМАТИЧЕСКИЙ РЕЖИМ
echo ==================================================
echo.
echo.
echo [001] Выполняется: BIOS Nvidia.bat
echo --------------------------------------------
@chcp 65001 >nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f
REM Define download folder
set DOWNLOAD_FOLDER=C:\Downloads
REM Ensure the download folder exists
if not exist "%DOWNLOAD_FOLDER%" mkdir "%DOWNLOAD_FOLDER%"
REM Log file for debugging
set LOGFILE="%DOWNLOAD_FOLDER%\download_log.txt"
REM Clear the log file before writing new logs
if exist "%LOGFILE%" del "%LOGFILE%"
REM Download files to the defined download folder with logging
echo Downloading SCEWIN_64.exe...
start /MIN /WAIT powershell -Command "Invoke-WebRequest -Uri 'https://github.com/agalievvv/ickurdaneteboli/raw/main/SCEWIN_64.exe' -OutFile '%DOWNLOAD_FOLDER%\SCEWIN_64.exe' 2>&1 | Tee-Object -FilePath '%LOGFILE%'"
echo Downloading amifldrv64.sys...
start /MIN /WAIT powershell -Command "Invoke-WebRequest -Uri 'https://github.com/agalievvv/ickurdaneteboli/raw/main/amifldrv64.sys' -OutFile '%DOWNLOAD_FOLDER%\amifldrv64.sys' 2>&1 | Tee-Object -FilePath '%LOGFILE%'"
echo Downloading amigendrv64.sys...
start /MIN /WAIT powershell -Command "Invoke-WebRequest -Uri 'https://github.com/agalievvv/ickurdaneteboli/raw/main/amigendrv64.sys' -OutFile '%DOWNLOAD_FOLDER%\amigendrv64.sys' 2>&1 | Tee-Object -FilePath '%LOGFILE%'"
REM Check if the downloads were successful and move the files
if exist "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" (
    echo SCEWIN_64.exe downloaded successfully.
) else (
    echo SCEWIN_64.exe was not downloaded. Check the log file at "%LOGFILE%" for errors.
)
if exist "%DOWNLOAD_FOLDER%\amifldrv64.sys" (
    echo amifldrv64.sys downloaded successfully.
) else (
    echo amifldrv64.sys was not downloaded. Check the log file at "%LOGFILE%" for errors.
)
if exist "%DOWNLOAD_FOLDER%\amigendrv64.sys" (
    echo amigendrv64.sys downloaded successfully.
) else (
    echo amigendrv64.sys was not downloaded. Check the log file at "%LOGFILE%" for errors.
)
REM Proceed with executing the downloaded executable if it exists
if exist "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" (
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ACPI Notify on TBT Hot-plug" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ACPI Standby State" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ACPI T-States" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ALS Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "AP threads Idle Manner" /qv 0x03
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ARI Forwarding" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ASPM" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BCLK Aware Adaptive Voltage" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Bi-directional PROCHOT#" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BIOS Hot-Plug Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BIOS Lock" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BIST Enable" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEG0 Hotplug" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP enumerated SATA ports" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP GNA" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP I2C6" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP I2C7" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP IPU" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP LAN(GBE)" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe DG1" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe GFX" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe LAN" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe Other" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe Storage" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe WLAN" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PEG0" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP SATA" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP SDXC" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP SPI" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP TBT RP" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP TCSS" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP THC0" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP THC1" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "SW Guard Extensions SGX" /qv 0x02
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "System Acceleration with Intel(R) Optane(TM) Memory" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Tcc Offset Lock Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB DbC Enable Mode" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB Overcurrent Override for DbC" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB S5 Wakeup Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB Standby Power at S4/S5" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB2 PHY Sus Well Power Gating" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB3 Type-C UFP2DFP Kernel/Platform Debug Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB3" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "VDD Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Vmax Stress" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Voltage Optimization" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Wake From Thunderbolt(TM) Devices" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Wake on LAN Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Wake on WLAN and BT Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "WatchDog" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "WDT Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Windows 10 Thunderbolt support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "WoV (Wake on Voice)" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Snoop Latency Override" /qv 0x02
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Non Snoop Latency Multiplier" /qv 0x01
)echo --------------------------------------------
echo [OK] Секция 1 выполнена
echo.
echo.
echo [002] Выполняется: Dynamic Pstate\Включить динамический Pstate.bat
echo --------------------------------------------
for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
for /f %%c in ('echo %%b ^| findstr "{"') do (
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /f
)
)
)echo --------------------------------------------
echo [OK] Секция 2 выполнена
echo.
echo.
echo [003] Выполняется: Dynamic Pstate\Отключить динамическое Pstate.bat
echo --------------------------------------------
for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
for /f %%c in ('echo %%b ^| findstr "{"') do (
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f
)
)
)echo --------------------------------------------
echo [OK] Секция 3 выполнена
echo.
echo.
echo [004] Выполняется: Gpu твик.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler --> [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers
:: ------------------------------------------------------------------------------------------------------------------------------------------------
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InterruptSteeringDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighestPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MinimumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumPerformancePercent" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitialUnparkCount" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f
REM "
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Acceleration.Level" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DesktopStereoShortcuts" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "FeatureControl" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NVDeviceSupportKFilter" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmCacheLoc" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmDisableInst2Sys" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmFbsrPagedDMA" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMGpuId" /t REG_DWORD /d "256" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmProfilingAdminOnly" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TCCSupported" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TrackResetEngine" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "UseBestResolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ValidateBlitSubRects" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PlatformSupportMiracast" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eofecho --------------------------------------------
echo [OK] Секция 4 выполнена
echo.
echo.
echo [005] Выполняется: GpuEnergyDriver.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eofecho --------------------------------------------
echo [OK] Секция 5 выполнена
echo.
echo.
echo [006] Выполняется: HDCP\Включить HDCP.bat
echo --------------------------------------------
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMHdcpKeyglobZero" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /f
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
for /f %%i in ('echo %%a ^| findstr "{"') do (
Reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "RMHdcpKeyglobZero" /f >nul 2>&1
)
)
)echo --------------------------------------------
echo [OK] Секция 6 выполнена
echo.
echo.
echo [007] Выполняется: HDCP\Отключить HDCP.bat
echo --------------------------------------------
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMHdcpKeyglobZero" /t REG_DWORD /d "1" /f
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
for /f %%i in ('echo %%a ^| findstr "{"') do (
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "RMHdcpKeyglobZero" /t REG_DWORD /d "1" /f >nul 2>&1			 
)
)
)echo --------------------------------------------
echo [OK] Секция 7 выполнена
echo.
echo.
echo [008] Выполняется: N ECC.bat
echo --------------------------------------------
C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -e 0echo --------------------------------------------
echo [OK] Секция 8 выполнена
echo.
echo.
echo [009] Выполняется: Nvidia аудио.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\***\0000\PowerSettings" /v "ConservationIdleTime" /t REG_BINARY /d "00000000" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\***\0000\PowerSettings" /v "IdlePowerState" /t REG_BINARY /d "00000000" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\***\0000\PowerSettings" /v "PerformanceIdleTime" /t REG_BINARY /d "00000000" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eofecho --------------------------------------------
echo [OK] Секция 9 выполнена
echo.
echo.
echo [010] Выполняется: Nvidia телеметрия отключение.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NvTelemetryContainer" /v "Start" /t REG_DWORD /d "4" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eofecho --------------------------------------------
echo [OK] Секция 10 выполнена
echo.
echo.
echo [011] Выполняется: Nvidia.bat
echo --------------------------------------------
rmdir /s /q "C:\Windows\System32\drivers\NVIDIA Corporation"
cd /d "C:\Windows\System32\DriverStore\FileRepository\"
dir NvTelemetry64.dll /a /b /s
del NvTelemetry64.dll /a /s
reg add "HKCU\SOFTWARE\NVIDIA Corporation\NVControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d "0" /f >nul 2>&1echo --------------------------------------------
echo [OK] Секция 11 выполнена
echo.
echo.
echo [012] Выполняется: P0-состояние.bat
echo --------------------------------------------
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f > nul 2>&1
                   )
                )
             )echo --------------------------------------------
echo [OK] Секция 12 выполнена
echo.
echo.
echo [013] Выполняется: merged_batch_20260215_153308.bat
echo --------------------------------------------
:: ==================================================
::   : 15.02.2026 15:33:08
::  : D:\Projects\Extreme\dist\tweaks\\ Nvidia
::  : 40
:: ==================================================
chcp 1251 >nul
setlocal enabledelayedexpansion
cls
echo.
echo ==================================================
echo   
echo ==================================================
echo.
echo  : 40
echo.
echo  :
echo [1]    
echo [2]    
echo [3]   
echo.
set /p mode=  (1/2/3): 
echo.
if "%mode%"=="3" goto :show_list
if "%mode%"=="2" goto :confirm_mode
if "%mode%"=="1" goto :auto_mode
echo  ,   1
goto :auto_mode
:show_list
cls
echo ==================================================
echo  
echo ==================================================
echo.
echo [001] BIOS Nvidia.bat -  
echo [002] Gpu .bat -  
echo [003] GpuEnergyDriver.bat -  
echo [004] N ECC.bat -  
echo [005] Nvidia .bat -  
echo [006] Nvidia  .bat -  
echo [007] Nvidia.bat -  
echo [008] P0-.bat -  
echo [009]  HDCP.bat -  
echo [010]   Pstate.bat -  
echo [011]     Nvidia.bat -  
echo [012]   NVIDIA.bat -  
echo [013]  .bat -  
echo [014]  GeForceExp..bat -  
echo [015]  HDCP.bat -  
echo [016]  Nvidia Dynamic P-STATE.cmd -  
echo [017]  .bat -  
echo [018]   Pstate.bat -  
echo [019]  .bat -  
echo [020]   .bat -  
echo [021]  .bat -  
echo [022]  .bat -  
echo [023] .bat -  
echo [024]   Nvidia.bat -  
echo [025]  .bat -  
echo [026]   .bat -  
echo [027]  P-.bat -  
echo [028]   P0.bat -  
echo [029]      Nvidia.bat -  
echo [030]    Nvidia.bat -  
echo [031]  ECC.bat -  
echo [032]   Nvidia .bat - https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
echo [033]   Nvidia 2.bat - https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
echo [034]   Nvidia 3.bat -  
echo [035]   Nvidia.bat -  
echo [036]   Windows.bat -  
echo [037]  .bat -  
echo [038]   .bat -  
echo [039]    Nvidia.bat -  
echo [040] .bat -  
echo.
 /b
:confirm_mode
cls
echo ==================================================
echo   
echo ==================================================
echo.
echo.
echo [001] BIOS Nvidia.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- : BIOS Nvidia.bat ---
    echo.
@chcp 65001 >nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f
REM Define download folder
set DOWNLOAD_FOLDER=C:\Downloads
REM Ensure the download folder exists
if not exist "%DOWNLOAD_FOLDER%" mkdir "%DOWNLOAD_FOLDER%"
REM Log file for debugging
set LOGFILE="%DOWNLOAD_FOLDER%\download_log.txt"
REM Clear the log file before writing new logs
if exist "%LOGFILE%" del "%LOGFILE%"
REM Download files to the defined download folder with logging
echo Downloading SCEWIN_64.exe...
start /MIN /WAIT powershell -Command "Invoke-WebRequest -Uri 'https://github.com/agalievvv/ickurdaneteboli/raw/main/SCEWIN_64.exe' -OutFile '%DOWNLOAD_FOLDER%\SCEWIN_64.exe' 2>&1 | Tee-Object -FilePath '%LOGFILE%'"
echo Downloading amifldrv64.sys...
start /MIN /WAIT powershell -Command "Invoke-WebRequest -Uri 'https://github.com/agalievvv/ickurdaneteboli/raw/main/amifldrv64.sys' -OutFile '%DOWNLOAD_FOLDER%\amifldrv64.sys' 2>&1 | Tee-Object -FilePath '%LOGFILE%'"
echo Downloading amigendrv64.sys...
start /MIN /WAIT powershell -Command "Invoke-WebRequest -Uri 'https://github.com/agalievvv/ickurdaneteboli/raw/main/amigendrv64.sys' -OutFile '%DOWNLOAD_FOLDER%\amigendrv64.sys' 2>&1 | Tee-Object -FilePath '%LOGFILE%'"
REM Check if the downloads were successful and move the files
if exist "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" (
    echo SCEWIN_64.exe downloaded successfully.
) else (
    echo SCEWIN_64.exe was not downloaded. Check the log file at "%LOGFILE%" for errors.
)
if exist "%DOWNLOAD_FOLDER%\amifldrv64.sys" (
    echo amifldrv64.sys downloaded successfully.
) else (
    echo amifldrv64.sys was not downloaded. Check the log file at "%LOGFILE%" for errors.
)
if exist "%DOWNLOAD_FOLDER%\amigendrv64.sys" (
    echo amigendrv64.sys downloaded successfully.
) else (
    echo amigendrv64.sys was not downloaded. Check the log file at "%LOGFILE%" for errors.
)
REM Proceed with executing the downloaded executable if it exists
if exist "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" (
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ACPI Notify on TBT Hot-plug" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ACPI Standby State" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ACPI T-States" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ALS Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "AP threads Idle Manner" /qv 0x03
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ARI Forwarding" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ASPM" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BCLK Aware Adaptive Voltage" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Bi-directional PROCHOT#" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BIOS Hot-Plug Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BIOS Lock" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BIST Enable" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEG0 Hotplug" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP enumerated SATA ports" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP GNA" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP I2C6" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP I2C7" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP IPU" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP LAN(GBE)" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe DG1" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe GFX" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe LAN" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe Other" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe Storage" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe WLAN" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PEG0" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP SATA" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP SDXC" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP SPI" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP TBT RP" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP TCSS" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP THC0" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP THC1" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "SW Guard Extensions SGX" /qv 0x02
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "System Acceleration with Intel(R) Optane(TM) Memory" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Tcc Offset Lock Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB DbC Enable Mode" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB Overcurrent Override for DbC" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB S5 Wakeup Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB Standby Power at S4/S5" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB2 PHY Sus Well Power Gating" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB3 Type-C UFP2DFP Kernel/Platform Debug Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB3" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "VDD Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Vmax Stress" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Voltage Optimization" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Wake From Thunderbolt(TM) Devices" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Wake on LAN Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Wake on WLAN and BT Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "WatchDog" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "WDT Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Windows 10 Thunderbolt support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "WoV (Wake on Voice)" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Snoop Latency Override" /qv 0x02
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Non Snoop Latency Multiplier" /qv 0x01
)
    echo.
    echo ---  ---
)
echo.
echo [002] Gpu .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- : Gpu .bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler --> [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers
:: ------------------------------------------------------------------------------------------------------------------------------------------------
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InterruptSteeringDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighestPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MinimumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumPerformancePercent" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitialUnparkCount" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f
REM "
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Acceleration.Level" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DesktopStereoShortcuts" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "FeatureControl" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NVDeviceSupportKFilter" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmCacheLoc" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmDisableInst2Sys" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmFbsrPagedDMA" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMGpuId" /t REG_DWORD /d "256" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmProfilingAdminOnly" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TCCSupported" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TrackResetEngine" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "UseBestResolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ValidateBlitSubRects" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PlatformSupportMiracast" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [003] GpuEnergyDriver.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- : GpuEnergyDriver.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [004] N ECC.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- : N ECC.bat ---
    echo.
C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -e 0    echo.
    echo ---  ---
)
echo.
echo [005] Nvidia .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- : Nvidia .bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\***\0000\PowerSettings" /v "ConservationIdleTime" /t REG_BINARY /d "00000000" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\***\0000\PowerSettings" /v "IdlePowerState" /t REG_BINARY /d "00000000" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\***\0000\PowerSettings" /v "PerformanceIdleTime" /t REG_BINARY /d "00000000" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [006] Nvidia  .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- : Nvidia  .bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NvTelemetryContainer" /v "Start" /t REG_DWORD /d "4" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [007] Nvidia.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- : Nvidia.bat ---
    echo.
rmdir /s /q "C:\Windows\System32\drivers\NVIDIA Corporation"
cd /d "C:\Windows\System32\DriverStore\FileRepository\"
dir NvTelemetry64.dll /a /b /s
del NvTelemetry64.dll /a /s
reg add "HKCU\SOFTWARE\NVIDIA Corporation\NVControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d "0" /f >nul 2>&1    echo.
    echo ---  ---
)
echo.
echo [008] P0-.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- : P0-.bat ---
    echo.
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f > nul 2>&1
                   )
                )
             )    echo.
    echo ---  ---
)
echo.
echo [009]  HDCP.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  HDCP.bat ---
    echo.
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMHdcpKeyglobZero" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /f
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "RMHdcpKeyglobZero" /f >nul 2>&1
                   )
                )
             )    echo.
    echo ---  ---
)
echo.
echo [010]   Pstate.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   Pstate.bat ---
    echo.
for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
    for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
        for /f %%c in ('echo %%b ^| findstr "{"') do (
            Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /f
        )
    )
)    echo.
    echo ---  ---
)
echo.
echo [011]     Nvidia.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :     Nvidia.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMDisableLRCCoalescing" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [012]   NVIDIA.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   NVIDIA.bat ---
    echo.
start "https://www.nvidia.com/ru-ru/geforce/drivers/"    echo.
    echo ---  ---
)
echo.
echo [013]  .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  .bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "StreamType" /t REG_DWORD /d "0" /f
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "WriteCapture" /t REG_DWORD /d "0" /f
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "WriteCaptureDir" /t REG_SZ /d "c:\dm.capture\\" /f
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "WriteCapturePath" /t REG_SZ /d "" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [014]  GeForceExp..bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  GeForceExp..bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
DevManView.exe /disable "NvModuleTracker Device" >nul 2>&1
DevManView.exe /disable "NVIDIA Virtual Audio Device (Wave Extensible) (WDM)" >nul 2>&1
for %%i in (NvTmMon NvTmRep NvProfile NvNodeLauncher NvDriverUpdateCheckDaily "NVIDIA GeForce Experience SelfUpdate*") do for /f "tokens=1 delims=," %%a in ('schtasks /query /fo csv ^| findstr /v "TaskName" ^| findstr "%%~i"') do schtasks /change /tn "%%a" /disable >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\NVIDIA Corporation\Global\GFExperience" /v "NotifyNewDisplayUpdates" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\NVIDIA Corporation\NvTray" /v "StartOnLogin" /t REG_DWORD /d "0" /f >nul 2>&1
    echo.
    echo ---  ---
)
echo.
echo [015]  HDCP.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  HDCP.bat ---
    echo.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMHdcpKeyglobZero" /t REG_DWORD /d "1" /f
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "RMHdcpKeyglobZero" /t REG_DWORD /d "1" /f >nul 2>&1			 
                   )
                )
             )    echo.
    echo ---  ---
)
echo.
echo [016]  Nvidia Dynamic P-STATE.cmd
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  Nvidia Dynamic P-STATE.cmd ---
    echo.
for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
    for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
        for /f %%c in ('echo %%b ^| findstr "{"') do (
            Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f
        )
    )
)
    echo.
    echo ---  ---
)
echo.
echo [017]  .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  .bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d "5" /f
    echo.
    echo ---  ---
)
echo.
echo [018]   Pstate.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   Pstate.bat ---
    echo.
for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
    for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
        for /f %%c in ('echo %%b ^| findstr "{"') do (
            Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f
        )
    )
)    echo.
    echo ---  ---
)
echo.
echo [019]  .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  .bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /s /f "Scaling"^| findstr "HKEY"') do reg.exe add "%%i" /v "Scaling" /t REG_DWORD /d "1" /f >nul 2>&1    echo.
    echo ---  ---
)
echo.
echo [020]   .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   .bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ;Disable Delivery Optimization
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v "DownloadMode" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [021]  .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  .bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\diagsvc" /v "Start" /t REG_DWORD /d "4" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [022]  .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  .bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler --> [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers
:: ------------------------------------------------------------------------------------------------------------------------------------------------
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisablePreemption" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PlatformSupportMiracast" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [023] .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- : .bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE																										made by konex#8100
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableWriteCombining" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [024]   Nvidia.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   Nvidia.bat ---
    echo.
@echo BESPLATNO! from Reborn FREE PC Optimization (RU) - https://discord.gg/hgBQRsrDRu
@echo made by FrazE-
@echo Clearing NVIDIA DirectX Cache...
REM РџРµСЂРµС…РѕРґ Рє РїР°РїРєРµ DXCache СЃ РёСЃРїРѕР»СЊР·РѕРІР°РЅРёРµРј РїРµСЂРµРјРµРЅРЅС‹С… СЃСЂРµРґС‹
set DXCachePath=%LOCALAPPDATA%\..\LocalLow\NVIDIA\PerDriverVersion\DXCache
REM РџСЂРѕРІРµСЂРєР° СЃСѓС‰РµСЃС‚РІРѕРІР°РЅРёСЏ РїР°РїРєРё
if exist "%DXCachePath%" (
    @echo Found directory: %DXCachePath%
    @echo Deleting cache files...
    del /q "%DXCachePath%\*.*"
    @echo Cache cleared successfully.
) else (
    @echo Directory not found: %DXCachePath%
)
@echo Completed.
@pause
    echo.
    echo ---  ---
)
echo.
echo [025]  .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  .bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "EnableRID61684" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [026]   .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   .bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -acp 0    echo.
    echo ---  ---
)
echo.
echo [027]  P-.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  P-.bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f > nul 2>&1
                   )
                )
             )    echo.
    echo ---  ---
)
echo.
echo [028]   P0.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   P0.bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f > nul 2>&1
                   )
                )
             )    echo.
    echo ---  ---
)
echo.
echo [029]      Nvidia.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :      Nvidia.bat ---
    echo.
echo.
echo.
echo.                 -----------------------------------------------------------------------------------------------------------------
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A 
:::                
:::                   $$$$$$$$\ $$\   $$\ $$\      $$\       $$$$$$$$\ $$\      $$\ $$$$$$$$\  $$$$$$\  $$\   $$\ $$$$$$$$\ $$$$$$$\  
:::                   $$  _____|$$ |  $$ |$$$\    $$$ |      \__$$  __|$$ | $\  $$ |$$  _____|$$  __$$\ $$ | $$  |$$  _____|$$  __$$\ 
:::                   $$ |      \$$\ $$  |$$$$\  $$$$ |         $$ |   $$ |$$$\ $$ |$$ |      $$ /  $$ |$$ |$$  / $$ |      $$ |  $$ |
:::                   $$$$$\     \$$$$  / $$\$$\$$ $$ |         $$ |   $$ $$ $$\$$ |$$$$$\    $$$$$$$$ |$$$$$  /  $$$$$\    $$$$$$$  |
:::                   $$  __|    $$  $$<  $$ \$$$  $$ |         $$ |   $$$$  _$$$$ |$$  __|   $$  __$$ |$$  $$<   $$  __|   $$  __$$< 
:::                   $$ |      $$  /\$$\ $$ |\$  /$$ |         $$ |   $$$  / \$$$ |$$ |      $$ |  $$ |$$ |\$$\  $$ |      $$ |  $$ |
:::                   $$$$$$$$\ $$ /  $$ |$$ | \_/ $$ |         $$ |   $$  /   \$$ |$$$$$$$$\ $$ |  $$ |$$ | \$$\ $$$$$$$$\ $$ |  $$ |
:::                   \________|\__|  \__|\__|     \__|         \__|   \__/     \__|\________|\__|  \__|\__|  \__|\________|\__|  \__|   
:::                                                                                                                 	
echo.                -----------------------------------------------------------------------------------------------------------------	
echo.  
echo.
echo.
echo 
echo.
echo                                                        Press Any Key To Continue...     
 >nul  						
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InterruptSteeringDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighestPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MinimumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumPerformancePercent" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitialUnparkCount" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnablePreemption" /t REG_DWORD /d "0" /f
echo.
echo 
echo.
echo                                                        Press any key to exit...     
 >nul
cls
    echo.
    echo ---  ---
)
echo.
echo [030]    Nvidia.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :    Nvidia.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler --> [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers
:: ------------------------------------------------------------------------------------------------------------------------------------------------
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InterruptSteeringDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighestPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MinimumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumPerformancePercent" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitialUnparkCount" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f
REM "
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Acceleration.Level" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DesktopStereoShortcuts" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "FeatureControl" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NVDeviceSupportKFilter" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmCacheLoc" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmDisableInst2Sys" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmFbsrPagedDMA" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMGpuId" /t REG_DWORD /d "256" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmProfilingAdminOnly" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TCCSupported" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TrackResetEngine" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "UseBestResolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ValidateBlitSubRects" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PlatformSupportMiracast" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [031]  ECC.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  ECC.bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -e 0    echo.
    echo ---  ---
)
echo.
echo [032]   Nvidia .bat
echo : https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   Nvidia .bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
:: https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
 & exit 1
    )
 0
)
:: Initialize environment
setlocal EnableExtensions DisableDelayedExpansion
:: ----------------------------------------------------------
:: ----------Disable "NVIDIA Telemetry Report" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report" task
:: Disable scheduled task(s): `\NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable "NVIDIA Telemetry Report on Logon" task------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report on Logon" task
:: Disable scheduled task(s): `\NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---------Disable "NVIDIA telemetry monitor" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA telemetry monitor" task
:: Disable scheduled task(s): `\NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Remove Nvidia telemetry packages-------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry packages
if exist "%ProgramFiles%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL" (
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetryContainer
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetry
)
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------------Remove Nvidia telemetry components------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry components
:: Soft delete files matching pattern  : "%PROGRAMFILES(X86)%\NVIDIA Corporation\NvTelemetry\*"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%PROGRAMFILES(X86)%\NVIDIA Corporation\NvTelemetry\*"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $renamedCount   = 0; $skippedCount   = 0; $failedCount    = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping folder (not its contents): `"^""$path`"^""."^""; $skippedCount++; continue; }; if($revert -eq $true) {; if (-not $path.EndsWith('.OLD')) {; Write-Host "^""Skipping non-backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; } else {; if ($path.EndsWith('.OLD')) {; Write-Host "^""Skipping backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; }; $originalFilePath = $path; Write-Host "^""Processing file: `"^""$originalFilePath`"^""."^""; if (-Not (Test-Path $originalFilePath)) {; Write-Host "^""Skipping, file `"^""$originalFilePath`"^"" not found."^""; $skippedCount++; exit 0; }; if ($revert -eq $true) {; $newFilePath = $originalFilePath.Substring(0, $originalFilePath.Length - 4); } else {; $newFilePath = "^""$($originalFilePath).OLD"^""; }; try {; Move-Item -LiteralPath "^""$($originalFilePath)"^"" -Destination "^""$newFilePath"^"" -Force -ErrorAction Stop; Write-Host "^""Successfully processed `"^""$originalFilePath`"^""."^""; $renamedCount++; } catch {; Write-Error "^""Failed to rename `"^""$originalFilePath`"^"" to `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; $failedCount++; }; }; if (($renamedCount -gt 0) -or ($skippedCount -gt 0)) {; Write-Host "^""Successfully processed $renamedCount items and skipped $skippedCount items."^""; }; if ($failedCount -gt 0) {; Write-Warning "^""Failed to processed $($failedCount) items."^""; }"
:: Soft delete files matching pattern  : "%PROGRAMFILES%\NVIDIA Corporation\NvTelemetry\*"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%PROGRAMFILES%\NVIDIA Corporation\NvTelemetry\*"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $renamedCount   = 0; $skippedCount   = 0; $failedCount    = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping folder (not its contents): `"^""$path`"^""."^""; $skippedCount++; continue; }; if($revert -eq $true) {; if (-not $path.EndsWith('.OLD')) {; Write-Host "^""Skipping non-backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; } else {; if ($path.EndsWith('.OLD')) {; Write-Host "^""Skipping backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; }; $originalFilePath = $path; Write-Host "^""Processing file: `"^""$originalFilePath`"^""."^""; if (-Not (Test-Path $originalFilePath)) {; Write-Host "^""Skipping, file `"^""$originalFilePath`"^"" not found."^""; $skippedCount++; exit 0; }; if ($revert -eq $true) {; $newFilePath = $originalFilePath.Substring(0, $originalFilePath.Length - 4); } else {; $newFilePath = "^""$($originalFilePath).OLD"^""; }; try {; Move-Item -LiteralPath "^""$($originalFilePath)"^"" -Destination "^""$newFilePath"^"" -Force -ErrorAction Stop; Write-Host "^""Successfully processed `"^""$originalFilePath`"^""."^""; $renamedCount++; } catch {; Write-Error "^""Failed to rename `"^""$originalFilePath`"^"" to `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; $failedCount++; }; }; if (($renamedCount -gt 0) -or ($skippedCount -gt 0)) {; Write-Host "^""Successfully processed $renamedCount items and skipped $skippedCount items."^""; }; if ($failedCount -gt 0) {; Write-Warning "^""Failed to processed $($failedCount) items."^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Disable Nvidia telemetry drivers-------------
:: ----------------------------------------------------------
echo --- Disable Nvidia telemetry drivers
:: Soft delete files matching pattern  : "%SYSTEMROOT%\System32\DriverStore\FileRepository\NvTelemetry*.dll"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\System32\DriverStore\FileRepository\NvTelemetry*.dll"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $renamedCount   = 0; $skippedCount   = 0; $failedCount    = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping folder (not its contents): `"^""$path`"^""."^""; $skippedCount++; continue; }; if($revert -eq $true) {; if (-not $path.EndsWith('.OLD')) {; Write-Host "^""Skipping non-backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; } else {; if ($path.EndsWith('.OLD')) {; Write-Host "^""Skipping backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; }; $originalFilePath = $path; Write-Host "^""Processing file: `"^""$originalFilePath`"^""."^""; if (-Not (Test-Path $originalFilePath)) {; Write-Host "^""Skipping, file `"^""$originalFilePath`"^"" not found."^""; $skippedCount++; exit 0; }; if ($revert -eq $true) {; $newFilePath = $originalFilePath.Substring(0, $originalFilePath.Length - 4); } else {; $newFilePath = "^""$($originalFilePath).OLD"^""; }; try {; Move-Item -LiteralPath "^""$($originalFilePath)"^"" -Destination "^""$newFilePath"^"" -Force -ErrorAction Stop; Write-Host "^""Successfully processed `"^""$originalFilePath`"^""."^""; $renamedCount++; } catch {; Write-Error "^""Failed to rename `"^""$originalFilePath`"^"" to `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; $failedCount++; }; }; if (($renamedCount -gt 0) -or ($skippedCount -gt 0)) {; Write-Host "^""Successfully processed $renamedCount items and skipped $skippedCount items."^""; }; if ($failedCount -gt 0) {; Write-Warning "^""Failed to processed $($failedCount) items."^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable participation in Nvidia telemetry---------
:: ----------------------------------------------------------
echo --- Disable participation in Nvidia telemetry
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client' /v 'OptInOrOutPreference' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID44231' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID64640' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID66610' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup' /v 'SendTelemetryData' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Disable "Nvidia Telemetry Container" service-------
:: ----------------------------------------------------------
echo --- Disable "Nvidia Telemetry Container" service
:: Disable service(s): `NvTelemetryContainer`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'NvTelemetryContainer'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: ----------------------------------------------------------
:: Pause the script to view the final state
:: Restore previous environment settings
endlocal
:: Exit the script successfully
 /b 0    echo.
    echo ---  ---
)
echo.
echo [033]   Nvidia 2.bat
echo : https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   Nvidia 2.bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
:: https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
    )
)
:: Initialize environment
setlocal EnableExtensions DisableDelayedExpansion
:: ----------------------------------------------------------
:: ----------Disable "NVIDIA Telemetry Report" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report" task
:: Disable scheduled task(s): `\NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable "NVIDIA Telemetry Report on Logon" task------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report on Logon" task
:: Disable scheduled task(s): `\NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---------Disable "NVIDIA telemetry monitor" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA telemetry monitor" task
:: Disable scheduled task(s): `\NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Remove Nvidia telemetry packages-------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry packages
if exist "%ProgramFiles%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL" (
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetryContainer
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetry
)
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------------Remove Nvidia telemetry components------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry components
:: Soft delete files matching pattern  : "%PROGRAMFILES(X86)%\NVIDIA Corporation\NvTelemetry\*"
:: Soft delete files matching pattern  : "%PROGRAMFILES%\NVIDIA Corporation\NvTelemetry\*"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Disable Nvidia telemetry drivers-------------
:: ----------------------------------------------------------
echo --- Disable Nvidia telemetry drivers
:: Soft delete files matching pattern  : "%SYSTEMROOT%\System32\DriverStore\FileRepository\NvTelemetry*.dll"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable participation in Nvidia telemetry---------
:: ----------------------------------------------------------
echo --- Disable participation in Nvidia telemetry
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client' /v 'OptInOrOutPreference' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID44231' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID64640' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID66610' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup' /v 'SendTelemetryData' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Disable "Nvidia Telemetry Container" service-------
:: ----------------------------------------------------------
echo --- Disable "Nvidia Telemetry Container" service
:: Disable service(s): `NvTelemetryContainer`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'NvTelemetryContainer'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: ----------------------------------------------------------
:: Pause the script to view the final state
:: Restore previous environment settings
endlocal
:: Exit the script successfully
    echo.
    echo ---  ---
)
echo.
echo [034]   Nvidia 3.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   Nvidia 3.bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID66610" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID64640" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID44231" /t REG_DWORD /d "0" /f
schtasks /change /disable /tn "NvTmRep_CrashReport1_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmRep_CrashReport2_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmRep_CrashReport3_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmRep_CrashReport4_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvDriverUpdateCheckDaily_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NVIDIA GeForce Experience SelfUpdate_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
echo Completed.
    echo.
    echo ---  ---
)
echo.
echo [035]   Nvidia.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   Nvidia.bat ---
    echo.
@echo.
@echo t.me/DE3NAKE
@echo.
echo аЄ  вҐ«аЁЁ NVIDIA
sc stop NvTelemetryContainer > NUL 2>&1
sc config NvTelemetryContainer start= disabled > NUL 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvTmMon"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvTmRep"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvTmRepOnLogon"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvProfileUpdaterDaily"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvProfileUpdaterOnLogon"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
reg add "HKCU\SOFTWARE\NVIDIA Corporation\NVControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d 0 /f > NUL 2>&1
echo бЇҐи­®!
    echo.
    echo ---  ---
)
echo.
echo [036]   Windows.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   Windows.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLua" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_SZ /d "00000000" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowSharedUserAppData" /v "value" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowStore" /v "value" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [037]  .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :  .bat ---
    echo.
reg add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup" /v "SendTelemetryData" /t REG_DWORD /d "0" /f
echo Execution is done.
    echo.
    echo ---  ---
)
echo.
echo [038]   .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :   .bat ---
    echo.
start "" "C:\Windows\System32\msinfo32.exe"    echo.
    echo ---  ---
)
echo.
echo [039]    Nvidia.bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- :    Nvidia.bat ---
    echo.
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DpiMapIommuContiguous" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
    echo.
    echo ---  ---
)
echo.
echo [040] .bat
echo :  
echo.
set /p confirm=? (y/n/q): 
if /i "!confirm!"=="q" goto :end
if /i "!confirm!"=="y" (
    echo.
    echo --- : .bat ---
    echo.
C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -acp 0    echo.
    echo ---  ---
)
goto :end
:auto_mode
cls
echo ==================================================
echo  
echo ==================================================
echo.
echo.
echo [001] : BIOS Nvidia.bat
echo --------------------------------------------
@chcp 65001 >nul 2>&1
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f
REM Define download folder
set DOWNLOAD_FOLDER=C:\Downloads
REM Ensure the download folder exists
if not exist "%DOWNLOAD_FOLDER%" mkdir "%DOWNLOAD_FOLDER%"
REM Log file for debugging
set LOGFILE="%DOWNLOAD_FOLDER%\download_log.txt"
REM Clear the log file before writing new logs
if exist "%LOGFILE%" del "%LOGFILE%"
REM Download files to the defined download folder with logging
echo Downloading SCEWIN_64.exe...
start /MIN /WAIT powershell -Command "Invoke-WebRequest -Uri 'https://github.com/agalievvv/ickurdaneteboli/raw/main/SCEWIN_64.exe' -OutFile '%DOWNLOAD_FOLDER%\SCEWIN_64.exe' 2>&1 | Tee-Object -FilePath '%LOGFILE%'"
echo Downloading amifldrv64.sys...
start /MIN /WAIT powershell -Command "Invoke-WebRequest -Uri 'https://github.com/agalievvv/ickurdaneteboli/raw/main/amifldrv64.sys' -OutFile '%DOWNLOAD_FOLDER%\amifldrv64.sys' 2>&1 | Tee-Object -FilePath '%LOGFILE%'"
echo Downloading amigendrv64.sys...
start /MIN /WAIT powershell -Command "Invoke-WebRequest -Uri 'https://github.com/agalievvv/ickurdaneteboli/raw/main/amigendrv64.sys' -OutFile '%DOWNLOAD_FOLDER%\amigendrv64.sys' 2>&1 | Tee-Object -FilePath '%LOGFILE%'"
REM Check if the downloads were successful and move the files
if exist "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" (
    echo SCEWIN_64.exe downloaded successfully.
) else (
    echo SCEWIN_64.exe was not downloaded. Check the log file at "%LOGFILE%" for errors.
)
if exist "%DOWNLOAD_FOLDER%\amifldrv64.sys" (
    echo amifldrv64.sys downloaded successfully.
) else (
    echo amifldrv64.sys was not downloaded. Check the log file at "%LOGFILE%" for errors.
)
if exist "%DOWNLOAD_FOLDER%\amigendrv64.sys" (
    echo amigendrv64.sys downloaded successfully.
) else (
    echo amigendrv64.sys was not downloaded. Check the log file at "%LOGFILE%" for errors.
)
REM Proceed with executing the downloaded executable if it exists
if exist "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" (
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ACPI Notify on TBT Hot-plug" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ACPI Standby State" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ACPI T-States" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ALS Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "AP threads Idle Manner" /qv 0x03
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ARI Forwarding" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ASPM" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BCLK Aware Adaptive Voltage" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Bi-directional PROCHOT#" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BIOS Hot-Plug Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BIOS Lock" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BIST Enable" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEG0 Hotplug" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP enumerated SATA ports" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP GNA" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP I2C6" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP I2C7" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP IPU" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP LAN(GBE)" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe DG1" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe GFX" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe LAN" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe Other" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe Storage" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PCIe WLAN" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP PEG0" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP SATA" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP SDXC" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP SPI" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP TBT RP" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP TCSS" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP THC0" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PEP THC1" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "SW Guard Extensions SGX" /qv 0x02
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "System Acceleration with Intel(R) Optane(TM) Memory" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Tcc Offset Lock Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB DbC Enable Mode" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB Overcurrent Override for DbC" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB S5 Wakeup Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB Standby Power at S4/S5" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB2 PHY Sus Well Power Gating" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB3 Type-C UFP2DFP Kernel/Platform Debug Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB3" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "VDD Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Vmax Stress" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Voltage Optimization" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Wake From Thunderbolt(TM) Devices" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Wake on LAN Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Wake on WLAN and BT Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "WatchDog" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "WDT Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Windows 10 Thunderbolt support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "WoV (Wake on Voice)" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Snoop Latency Override" /qv 0x02
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Non Snoop Latency Multiplier" /qv 0x01
)
echo --------------------------------------------
echo [OK]  1 
echo.
echo.
echo [002] : Gpu .bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler --> [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers
:: ------------------------------------------------------------------------------------------------------------------------------------------------
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InterruptSteeringDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighestPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MinimumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumPerformancePercent" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitialUnparkCount" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f
REM "
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Acceleration.Level" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DesktopStereoShortcuts" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "FeatureControl" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NVDeviceSupportKFilter" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmCacheLoc" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmDisableInst2Sys" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmFbsrPagedDMA" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMGpuId" /t REG_DWORD /d "256" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmProfilingAdminOnly" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TCCSupported" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TrackResetEngine" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "UseBestResolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ValidateBlitSubRects" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PlatformSupportMiracast" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  2 
echo.
echo.
echo [003] : GpuEnergyDriver.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  3 
echo.
echo.
echo [004] : N ECC.bat
echo --------------------------------------------
C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -e 0echo --------------------------------------------
echo [OK]  4 
echo.
echo.
echo [005] : Nvidia .bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\***\0000\PowerSettings" /v "ConservationIdleTime" /t REG_BINARY /d "00000000" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\***\0000\PowerSettings" /v "IdlePowerState" /t REG_BINARY /d "00000000" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\***\0000\PowerSettings" /v "PerformanceIdleTime" /t REG_BINARY /d "00000000" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  5 
echo.
echo.
echo [006] : Nvidia  .bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NvTelemetryContainer" /v "Start" /t REG_DWORD /d "4" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  6 
echo.
echo.
echo [007] : Nvidia.bat
echo --------------------------------------------
rmdir /s /q "C:\Windows\System32\drivers\NVIDIA Corporation"
cd /d "C:\Windows\System32\DriverStore\FileRepository\"
dir NvTelemetry64.dll /a /b /s
del NvTelemetry64.dll /a /s
reg add "HKCU\SOFTWARE\NVIDIA Corporation\NVControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d "0" /f >nul 2>&1echo --------------------------------------------
echo [OK]  7 
echo.
echo.
echo [008] : P0-.bat
echo --------------------------------------------
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f > nul 2>&1
                   )
                )
             )echo --------------------------------------------
echo [OK]  8 
echo.
echo.
echo [009] :  HDCP.bat
echo --------------------------------------------
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMHdcpKeyglobZero" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /f
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "RMHdcpKeyglobZero" /f >nul 2>&1
                   )
                )
             )echo --------------------------------------------
echo [OK]  9 
echo.
echo.
echo [010] :   Pstate.bat
echo --------------------------------------------
for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
    for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
        for /f %%c in ('echo %%b ^| findstr "{"') do (
            Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /f
        )
    )
)echo --------------------------------------------
echo [OK]  10 
echo.
echo.
echo [011] :     Nvidia.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMDisableLRCCoalescing" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  11 
echo.
echo.
echo [012] :   NVIDIA.bat
echo --------------------------------------------
start "https://www.nvidia.com/ru-ru/geforce/drivers/"echo --------------------------------------------
echo [OK]  12 
echo.
echo.
echo [013] :  .bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "StreamType" /t REG_DWORD /d "0" /f
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "WriteCapture" /t REG_DWORD /d "0" /f
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "WriteCaptureDir" /t REG_SZ /d "c:\dm.capture\\" /f
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "WriteCapturePath" /t REG_SZ /d "" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  13 
echo.
echo.
echo [014] :  GeForceExp..bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
DevManView.exe /disable "NvModuleTracker Device" >nul 2>&1
DevManView.exe /disable "NVIDIA Virtual Audio Device (Wave Extensible) (WDM)" >nul 2>&1
for %%i in (NvTmMon NvTmRep NvProfile NvNodeLauncher NvDriverUpdateCheckDaily "NVIDIA GeForce Experience SelfUpdate*") do for /f "tokens=1 delims=," %%a in ('schtasks /query /fo csv ^| findstr /v "TaskName" ^| findstr "%%~i"') do schtasks /change /tn "%%a" /disable >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\NVIDIA Corporation\Global\GFExperience" /v "NotifyNewDisplayUpdates" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\NVIDIA Corporation\NvTray" /v "StartOnLogin" /t REG_DWORD /d "0" /f >nul 2>&1
exitecho --------------------------------------------
echo [OK]  14 
echo.
echo.
echo [015] :  HDCP.bat
echo --------------------------------------------
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMHdcpKeyglobZero" /t REG_DWORD /d "1" /f
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "RMHdcpKeyglobZero" /t REG_DWORD /d "1" /f >nul 2>&1			 
                   )
                )
             )echo --------------------------------------------
echo [OK]  15 
echo.
echo.
echo [016] :  Nvidia Dynamic P-STATE.cmd
echo --------------------------------------------
for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
    for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
        for /f %%c in ('echo %%b ^| findstr "{"') do (
            Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f
        )
    )
)
exitecho --------------------------------------------
echo [OK]  16 
echo.
echo.
echo [017] :  .bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d "5" /f
exitecho --------------------------------------------
echo [OK]  17 
echo.
echo.
echo [018] :   Pstate.bat
echo --------------------------------------------
for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
    for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
        for /f %%c in ('echo %%b ^| findstr "{"') do (
            Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f
        )
    )
)echo --------------------------------------------
echo [OK]  18 
echo.
echo.
echo [019] :  .bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /s /f "Scaling"^| findstr "HKEY"') do reg.exe add "%%i" /v "Scaling" /t REG_DWORD /d "1" /f >nul 2>&1echo --------------------------------------------
echo [OK]  19 
echo.
echo.
echo [020] :   .bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ;Disable Delivery Optimization
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v "DownloadMode" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  20 
echo.
echo.
echo [021] :  .bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\diagsvc" /v "Start" /t REG_DWORD /d "4" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  21 
echo.
echo.
echo [022] :  .bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler --> [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers
:: ------------------------------------------------------------------------------------------------------------------------------------------------
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisablePreemption" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PlatformSupportMiracast" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  22 
echo.
echo.
echo [023] : .bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE																										made by konex#8100
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableWriteCombining" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  23 
echo.
echo.
echo [024] :   Nvidia.bat
echo --------------------------------------------
@echo BESPLATNO! from Reborn FREE PC Optimization (RU) - https://discord.gg/hgBQRsrDRu
@echo made by FrazE-
@echo Clearing NVIDIA DirectX Cache...
REM РџРµСЂРµС…РѕРґ Рє РїР°РїРєРµ DXCache СЃ РёСЃРїРѕР»СЊР·РѕРІР°РЅРёРµРј РїРµСЂРµРјРµРЅРЅС‹С… СЃСЂРµРґС‹
set DXCachePath=%LOCALAPPDATA%\..\LocalLow\NVIDIA\PerDriverVersion\DXCache
REM РџСЂРѕРІРµСЂРєР° СЃСѓС‰РµСЃС‚РІРѕРІР°РЅРёСЏ РїР°РїРєРё
if exist "%DXCachePath%" (
    @echo Found directory: %DXCachePath%
    @echo Deleting cache files...
    del /q "%DXCachePath%\*.*"
    @echo Cache cleared successfully.
) else (
    @echo Directory not found: %DXCachePath%
)
@echo Completed.
@pause
echo --------------------------------------------
echo [OK]  24 
echo.
echo.
echo [025] :  .bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "EnableRID61684" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  25 
echo.
echo.
echo [026] :   .bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -acp 0echo --------------------------------------------
echo [OK]  26 
echo.
echo.
echo [027] :  P-.bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f > nul 2>&1
                   )
                )
             )echo --------------------------------------------
echo [OK]  27 
echo.
echo.
echo [028] :   P0.bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f > nul 2>&1
                   )
                )
             )echo --------------------------------------------
echo [OK]  28 
echo.
echo.
echo [029] :      Nvidia.bat
echo --------------------------------------------
echo.
echo.
echo.                 -----------------------------------------------------------------------------------------------------------------
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A 
:::                
:::                   $$$$$$$$\ $$\   $$\ $$\      $$\       $$$$$$$$\ $$\      $$\ $$$$$$$$\  $$$$$$\  $$\   $$\ $$$$$$$$\ $$$$$$$\  
:::                   $$  _____|$$ |  $$ |$$$\    $$$ |      \__$$  __|$$ | $\  $$ |$$  _____|$$  __$$\ $$ | $$  |$$  _____|$$  __$$\ 
:::                   $$ |      \$$\ $$  |$$$$\  $$$$ |         $$ |   $$ |$$$\ $$ |$$ |      $$ /  $$ |$$ |$$  / $$ |      $$ |  $$ |
:::                   $$$$$\     \$$$$  / $$\$$\$$ $$ |         $$ |   $$ $$ $$\$$ |$$$$$\    $$$$$$$$ |$$$$$  /  $$$$$\    $$$$$$$  |
:::                   $$  __|    $$  $$<  $$ \$$$  $$ |         $$ |   $$$$  _$$$$ |$$  __|   $$  __$$ |$$  $$<   $$  __|   $$  __$$< 
:::                   $$ |      $$  /\$$\ $$ |\$  /$$ |         $$ |   $$$  / \$$$ |$$ |      $$ |  $$ |$$ |\$$\  $$ |      $$ |  $$ |
:::                   $$$$$$$$\ $$ /  $$ |$$ | \_/ $$ |         $$ |   $$  /   \$$ |$$$$$$$$\ $$ |  $$ |$$ | \$$\ $$$$$$$$\ $$ |  $$ |
:::                   \________|\__|  \__|\__|     \__|         \__|   \__/     \__|\________|\__|  \__|\__|  \__|\________|\__|  \__|   
:::                                                                                                                 	
echo.                -----------------------------------------------------------------------------------------------------------------	
echo.  
echo.
echo.
echo 
echo.
echo                                                        Press Any Key To Continue...     
 >nul  						
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InterruptSteeringDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighestPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MinimumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumPerformancePercent" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitialUnparkCount" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnablePreemption" /t REG_DWORD /d "0" /f
echo.
echo 
echo.
echo                                                        Press any key to exit...     
 >nul
cls
echo --------------------------------------------
echo [OK]  29 
echo.
echo.
echo [030] :    Nvidia.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler --> [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers
:: ------------------------------------------------------------------------------------------------------------------------------------------------
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InterruptSteeringDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighestPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MinimumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumPerformancePercent" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitialUnparkCount" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f
REM "
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Acceleration.Level" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DesktopStereoShortcuts" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "FeatureControl" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NVDeviceSupportKFilter" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmCacheLoc" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmDisableInst2Sys" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmFbsrPagedDMA" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMGpuId" /t REG_DWORD /d "256" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmProfilingAdminOnly" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TCCSupported" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TrackResetEngine" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "UseBestResolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ValidateBlitSubRects" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PlatformSupportMiracast" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  30 
echo.
echo.
echo [031] :  ECC.bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -e 0echo --------------------------------------------
echo [OK]  31 
echo.
echo.
echo [032] :   Nvidia .bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
:: https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
 & exit 1
    )
 0
)
:: Initialize environment
setlocal EnableExtensions DisableDelayedExpansion
:: ----------------------------------------------------------
:: ----------Disable "NVIDIA Telemetry Report" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report" task
:: Disable scheduled task(s): `\NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable "NVIDIA Telemetry Report on Logon" task------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report on Logon" task
:: Disable scheduled task(s): `\NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---------Disable "NVIDIA telemetry monitor" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA telemetry monitor" task
:: Disable scheduled task(s): `\NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Remove Nvidia telemetry packages-------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry packages
if exist "%ProgramFiles%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL" (
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetryContainer
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetry
)
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------------Remove Nvidia telemetry components------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry components
:: Soft delete files matching pattern  : "%PROGRAMFILES(X86)%\NVIDIA Corporation\NvTelemetry\*"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%PROGRAMFILES(X86)%\NVIDIA Corporation\NvTelemetry\*"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $renamedCount   = 0; $skippedCount   = 0; $failedCount    = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping folder (not its contents): `"^""$path`"^""."^""; $skippedCount++; continue; }; if($revert -eq $true) {; if (-not $path.EndsWith('.OLD')) {; Write-Host "^""Skipping non-backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; } else {; if ($path.EndsWith('.OLD')) {; Write-Host "^""Skipping backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; }; $originalFilePath = $path; Write-Host "^""Processing file: `"^""$originalFilePath`"^""."^""; if (-Not (Test-Path $originalFilePath)) {; Write-Host "^""Skipping, file `"^""$originalFilePath`"^"" not found."^""; $skippedCount++; exit 0; }; if ($revert -eq $true) {; $newFilePath = $originalFilePath.Substring(0, $originalFilePath.Length - 4); } else {; $newFilePath = "^""$($originalFilePath).OLD"^""; }; try {; Move-Item -LiteralPath "^""$($originalFilePath)"^"" -Destination "^""$newFilePath"^"" -Force -ErrorAction Stop; Write-Host "^""Successfully processed `"^""$originalFilePath`"^""."^""; $renamedCount++; } catch {; Write-Error "^""Failed to rename `"^""$originalFilePath`"^"" to `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; $failedCount++; }; }; if (($renamedCount -gt 0) -or ($skippedCount -gt 0)) {; Write-Host "^""Successfully processed $renamedCount items and skipped $skippedCount items."^""; }; if ($failedCount -gt 0) {; Write-Warning "^""Failed to processed $($failedCount) items."^""; }"
:: Soft delete files matching pattern  : "%PROGRAMFILES%\NVIDIA Corporation\NvTelemetry\*"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%PROGRAMFILES%\NVIDIA Corporation\NvTelemetry\*"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $renamedCount   = 0; $skippedCount   = 0; $failedCount    = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping folder (not its contents): `"^""$path`"^""."^""; $skippedCount++; continue; }; if($revert -eq $true) {; if (-not $path.EndsWith('.OLD')) {; Write-Host "^""Skipping non-backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; } else {; if ($path.EndsWith('.OLD')) {; Write-Host "^""Skipping backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; }; $originalFilePath = $path; Write-Host "^""Processing file: `"^""$originalFilePath`"^""."^""; if (-Not (Test-Path $originalFilePath)) {; Write-Host "^""Skipping, file `"^""$originalFilePath`"^"" not found."^""; $skippedCount++; exit 0; }; if ($revert -eq $true) {; $newFilePath = $originalFilePath.Substring(0, $originalFilePath.Length - 4); } else {; $newFilePath = "^""$($originalFilePath).OLD"^""; }; try {; Move-Item -LiteralPath "^""$($originalFilePath)"^"" -Destination "^""$newFilePath"^"" -Force -ErrorAction Stop; Write-Host "^""Successfully processed `"^""$originalFilePath`"^""."^""; $renamedCount++; } catch {; Write-Error "^""Failed to rename `"^""$originalFilePath`"^"" to `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; $failedCount++; }; }; if (($renamedCount -gt 0) -or ($skippedCount -gt 0)) {; Write-Host "^""Successfully processed $renamedCount items and skipped $skippedCount items."^""; }; if ($failedCount -gt 0) {; Write-Warning "^""Failed to processed $($failedCount) items."^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Disable Nvidia telemetry drivers-------------
:: ----------------------------------------------------------
echo --- Disable Nvidia telemetry drivers
:: Soft delete files matching pattern  : "%SYSTEMROOT%\System32\DriverStore\FileRepository\NvTelemetry*.dll"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\System32\DriverStore\FileRepository\NvTelemetry*.dll"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $renamedCount   = 0; $skippedCount   = 0; $failedCount    = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping folder (not its contents): `"^""$path`"^""."^""; $skippedCount++; continue; }; if($revert -eq $true) {; if (-not $path.EndsWith('.OLD')) {; Write-Host "^""Skipping non-backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; } else {; if ($path.EndsWith('.OLD')) {; Write-Host "^""Skipping backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; }; $originalFilePath = $path; Write-Host "^""Processing file: `"^""$originalFilePath`"^""."^""; if (-Not (Test-Path $originalFilePath)) {; Write-Host "^""Skipping, file `"^""$originalFilePath`"^"" not found."^""; $skippedCount++; exit 0; }; if ($revert -eq $true) {; $newFilePath = $originalFilePath.Substring(0, $originalFilePath.Length - 4); } else {; $newFilePath = "^""$($originalFilePath).OLD"^""; }; try {; Move-Item -LiteralPath "^""$($originalFilePath)"^"" -Destination "^""$newFilePath"^"" -Force -ErrorAction Stop; Write-Host "^""Successfully processed `"^""$originalFilePath`"^""."^""; $renamedCount++; } catch {; Write-Error "^""Failed to rename `"^""$originalFilePath`"^"" to `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; $failedCount++; }; }; if (($renamedCount -gt 0) -or ($skippedCount -gt 0)) {; Write-Host "^""Successfully processed $renamedCount items and skipped $skippedCount items."^""; }; if ($failedCount -gt 0) {; Write-Warning "^""Failed to processed $($failedCount) items."^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable participation in Nvidia telemetry---------
:: ----------------------------------------------------------
echo --- Disable participation in Nvidia telemetry
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client' /v 'OptInOrOutPreference' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID44231' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID64640' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID66610' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup' /v 'SendTelemetryData' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Disable "Nvidia Telemetry Container" service-------
:: ----------------------------------------------------------
echo --- Disable "Nvidia Telemetry Container" service
:: Disable service(s): `NvTelemetryContainer`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'NvTelemetryContainer'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: ----------------------------------------------------------
:: Pause the script to view the final state
:: Restore previous environment settings
endlocal
:: Exit the script successfully
 /b 0echo --------------------------------------------
echo [OK]  32 
echo.
echo.
echo [033] :   Nvidia 2.bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
:: https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
    )
)
:: Initialize environment
setlocal EnableExtensions DisableDelayedExpansion
:: ----------------------------------------------------------
:: ----------Disable "NVIDIA Telemetry Report" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report" task
:: Disable scheduled task(s): `\NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable "NVIDIA Telemetry Report on Logon" task------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report on Logon" task
:: Disable scheduled task(s): `\NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---------Disable "NVIDIA telemetry monitor" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA telemetry monitor" task
:: Disable scheduled task(s): `\NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Remove Nvidia telemetry packages-------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry packages
if exist "%ProgramFiles%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL" (
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetryContainer
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetry
)
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------------Remove Nvidia telemetry components------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry components
:: Soft delete files matching pattern  : "%PROGRAMFILES(X86)%\NVIDIA Corporation\NvTelemetry\*"
:: Soft delete files matching pattern  : "%PROGRAMFILES%\NVIDIA Corporation\NvTelemetry\*"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Disable Nvidia telemetry drivers-------------
:: ----------------------------------------------------------
echo --- Disable Nvidia telemetry drivers
:: Soft delete files matching pattern  : "%SYSTEMROOT%\System32\DriverStore\FileRepository\NvTelemetry*.dll"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable participation in Nvidia telemetry---------
:: ----------------------------------------------------------
echo --- Disable participation in Nvidia telemetry
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client' /v 'OptInOrOutPreference' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID44231' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID64640' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID66610' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup' /v 'SendTelemetryData' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Disable "Nvidia Telemetry Container" service-------
:: ----------------------------------------------------------
echo --- Disable "Nvidia Telemetry Container" service
:: Disable service(s): `NvTelemetryContainer`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'NvTelemetryContainer'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: ----------------------------------------------------------
:: Pause the script to view the final state
:: Restore previous environment settings
endlocal
:: Exit the script successfully
echo --------------------------------------------
echo [OK]  33 
echo.
echo.
echo [034] :   Nvidia 3.bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID66610" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID64640" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID44231" /t REG_DWORD /d "0" /f
schtasks /change /disable /tn "NvTmRep_CrashReport1_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmRep_CrashReport2_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmRep_CrashReport3_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmRep_CrashReport4_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvDriverUpdateCheckDaily_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NVIDIA GeForce Experience SelfUpdate_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
echo Completed.
echo --------------------------------------------
echo [OK]  34 
echo.
echo.
echo [035] :   Nvidia.bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
echo аЄ  вҐ«аЁЁ NVIDIA
sc stop NvTelemetryContainer > NUL 2>&1
sc config NvTelemetryContainer start= disabled > NUL 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvTmMon"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvTmRep"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvTmRepOnLogon"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvProfileUpdaterDaily"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvProfileUpdaterOnLogon"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
reg add "HKCU\SOFTWARE\NVIDIA Corporation\NVControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d 0 /f > NUL 2>&1
echo бЇҐи­®!
pauseecho --------------------------------------------
echo [OK]  35 
echo.
echo.
echo [036] :   Windows.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLua" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_SZ /d "00000000" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowSharedUserAppData" /v "value" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowStore" /v "value" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  36 
echo.
echo.
echo [037] :  .bat
echo --------------------------------------------
reg add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup" /v "SendTelemetryData" /t REG_DWORD /d "0" /f
echo Execution is done.
echo --------------------------------------------
echo [OK]  37 
echo.
echo.
echo [038] :   .bat
echo --------------------------------------------
start "" "C:\Windows\System32\msinfo32.exe"echo --------------------------------------------
echo [OK]  38 
echo.
echo.
echo [039] :    Nvidia.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DpiMapIommuContiguous" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof
echo --------------------------------------------
echo [OK]  39 
echo.
echo.
echo [040] : .bat
echo --------------------------------------------
C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -acp 0echo --------------------------------------------
echo [OK]  40 
echo.
:end
echo.
echo ==================================================
echo   
echo ==================================================echo --------------------------------------------
echo [OK] Секция 13 выполнена
echo.
echo.
echo [014] Выполняется: Включить HDCP.bat
echo --------------------------------------------
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMHdcpKeyglobZero" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /f
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
for /f %%i in ('echo %%a ^| findstr "{"') do (
Reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "RMHdcpKeyglobZero" /f >nul 2>&1
)
)
)echo --------------------------------------------
echo [OK] Секция 14 выполнена
echo.
echo.
echo [015] Выполняется: Включить динамический Pstate.bat
echo --------------------------------------------
for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
for /f %%c in ('echo %%b ^| findstr "{"') do (
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /f
)
)
)echo --------------------------------------------
echo [OK] Секция 15 выполнена
echo.
echo.
echo [016] Выполняется: Включить объеденение глобальной памяти Nvidia.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMDisableLRCCoalescing" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eofecho --------------------------------------------
echo [OK] Секция 16 выполнена
echo.
echo.
echo [017] Выполняется: Загрузка драйверов NVIDIA.bat
echo --------------------------------------------
start "https://www.nvidia.com/ru-ru/geforce/drivers/"echo --------------------------------------------
echo [OK] Секция 17 выполнена
echo.
echo.
echo [018] Выполняется: Оптимизация графики.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "StreamType" /t REG_DWORD /d "0" /f
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "WriteCapture" /t REG_DWORD /d "0" /f
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "WriteCaptureDir" /t REG_SZ /d "c:\dm.capture\\" /f
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "WriteCapturePath" /t REG_SZ /d "" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eofecho --------------------------------------------
echo [OK] Секция 18 выполнена
echo.
echo.
echo [019] Выполняется: Отключите GeForceExp.Телеметрия.bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.

DevManView.exe /disable "NvModuleTracker Device" >nul 2>&1
DevManView.exe /disable "NVIDIA Virtual Audio Device (Wave Extensible) (WDM)" >nul 2>&1

for %%i in (NvTmMon NvTmRep NvProfile NvNodeLauncher NvDriverUpdateCheckDaily "NVIDIA GeForce Experience SelfUpdate*") do for /f "tokens=1 delims=," %%a in ('schtasks /query /fo csv ^| findstr /v "TaskName" ^| findstr "%%~i"') do schtasks /change /tn "%%a" /disable >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\NVIDIA Corporation\Global\GFExperience" /v "NotifyNewDisplayUpdates" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\NVIDIA Corporation\NvTray" /v "StartOnLogin" /t REG_DWORD /d "0" /f >nul 2>&1

exitecho --------------------------------------------
echo [OK] Секция 19 выполнена
echo.
echo.
echo [020] Выполняется: Отключить HDCP.bat
echo --------------------------------------------
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMHdcpKeyglobZero" /t REG_DWORD /d "1" /f
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
for /f %%i in ('echo %%a ^| findstr "{"') do (
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "RMHdcpKeyglobZero" /t REG_DWORD /d "1" /f >nul 2>&1			 
)
)
)echo --------------------------------------------
echo [OK] Секция 20 выполнена
echo.
echo.
echo [021] Выполняется: Отключить Nvidia Dynamic P-STATE.cmd
echo --------------------------------------------
for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
    for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
        for /f %%c in ('echo %%b ^| findstr "{"') do (
            Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f
        )
    )
)
pause
exitecho --------------------------------------------
echo [OK] Секция 21 выполнена
echo.
echo.
echo [022] Выполняется: Отключить МПО.bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d "5" /f

exitecho --------------------------------------------
echo [OK] Секция 22 выполнена
echo.
echo.
echo [023] Выполняется: Отключить динамическое Pstate.bat
echo --------------------------------------------
for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
for /f %%c in ('echo %%b ^| findstr "{"') do (
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f
)
)
)echo --------------------------------------------
echo [OK] Секция 23 выполнена
echo.
echo.
echo [024] Выполняется: Отключить масштабирование.bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.

for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /s /f "Scaling"^| findstr "HKEY"') do reg.exe add "%%i" /v "Scaling" /t REG_DWORD /d "1" /f >nul 2>&1echo --------------------------------------------
echo [OK] Секция 24 выполнена
echo.
echo.
echo [025] Выполняется: Отключить оптимизацию доставки.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ;Disable Delivery Optimization
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v "DownloadMode" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eofecho --------------------------------------------
echo [OK] Секция 25 выполнена
echo.
echo.
echo [026] Выполняется: Отключить телеметрию.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\diagsvc" /v "Start" /t REG_DWORD /d "4" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eofecho --------------------------------------------
echo [OK] Секция 26 выполнена
echo.
echo.
echo [027] Выполняется: Отключить упреждение.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler --> [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers
:: ------------------------------------------------------------------------------------------------------------------------------------------------
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisablePreemption" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PlatformSupportMiracast" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eofecho --------------------------------------------
echo [OK] Секция 27 выполнена
echo.
echo.
echo [028] Выполняется: ОтключитьЗаписьОбъединение.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE																										made by konex#8100
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableWriteCombining" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eofecho --------------------------------------------
echo [OK] Секция 28 выполнена
echo.
echo.
echo [029] Выполняется: Очистить кеш Nvidia.bat
echo --------------------------------------------
@echo BESPLATNO! from Reborn FREE PC Optimization (RU) - https://discord.gg/hgBQRsrDRu
@echo made by FrazE-
@echo Clearing NVIDIA DirectX Cache...

REM РџРµСЂРµС…РѕРґ Рє РїР°РїРєРµ DXCache СЃ РёСЃРїРѕР»СЊР·РѕРІР°РЅРёРµРј РїРµСЂРµРјРµРЅРЅС‹С… СЃСЂРµРґС‹
set DXCachePath=%LOCALAPPDATA%\..\LocalLow\NVIDIA\PerDriverVersion\DXCache

REM РџСЂРѕРІРµСЂРєР° СЃСѓС‰РµСЃС‚РІРѕРІР°РЅРёСЏ РїР°РїРєРё
if exist "%DXCachePath%" (
    @echo Found directory: %DXCachePath%
    @echo Deleting cache files...
    del /q "%DXCachePath%\*.*"
    @echo Cache cleared successfully.
) else (
    @echo Directory not found: %DXCachePath%
)
@echo Completed.
@pause
echo --------------------------------------------
echo [OK] Секция 29 выполнена
echo.
echo.
echo [030] Выполняется: Показать шелковистость.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "EnableRID61684" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eofecho --------------------------------------------
echo [OK] Секция 30 выполнена
echo.
echo.
echo [031] Выполняется: Политика неограниченного времени.bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.

C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -acp 0echo --------------------------------------------
echo [OK] Секция 31 выполнена
echo.
echo.
echo [032] Выполняется: Принудительное P-состояние.bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f > nul 2>&1
                   )
                )
             )echo --------------------------------------------
echo [OK] Секция 32 выполнена
echo.
echo.
echo [033] Выполняется: Принудительное состояние P0.bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
	for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
		for /f %%i in ('echo %%a ^| findstr "{"') do (
		     Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f > nul 2>&1
                   )
                )
             )echo --------------------------------------------
echo [OK] Секция 33 выполнена
echo.
echo.
echo [034] Выполняется: Расширенные скрытые настройки графического процессора Nvidia.bat
echo --------------------------------------------
echo.
echo.
echo.                 -----------------------------------------------------------------------------------------------------------------
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A 
:::                
:::                   $$$$$$$$\ $$\   $$\ $$\      $$\       $$$$$$$$\ $$\      $$\ $$$$$$$$\  $$$$$$\  $$\   $$\ $$$$$$$$\ $$$$$$$\  
:::                   $$  _____|$$ |  $$ |$$$\    $$$ |      \__$$  __|$$ | $\  $$ |$$  _____|$$  __$$\ $$ | $$  |$$  _____|$$  __$$\ 
:::                   $$ |      \$$\ $$  |$$$$\  $$$$ |         $$ |   $$ |$$$\ $$ |$$ |      $$ /  $$ |$$ |$$  / $$ |      $$ |  $$ |
:::                   $$$$$\     \$$$$  / $$\$$\$$ $$ |         $$ |   $$ $$ $$\$$ |$$$$$\    $$$$$$$$ |$$$$$  /  $$$$$\    $$$$$$$  |
:::                   $$  __|    $$  $$<  $$ \$$$  $$ |         $$ |   $$$$  _$$$$ |$$  __|   $$  __$$ |$$  $$<   $$  __|   $$  __$$< 
:::                   $$ |      $$  /\$$\ $$ |\$  /$$ |         $$ |   $$$  / \$$$ |$$ |      $$ |  $$ |$$ |\$$\  $$ |      $$ |  $$ |
:::                   $$$$$$$$\ $$ /  $$ |$$ | \_/ $$ |         $$ |   $$  /   \$$ |$$$$$$$$\ $$ |  $$ |$$ | \$$\ $$$$$$$$\ $$ |  $$ |
:::                   \________|\__|  \__|\__|     \__|         \__|   \__/     \__|\________|\__|  \__|\__|  \__|\________|\__|  \__|   
:::                                                                                                                 	
echo.                -----------------------------------------------------------------------------------------------------------------	
echo.  
echo.
echo.
echo 
echo.
echo                                                        Press Any Key To Continue...     
pause >nul  						
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InterruptSteeringDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighestPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MinimumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumPerformancePercent" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitialUnparkCount" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnablePreemption" /t REG_DWORD /d "0" /f
echo.
echo 
echo.
echo                                                        Press any key to exit...     
pause >nul
cls
exit
echo --------------------------------------------
echo [OK] Секция 34 выполнена
echo.
echo.
echo [035] Выполняется: Твики графического процессора Nvidia.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler --> [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers
:: ------------------------------------------------------------------------------------------------------------------------------------------------
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InterruptSteeringDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighestPerformance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MinimumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumThrottlePercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumPerformancePercent" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitialUnparkCount" /t REG_DWORD /d "100" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f
REM "
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Acceleration.Level" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DesktopStereoShortcuts" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "FeatureControl" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NVDeviceSupportKFilter" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmCacheLoc" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmDisableInst2Sys" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmFbsrPagedDMA" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMGpuId" /t REG_DWORD /d "256" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmProfilingAdminOnly" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TCCSupported" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TrackResetEngine" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "UseBestResolution" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ValidateBlitSubRects" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PlatformSupportMiracast" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eofecho --------------------------------------------
echo [OK] Секция 35 выполнена
echo.
echo.
echo [036] Выполняется: Удалить ECC.bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.

C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -e 0echo --------------------------------------------
echo [OK] Секция 36 выполнена
echo.
echo.
echo [037] Выполняется: Удалить телеметрию Nvidia .bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.

:: https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
        pause & exit 1
    )
    exit 0
)
:: Initialize environment
setlocal EnableExtensions DisableDelayedExpansion


:: ----------------------------------------------------------
:: ----------Disable "NVIDIA Telemetry Report" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report" task
:: Disable scheduled task(s): `\NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----Disable "NVIDIA Telemetry Report on Logon" task------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report on Logon" task
:: Disable scheduled task(s): `\NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------Disable "NVIDIA telemetry monitor" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA telemetry monitor" task
:: Disable scheduled task(s): `\NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------Remove Nvidia telemetry packages-------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry packages
if exist "%ProgramFiles%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL" (
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetryContainer
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetry
)
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------Remove Nvidia telemetry components------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry components
:: Soft delete files matching pattern  : "%PROGRAMFILES(X86)%\NVIDIA Corporation\NvTelemetry\*"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%PROGRAMFILES(X86)%\NVIDIA Corporation\NvTelemetry\*"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $renamedCount   = 0; $skippedCount   = 0; $failedCount    = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping folder (not its contents): `"^""$path`"^""."^""; $skippedCount++; continue; }; if($revert -eq $true) {; if (-not $path.EndsWith('.OLD')) {; Write-Host "^""Skipping non-backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; } else {; if ($path.EndsWith('.OLD')) {; Write-Host "^""Skipping backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; }; $originalFilePath = $path; Write-Host "^""Processing file: `"^""$originalFilePath`"^""."^""; if (-Not (Test-Path $originalFilePath)) {; Write-Host "^""Skipping, file `"^""$originalFilePath`"^"" not found."^""; $skippedCount++; exit 0; }; if ($revert -eq $true) {; $newFilePath = $originalFilePath.Substring(0, $originalFilePath.Length - 4); } else {; $newFilePath = "^""$($originalFilePath).OLD"^""; }; try {; Move-Item -LiteralPath "^""$($originalFilePath)"^"" -Destination "^""$newFilePath"^"" -Force -ErrorAction Stop; Write-Host "^""Successfully processed `"^""$originalFilePath`"^""."^""; $renamedCount++; } catch {; Write-Error "^""Failed to rename `"^""$originalFilePath`"^"" to `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; $failedCount++; }; }; if (($renamedCount -gt 0) -or ($skippedCount -gt 0)) {; Write-Host "^""Successfully processed $renamedCount items and skipped $skippedCount items."^""; }; if ($failedCount -gt 0) {; Write-Warning "^""Failed to processed $($failedCount) items."^""; }"
:: Soft delete files matching pattern  : "%PROGRAMFILES%\NVIDIA Corporation\NvTelemetry\*"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%PROGRAMFILES%\NVIDIA Corporation\NvTelemetry\*"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $renamedCount   = 0; $skippedCount   = 0; $failedCount    = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping folder (not its contents): `"^""$path`"^""."^""; $skippedCount++; continue; }; if($revert -eq $true) {; if (-not $path.EndsWith('.OLD')) {; Write-Host "^""Skipping non-backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; } else {; if ($path.EndsWith('.OLD')) {; Write-Host "^""Skipping backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; }; $originalFilePath = $path; Write-Host "^""Processing file: `"^""$originalFilePath`"^""."^""; if (-Not (Test-Path $originalFilePath)) {; Write-Host "^""Skipping, file `"^""$originalFilePath`"^"" not found."^""; $skippedCount++; exit 0; }; if ($revert -eq $true) {; $newFilePath = $originalFilePath.Substring(0, $originalFilePath.Length - 4); } else {; $newFilePath = "^""$($originalFilePath).OLD"^""; }; try {; Move-Item -LiteralPath "^""$($originalFilePath)"^"" -Destination "^""$newFilePath"^"" -Force -ErrorAction Stop; Write-Host "^""Successfully processed `"^""$originalFilePath`"^""."^""; $renamedCount++; } catch {; Write-Error "^""Failed to rename `"^""$originalFilePath`"^"" to `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; $failedCount++; }; }; if (($renamedCount -gt 0) -or ($skippedCount -gt 0)) {; Write-Host "^""Successfully processed $renamedCount items and skipped $skippedCount items."^""; }; if ($failedCount -gt 0) {; Write-Warning "^""Failed to processed $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------Disable Nvidia telemetry drivers-------------
:: ----------------------------------------------------------
echo --- Disable Nvidia telemetry drivers
:: Soft delete files matching pattern  : "%SYSTEMROOT%\System32\DriverStore\FileRepository\NvTelemetry*.dll"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\System32\DriverStore\FileRepository\NvTelemetry*.dll"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $renamedCount   = 0; $skippedCount   = 0; $failedCount    = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping folder (not its contents): `"^""$path`"^""."^""; $skippedCount++; continue; }; if($revert -eq $true) {; if (-not $path.EndsWith('.OLD')) {; Write-Host "^""Skipping non-backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; } else {; if ($path.EndsWith('.OLD')) {; Write-Host "^""Skipping backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; }; $originalFilePath = $path; Write-Host "^""Processing file: `"^""$originalFilePath`"^""."^""; if (-Not (Test-Path $originalFilePath)) {; Write-Host "^""Skipping, file `"^""$originalFilePath`"^"" not found."^""; $skippedCount++; exit 0; }; if ($revert -eq $true) {; $newFilePath = $originalFilePath.Substring(0, $originalFilePath.Length - 4); } else {; $newFilePath = "^""$($originalFilePath).OLD"^""; }; try {; Move-Item -LiteralPath "^""$($originalFilePath)"^"" -Destination "^""$newFilePath"^"" -Force -ErrorAction Stop; Write-Host "^""Successfully processed `"^""$originalFilePath`"^""."^""; $renamedCount++; } catch {; Write-Error "^""Failed to rename `"^""$originalFilePath`"^"" to `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; $failedCount++; }; }; if (($renamedCount -gt 0) -or ($skippedCount -gt 0)) {; Write-Host "^""Successfully processed $renamedCount items and skipped $skippedCount items."^""; }; if ($failedCount -gt 0) {; Write-Warning "^""Failed to processed $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------Disable participation in Nvidia telemetry---------
:: ----------------------------------------------------------
echo --- Disable participation in Nvidia telemetry
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client' /v 'OptInOrOutPreference' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID44231' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID64640' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID66610' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup' /v 'SendTelemetryData' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------Disable "Nvidia Telemetry Container" service-------
:: ----------------------------------------------------------
echo --- Disable "Nvidia Telemetry Container" service
:: Disable service(s): `NvTelemetryContainer`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'NvTelemetryContainer'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: ----------------------------------------------------------


:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0echo --------------------------------------------
echo [OK] Секция 37 выполнена
echo.
echo.
echo [038] Выполняется: Удалить телеметрию Nvidia 2.bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
:: https://privacy.sexy вЂ” v0.13.5 вЂ” Sun, 04 Aug 2024 20:29:30 GMT
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
    )
)
:: Initialize environment
setlocal EnableExtensions DisableDelayedExpansion
:: ----------------------------------------------------------
:: ----------Disable "NVIDIA Telemetry Report" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report" task
:: Disable scheduled task(s): `\NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable "NVIDIA Telemetry Report on Logon" task------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report on Logon" task
:: Disable scheduled task(s): `\NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---------Disable "NVIDIA telemetry monitor" task----------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA telemetry monitor" task
:: Disable scheduled task(s): `\NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Remove Nvidia telemetry packages-------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry packages
if exist "%ProgramFiles%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL" (
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetryContainer
    rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetry
)
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------------Remove Nvidia telemetry components------------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry components
:: Soft delete files matching pattern  : "%PROGRAMFILES(X86)%\NVIDIA Corporation\NvTelemetry\*"
:: Soft delete files matching pattern  : "%PROGRAMFILES%\NVIDIA Corporation\NvTelemetry\*"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Disable Nvidia telemetry drivers-------------
:: ----------------------------------------------------------
echo --- Disable Nvidia telemetry drivers
:: Soft delete files matching pattern  : "%SYSTEMROOT%\System32\DriverStore\FileRepository\NvTelemetry*.dll"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable participation in Nvidia telemetry---------
:: ----------------------------------------------------------
echo --- Disable participation in Nvidia telemetry
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client' /v 'OptInOrOutPreference' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID44231' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID64640' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID66610' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup' /v 'SendTelemetryData' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Disable "Nvidia Telemetry Container" service-------
:: ----------------------------------------------------------
echo --- Disable "Nvidia Telemetry Container" service
:: Disable service(s): `NvTelemetryContainer`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'NvTelemetryContainer'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: ----------------------------------------------------------
:: Pause the script to view the final state
:: Restore previous environment settings
endlocal
:: Exit the script successfullyecho --------------------------------------------
echo [OK] Секция 38 выполнена
echo.
echo.
echo [039] Выполняется: Удалить телеметрию Nvidia 3.bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID66610" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID64640" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID44231" /t REG_DWORD /d "0" /f
schtasks /change /disable /tn "NvTmRep_CrashReport1_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmRep_CrashReport2_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmRep_CrashReport3_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmRep_CrashReport4_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvDriverUpdateCheckDaily_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NVIDIA GeForce Experience SelfUpdate_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
schtasks /change /disable /tn "NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"
echo Completed.echo --------------------------------------------
echo [OK] Секция 39 выполнена
echo.
echo.
echo [040] Выполняется: Удалить телеметрию Nvidia.bat
echo --------------------------------------------
@echo.
@echo t.me/DE3NAKE
@echo.

echo “Ў®аЄ  вҐ«Ґ¬ҐваЁЁ NVIDIA
sc stop NvTelemetryContainer > NUL 2>&1
sc config NvTelemetryContainer start= disabled > NUL 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvTmMon"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvTmRep"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvTmRepOnLogon"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvProfileUpdaterDaily"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
for /f "tokens=1 delims=," %%t in ('schtasks /Query /FO CSV ^| find /v "TaskName" ^| find "NvProfileUpdaterOnLogon"') do schtasks /Change /TN "%%~t" /Disable >nul 2>&1
reg add "HKCU\SOFTWARE\NVIDIA Corporation\NVControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d 0 /f > NUL 2>&1
echo “бЇҐи­®!
pauseecho --------------------------------------------
echo [OK] Секция 40 выполнена
echo.
echo.
echo [041] Выполняется: Удалить телеметрию Windows.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLua" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_SZ /d "00000000" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowSharedUserAppData" /v "value" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowStore" /v "value" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eofecho --------------------------------------------
echo [OK] Секция 41 выполнена
echo.
echo.
echo [042] Выполняется: Удалить телеметрию.bat
echo --------------------------------------------
reg add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup" /v "SendTelemetryData" /t REG_DWORD /d "0" /f
echo Execution is done.echo --------------------------------------------
echo [OK] Секция 42 выполнена
echo.
echo.
echo [043] Выполняется: Узнать модель видеокарты.bat
echo --------------------------------------------
start "" "C:\Windows\System32\msinfo32.exe"echo --------------------------------------------
echo [OK] Секция 43 выполнена
echo.
echo.
echo [044] Выполняется: Уменьшение задержек для Nvidia.bat
echo --------------------------------------------
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DpiMapIommuContiguous" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eofecho --------------------------------------------
echo [OK] Секция 44 выполнена
echo.
echo.
echo [045] Выполняется: УнКП.bat
echo --------------------------------------------
C:
cd C:\Program Files\NVIDIA Corporation\NVSMI
nvidia-smi.exe -acp 0echo --------------------------------------------
echo [OK] Секция 45 выполнена
echo.
:end
echo.
echo ==================================================
echo ВСЕ СЕКЦИИ ВЫПОЛНЕНЫ
echo ==================================================
pause
