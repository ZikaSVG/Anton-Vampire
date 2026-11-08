@echo off
reg delete "HKEY_CLASSES_ROOT\DesktopBackground\Shell\CpuIdle" /f >nul 2>&1
