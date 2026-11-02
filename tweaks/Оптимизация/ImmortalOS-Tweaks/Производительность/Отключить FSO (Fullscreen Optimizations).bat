@echo off
chcp 65001 >nul 2>&1

net session >nul 2>&1
if %errorLevel% neq 0 exit /b 1

reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "2" /f >nul 2>&1

exit /b 0
