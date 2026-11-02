@echo off
title Made By: Igromanoff
cls
chcp 65001 >nul
mode con cols=80 lines=25
color f
:Main
echo.
echo [95m
echo		╔─────────────────────────────────────────────────────────────╗
echo		│      ____                                         ___ ___   │
echo		│     /  _/___ _ ____ ___   __ _  ___ _ ___  ___   / _// _/   │
echo		│    _/ / / _ `// __// _ \ /  ' \/ _ `// _ \/ _ \ / _// _/    │
echo		│   /___/ \_, //_/   \___//_/_/_/\_,_//_//_/\___//_/ /_/      │
echo		│        /___/                                                │
echo		│                                                             │
echo		╚─────────────────────────────────────────────────────────────╝
echo					   [33mVersion 1.0
echo			[38;5;63m╔═══════════════════════════════════════════════╗[38;5;63m
echo			║            [35mMade By: [95mIgromanoff               [38;5;63m ║
echo			║    ↓ Видео обучение на моём ютуб канале ↓     ║
echo			║         [31mwww.youtube.com/@Igromanoff[38;5;31m           ║[38;5;63m
echo			[38;5;63m╚═══════════════════════════════════════════════╝[38;5;63m 
echo		        [38;5;63m╔═══════════════════════════════════════════════╗[38;5;63m 
echo		         [38;5;63m[1] - [92mWindows Исправить[92m  [38;5;63m[2] - [92mNVIDIA Исправить[92m      
echo		       [38;5;63m ╚═══════════════════════════════════════════════╝[38;5;63m 
set /p input=%BS% [95m             ➤ [95m
if /I %input% EQU 1 goto :WinTweaks
if /I %input% EQU 2 goto :NVIDIATweaks
if /I %input% EQU 3 goto :NetworkTweak
if /I %input% EQU 4 goto :MouseTweaks
if /I %input% EQU 5 goto :AMDTweaks
if /I %input% EQU 6 goto :PowerPlan
if /I %input% EQU 0 goto :youtube
:WinTweaks
reg add "HKLM\System\CurrentControlSet\Services\Appinfo" /v "Start" /t REG_DWORD /d "3" /f >NUL 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableVirtualization" /t REG_DWORD /d "1" /f >NUL 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableInstallerDetection" /t REG_DWORD /d "1" /f >NUL 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "1" /f >NUL 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "1" /f >NUL 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableSecureUIAPaths" /t REG_DWORD /d "1" /f >NUL 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "5" /f >NUL 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ValidateAdminCodeSignatures" /t REG_DWORD /d "1" /f >NUL 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableUIADesktopToggle" /t REG_DWORD /d "1" /f >NUL 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorUser" /t REG_DWORD /d "3" /f >NUL 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "FilterAdministratorToken" /t REG_DWORD /d "1" /f >NUL 2>&1
cls
goto :Main
:NVIDIATweaks
echo.
set /p guid=[95m             ➤ Вставте свой класс GUID ➤ 
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "RMBandwidthFeature" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "RMBandwidthFeature2" /t REG_DWORD /d "0" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0001" /v "RMBandwidthFeature" /t REG_DWORD /d "0" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0001" /v "RMBandwidthFeature2" /t REG_DWORD /d "0" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "RMElcg" /t REG_DWORD /d "0" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "RMBlcg" /t REG_DWORD /d "0" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "RMElpg" /t REG_DWORD /d "0" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "RMSlcg" /t REG_DWORD /d "0" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "RMFspg" /t REG_DWORD /d "0" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "RmLogonRC" /t REG_DWORD /d "0" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "RMLpwrArch" /t REG_DWORD /d "0" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "RmLpwrCtrlGrRgParameters" /t REG_DWORD /d "0" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "RMLpwrEiClient" /t REG_DWORD /d "0" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "RmMIONoPowerOff" /t REG_DWORD /d "0" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "RMDeepL1EntryLatencyUsec" /t REG_DWORD /d "0" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "D3PCLatency" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "F1TransitionLatency" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "LOWLATENCY" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "Node3DLowLatency" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "PciLatencyTimerControl" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "RMDeepL1EntryLatencyUsec" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "RmGspcMaxFtuS" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "RmGspcMinFtuS" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "RmGspcPerioduS" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "RMLpwrEiIdleThresholdUs" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "RMLpwrGrIdleThresholdUs" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "RMLpwrGrRgIdleThresholdUs" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "RMLpwrMsIdleThresholdUs" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "VRDirectFlipDPCDelayUs" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "VRDirectFlipTimingMarginUs" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "VRDirectJITFlipMsHybridFlipDelayUs" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "vrrCursorMarginUs" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "vrrDeflickerMarginUs" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%guid%\0000" /v "vrrDeflickerMaxUs" /t REG_DWORD /d "0" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InterruptSteeringDisabled" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighPerformance" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HighestPerformance" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MinimumThrottlePercent" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumThrottlePercent" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaximumPerformancePercent" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitialUnparkCount" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceMemory" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContext" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceOther" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultLatencyToleranceTimerPeriod" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MiracastPerfTrackGraphicsLatency" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorLatencyTolerance" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MonitorRefreshLatencyTolerance" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "TransitionLatency" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnablePreemption" /f
cls
goto :Main