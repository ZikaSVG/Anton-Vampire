@Echo Off
Title Reg Converter v1.1 & Color 1A
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\intelppm\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\pci\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\kbdclass\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\kbdhid\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\NdisWan\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\EhStorClass\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\HDAudBus\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\partmgr\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\ACPI\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\acpipagr\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\BasicDisplay\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\BasicRender\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\dc1-controller\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\intelpep\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\MEIx64\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\monitor\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\mouhid\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\msisadrv\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\NdisVirtualBus\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\NvModuleTracker\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\storahci\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\umbus\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\USBHUB3\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\USBXHCI\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\vdrvroot\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\vwifibus\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\WpdUpFltr\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\WUDFWpdFsParameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\xinputhid\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof