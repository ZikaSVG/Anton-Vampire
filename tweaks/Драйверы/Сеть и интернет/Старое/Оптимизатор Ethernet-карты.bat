@Echo Off
Title Reg Converter v1.1 & Color 1A
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SackOpts" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "PMTUDiscovery" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUDiscovery" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUBHDetect" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DeadGWDetectDefault" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v "TcpAckFrequency" /t REG_DWORD /d "8" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v "TCPNoDelay" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "NonBestEffortLimit" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "4294967295" /f
Reg.exe add "HKLM\SOFTWARE\OfficialHawk\Minecraft" /v "Version" /t REG_SZ /d "1.8.8" /f
Reg.exe add "HKLM\SOFTWARE\OfficialHawk\Minecraft" /v "Path" /t REG_SZ /d "C:\USER\AppData\Roaming\.vimeworld\1.8.8\\" /f
Reg.exe add "HKLM\SOFTWARE\OfficialHawk\Minecraft" /v "TcpAckFrequency" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SOFTWARE\OfficialHawk\Minecraft" /v "TCPNoDelay" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\OfficialHawk\Minecraft" /v "TcpDelAckTicks" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof