@echo off
for %%k in (Bags BagMRU BagsMRU) do (
    reg delete "HKCU\Software\Microsoft\Windows\Shell\%%k" /f >nul 2>&1
    reg delete "HKCU\Software\Microsoft\Windows\ShellNoRoam\%%k" /f >nul 2>&1
    reg delete "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\%%k" /f >nul 2>&1
)
