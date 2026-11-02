@echo off
@echo.
@echo t.me/DE3NAKE
@echo.

::Включить аппаратное ускорение обработки поверхностей (DDSCAPS)
reg add "HKLM\SOFTWARE\Microsoft\DirectDraw" /v "DisableDDSCAPSInDDSD" /t reg_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\DirectDraw" /v "DisableDDSCAPSInDDSD" /t reg_DWORD /d "0" /f

::Включить аппаратное ускорение DirectDraw
reg add "HKLM\SOFTWARE\Microsoft\DirectDraw" /v "EmulationOnly" /t reg_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\DirectDraw" /v "EmulationOnly" /t reg_DWORD /d "0" /f

::Включить аппаратное ускорение для Midi
reg add "HKLM\SOFTWARE\Microsoft\DirectMusic" /v "DisableHWAcceleration" /t reg_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\DirectMusic" /v "DisableHWAcceleration" /t reg_DWORD /d "0" /f

::Включить аппаратное ускорение для отрисовки точечных объектов
reg add "HKLM\SOFTWARE\Microsoft\DirectDraw" /v "EmulatePointSprites" /t reg_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\DirectDraw" /v "EmulatePointSprites" /t reg_DWORD /d "0" /f

::Включить аппаратные средства растеризации
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\Drivers" /v "ForceRgbRasterizer" /t reg_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Direct3D\Drivers" /v "ForceRgbRasterizer" /t reg_DWORD /d "0" /f

::Включить обработку stateblocks видеодрайвером
reg add "HKLM\SOFTWARE\Microsoft\DirectDraw" /v "EmulateStateBlocks" /t reg_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\DirectDraw" /v "EmulateStateBlocks" /t reg_DWORD /d "0" /f

pause
exit