@echo off
@echo
@echo Отключение hyper virtualization
bcdedit /set hypervisorlaunchtype off
@echo
@echo Отключение trusted platform module (TPM)
bcdedit /set tpmbootentropy ForceDisable
@echo
@echo Тайма-аут запуска 0 сек
bcdedit /timeout 0
@echo
@echo Отключение анимации запуска
bcdedit /set bootux disabled
@echo
@echo Ускорить время запуска
bcdedit /set bootmenupolicy standard
@echo
@echo Отключение лого запуска Windows
bcdedit /set quietboot yes
@echo
@echo Отключение лого запуска
bcdedit /set {globalsettings} custom:16000067 true
@echo
@echo Отключение анимации
bcdedit /set {globalsettings} custom:16000069 true
@echo
@echo Отключение сообщений запуска
bcdedit /set {globalsettings} custom:16000068 true
@echo
pause
