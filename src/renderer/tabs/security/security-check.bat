@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul
title HardeningPack - Проверка уровня защиты

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ОШИБКА] Запустите от имени администратора.
    pause
    exit /b 1
)

set /a STATS_PASSED=0
set /a STATS_LOW=0
set /a STATS_MEDIUM=0
set /a STATS_HIGH=0
set /a STATS_TOTAL=0

echo.
echo ============================================================
echo   HardeningPack - Проверка уровня защиты
echo ============================================================
echo.
echo   Идёт проверка системы...
echo.

:: БРАНДМАУЭР
set "R=OFF"
for /f "tokens=2" %%a in ('netsh advfirewall show allprofiles state ^| findstr /i "State"') do (
    if /i "%%a"=="ON" set "R=ON"
)
if "!R!"=="ON" (set "S=Passed") else (set "S=High")
call :AddStat !S!
call :Print "1001" "Брандмауэр включён" "!R!" "ON" "!S!"

:: ВХОДЯЩИЕ БЛОКИРУЮТСЯ
set "R=Allow"
for /f "tokens=*" %%a in ('netsh advfirewall show allprofiles firewallpolicy ^| findstr /i "Inbound"') do (
    echo %%a | findstr /i "Block" >nul && set "R=Block"
)
if "!R!"=="Block" (set "S=Passed") else (set "S=Medium")
call :AddStat !S!
call :Print "1002" "Брандмауэр: входящие блокируются" "!R!" "Block" "!S!"

:: DEFENDER
set "R=False"
for /f "tokens=2 delims=:" %%a in ('powershell -NoProfile -Command "(Get-MpComputerStatus).RealTimeProtectionEnabled" 2^>nul') do (
    set "R=%%a"
    set "R=!R: =!"
)
if /i "!R!"=="True" (set "S=Passed") else (set "S=High")
call :AddStat !S!
call :Print "1101" "Defender: защита в реальном времени" "!R!" "True" "!S!"

:: UAC
set "R=0x0"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA 2^>nul ^| findstr /i "EnableLUA"') do set "R=%%a"
if "!R!"=="0x1" (set "S=Passed") else (set "S=High")
call :AddStat !S!
call :Print "1201" "UAC включён" "!R!" "0x1" "!S!"

:: BITLOCKER
set "R=Off"
for /f "tokens=*" %%a in ('manage-bde -status %SystemDrive% 2^>nul ^| findstr /i "Protection"') do (
    echo %%a | findstr /i "On" >nul && set "R=On"
)
if "!R!"=="On" (set "S=Passed") else (set "S=High")
call :AddStat !S!
call :Print "1301" "BitLocker на системном диске" "!R!" "On" "!S!"

:: SMBv1
set "R=True"
for /f "tokens=2 delims=:" %%a in ('powershell -NoProfile -Command "(Get-SmbServerConfiguration).EnableSMB1Protocol" 2^>nul') do (
    set "R=%%a"
    set "R=!R: =!"
)
if /i "!R!"=="False" (set "S=Passed") else (set "S=High")
call :AddStat !S!
call :Print "1401" "SMBv1 отключён" "!R!" "False" "!S!"

:: SMB-ПОДПИСЬ
set "R=False"
for /f "tokens=2 delims=:" %%a in ('powershell -NoProfile -Command "(Get-SmbServerConfiguration).RequireSecuritySignature" 2^>nul') do (
    set "R=%%a"
    set "R=!R: =!"
)
if /i "!R!"=="True" (set "S=Passed") else (set "S=Medium")
call :AddStat !S!
call :Print "1402" "SMB-подпись обязательна" "!R!" "True" "!S!"

:: MIN PASSWORD LENGTH
set "R=0"
for /f "tokens=*" %%a in ('net accounts ^| findstr /i "Minimum password length"') do (
    for /f "tokens=2 delims=:" %%b in ("%%a") do (
        set "R=%%b"
        set "R=!R: =!"
    )
)
set /a R_INT=!R! 2>nul
if !R_INT! geq 14 (set "S=Passed") else (set "S=Medium")
call :AddStat !S!
call :Print "1501" "Минимальная длина пароля" "!R!" "14" "!S!"

