@echo off
@echo.
@echo made by FrazE- for Reborn PC Optimization - https://discord.gg/hgBQRsrDRu
@echo.
ipconfig /release
ipconfig /renew
arp -d *
nbtstat -R
nbtstat -RR
ipconfig /flushdns
ipconfig /registerdns
ipconfig /release
ipconfig /renew
ipconfig /flushdns
netsh int ip reset
netsh int ipv4 reset
netsh int ipv6 reset
netsh int tcp reset
netsh winsock reset
netsh branchcache reset
netsh http flush logbuffer
@echo Completed.