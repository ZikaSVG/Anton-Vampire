@echo off
call "%windir%\AtlasModules\Scripts\setSvc.cmd" NVDisplay.ContainerLocalSystem 4
sc stop NVDisplay.ContainerLocalSystem >nul 2>&1
