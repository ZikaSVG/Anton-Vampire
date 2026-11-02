@Echo Off
Title Reg Converter v1.2 & Color 1A
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "IoStripeAlignment" /t REG_MULTI_SZ /d "VEN_8086&DEV_0953&REV_?? 128\0VEN_8086&DEV_0984&REV_?? 128\0VEN_8086&DEV_0A53&REV_?? 128\0VEN_8086&DEV_0A54&REV_?? 128\0VEN_8086&DEV_0A55&REV_?? 128" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "IdlePowerMode" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof