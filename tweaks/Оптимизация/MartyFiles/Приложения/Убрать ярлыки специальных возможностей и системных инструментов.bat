@echo off
rd "%AppData%\Microsoft\Windows\Start Menu\Programs\Accessibility" /Q /S >nul 2>&1
rd "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Accessories\System Tools" /Q /S >nul 2>&1
