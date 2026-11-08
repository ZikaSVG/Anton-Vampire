@echo off
@echo.
@echo t.me/DE3NAKE
@echo.
set "backupPath=%~dp0RegistryBackup.reg"
:: Экспортируем весь реестр в файл full_backup.reg
@echo Exporting registry...
@echo Please wait...
regedit /e "%backupPath%"
@echo.
@echo.
@echo Completed