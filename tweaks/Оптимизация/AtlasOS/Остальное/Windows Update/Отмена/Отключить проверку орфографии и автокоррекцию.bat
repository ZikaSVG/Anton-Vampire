@echo off
reg delete "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableAutocorrection" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableDoubleTapSpace" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnablePredictionSpaceInsertion" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableSpellchecking" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableTextPrediction" /f >nul 2>&1
