@echo off
chcp 65001 >nul
echo Анализ хранилища компонентов WinSxS...
Dism.exe /Online /Cleanup-Image /AnalyzeComponentStore
echo Готово.
