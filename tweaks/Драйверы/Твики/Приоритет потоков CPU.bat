@echo off
@echo DE3NAKE OPTIMIZATION / t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "ThreadBoostType" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "ThreadSchedulingModel" /t REG_DWORD /d "2" /f
@echo Completed.
@pause