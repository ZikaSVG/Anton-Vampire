@echo off
vssadmin resize shadowstorage /on=c: /for=c: /maxsize=unbounded >nul 2>&1
