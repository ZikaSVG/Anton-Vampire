@echo off
for %%a in ("BluetoothUserService" "BTAGService" "BthA2dp" "BthAvctpSvc" "BthEnum" "BthHFEnum" "BthLEEnum" "BthMini" "BTHMODEM" "BTHPORT" "bthserv" "BTHUSB" "HidBth" "Microsoft_Bluetooth_AvrcpTransport" "RFCOMM") do call "%windir%\AtlasModules\Scripts\setSvc.cmd" %%~a 4
call "%windir%\AtlasModules\Scripts\setSvc.cmd" BthPan 4 >nul 2>&1
call "%windir%\AtlasModules\Scripts\toggleDev.cmd" -Silent '*Bluetooth*'
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Connectivity\AllowBluetooth" /v "value" /t REG_DWORD /d "0" /f >nul
