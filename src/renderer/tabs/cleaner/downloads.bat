@echo off
chcp 65001 >nul
echo Очистка папки Загрузки...
del /f /s /q "%USERPROFILE%\Downloads\*.*" >nul 2>&1
for /d %%D in ("%USERPROFILE%\Downloads\*") do rd /s /q "%%D" >nul 2>&1
echo Готово.
