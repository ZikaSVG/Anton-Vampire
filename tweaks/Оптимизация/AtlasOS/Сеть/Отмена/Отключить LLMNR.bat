@echo off
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v "EnableMulticast" /f >nul 2>&1
