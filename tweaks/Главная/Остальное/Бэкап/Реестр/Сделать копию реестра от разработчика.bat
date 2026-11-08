CD \
MD Backup\RegistryBackup_%DATE:~-4,4%-%DATE:~-10,2%-%DATE:~-7,2%_%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
CD Backup\RegistryBackup_%DATE:~-4,4%-%DATE:~-10,2%-%DATE:~-7,2%_%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
REG EXPORT HKLM hklm.reg 
REG EXPORT HKCU hkcu.reg 
REG EXPORT HKCR hkcr.reg 
REG EXPORT HKCC hkcc.reg 
REG EXPORT HKU hku.reg