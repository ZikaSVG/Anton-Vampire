@echo off
title Блокировка ICMP
netsh advfirewall firewall add rule name="Block ICMPv4" protocol=icmpv4:8,any dir=in action=block
netsh advfirewall firewall add rule name="Block ICMPv6" protocol=icmpv6:8,any dir=in action=block
echo [+] ICMP заблокирован.