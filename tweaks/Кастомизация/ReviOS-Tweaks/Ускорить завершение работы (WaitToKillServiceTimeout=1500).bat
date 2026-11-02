@echo off
reg add "HKLM\SYSTEM\ControlSet001\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "1500" /f
