@Echo Off
Title Reg Converter v1.1 & Color 1A
cd %systemroot%\system32
call :IsAdmin
:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nsi{eb004a03-9b1a-11d4-9123-0050047759bc}\0 --> 0200"=hex:00,00,00,00,00,00,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nsi{eb004a03-9b1a-11d4-9123-0050047759bc}\0 --> 00,00,00,ff,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,?\
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nsi{eb004a03-9b1a-11d4-9123-0050047759bc}\0 --> ff,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nsi{eb004a03-9b1a-11d4-9123-0050047759bc}\0 --> 1700"=hex:00,00,00,00,00,00,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nsi{eb004a03-9b1a-11d4-9123-0050047759bc}\0 --> 00,00,00,ff,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,?\
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nsi{eb004a03-9b1a-11d4-9123-0050047759bc}\0 --> ff,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
:: ------------------------------------------------------------------------------------------------------------------------------------------------
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Nsi{eb004a03-9b1a-11d4-9123-0050047759bc}\0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableBoottrace" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "NegativeCacheTime" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "NegativeSOACacheTime" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "NetFailureCacheTime" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaximumUdpPacketSize" /t REG_DWORD /d "4864" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RemoteComputer\NameSpace{D6277990-4C6A-11CF-8D87-00AA0060F5BF}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v "TcpNoDelay" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "4294967295" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof