@Echo Off
Title Reg Converter v1.1 & Color 1A
cd %systemroot%\system32
call :IsAdmin
REM TDP
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PerfTargetEnable" /t REG_DWORD /d "1" /f
REM BoostClock
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmEnableBoostClock" /t REG_DWORD /d "1" /f
REM 
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Class{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableAggressivePStateBoost" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof