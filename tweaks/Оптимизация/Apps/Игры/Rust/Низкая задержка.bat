@Echo Off
Title Reg Converter v1.1 & Color 1A
cd %systemroot%\system32
call :IsAdmin
:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: HKEY_CURRENT_USER\Control Panel\Mouse --> SmoothMouseXCurve"=hex:\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 00,00,00,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> C0,CC,0C,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 80,99,19,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 40,66,26,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 00,33,33,00,00,00,00,00
:: HKEY_CURRENT_USER\Control Panel\Mouse --> SmoothMouseYCurve"=hex:\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 00,00,00,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 00,00,38,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 00,00,70,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 00,00,A8,00,00,00,00,00,\
:: HKEY_CURRENT_USER\Control Panel\Mouse --> 00,00,E0,00,00,00,00,00
:: ------------------------------------------------------------------------------------------------------------------------------------------------
REM ;=== Disables Fullscreen Optimizations, GameDVR and GameBar which is known to cause stutter and low FPS in games. Also fixes most game crashes.
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_SZ /d "00000000" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d "2" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f
REM ;=== Unlocks the ability to modify sleeping CPU cores to improve performance and decrease stutter in games.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\943c8cb6-6f93-4227-ad87-e9a3feec08d1" /v "Attributes" /t REG_SZ /d "2" /f
REM ;=== Improves system responsiveness and network speed.
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "10" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_SZ /d "fffffff" /f
REM ;=== Marginally improves GPU performance and provides more power to games.
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d "10000" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "8" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "6" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
REM ;=== Adds the "Copy To..." ability from Windows 7, when you right click files or folders, for easier file management.
Reg.exe add "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\Copy To" /ve /t REG_SZ /d "{C2FBB630-2971-11D1-A18C-00C04FD75D13}" /f
REM ;=== Adds the "Move To..." ability from Windows 7, when you right click files or folders, for easier file management.
Reg.exe add "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\Move To" /ve /t REG_SZ /d "{C2FBB631-2971-11D1-A18C-00C04FD75D13}" /f
REM ;=== Slightly improves RAM management and overall system speed.
Reg.exe add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "1000" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "8" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "2000" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d "1000" /f
REM ;=== Disables unnecessary features present in the Explorer.
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoLowDiskSpaceChecks" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "LinkResolveIgnoreLinkInfo" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveSearch" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveTrack" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoInternetOpenWith" /t REG_DWORD /d "1" /f
REM ;=== Speeds up Shut Down time.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "2000" /f
REM ;=== Disables mouse smoothing and acceleration for a more pleasent mouse experience and aim.
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f
Reg.exe add "HKU\.DEFAULT\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f
Reg.exe add "HKU\.DEFAULT\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f
Reg.exe add "HKU\.DEFAULT\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f
REM ;=== Fixes DPI scaling and blurry windows, text and elements.
Reg.exe add "HKCU\Control Panel\Desktop" /v "Win8DpiScaling" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "DpiScalingVer" /t REG_DWORD /d "4096" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "LogPixels" /t REG_DWORD /d "150" /f
REM ;=== Tweaks to improve privacy and stop Microsoft from collecting your data.
Reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoInstrumentation" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoInstrumentation" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof