@echo off
powershell -Command "& { $bagsPath = 'HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags'; Get-ChildItem -Path $bagsPath | ForEach-Object { $fullPath = Join-Path -Path $_.PSPath -ChildPath 'Shell\{885A186E-A440-4ADA-812B-DB871B942259}'; if (Test-Path -Path $fullPath) { Remove-Item -Path $fullPath -Recurse -Force } } }"
