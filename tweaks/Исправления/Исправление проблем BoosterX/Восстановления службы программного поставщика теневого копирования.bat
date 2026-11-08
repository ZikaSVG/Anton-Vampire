@echo off
@echo.
@echo made by FrazE- for Reborn PC Optimization - https://discord.gg/hgBQRsrDRu
@echo.
@echo Deleting the Microsoft Software Shadow Copy Provider service
sc delete swprv
@echo Creating the Microsoft Software Shadow Copy Provider service
sc create swprv binPath= "C:\Windows\System32\svchost.exe" DisplayName= "Microsoft Software Shadow Copy Provider" type= own start= demand error= normal depend= rpcss obj= LocalSystem
@echo Updating registry
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\swprv" /v ImagePath /t REG_EXPAND_SZ /d "C:\Windows\System32\svchost.exe -k swprv" /f
@echo Creating Parameters key
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\swprv\Parameters"
@echo Adding ServiceDll value
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\swprv\Parameters" /v ServiceDll /t REG_EXPAND_SZ /d "%Systemroot%\System32\swprv.dll" /f
@echo.
@echo.
@echo Completed