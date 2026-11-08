@echo off
reg delete "HKCU\Control Panel\Desktop" /v "FontSmoothing" /f >nul 2>&1
reg delete "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /f >nul 2>&1
reg delete "HKCU\Control Panel\Desktop" /v "DragFullWindows" /f >nul 2>&1
reg delete "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "IconsOnly" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewShadow" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableAeroPeek" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "AlwaysHibernateThumbnails" /f >nul 2>&1
