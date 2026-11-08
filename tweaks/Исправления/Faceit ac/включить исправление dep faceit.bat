@echo off
bcdedit /deletevalue nx
bcdedit /set hypervisorlaunchtype auto
DevManView.exe /enable "Trusted Platform Module 2.0"