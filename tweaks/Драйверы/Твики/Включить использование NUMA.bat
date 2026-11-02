@echo off
@echo DE3NAKE OPTIMIZATION / t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\NUMA" /v "SplitLargeNodes" /t REG_DWORD /d "1" /f
@echo Completed.
@pause