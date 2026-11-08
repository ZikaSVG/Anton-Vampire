@echo off
chcp 65001 >nul
echo Удаление кэша шейдеров NVIDIA...
del /f /s /q "%LocalAppData%\NVIDIA\DXCache\*.*"      >nul 2>&1
del /f /s /q "%LocalAppData%\NVIDIA\GLCache\*.*"      >nul 2>&1
del /f /s /q "%LocalAppData%\NVIDIA\ComputeCache\*.*" >nul 2>&1
echo Готово.
