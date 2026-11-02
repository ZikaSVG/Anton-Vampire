@echo off
bcdedit /timeout 10 >nul 2>&1
bcdedit /set bootmenupolicy legacy >nul 2>&1
