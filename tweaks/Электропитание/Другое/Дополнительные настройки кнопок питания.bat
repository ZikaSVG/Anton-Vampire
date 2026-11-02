@Echo Off
Title Reg Converter v1.1 & Color 1A
cd %systemroot%\system32
call :IsAdmin
REM ; t.me/DE3NAKE
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\4f971e89-eebd-4455-a8de-9e59040e7347\833a6b62-dfa4-46d1-82f8-e09e34d029d6" /v "Attributes" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof