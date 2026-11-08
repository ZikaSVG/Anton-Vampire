@echo off
@echo.
@echo t.me/DE3NAKE
@echo.

Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /f >nul 2>&1
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "CoalescingTimerInterval" /f >nul 2>&1

exit