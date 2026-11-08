@echo off
@echo BESPLATNO! from Reborn FREE PC Optimization (RU) - https://discord.gg/hgBQRsrDRu
@echo Made by FrazE-
reg delete "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Control Panel\Desktop" /v EnablePerProcessSystemDPI /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop" /v EnablePerProcessSystemDPI /f
reg delete "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Display" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Display" /f
@echo Completed.
@pause