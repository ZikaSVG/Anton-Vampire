@echo off
bcdedit /set {current} safeboot minimal >nul
bcdedit /set {current} safebootalternateshell yes >nul
