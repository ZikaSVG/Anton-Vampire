@echo off
chcp 65001 >nul
echo Удаление Prefetch...
del /f /s /q "%windir%\Prefetch\*.*" >nul 2>&1
echo Готово.
