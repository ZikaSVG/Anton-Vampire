@echo off
bcdedit /deletevalue {globalsettings} advancedoptions >nul 2>&1
