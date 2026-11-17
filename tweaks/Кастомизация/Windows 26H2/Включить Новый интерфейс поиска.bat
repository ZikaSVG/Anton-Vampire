@echo off
setlocal enableextensions
title Включить: Новый интерфейс поиска
set "VIVETOOL=%~dp0..\..\..\..\Utils\ViVeTool\ViVeTool.exe"
if not exist "%VIVETOOL%" set "VIVETOOL=%~dp0..\..\..\..\..\Utils\ViVeTool\ViVeTool.exe"
if not exist "%VIVETOOL%" (
  echo [ERROR] ViVeTool.exe не найден
  exit /b 1
)
"" "%VIVETOOL%" /enable /id:62353331,62762248
if errorlevel 1 (
  echo [ERROR] ViVeTool вернул ошибку
  exit /b 1
)
echo OK
exit /b 0
