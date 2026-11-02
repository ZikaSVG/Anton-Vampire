@echo off
chcp 65001 >nul
title Диагностика системы
echo ============================================================
echo   СИСТЕМНАЯ ДИАГНОСТИКА
echo ============================================================
echo.

for /f "tokens=2 delims==" %%a in ('wmic cpu get name /value 2^>nul') do (
    for /f "delims=" %%b in ("%%a") do echo CPU: %%b
)
for /f "tokens=2 delims==" %%a in ('wmic path win32_videocontroller get name /value 2^>nul') do (
    for /f "delims=" %%b in ("%%a") do echo GPU: %%b
)

set "ram=0"
for /f "tokens=2 delims==" %%a in ('wmic OS get TotalVisibleMemorySize /Value 2^>nul') do (
    for /f "tokens=1" %%b in ("%%a") do set "ram=%%b"
)
set /a ram_gb=ram/1048576 2>nul
echo ОЗУ: %ram_gb% ГБ

set "cpuload=0"
for /f "tokens=2 delims==" %%a in ('wmic cpu get loadpercentage /value 2^>nul') do (
    for /f "tokens=1" %%b in ("%%a") do set "cpuload=%%b"
)
if "%cpuload%"=="" set "cpuload=0"
echo Загрузка CPU: %cpuload%%%
if %cpuload% GTR 70 (echo [!] Процессор нагружен фоновыми задачами) else (echo [OK] Нагрузка в норме)

echo.
echo --- SMART дисков ---
wmic diskdrive get model,status 2>nul

echo.
echo --- Последние 5 критических ошибок ---
wevtutil qe System /c:5 /f:text /q:"*[System[(Level=1 or Level=2)]]" 2>nul

echo.
echo Готово.