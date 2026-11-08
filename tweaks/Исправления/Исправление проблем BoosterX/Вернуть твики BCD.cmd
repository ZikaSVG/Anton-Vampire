@echo off
@echo
bcdedit /set hypervisorlaunchtype auto
@echo
bcdedit /deletevalue tpmbootentropy
@echo
bcdedit /timeout 30
@echo
bcdedit /deletevalue bootux
@echo
bcdedit /set bootmenupolicy standard
@echo
bcdedit /deletevalue {globalsettings} custom:16000067
@echo
bcdedit /deletevalue {globalsettings} custom:16000069
@echo
bcdedit /deletevalue {globalsettings} custom:16000068
@echo