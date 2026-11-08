@echo off
reg add "HKCU\Software\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" /t REG_DWORD /v System.IsPinnedToNameSpaceTree /d "1" /f >nul
