@echo off
set adapters=Ethernet "Беспроводная сеть" "Бездротова мережа" "Wireless network"
for %%a in (!adapters!) do (
    netsh interface ipv4 set dns name=%%a static 1.1.1.1 >nul
    netsh interface ip add dns name=%%a address=1.0.0.1 index=2 >nul
)
