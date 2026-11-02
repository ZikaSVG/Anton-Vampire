@Echo Off
Title Reg Converter v1.1 & Color 1A
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "NonPagedPoolQuota" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "NonPagedPoolSize" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "PagedPoolQuota" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "PagedPoolSize" /t REG_DWORD /d "192" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "SystemPages" /t REG_DWORD /d "4294967295" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "KernelSEHOPEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "DisableExceptionChainValidation" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "PhysicalAddressExtension" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "PoolUsageMaximum" /t REG_DWORD /d "96" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "EnableBoottrace" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "EnableCfg" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "EnableLowVaAccess" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /t REG_DWORD /d "8000000" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "DisablePagingCombining" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableBootTrace" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "0" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof