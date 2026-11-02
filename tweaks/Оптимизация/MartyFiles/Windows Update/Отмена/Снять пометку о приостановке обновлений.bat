@echo off
reg delete "HKLM\Software\Microsoft\WindowsUpdate\UpdatePolicy\Settings" /v "PausedFeatureStatus" /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\WindowsUpdate\UpdatePolicy\Settings" /v "PausedQualityStatus" /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\WindowsUpdate\UpdatePolicy\Settings" /v "PausedQualityDate" /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\WindowsUpdate\UpdatePolicy\Settings" /v "PausedFeatureDate" /f >nul 2>&1
