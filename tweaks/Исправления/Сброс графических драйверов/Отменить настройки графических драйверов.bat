@Echo Off
Title Reg Converter v1.1 & Color 1A
cd %systemroot%\system32
call :IsAdmin
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "PlatformSupportMiracast" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "ForceDirectFlip" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof