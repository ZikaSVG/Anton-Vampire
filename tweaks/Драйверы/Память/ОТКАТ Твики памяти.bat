@Echo Off
Title Reg Converter v1.1 & Color 1A
cd %systemroot%\system32
call :IsAdmin
REM ; Besplatno! from Reborn PC Optimization (RU) - https://discord.gg/hgBQRsrDRu
Reg.exe delete "HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management" /v "TrackLockedPages" /f
Reg.exe delete "HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management" /v "TrackPtes" /f
Reg.exe delete "HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management" /v "SimulateCommitSavings" /f
Reg.exe delete "HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management" /v "SecondLevelDataCache" /f
Reg.exe add "HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "AlpcWakePolicy" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof