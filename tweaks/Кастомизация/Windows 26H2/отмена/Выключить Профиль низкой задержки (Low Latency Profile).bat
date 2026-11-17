@echo off
setlocal enableextensions
title Выключить: Профиль низкой задержки (Low Latency Profile)
set "VIVETOOL="
for %%D in ("%~dp0.." "%~dp0..\.." "%~dp0..\..\.." "%~dp0..\..\..\.." "%~dp0..\..\..\..\..") do (
  if not defined VIVETOOL if exist "%%~fD\Utils\ViVeTool\ViVeTool.exe" set "VIVETOOL=%%~fD\Utils\ViVeTool\ViVeTool.exe"
)
if not defined VIVETOOL (
  echo [ERROR] ViVeTool.exe не найден
  exit /b 1
)
"%VIVETOOL%" /disable /id:58989092,58989177,60716524,61391826,62816659
if errorlevel 1 (
  echo [ERROR] ViVeTool вернул ошибку
  exit /b 1
)
echo OK
exit /b 0
