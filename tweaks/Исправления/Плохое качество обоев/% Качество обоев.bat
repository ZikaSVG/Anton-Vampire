@echo off
@echo BESPLATNO! from Reborn FREE PC Optimization (RU) - https://discord.gg/hgBQRsrDRu
Reg.exe add "HKCU\Control Panel\Desktop" /v "JPEGImportQuality" /t REG_DWORD /d "100" /f
@echo Completed.
@pause