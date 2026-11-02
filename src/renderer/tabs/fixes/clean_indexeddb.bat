@echo off
setlocal EnableExtensions
chcp 65001 >nul

net session >nul 2>&1
if not "%errorlevel%"=="0" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs -Wait"
    exit /b
)

call :clean "%LocalAppData%\Yandex\YandexBrowser\User Data"
call :clean "%LocalAppData%\Google\Chrome\User Data"
call :clean "%LocalAppData%\Microsoft\Edge\User Data"

exit /b 0

:clean
set "BASE=%~1"
if not exist "%BASE%" exit /b 0

if exist "%BASE%\Default\IndexedDB" (
    attrib -h -s -r "%BASE%\Default\IndexedDB\*" /s /d >nul 2>&1
    del /f /s /q "%BASE%\Default\IndexedDB\*" >nul 2>&1
    for /d %%D in ("%BASE%\Default\IndexedDB\*") do rd /s /q "%%~fD" >nul 2>&1
)

for /d %%P in ("%BASE%\Profile *") do (
    if exist "%%~fP\IndexedDB" (
        attrib -h -s -r "%%~fP\IndexedDB\*" /s /d >nul 2>&1
        del /f /s /q "%%~fP\IndexedDB\*" >nul 2>&1
        for /d %%D in ("%%~fP\IndexedDB\*") do rd /s /q "%%~fD" >nul 2>&1
    )
)
exit /b 0