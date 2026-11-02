@Echo Off
Title Reg Converter v1.1 & Color 1A
cd %systemroot%\system32
call :IsAdmin
REM ; Besplatno! from Reborn PC Optimization (RU) - https://discord.gg/hgBQRsrDRu
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "1" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof