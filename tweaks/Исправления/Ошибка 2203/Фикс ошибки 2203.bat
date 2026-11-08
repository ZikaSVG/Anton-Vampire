@echo off
@echo BESPLATNO! from Reborn FREE PC Optimization (RU) - https://discord.gg/hgBQRsrDRu
msiexec /unregister
msiexec /regserver
sc config msiserver start= demand
net start msiserver
sc query msiserver
sfc /scannow
DISM /Online /Cleanup-Image /RestoreHealth
chkdsk C: /f /r
@echo Completed.
@pause