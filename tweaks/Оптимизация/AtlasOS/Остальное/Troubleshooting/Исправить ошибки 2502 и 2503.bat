@echo off
takeown /f "%windir%\Temp" /r /d y >nul
icacls "%windir%\Temp" /inheritance:e >nul
icacls "%windir%\Temp" /reset >nul
icacls "%windir%\Temp" /inheritance:r >nul
icacls "%windir%\Temp" /grant:r "*S-1-5-32-545:(OI)(CI)F" /grant:r "*S-1-5-18:(OI)(CI)F" /grant:r "*S-1-3-0:(OI)(CI)F" /grant:r "*S-1-5-11:(OI)(CI)(X,AD,WD)" /t >nul
del /s /f /q "%windir%\Temp\*.*" >nul 2>&1
