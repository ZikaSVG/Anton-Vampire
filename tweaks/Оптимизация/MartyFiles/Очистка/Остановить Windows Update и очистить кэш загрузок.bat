@echo off
sc query wuauserv | find /i "RUNNING" >nul 2>&1 && (
    net stop wuauserv >nul 2>&1
    timeout /t 1 /nobreak >nul 2>&1
    sc query wuauserv | find /i "RUNNING" >nul 2>&1 && net stop wuauserv
)
del /q /f /s "%SystemRoot%\SoftwareDistribution\Download\*.*" >nul 2>&1
rd /q /s "%SystemRoot%\SoftwareDistribution\Download\" >nul 2>&1
