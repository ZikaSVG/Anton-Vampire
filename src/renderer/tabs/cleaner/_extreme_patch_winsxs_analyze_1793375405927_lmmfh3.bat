@echo off
chcp 65001 >nul
cd /d "D:\Projects\Anton Vampire\src\renderer\tabs\cleaner"


echo Анализ хранилища компонентов WinSxS...
Dism.exe /Online /Cleanup-Image /AnalyzeComponentStore
echo Готово.

exit /b 0
