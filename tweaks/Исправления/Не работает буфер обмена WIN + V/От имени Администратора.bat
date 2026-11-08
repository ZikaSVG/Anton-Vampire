@echo off
@echo.
@echo made by FrazE- for Reborn PC Optimization - https://discord.gg/hgBQRsrDRu
@echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v AllowClipboardHistory /t REG_DWORD /d 1 /f
@echo.
@echo Completed
@echo. 