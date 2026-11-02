@echo off
reg add "HKLM\System\CurrentControlSet\Control\Power\User\PowerSchemes" /v ActivePowerScheme /t REG_SZ /d e9a42b02-d5df-448d-aa00-03f14749eb61 /f >nul
