@echo off
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontReportInfectionInformation" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\RemovalTools\MpGears" /v "HeartbeatTrackingIndex" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\RemovalTools\MpGears" /v "SpyNetReportingLocation" /t REG_MULTI_SZ /d "" /f >nul 2>&1
