@echo off
reg delete "HKLM\SYSTEM\Maps" /v "UpdateOnlyOnWifi" /f >nul 2>&1
