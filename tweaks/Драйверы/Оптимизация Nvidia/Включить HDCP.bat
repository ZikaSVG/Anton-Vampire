Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMHdcpKeyglobZero" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /f
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%i" /v "Driver"') do (
for /f %%i in ('echo %%a ^| findstr "{"') do (
Reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "RMHdcpKeyglobZero" /f >nul 2>&1
)
)
)