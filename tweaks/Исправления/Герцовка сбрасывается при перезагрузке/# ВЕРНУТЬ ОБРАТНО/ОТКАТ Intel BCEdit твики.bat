@echo off
@echo BESPLATNO! from Reborn FREE PC Optimization (RU) - https://discord.gg/hgBQRsrDRu
@echo Made by FrazE-
@echo Restore Default Intel BCEdit Settings
@echo.
bcdedit /deletevalue allowedinmemorysettings
bcdedit /deletevalue isolatedcontext
@echo.
@echo Completed
@pause
