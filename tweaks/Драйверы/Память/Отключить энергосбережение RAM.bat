@echo off
@echo DE3NAKE OPTIMIZATION / t.me/DE3NAKE
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings" /v MemoryPowerSaving /t REG_DWORD /d 0 /f
@echo Completed.