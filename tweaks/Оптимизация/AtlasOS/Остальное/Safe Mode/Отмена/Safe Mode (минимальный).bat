@echo off
bcdedit /deletevalue {current} safeboot >nul 2>&1
