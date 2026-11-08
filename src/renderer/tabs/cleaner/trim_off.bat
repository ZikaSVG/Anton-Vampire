@echo off
chcp 65001 >nul
echo Отключение TRIM...
fsutil behavior set DisableDeleteNotify 1
echo Готово.
