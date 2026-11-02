@echo off
reg delete "HKLM\SYSTEM\ControlSet001\Services\Tcpip\Parameters" /v DefaultTTL /f >nul 2>&1
reg delete "HKLM\SYSTEM\ControlSet001\Services\Tcpip6\Parameters" /v DefaultTTL /f >nul 2>&1
