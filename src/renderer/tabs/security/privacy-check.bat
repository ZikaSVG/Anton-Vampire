@echo off
setlocal EnableDelayedExpansion
title Privacy Audit

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ОШИБКА] Запустите от имени администратора.
    exit /b 1
)

set /a P_PASS=0
set /a P_FAIL=0
set /a C_PASS=0
set /a C_FAIL=0
set /a A_PASS=0
set /a A_FAIL=0

echo.
echo ============================================================
echo   Privacy Audit - анализ исходящих данных
echo ============================================================
echo.

:: ============ ПРИВАТНОСТЬ ============

set "R=?"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry 2^>nul ^| findstr /i "AllowTelemetry"') do set "R=%%a"
if "!R!"=="0x0" (set "S=Passed" & set /a P_PASS+=1) else (set "S=High" & set /a P_FAIL+=1)
call :P "T01" "Телеметрия отключена" "!R!" "0x0" "!S!"

set "R=NOTFOUND"
for /f "tokens=*" %%a in ('sc query DiagTrack 2^>nul ^| findstr /i "STATE"') do (
    echo %%a | findstr /i "STOPPED" >nul && set "R=STOPPED"
    echo %%a | findstr /i "RUNNING" >nul && set "R=RUNNING"
)
if "!R!"=="STOPPED" (set "S=Passed" & set /a P_PASS+=1) else (set "S=High" & set /a P_FAIL+=1)
call :P "T02" "Служба DiagTrack остановлена" "!R!" "STOPPED" "!S!"

set "R=RUNNING"
for /f "tokens=*" %%a in ('sc query dmwappushservice 2^>nul ^| findstr /i "STATE"') do (
    echo %%a | findstr /i "STOPPED" >nul && set "R=STOPPED"
)
if "!R!"=="STOPPED" (set "S=Passed" & set /a P_PASS+=1) else (set "S=Medium" & set /a P_FAIL+=1)
call :P "T03" "Служба WAP Push остановлена" "!R!" "STOPPED" "!S!"

set "R=?"
for /f "tokens=3" %%a in ('reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled 2^>nul ^| findstr /i "Enabled"') do set "R=%%a"
if "!R!"=="0x0" (set "S=Passed" & set /a P_PASS+=1) else (set "S=Medium" & set /a P_FAIL+=1)
call :P "T04" "Рекламный ID отключён" "!R!" "0x0" "!S!"

set "R=?"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v Value 2^>nul ^| findstr /i "Value"') do set "R=%%a"
if /i "!R!"=="Deny" (set "S=Passed" & set /a P_PASS+=1) else (set "S=Medium" & set /a P_FAIL+=1)
call :P "T05" "Доступ к местоположению запрещён" "!R!" "Deny" "!S!"

set "R=?"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana 2^>nul ^| findstr /i "AllowCortana"') do set "R=%%a"
if "!R!"=="0x0" (set "S=Passed" & set /a P_PASS+=1) else (set "S=Medium" & set /a P_FAIL+=1)
call :P "T06" "Cortana отключена" "!R!" "0x0" "!S!"

:: ============ КОНФИДЕНЦИАЛЬНОСТЬ ============

set "R=?"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v AllowClipboardHistory 2^>nul ^| findstr /i "AllowClipboardHistory"') do set "R=%%a"
if "!R!"=="0x0" (set "S=Passed" & set /a C_PASS+=1) else (set "S=High" & set /a C_FAIL+=1)
call :P "T07" "История буфера обмена отключена" "!R!" "0x0" "!S!"

set "R=?"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v AllowCrossDeviceClipboard 2^>nul ^| findstr /i "AllowCrossDeviceClipboard"') do set "R=%%a"
if "!R!"=="0x0" (set "S=Passed" & set /a C_PASS+=1) else (set "S=Medium" & set /a C_FAIL+=1)
call :P "T08" "Синхронизация буфера отключена" "!R!" "0x0" "!S!"

set "R=?"
for /f "tokens=3" %%a in ('reg query "HKCU\SOFTWARE\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v HasAccepted 2^>nul ^| findstr /i "HasAccepted"') do set "R=%%a"
if not "!R!"=="0x1" (set "S=Passed" & set /a C_PASS+=1) else (set "S=Medium" & set /a C_FAIL+=1)
call :P "T09" "Облачное распознавание речи отключено" "!R!" "not 0x1" "!S!"