:: LOCKOUT THRESHOLD
set "R=0"
for /f "tokens=*" %%a in ('net accounts ^| findstr /i "Lockout threshold"') do (
    for /f "tokens=2 delims=:" %%b in ("%%a") do (
        set "R=%%b"
        set "R=!R: =!"
    )
)
set /a R_INT=!R! 2>nul
if !R_INT! leq 5 (set "S=Passed") else (set "S=Medium")
call :AddStat !S!
call :Print "1502" "Порог блокировки учётной записи" "!R!" "5" "!S!"

:: MAX PASSWORD AGE
set "R=0"
for /f "tokens=*" %%a in ('net accounts ^| findstr /i "Maximum password age"') do (
    for /f "tokens=2 delims=:" %%b in ("%%a") do (
        set "R=%%b"
        set "R=!R: =!"
    )
)
set /a R_INT=!R! 2>nul
if !R_INT! leq 365 (set "S=Passed") else (set "S=Low")
call :AddStat !S!
call :Print "1503" "Максимальный срок действия пароля" "!R!" "365" "!S!"

:: AUTORUN
set "R=0x0"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun 2^>nul ^| findstr /i "NoDriveTypeAutoRun"') do set "R=%%a"
if /i "!R!"=="0xff" (set "S=Passed") else (set "S=Low")
call :AddStat !S!
call :Print "1601" "Автозапуск отключён" "!R!" "0xff" "!S!"

:: WDIGEST
set "R=0x1"
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" /v UseLogonCredential 2^>nul ^| findstr /i "UseLogonCredential"') do set "R=%%a"
if "!R!"=="0x0" (set "S=Passed") else (set "S=High")
call :AddStat !S!
call :Print "1701" "WDigest отключён" "!R!" "0x0" "!S!"

:: LSA PROTECTION
set "R=0x0"
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v RunAsPPL 2^>nul ^| findstr /i "RunAsPPL"') do set "R=%%a"
if "!R!"=="0x1" (set "S=Passed") else (set "S=High")
call :AddStat !S!
call :Print "1702" "LSA Protection включён" "!R!" "0x1" "!S!"

:: LLMNR
set "R=0x1"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v EnableMulticast 2^>nul ^| findstr /i "EnableMulticast"') do set "R=%%a"
if "!R!"=="0x0" (set "S=Passed") else (set "S=Medium")
call :AddStat !S!
call :Print "1801" "LLMNR отключён" "!R!" "0x0" "!S!"

:: REMOTE REGISTRY
set "R=ENABLED"
for /f "tokens=3" %%a in ('sc qc RemoteRegistry 2^>nul ^| findstr /i "START_TYPE"') do (
    if /i "%%a"=="4" (set "R=DISABLED")
)
if "!R!"=="DISABLED" (set "S=Passed") else (set "S=Medium")
call :AddStat !S!
call :Print "1802" "Служба Remote Registry отключена" "!R!" "DISABLED" "!S!"

:: POWERSHELL V2
set "R=Unknown"
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "(Get-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root).State" 2^>nul') do set "R=%%a"
if /i "!R!"=="Disabled" (set "S=Passed") else (set "S=Low")
call :AddStat !S!
call :Print "1803" "PowerShell v2 отключён" "!R!" "Disabled" "!S!"

:: DEP
set "R=Unknown"
for /f "tokens=*" %%a in ('bcdedit /enum {current} ^| findstr /i "nx"') do (
    echo %%a | findstr /i "AlwaysOn" >nul && set "R=AlwaysOn"
)
if "!R!"=="AlwaysOn" (set "S=Passed") else (set "S=Medium")
call :AddStat !S!
call :Print "1901" "DEP (Data Execution Prevention)" "!R!" "AlwaysOn" "!S!"

:: ASLR
set "R=0x0"
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v MoveImages 2^>nul ^| findstr /i "MoveImages"') do set "R=%%a"
if "!R!"=="0x1" (set "S=Passed") else (set "S=Medium")
call :AddStat !S!
call :Print "1902" "ASLR включён" "!R!" "0x1" "!S!"

:: SMARTSCREEN
set "R=0x0"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableSmartScreen 2^>nul ^| findstr /i "EnableSmartScreen"') do set "R=%%a"
if "!R!"=="0x1" (set "S=Passed") else (set "S=Medium")
call :AddStat !S!
call :Print "1903" "SmartScreen включён" "!R!" "0x1" "!S!"

