@echo off
chcp 65001 >nul
echo Удаление кэша шейдеров (все GPU)...
del /f /s /q "%LocalAppData%\D3DSCache\*.*"         >nul 2>&1
del /f /s /q "%LocalAppData%\NVIDIA\DXCache\*.*"    >nul 2>&1
del /f /s /q "%LocalAppData%\NVIDIA\GLCache\*.*"    >nul 2>&1
del /f /s /q "%LocalAppData%\NVIDIA\ComputeCache\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\AMD\DxCache\*.*"       >nul 2>&1
del /f /s /q "%LocalAppData%\AMD\GLCache\*.*"       >nul 2>&1
del /f /s /q "%LocalAppData%\AMD\DxcCache\*.*"      >nul 2>&1
del /f /s /q "%LocalAppData%\Intel\ShaderCache\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\Intel\ShaderCacheVk\*.*" >nul 2>&1
echo Готово.
