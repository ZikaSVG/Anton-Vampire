@echo off
chcp 65001 >nul
echo Сброс кэша DNS...
ipconfig /flushdns
echo Готово.
