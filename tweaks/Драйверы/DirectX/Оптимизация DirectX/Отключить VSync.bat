@echo off
@echo.
@echo t.me/DE3NAKE
@echo.

::Отключить VSync
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "FlipNoVsync" /t reg_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Direct3D" /v "FlipNoVsync" /t reg_DWORD /d "1" /f

pause
exit