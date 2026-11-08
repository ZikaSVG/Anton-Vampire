for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
for /f %%c in ('echo %%b ^| findstr "{"') do (
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /f
)
)
)