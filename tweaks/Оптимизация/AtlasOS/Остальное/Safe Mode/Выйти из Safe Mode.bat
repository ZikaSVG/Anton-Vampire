@echo off
bcdedit /deletevalue {current} safeboot >nul 2>&1
bcdedit /deletevalue {current} safebootalternateshell >nul 2>&1
