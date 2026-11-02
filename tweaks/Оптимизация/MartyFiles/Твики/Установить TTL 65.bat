@echo off
reg add "HKLM\SYSTEM\ControlSet001\Services\Tcpip\Parameters" /v DefaultTTL /t REG_DWORD /d 0x41 /f >nul
reg add "HKLM\SYSTEM\ControlSet001\Services\Tcpip6\Parameters" /v DefaultTTL /t REG_DWORD /d 0x41 /f >nul
