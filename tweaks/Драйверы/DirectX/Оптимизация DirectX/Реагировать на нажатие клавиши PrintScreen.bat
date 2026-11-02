@echo off
@echo.
@echo t.me/DE3NAKE
@echo.

::Реагировать на нажатие клавиши PrintScreen
reg add "HKLM\SOFTWARE\Microsoft\DirectDraw" /v "EnablePrintScreen" /t reg_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\DirectDraw" /v "EnablePrintScreen" /t reg_DWORD /d "1" /f

pause
exit