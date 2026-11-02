@echo off
chcp 65001 >nul
echo Удаление кэша шейдеров Intel...
del /f /s /q "%LocalAppData%\Intel\ShaderCache\*.*"   >nul 2>&1
del /f /s /q "%LocalAppData%\Intel\ShaderCacheVk\*.*" >nul 2>&1
echo Готово.
