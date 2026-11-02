@echo off
powercfg -h off >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Power" /v "HibernateEnabledDefault" /t REG_DWORD /d 0x0 /f >nul 2>&1
