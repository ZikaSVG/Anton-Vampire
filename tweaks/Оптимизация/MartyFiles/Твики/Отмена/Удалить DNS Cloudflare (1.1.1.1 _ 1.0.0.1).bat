@echo off
set adapters=Ethernet "Беспроводная сеть" "Бездротова мережа" "Wireless network"
for %%a in (!adapters!) do (
    netsh interface ipv4 set dns name=%%a dhcp >nul
)
