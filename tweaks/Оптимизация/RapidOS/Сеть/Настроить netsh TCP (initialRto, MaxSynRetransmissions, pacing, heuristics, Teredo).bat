@echo off
title RapidOS Tweak
:: ---
netsh int tcp set global initialRto=2000 >nul 2>&1
netsh int tcp set global MaxSynRetransmissions=2 >nul 2>&1
netsh int tcp set global pacingprofile=off >nul 2>&1
netsh int tcp set heuristics disabled >nul 2>&1
netsh int teredo set state type=enterpriseclient >nul 2>&1
netsh int teredo set state servername=default >nul 2>&1
netsh int tcp set supplemental internet congestionprovider=default >nul 2>&1
:: ---
echo Done.
pause
exit /b
