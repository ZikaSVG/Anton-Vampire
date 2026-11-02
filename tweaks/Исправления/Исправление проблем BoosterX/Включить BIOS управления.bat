@echo off
sc config mssmbios start= System
DevManView /enable "Microsoft System Management BIOS Driver"