@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Массовое включение служб
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
echo [!] Массовое включение служб...
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

echo [^>] Включение: !SVC!
reg add "HKLM\SYSTEM\CurrentControlSet\Services\!SVC!" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
sc config "!SVC!" start= demand >nul 2>&1
sc start "!SVC!" >nul 2>&1
set /a COUNT+=1
goto :loop

:done
echo.
echo [OK] Успешно включено: !COUNT! служб.
endlocal