@echo off
setlocal enableextensions
title Включить: Переработанный поиск
set "VIVETOOL=%~dp0..\..\..\..\Utils\ViVeTool\ViVeTool.exe"
if not exist "%VIVETOOL%" set "VIVETOOL=%~dp0..\..\..\..\..\Utils\ViVeTool\ViVeTool.exe"
if not exist "%VIVETOOL%" (
  echo [ERROR] ViVeTool.exe не найден
  exit /b 1
)
"%VIVETOOL%" /enable /id:62353331,62762248
if errorlevel 1 exit /b 1
echo OK
exit /b 0
