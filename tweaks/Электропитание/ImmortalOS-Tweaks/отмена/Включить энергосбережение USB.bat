@echo off
chcp 65001 >nul 2>&1

net session >nul 2>&1
if %errorLevel% neq 0 exit /b 1

powercfg /setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 1 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1

exit /b 0
