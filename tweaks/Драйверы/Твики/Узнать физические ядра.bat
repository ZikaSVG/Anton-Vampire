@echo off
SETLOCAL EnableDelayedExpansion
echo Made by ios1ph
echo.
echo.
for /F "tokens=* skip=1" %%a in ('wmic cpu get NumberOfCores ^| findstr "."') do set /a CPUCORES=%%a
if %NUMBER_OF_PROCESSORS% LEQ %CPUCORES% (goto htoff)
if %NUMBER_OF_PROCESSORS% GTR %CPUCORES% (goto hton)
)

:hton
echo Твои физические ядра под номерами:
set CPUCORES=%NUMBER_OF_PROCESSORS%
set /a CPUCORES=%CPUCORES% - 1
set "output="
for /L %%a in (0 2 %CPUCORES%) do set "output=!output! %%a"
echo !output:~1!
goto end

:htoff
echo Твои физические ядра под номерами:
set CPUCORES=%NUMBER_OF_PROCESSORS%
set /a CPUCORES=%CPUCORES% - 1
set "output="
for /L %%a in (0 1 %CPUCORES%) do set "output=!output! %%a"
echo !output:~1!
goto end

:end
echo.
echo.
pause

