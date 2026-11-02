@echo off
reg delete "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Settings\AllowOnlineTips" /v "value" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "AllowOnlineTips" /f >nul 2>&1
