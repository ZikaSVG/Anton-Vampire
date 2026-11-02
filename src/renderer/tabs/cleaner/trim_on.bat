@echo off
chcp 65001 >nul
echo Включение TRIM...
fsutil behavior set DisableDeleteNotify 0
echo Готово.
