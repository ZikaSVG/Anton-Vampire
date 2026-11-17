@echo off
setlocal enableextensions
title Включить: Расширенная настройка меню «Пуск» и его размера
set "VIVETOOL="
for %%D in ("%~dp0.." "%~dp0..\.." "%~dp0..\..\.." "%~dp0..\..\..\.." "%~dp0..\..\..\..\..") do (
  if not defined VIVETOOL if exist "%%~fD\Utils\ViVeTool\ViVeTool.exe" set "VIVETOOL=%%~fD\Utils\ViVeTool\ViVeTool.exe"
)
if not defined VIVETOOL (
  echo [ERROR] ViVeTool.exe не найден
  exit /b 1
)
"%VIVETOOL%" /enable /id:61754985,61225604,61596616,61596617,61596618,61596619
if errorlevel 1 (
  echo [ERROR] ViVeTool вернул ошибку
  exit /b 1
)
echo OK
exit /b 0
