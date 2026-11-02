@echo off
reg add "HKCU\SOFTWARE\Microsoft\Multimedia\Audio\DeviceCpl" /v "ShowDisconnectedDevices" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Multimedia\Audio\DeviceCpl" /v "ShowHiddenDevices" /t REG_DWORD /d 0 /f >nul 2>&1
