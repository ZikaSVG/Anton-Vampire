@echo off
setlocal enableextensions
title Включить: Добавить общий доступ к отдельному окну с панели задач
set "VIVETOOL="
for %%D in ("%~dp0.." "%~dp0..\.." "%~dp0..\..\.." "%~dp0..\..\..\.." "%~dp0..\..\..\..\..") do (
  if not defined VIVETOOL if exist "%%~fD\Utils\ViVeTool\ViVeTool.exe" set "VIVETOOL=%%~fD\Utils\ViVeTool\ViVeTool.exe"
)
if not defined VIVETOOL (
  echo [ERROR] ViVeTool.exe не найден
  exit /b 1
)
"%VIVETOOL%" /enable /id:57882334
if errorlevel 1 (
  echo [ERROR] ViVeTool вернул ошибку
  exit /b 1
)
echo OK
exit /b 0
