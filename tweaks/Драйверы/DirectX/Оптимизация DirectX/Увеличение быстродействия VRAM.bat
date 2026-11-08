@echo off
@echo.
@echo t.me/DE3NAKE
@echo.

::Увеличить объем буфера VRAM
reg add "HKLM\SOFTWARE\Microsoft\DirectDraw" /v "VGABuffer" /t reg_DWORD /d "21181233" /f
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\DirectDraw" /v "VGABuffer" /t reg_DWORD /d "21181233" /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "VGABuffer" /t reg_DWORD /d "21181233" /f
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Direct3D" /v "VGABuffer" /t reg_DWORD /d "21181233" /f
reg add "HKLM\SOFTWARE\Microsoft\DirectMusic" /v "VGABuffer" /t reg_DWORD /d "21181233" /f
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\DirectMusic" /v "VGABuffer" /t reg_DWORD /d "21181233" /f

pause
exit