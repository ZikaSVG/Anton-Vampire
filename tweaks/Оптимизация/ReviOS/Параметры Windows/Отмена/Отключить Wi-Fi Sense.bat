@echo off
reg delete "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" /v "AutoConnectAllowedOEM" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features" /v "PaidWifi" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features" /v "WiFiSenseOpen" /f >nul 2>&1
