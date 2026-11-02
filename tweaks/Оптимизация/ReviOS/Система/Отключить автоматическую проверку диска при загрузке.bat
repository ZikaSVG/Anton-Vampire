@echo off
reg add "HKLM\SYSTEM\ControlSet001\Control\Session Manager" /v "BootExecute" /t REG_MULTI_SZ /d "autocheck autochk /k:C*" /f
