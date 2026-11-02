@echo off
reg add "HKCU\Control Panel\Cursors" /v "GestureVisualization" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Cursors" /v "ContactVisualization" /t REG_DWORD /d 0 /f >nul 2>&1
