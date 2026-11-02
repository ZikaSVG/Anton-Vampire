@echo off
@echo.
@echo BESPLATNO! from Reborn FREE PC Optimization (RU) - https://discord.gg/hgBQRsrDRu
@echo.
bcdedit /set {current} bootmenupolicy Standard
bcdedit /set {current} bootlog Yes
bcdedit /set {current} quietboot Yes
bcdedit /set {current} testsigning Off
bcdedit /set {current} nx OptIn
@echo.
@echo.
@echo Completed
@pause
