@echo off
@echo DE3NAKE OPTIMIZATION / t.me/DE3NAKE
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "PerfIsoEnabled" /t REG_DWORD /d "1" /f
@echo Completed.
@pause