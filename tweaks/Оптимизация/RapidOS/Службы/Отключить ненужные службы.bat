@echo off
title RapidOS Tweak
:: ---
for %%s in (AppMgmt AxInstSV DoSvc FontCache LanmanServer MSDTC PcaSvc SEMgrSvc ShellHWDetection SSDPSRV TrkWks UCPD WEPHOSTSVC WinRM AssignedAccessManagerSvc NvTelemetryContainer TroubleshootingSvc UdkUserSvc uhssvc WarpJITSvc Wecsvc wercplsupport NetBT GpuEnergyDrv) do (
    sc config %%s start= disabled >nul 2>&1
    sc stop %%s >nul 2>&1
)
:: ---
echo Done.
pause
exit /b
