@echo off
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
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "AP threads Idle Manner" /qv 0x03
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "ASPM" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BIOS Lock" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "BIST Enable" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Boot performance mode" /qv 0x02
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "CER" /qv 0x01
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "CFG Lock" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Disable Gen2 Pll Shutdown and L1 Controller Power gating" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "DMI Link ASPM Control" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "EC Notification" /qv 0x00
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "EC Turbo Control Mode" /qv 0x01
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "I2C 1 D3 Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "I2C 2 D3 Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "I2C 3 D3 Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "I2C 4 D3 Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "I2C 5 D3 Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Indirect Branch Prediction Speculation" /qv 0x1
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Integrated Graphics" /qv 0x1
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "IOMMU" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Ipv4 PXE Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Ipv6 PXE Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "L1 Stream HW Prefetcher" /qv 0x1
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "L2 Stream HW Prefetcher" /qv 0x1
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "LCLK DPM Enhanced PCIe Detection" /qv 0x2
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "NBIO Poison Consumption" /qv 0x2
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "NBIO RAS Control" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "NBIO RAS Global Control" /qv 0x1
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "NBIO SyncFlood Generation" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "OC Mode" /qv 0x3
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Onboard PCIE LAN PXE ROM" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Option ROM Messages" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Parallel Port" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PCIe ARI Enumeration" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PCIe ARI Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PCIe Ten Bit Tag Support" /qv 0x1
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Periodic Directory Rinse" /qv 0x1
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Platform First Error Handling" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "PM L1 SS" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "UART 1 D3 Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "UART 2 D3 Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "UART 3 D3 Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB ecc SMI Enable" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "USB Phy Power Down" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "VGA Palette Snoop" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Wake on PME" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "xGMI encryption control" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "XHCI D3 Support" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "XHCI Hand-off" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Xtrig7 Workaround" /qv 0x0
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Snoop Latency Override" /qv 0x02
    "%DOWNLOAD_FOLDER%\SCEWIN_64.exe" /i /lang en-US /ms "Non Snoop Latency Multiplier" /qv 0x01
)