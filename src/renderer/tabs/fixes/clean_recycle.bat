@echo off
setlocal EnableExtensions
chcp 65001 >nul

net session >nul 2>&1
if not "%errorlevel%"=="0" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs -Wait"
    exit /b
)

for %%D in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%D:\$Recycle.Bin" rd /s /q "%%D:\$Recycle.Bin" >nul 2>&1
)
exit /b 0