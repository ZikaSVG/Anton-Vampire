@echo off
setlocal enableextensions
title Включить: Общий доступ к отдельному окну
set "VIVETOOL=%~dp0..\..\..\..\Utils\ViVeTool\ViVeTool.exe"
if not exist "%VIVETOOL%" set "VIVETOOL=%~dp0..\..\..\..\..\Utils\ViVeTool\ViVeTool.exe"
if not exist "%VIVETOOL%" (
  echo [ERROR] ViVeTool.exe не найден
  exit /b 1
)
"%VIVETOOL%" /enable /id:57882334
if errorlevel 1 exit /b 1
echo OK
exit /b 0
