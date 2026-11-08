@echo off
bcdedit /deletevalue {globalsettings} custom:16000069 >nul 2>&1
