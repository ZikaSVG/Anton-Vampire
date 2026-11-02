@echo off
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v "EnthusiastMode" /f >nul 2>&1
reg delete "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v "EnthusiastMode" /f >nul 2>&1
