@echo off
setlocal enableextensions
title Включить: Управление веб-результатами в поиске
set "VIVETOOL=%~dp0..\..\..\..\Utils\ViVeTool\ViVeTool.exe"
if not exist "%VIVETOOL%" set "VIVETOOL=%~dp0..\..\..\..\..\Utils\ViVeTool\ViVeTool.exe"
if not exist "%VIVETOOL%" (
  echo [ERROR] ViVeTool.exe не найден
  exit /b 1
)
"" "%VIVETOOL%" /enable /id:61267302,61482515,61532758,61760679
if errorlevel 1 (
  echo [ERROR] ViVeTool вернул ошибку
  exit /b 1
)
echo OK
exit /b 0
