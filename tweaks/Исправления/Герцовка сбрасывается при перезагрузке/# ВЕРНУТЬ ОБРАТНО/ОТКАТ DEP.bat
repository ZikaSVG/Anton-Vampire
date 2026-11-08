@echo off
@echo.
@echo BESPLATNO! from Reborn FREE PC Optimization (RU) - https://discord.gg/hgBQRsrDRu
@echo.
BCDEDIT /SET {CURRENT} NX ALWAYSON
bcdedit /set {current} nx OptIn
powershell.exe Set-ProcessMitigation -System -Enable DEP
@echo.
@echo.
@echo Completed
@pause
