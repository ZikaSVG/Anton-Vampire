@echo off
setlocal enableextensions
title Включить: Изменение размера и настройка меню Пуск
set "VIVETOOL=%~dp0..\..\..\..\Utils\ViVeTool\ViVeTool.exe"
if not exist "%VIVETOOL%" set "VIVETOOL=%~dp0..\..\..\..\..\Utils\ViVeTool\ViVeTool.exe"
if not exist "%VIVETOOL%" (
  echo [ERROR] ViVeTool.exe не найден
  exit /b 1
)
"%VIVETOOL%" /enable /id:61754985,61225604,61596616,61596617,61596618,61596619
if errorlevel 1 exit /b 1
echo OK
exit /b 0
