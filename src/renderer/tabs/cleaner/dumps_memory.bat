@echo off
chcp 65001 >nul
echo Удаление дампов памяти...
del /f /q "%windir%\MEMORY.DMP"      >nul 2>&1
del /f /q "%windir%\memory.dmp"      >nul 2>&1
del /f /s /q "%windir%\Minidump\*.*" >nul 2>&1
echo Готово.
