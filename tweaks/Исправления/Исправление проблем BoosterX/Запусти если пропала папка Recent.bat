@echo off
@echo.
@echo made by FrazE- for Reborn PC Optimization - https://discord.gg/hgBQRsrDRu
@echo.
:: Удаление параметра NoRecentDocsHistory в реестре
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoRecentDocsHistory /f
:: Установка групповой политики в значение "Not Configured"
echo Проверка и изменение групповой политики...
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Group Policy Objects\{53D6AB0B-F5A1-48D3-9E8D-2E3E6D5285DD}User\Software\Policies\Microsoft\Windows\CurrentVersion\Group Policy\State\0" /v WPN_Action /t REG_DWORD /d 0 /f
@echo.
@echo Completed. Restart your PC
@echo.