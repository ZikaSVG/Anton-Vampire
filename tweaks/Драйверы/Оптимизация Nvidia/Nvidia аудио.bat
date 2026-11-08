@Echo Off
Title Reg Converter v1.1 & Color 1A
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\***\0000\PowerSettings" /v "ConservationIdleTime" /t REG_BINARY /d "00000000" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\***\0000\PowerSettings" /v "IdlePowerState" /t REG_BINARY /d "00000000" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\***\0000\PowerSettings" /v "PerformanceIdleTime" /t REG_BINARY /d "00000000" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof