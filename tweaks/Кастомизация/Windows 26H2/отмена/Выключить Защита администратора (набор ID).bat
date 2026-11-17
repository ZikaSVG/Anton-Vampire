@echo off
setlocal enableextensions
title Выключить: Защита администратора (набор ID)
set "VIVETOOL=%~dp0..\..\..\..\..\Utils\ViVeTool\ViVeTool.exe"
if not exist "%VIVETOOL%" set "VIVETOOL=%~dp0..\..\..\..\..\..\Utils\ViVeTool\ViVeTool.exe"
if not exist "%VIVETOOL%" (
  echo [ERROR] ViVeTool.exe не найден
  exit /b 1
)
"%VIVETOOL%" /disable /id:51406324,60288851,48433719,58989092,58989177,61160789
if errorlevel 1 exit /b 1
echo OK
exit /b 0
