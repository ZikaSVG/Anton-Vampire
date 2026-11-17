@echo off
setlocal enableextensions
title Выключить: Уменьшенные кнопки панели задач
set "VIVETOOL=%~dp0..\..\..\..\..\Utils\ViVeTool\ViVeTool.exe"
if not exist "%VIVETOOL%" set "VIVETOOL=%~dp0..\..\..\..\..\..\Utils\ViVeTool\ViVeTool.exe"
if not exist "%VIVETOOL%" (
  echo [ERROR] ViVeTool.exe не найден
  exit /b 1
)
"%VIVETOOL%" /disable /id:61090762
if errorlevel 1 exit /b 1
echo OK
exit /b 0
