@echo off
bcdedit /deletevalue {globalsettings} custom:16000067 >nul 2>&1
