@echo off
del /q /f /s "%ProgramFiles(x86)%\Microsoft\EdgeUpdate\Download\*.*" >nul 2>&1
rd /q /s "%ProgramFiles(x86)%\Microsoft\EdgeUpdate\Download\" >nul 2>&1
