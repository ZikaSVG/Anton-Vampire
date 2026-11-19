@echo off
set ID=999999
openfiles > nul 2>&1
if not %errorlevel% equ 0 goto NotAdmin
goto start

:NotAdmin
echo.===NOT ADMIN===
goto END

:start
cls
ECHO.
ECHO.
ECHO 1. Stop services
ECHO 2. Start services
ECHO.
ECHO.
ECHO.
ECHO       +oooooo .oooo+-    `/oo/.       `oooo+:     `/o+:`    ./o+:     .+o+:`  /oooooo+           
ECHO       mMmyyyy`:MMhymMd` :NMhsNMo      -MMdymMm.  +MNhdMN:  yMNhmMm.  sMNshMm- oyhMMdys         
ECHO       mMs     :MM. `MM: yMm  -+:      -MM+ `NMy  NM+  dMh .MM-  NMs `NMo  //.   .MM-         
ECHO       mMs     :MM. `MM: -NMy.         -MMo-+MM/  NM+  hMh .MM-  NMs  sMN+       .MM-         
ECHO       mMMMMm  :MMhhmMh`  `sNMh-       -MMNmNMy`  NM+  hMh .MM-  NMs   :hMNo`    .MM-          
ECHO       mMy...  :MMso+-      `oNMo      -MM+ `mMh  NM+  hMh .MM-  NMs     -hMm.   .MM-          
ECHO       mMs     :MM.      oy/  +MM`     -MM+  dMN  NM+  dMh .MM-  NMs .yy`  dMy   .MM-        
ECHO       mMs     :MM.      :NNssmMy      -MMdydMM+  oMNyhMN:  yMmydMm-  yMmoyMN:   .MM-               
ECHO       os:     .ss`       `/os+-       .sssss+.    .+so/`    -+so:`    -+so/`    `ss.  
ECHO.
ECHO.
set /p choice=?
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto STOPUSELESS
if '%choice%'=='2' goto START
ECHO "%choice%" is not valid, try again
ECHO.
@pause
goto start

:STOPUSELESS
ECHO STOP USELESS
call :StopService SysMain
call :StopService WSearch
call :StopService diagnosticshub.standardcollector.service
call :StopService diagsvc
call :StopService WbioSrvc
call :StopService MapsBroker
call :StopService lfsvc
call :StopService XblAuthManager
call :StopService XblGameSave
call :StopService XboxNetApiSvc
call :StopService XboxGipSvc
call :StopService UevAgentService
pause
goto start

:StopService
echo.=== %1 STOPING ====
sc stop %1
echo.=== %1 DISABLING ===
sc config %1 start=disabled
echo.=============== %1 REG 4 ======
reg add "HKLM\SYSTEM\CurrentControlSet\services\%1" /v "Start" /t REG_DWORD /d 4 /f
echo.---------------------------------
echo.
echo.
exit /b

:START
ECHO STOP USELESS
call :Start SysMain
call :Start WSearch
call :Start diagnosticshub.standardcollector.service
call :Start diagsvc
call :Start WbioSrvc
call :Start MapsBroker
call :Start lfsvc
call :Start XblAuthManager
call :Start XblGameSave
call :Start XboxNetApiSvc
call :Start XboxGipSvc
call :Start UevAgentService
pause
goto start

:Start
echo.=============== %1 REG 2 ======
reg add "HKLM\SYSTEM\CurrentControlSet\services\%1" /v "Start" /t REG_DWORD /d 2 /f
echo.---------------------------------
echo.
echo.
exit /b