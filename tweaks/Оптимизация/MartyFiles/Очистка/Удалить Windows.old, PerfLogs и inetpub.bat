@echo off
for %%F in ("%SystemDrive%\Windows.old" "%SystemDrive%\PerfLogs" "%SystemDrive%\inetpub") do rd /q /s %%F >nul 2>&1
