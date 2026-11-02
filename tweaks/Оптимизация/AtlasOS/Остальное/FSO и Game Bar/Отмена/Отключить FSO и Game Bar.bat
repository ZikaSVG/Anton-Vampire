@echo off
reg delete "HKCU\System\GameConfigStore" /v "GameDVR_DSEBehavior" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d 0 /f >nul
reg delete "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 2 /f >nul
reg add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d 0 /f >nul
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "__COMPAT_LAYER" /f >nul 2>&1
reg delete "HKCU\System\GameBar" /v "GamePanelStartupTipIndex" /f >nul 2>&1
reg delete "HKCU\System\GameBar" /v "ShowStartupPanel" /f >nul 2>&1
reg delete "HKCU\System\GameBar" /v "UseNexusForGameBarEnabled" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" /v "ActivationType" /t REG_DWORD /d 1 /f >nul
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 1 /f >nul
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /f >nul 2>&1
