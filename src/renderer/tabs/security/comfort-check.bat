@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul
title Comfort Audit - зеркало безопасности

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ОШИБКА] Запустите от имени администратора.
    pause
    exit /b 1
)

set /a STATS_PASSED=0
set /a STATS_HIGH=0
set /a STATS_TOTAL=0

echo.
echo ============================================================
echo   Comfort Audit — что отключено ради удобства
echo   (зеркало безопасности)
echo ============================================================
echo.

:: Брандмауэр
set "R=ON"
for /f "tokens=2" %%a in ('netsh advfirewall show allprofiles state ^| findstr /i "State"') do (
    if /i "%%a"=="OFF" set "R=OFF"
)
set /a STATS_TOTAL+=1
if "!R!"=="OFF" (set "S=High" & set /a STATS_HIGH+=1) else (set "S=Passed" & set /a STATS_PASSED+=1)
call :C "C1001" "Брандмауэр отключён" "!R!" "OFF" "!S!" "Без брандмауэра другие устройства в сети могут подключаться к ПК"

:: Defender
set "R=True"
for /f "tokens=2 delims=:" %%a in ('powershell -NoProfile -Command "(Get-MpComputerStatus).RealTimeProtectionEnabled" 2^>nul') do (
    set "R=%%a"
    set "R=!R: =!"
)
set /a STATS_TOTAL+=1
if /i "!R!"=="False" (set "S=High" & set /a STATS_HIGH+=1) else (set "S=Passed" & set /a STATS_PASSED+=1)
call :C "C1002" "Defender: real-time отключён" "!R!" "False" "!S!" "ПК работает быстрее, но вирусы запускаются без предупреждения"

:: UAC
set "R=0x1"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA 2^>nul ^| findstr /i "EnableLUA"') do set "R=%%a"
set /a STATS_TOTAL+=1
if "!R!"=="0x0" (set "S=High" & set /a STATS_HIGH+=1) else (set "S=Passed" & set /a STATS_PASSED+=1)
call :C "C1201" "UAC отключён" "!R!" "0x0" "!S!" "Программы запускаются от админа без запроса подтверждения"

:: SmartScreen
set "R=0x1"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableSmartScreen 2^>nul ^| findstr /i "EnableSmartScreen"') do set "R=%%a"
set /a STATS_TOTAL+=1
if "!R!"=="0x0" (set "S=High" & set /a STATS_HIGH+=1) else (set "S=Passed" & set /a STATS_PASSED+=1)
call :C "C1301" "SmartScreen отключён" "!R!" "0x0" "!S!" "Windows не предупреждает о подозрительных программах"

:: DEP
set "R=AlwaysOn"
for /f "tokens=*" %%a in ('bcdedit /enum {current} ^| findstr /i "nx"') do (
    echo %%a | findstr /i "AlwaysOff" >nul && set "R=AlwaysOff"
    echo %%a | findstr /i "OptIn" >nul && set "R=OptIn"
)
set /a STATS_TOTAL+=1
if "!R!"=="AlwaysOn" (set "S=Passed" & set /a STATS_PASSED+=1) else (set "S=High" & set /a STATS_HIGH+=1)
call :C "C1501" "DEP отключён" "!R!" "AlwaysOn" "!S!" "Эксплойты могут исполнять код в областях памяти для данных"

:: ASLR
set "R=0x1"
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v MoveImages 2^>nul ^| findstr /i "MoveImages"') do set "R=%%a"
set /a STATS_TOTAL+=1
if "!R!"=="0x0" (set "S=High" & set /a STATS_HIGH+=1) else (set "S=Passed" & set /a STATS_PASSED+=1)
call :C "C1502" "ASLR отключён" "!R!" "0x0" "!S!" "Эксплойтам проще — они знают, куда прыгать"

:: LSA Protection
set "R=0x1"
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v RunAsPPL 2^>nul ^| findstr /i "RunAsPPL"') do set "R=%%a"
set /a STATS_TOTAL+=1
if "!R!"=="0x0" (set "S=High" & set /a STATS_HIGH+=1) else (set "S=Passed" & set /a STATS_PASSED+=1)
call :C "C1503" "LSA Protection отключена" "!R!" "0x0" "!S!" "Память lsass.exe можно прочитать и вытащить пароли"

