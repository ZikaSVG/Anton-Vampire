@Echo Off
Title Reg Converter v1.1 & Color 1A
REM ~ call :IsAdmin

call :RegExport
Exit

:RegExport
Set RegFile="%Temp%\~xdbklzq.tmp"

If Exist %RegFile% (
 Attrib -R -S -H %RegFile% &  Del /F /Q %RegFile%
 If Exist %RegFile% cls & Echo Could not delete file %RegFile% & Pause
)
> %RegFile% Echo Windows Registry Editor Version 5.00				Made By EverythingTech (https://www.youtube.com/c/EverythingTechTutorials/?sub_confirmation=1)
>> %RegFile% Echo.
>> %RegFile% Echo *Mouse Optimizations*
>> %RegFile% Echo.
>> %RegFile% Echo [HKEY_USERS\.DEFAULT\Control Panel\Mouse]
>> %RegFile% Echo "MouseSpeed"=hex(1):30,00,00,00
>> %RegFile% Echo "MouseThreshold1"=hex(1):30,00,00,00
>> %RegFile% Echo "MouseThreshold2"=hex(1):30,00,00,00
>> %RegFile% Echo.
>> %RegFile% Echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Input\Settings\ControllerProcessor\CursorSpeed]
>> %RegFile% Echo "CursorSensitivity"=dword:00002710
>> %RegFile% Echo "CursorUpdateInterval"=dword:00000001
>> %RegFile% Echo "IRRemoteNavigationDelta"=dword:00000001
>> %RegFile% Echo.
>> %RegFile% Echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Input\Settings\ControllerProcessor\CursorMagnetism]
>> %RegFile% Echo "AttractionRectInsetInDIPS"=dword:00000005
>> %RegFile% Echo "DistanceThresholdInDIPS"=dword:00000028
>> %RegFile% Echo "MagnetismDelayInMilliseconds"=dword:00000032
>> %RegFile% Echo "MagnetismUpdateIntervalInMilliseconds"=dword:00000010
>> %RegFile% Echo "VelocityInDIPSPerSecond"=dword:00000168
>> %RegFile% Echo.
>> %RegFile% Echo [HKEY_CURRENT_USER\Control Panel\Mouse]
>> %RegFile% Echo "MouseHoverTime"=hex(1):38,00,00,00
>> %RegFile% Echo.
>> %RegFile% Echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mouclass\Parameters]
>> %RegFile% Echo "MouseDataQueueSize"=dword:00000014
>> %RegFile% Echo "ThreadPriority"=dword:0000001f
>> %RegFile% Echo.
>> %RegFile% Echo [HKEY_CURRENT_USER\Control Panel\Mouse]
>> %RegFile% Echo "MouseSensitivity"=hex(1):31,00,30,00,00,00
>> %RegFile% Echo "SmoothMouseXCurve"=hex:\
>> %RegFile% Echo 	00,00,00,00,00,00,00,00,\
>> %RegFile% Echo 	C0,CC,0C,00,00,00,00,00,\
>> %RegFile% Echo 	80,99,19,00,00,00,00,00,\
>> %RegFile% Echo 	40,66,26,00,00,00,00,00,\
>> %RegFile% Echo 	00,33,33,00,00,00,00,00
>> %RegFile% Echo "SmoothMouseYCurve"=hex:\
>> %RegFile% Echo 	00,00,00,00,00,00,00,00,\
>> %RegFile% Echo 	00,00,38,00,00,00,00,00,\
>> %RegFile% Echo 	00,00,70,00,00,00,00,00,\
>> %RegFile% Echo 	00,00,A8,00,00,00,00,00,\
>> %RegFile% Echo 	00,00,E0,00,00,00,00,00

Start /Wait %systemroot%\Regedit.exe /S %RegFile%
Del %RegFile%
goto:eof

:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 Pause & Exit
)
Cls
goto:eof
