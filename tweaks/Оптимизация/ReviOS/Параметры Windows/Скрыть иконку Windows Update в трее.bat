@echo off
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "TrayIconVisibility" /t REG_DWORD /d "0" /f
