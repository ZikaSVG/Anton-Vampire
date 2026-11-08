@echo off
setlocal EnableExtensions
chcp 65001 >nul

net session >nul 2>&1
if not "%errorlevel%"=="0" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs -Wait"
    exit /b
)

call :clean "%LocalAppData%\Microsoft\Windows\WER"
call :clean "%ProgramData%\Microsoft\Windows\WER"

exit /b 0

:clean
set "P=%~1"
if not exist "%P%" exit /b 0
attrib -h -s -r "%P%\*" /s /d >nul 2>&1
del /f /s /q "%P%\*" >nul 2>&1
for /d %%D in ("%P%\*") do rd /s /q "%%~fD" >nul 2>&1
exit /b 0