@echo off
SETLOCAL EnableDelayedExpansion
:getusbaffinity
set CPUCORES=%NUMBER_OF_PROCESSORS%
set /a CPUCORES=%CPUCORES% - 1
set "output="
for /L %%a in (0 1 %CPUCORES%) do set "output=!output! %%a"
echo.
echo BY AMITXV
echo.
echo  ਯ 㡥 । ⮪  ॡ⥫ ᮢ.
echo.
echo ४ ⠢ ⮪  ஬ ࠡ⠥ USB  .
echo.
echo ਬ: ⠢ 1         ⮪ ஬ 1.
echo.
echo  : !output:~1!
echo.
set /p affinity=" ⮪   ᮢ?: "
if defined affinity (
  set affinity=%affinity: =%
) else goto invalidusb
if %affinity% GTR %CPUCORES% goto invalidusb
if %affinity% LEQ %CPUCORES% cls & goto readusbaffinity
:invalidusb
cls
echo 訡, ஡  ࠧ.
echo.
goto getusbaffinity
:readusbaffinity
set CPUCORES=%NUMBER_OF_PROCESSORS%
set /a "mask_dec=1<<affinity"
set "bin="
for /L %%A in (1,1,32) do (
    set /a "bit=mask_dec&1, mask_dec>>=1"
    set bin=!bit!!bin!
)
set mask=!bin:~-%cpucores%!
set "inverted=%mask:1=#%"
set "inverted=%inverted:0=1%"
set "inverted=%inverted:#=0%"
set binaryaffinity=%inverted%
:START
IF     "binaryaffinity"=="" GOTO START
IF NOT "%~2"=="" GOTO START
ECHO "%binaryaffinity%"| FINDSTR /R /B /C:"\"[01][01]*\"$" >NUL || GOTO START
SET Binary=%binaryaffinity%
SET Decimal=0
SET DigVal=1
:LOOP
IF %Binary% GTR 1 (
	SET Digit=%Binary:~-1%
	SET Binary=%Binary:~0,-1%
) ELSE (
	SET /A Digit = %Binary%
	SET Binary=0
)
IF %Digit% EQU 1 SET /A Decimal = %Decimal% + %DigVal%
SET /A DigVal *= 2
IF %Binary% GTR 0 GOTO LOOP
SET Binary=
SET Digit=
SET DigVal=
cls
>> "C:\Program Files\startupoptimizer\startup.bat" echo set affinity=%Decimal%
cls
timeout t 2 > NUL 2>&1
start "" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\startup.lnk"
cls
echo ᯥ譮!