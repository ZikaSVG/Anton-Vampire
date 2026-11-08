@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключение выбранных служб
net session >nul 2>&1 || (
echo [!] Запустите от имени администратора.
pause & exit /b 1
)
if "%~1"=="" (
echo [ERROR] Не передан список служб.
echo Использование: %~nx0 "Svc1,Svc2,Svc3"
pause & exit /b 1
)
set "LIST=%~1"
set "COUNT=0"
echo [!] Отключение выбранных служб...
echo.
:loop
if "!LIST!"=="" goto :done
for /f "tokens=1* delims=," %%A in ("!LIST!") do (
    set "SVC=%%A"
    set "LIST=%%B"
)
if "!SVC!"=="" goto :done
set "SVC=!SVC: =!"
if "!SVC!"=="" goto :loop

echo [^>] Отключение: !SVC!
sc stop "!SVC!" >nul 2>&1
sc config "!SVC!" start= disabled >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\!SVC!" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
set /a COUNT+=1
goto :loop

:done
echo.
echo [OK] Успешно отключено: !COUNT! служб.
endlocal