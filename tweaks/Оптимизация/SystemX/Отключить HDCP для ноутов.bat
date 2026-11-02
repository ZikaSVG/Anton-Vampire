@echo off
echo Made by ios1ph
echo ⪫祭 HDCP  ⥣஢  INTEL
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\cphs" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\cplspcon" /v "Start" /t REG_DWORD /d 4 /f
echo.
sc stop cphs
sc stop cplspcon
echo ᯥ譮!