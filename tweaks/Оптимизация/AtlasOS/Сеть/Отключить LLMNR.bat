@echo off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v "EnableMulticast" /t REG_DWORD /d 0 /f >nul 2>&1
