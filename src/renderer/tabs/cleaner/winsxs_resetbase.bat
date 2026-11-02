@echo off
chcp 65001 >nul
echo Очистка WinSxS с сбросом базы компонентов (ResetBase)...
Dism.exe /Online /Cleanup-Image /StartComponentCleanup /ResetBase
echo Готово.
