@echo off
title Включение DiagTrack
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
sc config DiagTrack start= auto
sc start DiagTrack >nul 2>&1
echo [+] DiagTrack включена.
