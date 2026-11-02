@echo off
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "RestrictAnonymous" /f >nul 2>&1
