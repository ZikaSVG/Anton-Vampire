@echo off
chcp 65001 >nul
echo Удаление кэша шейдеров AMD...
del /f /s /q "%LocalAppData%\AMD\DxCache\*.*"  >nul 2>&1
del /f /s /q "%LocalAppData%\AMD\GLCache\*.*"  >nul 2>&1
del /f /s /q "%LocalAppData%\AMD\DxcCache\*.*" >nul 2>&1
echo Готово.
