@echo off
@echo.
@echo made by FrazE- for Reborn PC Optimization - https://discord.gg/hgBQRsrDRu
@echo.
for /f %%I in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /k /f "WpnUserService" ^| find /i "WpnUserService"') do (
    reg add "%%I" /v "Start" /t reg_dword /d 2 /f
)
@echo.
@echo Completed
@echo.