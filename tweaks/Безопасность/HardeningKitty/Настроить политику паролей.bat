@echo off
title Политика паролей
net accounts /minpwlen:14
net accounts /maxpwage:365
net accounts /minpwage:1
net accounts /uniquepw:24
echo [+] Политика паролей настроена.