@echo off
echo Resetting Network
ipconfig /flushdns 
ipconfig /release
ipconfig /renew 