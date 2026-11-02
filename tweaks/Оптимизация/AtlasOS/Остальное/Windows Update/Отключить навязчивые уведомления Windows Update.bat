@echo off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAUAsDefaultShutdownOption" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "HideMCTLink" /t REG_DWORD /d 1 /f >nul 2>&1
