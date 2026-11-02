@Echo Off
Title Reg Converter v1.2 & Color 1A
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Storage" /v "StorageD3InModernStandby" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Storage\EnabledDenyGP" /v "DenyAllGPState" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Storage\RegCacheState" /v "RegCacheUpdated" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Storage\StorageTelemetry" /v "DeviceDumpLevel" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Storage\StorageTelemetry" /v "DeviceDumpMaxSize" /t REG_DWORD /d "32768" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Storage\StorageTelemetry\ATA" /v "PrivateLogAddress" /t REG_DWORD /d "10" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Storage\StorageTelemetry\ATA\PublicLogAddressList" /v "DataStatistics" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Storage\StorageTelemetry\ATA\PublicLogAddressList" /v "LPSMisalignment" /t REG_DWORD /d "13" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Storage\StorageTelemetry\ATA\PublicLogAddressList" /v "NCQErrors" /t REG_DWORD /d "16" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Storage\StorageTelemetry\ATA\PublicLogAddressList" /v "PowerConditions" /t REG_DWORD /d "8" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Storage\StorageTelemetry\ATA\PublicLogAddressList" /v "SATAPHYErrors" /t REG_DWORD /d "17" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof