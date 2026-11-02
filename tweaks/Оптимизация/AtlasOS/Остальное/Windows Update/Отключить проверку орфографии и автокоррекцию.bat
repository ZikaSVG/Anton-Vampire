@echo off
reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableAutocorrection" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableDoubleTapSpace" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnablePredictionSpaceInsertion" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableSpellchecking" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableTextPrediction" /t REG_DWORD /d 0 /f >nul 2>&1
