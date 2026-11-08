@echo off
title LLMNR и NetBIOS
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v EnableMulticast /t REG_DWORD /d 0 /f
powershell -NoProfile -Command "Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object {$_.IPEnabled -eq $true} | ForEach-Object {$_.SetTcpipNetbios(2)}"
echo [+] LLMNR и NetBIOS отключены.
