@echo off
@echo BESPLATNO! from Reborn FREE PC Optimization (RU) - https://discord.gg/hgBQRsrDRu
:: Fix Mouse Disappearing cursor
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableCursorSuppression /t REG_DWORD /d 0 /f
@echo Completed.
@pause