@echo off
setlocal
:: Указываем путь к 7za.exe
set "7za_path=Utils\7za.exe"
:: Указываем папку AppData текущего пользователя
set "appdata_path=%USERPROFILE%\AppData"
:: Указываем папку для бэкапа
set "backup_path=Backup"
:: Создаем папку для бэкапа, если она не существует
if not exist "%backup_path%" mkdir "%backup_path%"
:: Создаем имя архива с текущей датой и временем
set "archive_name=AppData_Backup_%date:~10,4%-%date:~7,2%-%date:~4,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%.7z"
:: Создаем архив с помощью 7za.exe
"%7za_path%" a -t7z "%backup_path%\%archive_name%" "%appdata_path%" -mx=9
:: Проверяем успешность создания архива
if %errorlevel% equ 0 (
    echo Backup completed successfully.
) else (
    echo Backup failed.
)