@echo off
vssadmin resize shadowstorage /on=c: /for=c: /maxsize=1%% >nul 2>&1
