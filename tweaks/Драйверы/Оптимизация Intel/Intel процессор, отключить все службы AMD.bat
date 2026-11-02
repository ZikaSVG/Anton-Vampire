@echo off
@echo DE3NAKE OPTIMIZATION / t.me/DE3NAKE
:: Disable AMD Drivers (Intel CPU Only)
reg add "HKLM\System\CurrentControlSet\Services\amdi2c" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\System\CurrentControlSet\Services\AmdK8" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\System\CurrentControlSet\Services\amdlog" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\System\CurrentControlSet\Services\AmdPPM" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\System\CurrentControlSet\Services\AMDSAFD" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\System\CurrentControlSet\Services\amdsata" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\System\CurrentControlSet\Services\amdsbs" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\System\CurrentControlSet\Services\amdxata" /v "Start" /t REG_DWORD /d "4" /f
@echo Completed.