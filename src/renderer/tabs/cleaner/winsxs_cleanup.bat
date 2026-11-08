@echo off
chcp 65001 >nul
echo Очистка устаревших компонентов WinSxS...
Dism.exe /Online /Cleanup-Image /StartComponentCleanup
echo Готово.
