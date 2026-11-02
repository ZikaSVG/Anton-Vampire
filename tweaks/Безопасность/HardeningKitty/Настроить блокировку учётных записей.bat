@echo off
title Блокировка учётных записей
net accounts /lockoutthreshold:5
net accounts /lockoutduration:30
net accounts /lockoutwindow:30
echo [+] Блокировка настроена.