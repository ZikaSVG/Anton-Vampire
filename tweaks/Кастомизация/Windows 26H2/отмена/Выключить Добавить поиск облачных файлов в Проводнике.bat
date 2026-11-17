@echo off
setlocal enableextensions
title Выключить: Добавить поиск облачных файлов в Проводнике
set "VIVETOOL="
for %%D in ("%~dp0.." "%~dp0..\.." "%~dp0..\..\.." "%~dp0..\..\..\.." "%~dp0..\..\..\..\..") do (
  if not defined VIVETOOL if exist "%%~fD\Utils\ViVeTool\ViVeTool.exe" set "VIVETOOL=%%~fD\Utils\ViVeTool\ViVeTool.exe"
)
if not defined VIVETOOL (
  echo [ERROR] ViVeTool.exe не найден
  exit /b 1
)
"%VIVETOOL%" /disable /id:45690266
if errorlevel 1 (
  echo [ERROR] ViVeTool вернул ошибку
  exit /b 1
)
echo OK
exit /b 0
