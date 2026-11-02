@echo off
reg delete "HKLM\Software\Microsoft\Windows Search\Gather\Windows\SystemIndex" /v "RespectPowerModes" /f >nul 2>&1
