@echo off
title RapidOS Tweak
:: ---
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "CreateGdiPrimaryOnSlaveGPU" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "DriverSupportsCddDwmInterop" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "DxgkCddSyncDxAccess" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "DxgkCddSyncGPUAccess" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "DxgkCddWaitForVerticalBlankEvent" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "DxgkCreateSwapChain" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "DxgkFreeGpuVirtualAddress" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "DxgkOpenSwapChain" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "DxgkShareSwapChainObject" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "DxgkWaitForVerticalBlankEvent" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "DxgkWaitForVerticalBlankEvent2" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "SwapChainBackBuffer" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "TdrResetFromTimeoutAsync" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "MonitorLatencyTolerance" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d 0 /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
