@echo off
sc config wuauserv start= demand >nul 2>&1
sc start wuauserv >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\sih" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\sihboot" /Enable >nul 2>&1