set "R=?"
for /f "tokens=*" %%a in ('sc query WerSvc 2^>nul ^| findstr /i "STATE"') do (
    echo %%a | findstr /i "STOPPED" >nul && set "R=STOPPED"
    echo %%a | findstr /i "RUNNING" >nul && set "R=RUNNING"
)
if "!R!"=="STOPPED" (set "S=Passed" & set /a C_PASS+=1) else (set "S=Medium" & set /a C_FAIL+=1)
call :P "T10" "Служба отчётов об ошибках остановлена" "!R!" "STOPPED" "!S!"

:: ============ АНОНИМНОСТЬ ============

set "R=NOT_RUNNING"
tasklist /FI "IMAGENAME eq OneDrive.exe" 2>nul | findstr /i "OneDrive.exe" >nul && set "R=RUNNING"
if "!R!"=="NOT_RUNNING" (set "S=Passed" & set /a A_PASS+=1) else (set "S=High" & set /a A_FAIL+=1)
call :P "T11" "OneDrive не запущен" "!R!" "NOT_RUNNING" "!S!"

set "R=NOT_RUNNING"
tasklist /FI "IMAGENAME eq msedge.exe" 2>nul | findstr /i "msedge.exe" >nul && set "R=RUNNING"
if "!R!"=="NOT_RUNNING" (set "S=Passed" & set /a A_PASS+=1) else (set "S=Medium" & set /a A_FAIL+=1)
call :P "T12" "Edge не запущен" "!R!" "NOT_RUNNING" "!S!"

set "R=?"
for /f "tokens=3" %%a in ('reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled 2^>nul ^| findstr /i "BingSearchEnabled"') do set "R=%%a"
if "!R!"=="0x0" (set "S=Passed" & set /a A_PASS+=1) else (set "S=Medium" & set /a A_FAIL+=1)
call :P "T13" "Bing в поиске отключён" "!R!" "0x0" "!S!"

set "R=?"
for /f "tokens=3" %%a in ('reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled 2^>nul ^| findstr /i "GlobalUserDisabled"') do set "R=%%a"
if "!R!"=="0x1" (set "S=Passed" & set /a A_PASS+=1) else (set "S=Medium" & set /a A_FAIL+=1)
call :P "T14" "Фоновые приложения отключены" "!R!" "0x1" "!S!"

:: ============ ИТОГ ============

set /a P_TOTAL=%P_PASS% + %P_FAIL%
set /a C_TOTAL=%C_PASS% + %C_FAIL%
set /a A_TOTAL=%A_PASS% + %A_FAIL%

set /a P_PCT=0
if %P_TOTAL% gtr 0 set /a P_PCT=%P_PASS% * 100 / %P_TOTAL%
set /a C_PCT=0
if %C_TOTAL% gtr 0 set /a C_PCT=%C_PASS% * 100 / %C_TOTAL%
set /a A_PCT=0
if %A_TOTAL% gtr 0 set /a A_PCT=%A_PASS% * 100 / %A_TOTAL%

set /a TOTAL=(%P_PCT% + %C_PCT% + %A_PCT%) / 3

set "GRADE=F"
if %TOTAL% geq 95 set "GRADE=A+"
if %TOTAL% geq 85 if %TOTAL% lss 95 set "GRADE=A"
if %TOTAL% geq 75 if %TOTAL% lss 85 set "GRADE=B"
if %TOTAL% geq 65 if %TOTAL% lss 75 set "GRADE=C"
if %TOTAL% geq 50 if %TOTAL% lss 65 set "GRADE=D"

echo END^|percent=%TOTAL%^|grade=%GRADE%^|privacy=%P_PCT%^|confidential=%C_PCT%^|anonymous=%A_PCT%
exit /b 0

:P
:: %1=id %2=name %3=result %4=expected %5=severity
echo   [%5] %1 %2 — %3 (ожидается %4)
echo ITEM^|%5^|%1^|%2^|%3^|%4
goto :eof