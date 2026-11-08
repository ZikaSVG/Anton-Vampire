@echo off
title Разрешить ICMP
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
netsh advfirewall firewall delete rule name="Block ICMPv4" >nul 2>&1
netsh advfirewall firewall delete rule name="Block ICMPv6" >nul 2>&1
echo [+] ICMP разрешён.
