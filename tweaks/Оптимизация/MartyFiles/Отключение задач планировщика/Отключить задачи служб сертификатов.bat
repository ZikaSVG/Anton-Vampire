@echo off
chcp 866 >nul

:: Отключить задачи служб сертификатов
for %%T in (
    "\Microsoft\Windows\CertificateServicesClient\AikCertEnrollTask"
    "\Microsoft\Windows\CertificateServicesClient\CryptoPolicyTask"
    "\Microsoft\Windows\CertificateServicesClient\KeyPreGenTask"
    "\Microsoft\Windows\CertificateServicesClient\SystemTask"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul