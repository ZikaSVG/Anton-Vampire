@echo off
@echo.
@echo t.me/DE3NAKE
@echo.

::Включить дополнительные библиотеки DirectX
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDP2" /t reg_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Direct3D" /v "DisableDP2" /t reg_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "D3DXDoNotMute" /t reg_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Direct3D" /v "D3DXDoNotMute" /t reg_DWORD /d "1" /f

pause
exit