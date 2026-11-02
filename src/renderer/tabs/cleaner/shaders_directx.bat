@echo off
chcp 65001 >nul
echo Удаление кэша шейдеров DirectX...
del /f /s /q "%LocalAppData%\D3DSCache\*.*" >nul 2>&1
echo Готово.
