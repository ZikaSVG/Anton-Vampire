@echo off
reg delete "HKCU\Control Panel\Cursors" /v "GestureVisualization" /f >nul 2>&1
reg delete "HKCU\Control Panel\Cursors" /v "ContactVisualization" /f >nul 2>&1
