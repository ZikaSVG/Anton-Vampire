@echo off
@echo BESPLATNO! from Reborn FREE PC Optimization (RU) - https://discord.gg/hgBQRsrDRu
@echo made by FrazE-
@echo Clearing NVIDIA DirectX Cache...

REM Переход к папке DXCache с использованием переменных среды
set DXCachePath=%LOCALAPPDATA%\..\LocalLow\NVIDIA\PerDriverVersion\DXCache

REM Проверка существования папки
if exist "%DXCachePath%" (
    @echo Found directory: %DXCachePath%
    @echo Deleting cache files...
    del /q "%DXCachePath%\*.*"
    @echo Cache cleared successfully.
) else (
    @echo Directory not found: %DXCachePath%
)
@echo Completed.
@pause
