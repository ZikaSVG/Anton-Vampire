@Echo Off
Title Reg Converter v1.1 & Color 1A
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" /v "autodisconnect" /t REG_DWORD /d "4294967295" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" /v "Size" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" /v "EnableOplocks" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" /v "IRPStackSize" /t REG_DWORD /d "32" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" /v "SharingViolationDelay" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" /v "SharingViolationRetries" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof