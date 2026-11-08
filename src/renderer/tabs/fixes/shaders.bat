@echo off
chcp 65001 >nul
title Очистка кэша шейдеров
:: ВАЖНО: кэш лежит в профиле ПОЛЬЗОВАТЕЛЯ.
:: Если запускать от админа — %localappdata% указывает на профиль админа.
:: Поэтому используем %USERPROFILE% и фиксированные пути.

set "U=%USERPROFILE%"
if "%U%"=="" set "U=%HOMEDRIVE%%HOMEPATH%"

echo Удаление DirectX / NVIDIA / AMD кэша для профиля: %U%
echo.

del /s /q /f "%U%\AppData\Local\D3DSCache\*"               >nul 2>&1
del /s /q /f "%U%\AppData\Local\NVIDIA\DXCache\*"          >nul 2>&1
del /s /q /f "%U%\AppData\Local\NVIDIA\GLCache\*"          >nul 2>&1
del /s /q /f "%U%\AppData\Local\NVIDIA\ComputeCache\*"     >nul 2>&1
del /s /q /f "%U%\AppData\Roaming\NVIDIA\ComputeCache\*"   >nul 2>&1
del /s /q /f "%U%\AppData\Local\AMD\DxCache\*"             >nul 2>&1

echo Готово. Кэш шейдеров очищен.