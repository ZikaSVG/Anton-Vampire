@echo off
bcdedit /deletevalue {globalsettings} highestmode >nul 2>&1
