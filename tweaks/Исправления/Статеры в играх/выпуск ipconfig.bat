@echo off
echo Выполняю команды для сброса сетевых настроек...
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
echo Все команды выполнены. Нажмите любую клавишу для выхода...