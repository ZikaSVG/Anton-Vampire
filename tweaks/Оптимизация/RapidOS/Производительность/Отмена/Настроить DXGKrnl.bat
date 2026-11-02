@echo off
title RapidOS Tweak
:: ---
for %%v in (CreateGdiPrimaryOnSlaveGPU DriverSupportsCddDwmInterop DxgkCddSyncDxAccess DxgkCddSyncGPUAccess DxgkCddWaitForVerticalBlankEvent DxgkCreateSwapChain DxgkFreeGpuVirtualAddress DxgkOpenSwapChain DxgkShareSwapChainObject DxgkWaitForVerticalBlankEvent DxgkWaitForVerticalBlankEvent2 SwapChainBackBuffer TdrResetFromTimeoutAsync MonitorLatencyTolerance MonitorRefreshLatencyTolerance) do reg delete "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "%%v" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