:: SMBv1
set "R=False"
for /f "tokens=2 delims=:" %%a in ('powershell -NoProfile -Command "(Get-SmbServerConfiguration).EnableSMB1Protocol" 2^>nul') do (
    set "R=%%a"
    set "R=!R: =!"
)
set /a STATS_TOTAL+=1
if /i "!R!"=="True" (set "S=High" & set /a STATS_HIGH+=1) else (set "S=Passed" & set /a STATS_PASSED+=1)
call :C "C1504" "SMBv1 включён" "!R!" "False" "!S!" "Старый уязвимый протокол — открытая дверь для вирусов"

:: Autorun
set "R=0xff"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun 2^>nul ^| findstr /i "NoDriveTypeAutoRun"') do set "R=%%a"
set /a STATS_TOTAL+=1
if /i not "!R!"=="0xff" (set "S=High" & set /a STATS_HIGH+=1) else (set "S=Passed" & set /a STATS_PASSED+=1)
call :C "C1505" "Автозапуск включён" "!R!" "0xff" "!S!" "Флешки могут запустить вирус автоматически"

:: LLMNR
set "R=0x0"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v EnableMulticast 2^>nul ^| findstr /i "EnableMulticast"') do set "R=%%a"
set /a STATS_TOTAL+=1
if /i not "!R!"=="0x0" (set "S=High" & set /a STATS_HIGH+=1) else (set "S=Passed" & set /a STATS_PASSED+=1)
call :C "C1506" "LLMNR включён" "!R!" "0x0" "!S!" "Злоумышленник может перехватить имена хостов в локальной сети"

:: RemoteRegistry
set "R=DISABLED"
for /f "tokens=3" %%a in ('sc qc RemoteRegistry 2^>nul ^| findstr /i "START_TYPE"') do (
    if /i not "%%a"=="4" set "R=ENABLED"
)
set /a STATS_TOTAL+=1
if "!R!"=="ENABLED" (set "S=High" & set /a STATS_HIGH+=1) else (set "S=Passed" & set /a STATS_PASSED+=1)
call :C "C1507" "Служба удалённого реестра включена" "!R!" "DISABLED" "!S!" "По сети можно менять реестр"

:: PowerShell v2
set "R=Disabled"
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "(Get-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root).State" 2^>nul') do set "R=%%a"
set /a STATS_TOTAL+=1
if /i "!R!"=="Enabled" (set "S=High" & set /a STATS_HIGH+=1) else (set "S=Passed" & set /a STATS_PASSED+=1)
call :C "C1508" "PowerShell v2 включён" "!R!" "Disabled" "!S!" "Старые атаки всё ещё работают"

:: WDigest
set "R=0x0"
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" /v UseLogonCredential 2^>nul ^| findstr /i "UseLogonCredential"') do set "R=%%a"
set /a STATS_TOTAL+=1
if /i not "!R!"=="0x0" (set "S=High" & set /a STATS_HIGH+=1) else (set "S=Passed" & set /a STATS_PASSED+=1)
call :C "C1509" "WDigest включён" "!R!" "0x0" "!S!" "Пароли хранятся в открытом виде в памяти"

:: ============ ИТОГ ============
set /a PERCENT=%STATS_HIGH% * 100 / %STATS_TOTAL%

set "GRADE=F"
if %PERCENT% geq 95 set "GRADE=A+"
if %PERCENT% geq 85 if %PERCENT% lss 95 set "GRADE=A"
if %PERCENT% geq 75 if %PERCENT% lss 85 set "GRADE=B"
if %PERCENT% geq 65 if %PERCENT% lss 75 set "GRADE=C"
if %PERCENT% geq 50 if %PERCENT% lss 65 set "GRADE=D"

echo.
echo ============================================================
echo   ИТОГ УДОБСТВА
echo ============================================================
echo   Отключено защит: %STATS_HIGH% из %STATS_TOTAL%
echo   Уровень удобства: %PERCENT%%% (%GRADE%)
echo ============================================================
echo.

echo END^|percent=%PERCENT%^|grade=%GRADE%^|passed=%STATS_HIGH%^|high=%STATS_PASSED%^|total=%STATS_TOTAL%
exit /b 0

:C
echo   [%6] %1 %2 — %4 (ожидается %5)
echo ITEM^|%6^|%1^|%2^|%4^|%5
echo DESC^|%1^|%7
goto :eof