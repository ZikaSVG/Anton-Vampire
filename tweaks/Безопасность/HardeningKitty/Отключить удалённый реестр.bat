@echo off
title Remote Registry
sc config RemoteRegistry start= disabled
sc stop RemoteRegistry >nul 2>&1
echo [+] Remote Registry отключён.