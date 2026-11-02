@echo off
reg add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" /v "AutoConnectAllowedOEM" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features" /v "PaidWifi" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features" /v "WiFiSenseOpen" /t REG_DWORD /d "0" /f