:: SMB ANON
set "R=0x0"
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v RestrictNullSessAccess 2^>nul ^| findstr /i "RestrictNullSessAccess"') do set "R=%%a"
if "!R!"=="0x1" (set "S=Passed") else (set "S=Medium")
call :AddStat !S!
call :Print "2001" "Анонимный доступ к SMB запрещён" "!R!" "0x1" "!S!"

:: SMB GUEST
set "R=0x1"
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v AllowInsecureGuestAuth 2^>nul ^| findstr /i "AllowInsecureGuestAuth"') do set "R=%%a"
if "!R!"=="0x0" (set "S=Passed") else (set "S=Medium")
call :AddStat !S!
call :Print "2002" "Гостевая SMB-аутентификация запрещена" "!R!" "0x0" "!S!"

:: NETBIOS
set "R=0"
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "(Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object {$_.IPEnabled -eq $true} | Select-Object -First 1).TcpipNetbiosOptions" 2^>nul') do set "R=%%a"
if "!R!"=="2" (set "S=Passed") else (set "S=Low")
call :AddStat !S!
call :Print "2003" "NetBIOS over TCP/IP отключён" "!R!" "2" "!S!"

:: ПОДСЧЁТ
set /a TOTAL_POINTS=%STATS_TOTAL% * 4
set /a ACHIEVED=%STATS_PASSED% * 4 + %STATS_LOW% * 2 + %STATS_MEDIUM%

if %TOTAL_POINTS% equ 0 (
    set "SCORE=1.00"
    set "PERCENT=0"
    goto :show
)

set /a PERCENT=%ACHIEVED% * 100 / %TOTAL_POINTS%
set /a SCORE_X100=(ACHIEVED * 100 * 5) / TOTAL_POINTS + 100
set /a SCORE_INT=%SCORE_X100% / 100
set /a SCORE_FRAC=%SCORE_X100% %% 100

if %STATS_PASSED% equ 0 set "SCORE_X100=100"

if %SCORE_FRAC% lss 10 (
    set "SCORE=%SCORE_INT%.0%SCORE_FRAC%"
) else (
    set "SCORE=%SCORE_INT%.%SCORE_FRAC%"
)

:show
if %STATS_PASSED% equ 0 (
    set "SCORE=1.00"
    set /a PERCENT=0
)

set /a SCORE_ROUND=%SCORE_INT%
if %SCORE_FRAC% geq 50 set /a SCORE_ROUND+=1

set "GRADE=Bogus"
if %SCORE_ROUND% geq 6 set "GRADE=Excellent"
if %SCORE_ROUND% equ 5 set "GRADE=Well done"
if %SCORE_ROUND% equ 4 set "GRADE=Sufficient"
if %SCORE_ROUND% equ 3 set "GRADE=You should do better"
if %SCORE_ROUND% equ 2 set "GRADE=Weak"

echo.
echo END^|passed=%STATS_PASSED%^|low=%STATS_LOW%^|medium=%STATS_MEDIUM%^|high=%STATS_HIGH%^|total=%STATS_TOTAL%^|score=%SCORE%^|percent=%PERCENT%^|grade=%GRADE%
exit /b 0

:AddStat
set /a STATS_TOTAL+=1
if /i "%~1"=="Passed" set /a STATS_PASSED+=1
if /i "%~1"=="Low"    set /a STATS_LOW+=1
if /i "%~1"=="Medium" set /a STATS_MEDIUM+=1
if /i "%~1"=="High"   set /a STATS_HIGH+=1
goto :eof

:Print
:: %1=ID  %2=Name  %3=Result  %4=Recommended  %5=Severity
set "ICON=[?]"
if /i "%~5"=="Passed" set "ICON=[+]"
if /i "%~5"=="Low"    set "ICON=[-]"
if /i "%~5"=="Medium" set "ICON=[$]"
if /i "%~5"=="High"   set "ICON=[!]"

echo   %ICON% ID %~1, %~2, Result=%~3, Recommended=%~4, Severity=%~5
echo ITEM^|%~5^|%~1^|%~2^|%~3^|%~4
goto :eof