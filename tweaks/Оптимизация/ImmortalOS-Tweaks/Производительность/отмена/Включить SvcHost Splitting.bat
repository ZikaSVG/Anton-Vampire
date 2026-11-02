@echo off
chcp 65001 >nul 2>&1

net session >nul 2>&1
if %errorLevel% neq 0 exit /b 1

reg delete "HKLM\SYSTEM\ControlSet001\Control" /v "SvcHostSplitThresholdInKB" /f >nul 2>&1

exit /b 0
