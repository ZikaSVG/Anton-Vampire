@echo off
call "%windir%\AtlasModules\Scripts\setSvc.cmd" NVDisplay.ContainerLocalSystem 2
sc start NVDisplay.ContainerLocalSystem >nul 2>&1
