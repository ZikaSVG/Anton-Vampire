@echo off
reg delete "HKCR\CLSID\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}" /f >nul 2>&1
