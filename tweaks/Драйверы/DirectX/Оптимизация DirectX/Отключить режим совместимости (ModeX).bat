@echo off
@echo.
@echo t.me/DE3NAKE
@echo.

::Отключить режим совместимости (ModeX) для старых EGA-видеокарт
reg add "HKLM\SOFTWARE\Microsoft\DirectDraw" /v "ModeXOnly" /t reg_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\DirectDraw" /v "ModeXOnly" /t reg_DWORD /d "0" /f

pause
exit