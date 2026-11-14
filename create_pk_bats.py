#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from pathlib import Path

BASE = Path("tweaks") / "Электропитание" / "PowerKiller"

GUID_BALANCED = "381b4222-f694-41f0-9685-ff5bb260df2e"
GUID_HIGH     = "8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"
GUID_SAVER    = "a1841308-3541-4fab-bc81-f71556f20b4a"

SUB_PROC  = "54533251-82be-4824-96c1-47b60b740d00"
SUB_DISK  = "0012ee47-9041-4b5d-9b77-535fba8b1442"
SUB_USB   = "2a737441-1930-4402-8d77-b2bebba308a3"
SUB_VIDEO = "7516b95f-f776-4464-8c53-06167f40cc99"

DISKIDLE        = "6738e2c4-e8a5-4a42-b16a-e040e769756e"
USBSUSPEND      = "48e6b7a6-50f5-4782-a5d4-53bb8f07e226"
VIDEOIDLE       = "3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e"
PROCTHROTTLEMIN = "893dee8e-2bef-41e0-89c6-b55d0929964c"
PROCTHROTTLEMAX = "bc5038f7-23e0-4960-96da-33abaf5935ec"
CPMINCORES      = "0cc5b647-c1df-4637-891a-dec35c318583"
CPMAXCORES      = "ea062031-0e34-4ff1-9b6d-eb1059334028"
IDLEDISABLE     = "5d76a2ca-e8c0-402f-a133-2158492d58ad"
PERFINCPOL      = "465e1f50-b610-473a-ab58-00d1077dc418"
PERFDECPOL      = "40fbefc7-2e9d-4d25-a185-0cfd8574bac6"
PERFEPP         = "36687f9e-e3a5-4dbf-b1dc-15eb381c6863"
PERFBOOSTMODE   = "be337238-0d82-4146-a960-4f3749d470c7"
SYSCOOLPOL      = "94d3a615-a899-4ac5-ae2b-e4d8f634367f"

PLANS = [
    {"id": "BalancedPerformance", "name": "Balanced Performance",
     "guid": "90a358c8-3bbc-4fb3-8b4e-d7ab065d2614", "base": GUID_BALANCED,
     "desc": "Balanced performance for everyday tasks",
     "tweaks": [(SUB_VIDEO, VIDEOIDLE, 900, 300)]},

    {"id": "MaximumPerformance", "name": "Maximum Performance",
     "guid": "a1b2c3d4-e5f6-4789-a0ab-cdef12345678", "base": GUID_HIGH,
     "desc": "Maximum performance in games and work applications",
     "tweaks": [(SUB_VIDEO, VIDEOIDLE, 900, 600)]},

    {"id": "PowerSaving", "name": "Power Saving",
     "guid": "d8e76bb7-6943-4b7c-ab30-441296b72264", "base": GUID_SAVER,
     "desc": "Reduced power consumption and maximum battery life",
     "tweaks": [(SUB_VIDEO, VIDEOIDLE, 300, 120)]},

    {"id": "NFSRacing", "name": "NFS Racing",
     "guid": "b2c3d4e5-f6a7-4890-b1c2-def345678901", "base": GUID_HIGH,
     "desc": "Race-optimized, stable frametime, no CPU throttle",
     "tweaks": [
         (SUB_PROC, PROCTHROTTLEMIN, 100, 100),
         (SUB_PROC, PROCTHROTTLEMAX, 100, 100),
         (SUB_PROC, CPMINCORES, 100, 100),
         (SUB_VIDEO, VIDEOIDLE, 900, 600),
     ]},

    {"id": "Shooter", "name": "Shooter Low-Latency",
     "guid": "c3d4e5f6-a7b8-4901-c2d3-ef4567890123", "base": GUID_HIGH,
     "desc": "Low input latency for competitive shooters",
     "tweaks": [
         (SUB_PROC, PROCTHROTTLEMIN, 100, 100),
         (SUB_PROC, PROCTHROTTLEMAX, 100, 100),
         (SUB_PROC, CPMINCORES, 100, 100),
         (SUB_PROC, PERFINCPOL, 2, 2),
         (SUB_PROC, PERFDECPOL, 1, 1),
         (SUB_VIDEO, VIDEOIDLE, 900, 600),
     ]},

    {"id": "InputLag", "name": "Minimal Input Lag",
     "guid": "d4e5f6a7-b8c9-4012-d3e4-f56789012345", "base": GUID_HIGH,
     "desc": "Aggressive latency reduction for esports",
     "tweaks": [
         (SUB_PROC, PROCTHROTTLEMIN, 100, 100),
         (SUB_PROC, PROCTHROTTLEMAX, 100, 100),
         (SUB_PROC, CPMINCORES, 100, 100),
         (SUB_PROC, IDLEDISABLE, 1, 1),
         (SUB_PROC, PERFINCPOL, 2, 2),
         (SUB_PROC, PERFDECPOL, 1, 1),
         (SUB_VIDEO, VIDEOIDLE, 900, 600),
     ]},

    {"id": "EnergeticDeath", "name": "Energetic Death",
     "guid": "7f8e9d0c-1b2a-4c3d-9e8f-a0b1c2d3e4f5", "base": GUID_HIGH,
     "desc": "Maximum CPU power, no idle, aggressive boost",
     "tweaks": [
         (SUB_PROC, PROCTHROTTLEMIN, 100, 100),
         (SUB_PROC, PROCTHROTTLEMAX, 100, 100),
         (SUB_PROC, CPMINCORES, 100, 100),
         (SUB_PROC, IDLEDISABLE, 1, 1),
         (SUB_PROC, PERFINCPOL, 2, 2),
         (SUB_PROC, PERFDECPOL, 0, 0),
         (SUB_PROC, PERFEPP, 0, 0),
         (SUB_PROC, PERFBOOSTMODE, 2, 2),
         (SUB_PROC, SYSCOOLPOL, 1, 1),
         (SUB_VIDEO, VIDEOIDLE, 0, 0),
         (SUB_DISK, DISKIDLE, 0, 0),
         (SUB_USB, USBSUSPEND, 0, 0),
     ]},

    {"id": "PowerKiller", "name": "Power Killer",
     "guid": "8f0a1b2c-3d4e-5f60-a1b2-c3d4e5f60718", "base": GUID_HIGH,
     "desc": "Absolute maximum, all cores pinned",
     "tweaks": [
         (SUB_PROC, PROCTHROTTLEMIN, 100, 100),
         (SUB_PROC, PROCTHROTTLEMAX, 100, 100),
         (SUB_PROC, CPMINCORES, 100, 100),
         (SUB_PROC, CPMAXCORES, 100, 100),
         (SUB_PROC, IDLEDISABLE, 1, 1),
         (SUB_PROC, PERFINCPOL, 2, 2),
         (SUB_PROC, PERFDECPOL, 0, 0),
         (SUB_PROC, PERFEPP, 0, 0),
         (SUB_PROC, PERFBOOSTMODE, 2, 2),
         (SUB_PROC, SYSCOOLPOL, 1, 1),
         (SUB_VIDEO, VIDEOIDLE, 0, 0),
         (SUB_DISK, DISKIDLE, 0, 0),
         (SUB_USB, USBSUSPEND, 0, 0),
     ]},
]


def wbat(name, lines):
    p = BASE / name
    with open(p, "w", encoding="utf-8", newline="") as f:
        f.write("\r\n".join(lines).rstrip() + "\r\n")
    print(f"  + {name}")


def wreg(name, lines):
    p = BASE / name
    with open(p, "w", encoding="utf-16", newline="") as f:
        f.write("\r\n".join(lines).rstrip() + "\r\n")
    print(f"  + {name}")


def activate_bat(plan):
    L = [
        "@echo off",
        "setlocal",
        f'set "GUID={plan["guid"]}"',
        "",
        ":: Ensure scheme exists",
        'powercfg /list | findstr /i "%GUID%" >nul',
        "if not errorlevel 1 goto :activate",
        "",
        "echo [*] Creating scheme...",
        f'powercfg /duplicatescheme {plan["base"]} %GUID% >nul',
        f'powercfg /changename %GUID% "{plan["name"]}" "{plan["desc"]}" >nul',
    ]
    for sub, setting, ac, dc in plan["tweaks"]:
        L.append(f"powercfg /setacvalueindex %GUID% {sub} {setting} {ac} >nul 2>&1")
        L.append(f"powercfg /setdcvalueindex %GUID% {sub} {setting} {dc} >nul 2>&1")
    L += [
        "",
        ":activate",
        "powercfg /setactive %GUID%",
        "if errorlevel 1 (",
        f'    echo [!] Failed to activate "{plan["name"]}"',
        "    exit /b 1",
        ")",
        f'echo OK: "{plan["name"]}" activated.',
    ]
    return L


def create_all_bat():
    L = [
        "@echo off",
        "setlocal",
        "net session >nul 2>&1 || (echo [!] Run as Administrator. & pause & exit /b 1)",
        "",
        "echo Creating/verifying all VampireOS power plans...",
        "",
    ]
    for plan in PLANS:
        L += [
            f'echo Checking: {plan["name"]}',
            f'set "GUID={plan["guid"]}"',
            'powercfg /list | findstr /i "%GUID%" >nul',
            "if not errorlevel 1 (",
            "    echo   [OK] already exists",
            ") else (",
            "    echo   [*] creating...",
            f'    powercfg /duplicatescheme {plan["base"]} %GUID% >nul',
            f'    powercfg /changename %GUID% "{plan["name"]}" "{plan["desc"]}" >nul',
        ]
        for sub, setting, ac, dc in plan["tweaks"]:
            L.append(f"    powercfg /setacvalueindex %GUID% {sub} {setting} {ac} >nul 2>&1")
            L.append(f"    powercfg /setdcvalueindex %GUID% {sub} {setting} {dc} >nul 2>&1")
        L += [
            "    echo   [DONE]",
            ")",
            "",
        ]
    L += ["echo.", "echo All plans are ready.", "powercfg /list"]
    return L


def bloodenergy_reg():
    root = r"HKEY_CLASSES_ROOT\DesktopBackground\Shell\BloodEnergy"
    L = ["Windows Registry Editor Version 5.00", ""]

    L += [
        f"[{root}]",
        '"MUIVerb"="Blood Energy"',
        '"Icon"="powercpl.dll"',
        '"SubCommands"=""',
        '"Position"="Bottom"',
        "",
    ]

    for i, plan in enumerate(PLANS, start=1):
        key = f"{i:02d}menu"
        L += [
            f"[{root}\\shell\\{key}]",
            f'"MUIVerb"="{plan["name"]}"',
            "",
            f"[{root}\\shell\\{key}\\command]",
            f'@="cmd.exe /c powercfg /setactive {plan["guid"]}"',
            "",
        ]

    standard = [
        ("Сбалансированная", "381b4222-f694-41f0-9685-ff5bb260df2e"),
        ("Высокая производительность", "8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"),
        ("Максимальная производительность", "e9a42b02-d5df-448d-aa00-03f14749eb61"),
        ("Энергосбережение", "a1841308-3541-4fab-bc81-f71556f20b4a"),
    ]
    for i, (label, guid) in enumerate(standard, start=11):
        key = f"{i:02d}menu"
        L += [
            f"[{root}\\shell\\{key}]",
            f'"MUIVerb"="{label}"',
            "",
            f"[{root}\\shell\\{key}\\command]",
            f'@="cmd.exe /c powercfg /setactive {guid}"',
            "",
        ]

    for i, (label, val) in enumerate([("Disable Idle", 1), ("Enable Idle", 0)], start=21):
        key = f"{i:02d}menu"
        cmd = (
            "cmd.exe /c powercfg -setacvalueindex scheme_current "
            f"sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad {val} "
            "&& powercfg -setactive scheme_current"
        )
        L += [
            f"[{root}\\shell\\{key}]",
            f'"MUIVerb"="{label}"',
            "",
            f"[{root}\\shell\\{key}\\command]",
            f'@="{cmd}"',
            "",
        ]
    return L


def installer_bat():
    return [
        "@echo off",
        "setlocal",
        "net session >nul 2>&1 || (echo [!] Run as Administrator. & pause & exit /b 1)",
        'cd /d "%~dp0"',
        "",
        "echo ============================================================",
        "echo  Installing Blood Energy context menu",
        "echo ============================================================",
        "",
        "echo [1/3] Cleaning old installs (both paths)...",
        'reg delete "HKCR\\DesktopBackground\\Shell\\PowerPlan\\shell\\BloodEnergy" /f >nul 2>&1',
        'reg delete "HKCR\\DesktopBackground\\Shell\\BloodEnergy" /f >nul 2>&1',
        "",
        "echo [2/3] Creating all VampireOS power plans...",
        'call "%~dp0PK_Create_All_Plans.bat"',
        "",
        "echo [3/3] Importing Blood Energy menu...",
        'if not exist "%~dp0PK_BloodEnergy.reg" (',
        "    echo [!] PK_BloodEnergy.reg not found next to this installer.",
        "    pause",
        "    exit /b 1",
        ")",
        'reg import "%~dp0PK_BloodEnergy.reg"',
        "if errorlevel 1 (",
        "    echo [!] Registry import failed.",
        "    pause",
        "    exit /b 1",
        ")",
        "",
        "echo.",
        "echo ============================================================",
        "echo  Blood Energy menu installed at TOP level.",
        "echo  Right-click desktop to use it.",
        "echo ============================================================",
        "echo.",
        "echo Installed entries:",
        'reg query "HKCR\\DesktopBackground\\Shell\\BloodEnergy\\shell" /s 2>nul | findstr "MUIVerb"',
        "echo.",
        "pause",
    ]


def remover_bat():
    return [
        "@echo off",
        "setlocal",
        "net session >nul 2>&1 || (echo [!] Run as Administrator. & pause & exit /b 1)",
        "",
        'reg delete "HKCR\\DesktopBackground\\Shell\\BloodEnergy" /f >nul 2>&1',
        'reg delete "HKCR\\DesktopBackground\\Shell\\PowerPlan\\shell\\BloodEnergy" /f >nul 2>&1',
        "echo Blood Energy menu removed.",
    ]


def main():
    print(f"Target: {BASE.resolve()}")
    BASE.mkdir(parents=True, exist_ok=True)
    print()

    print("Per-plan activate scripts:")
    for plan in PLANS:
        wbat(f"PK_Activate_{plan['id']}.bat", activate_bat(plan))

    print()
    print("Create-all:")
    wbat("PK_Create_All_Plans.bat", create_all_bat())

    print()
    print("Blood Energy registry (UTF-16 LE):")
    wreg("PK_BloodEnergy.reg", bloodenergy_reg())

    print()
    print("Installer / remover / opener:")
    wbat("PK_ContextMenu_BloodEnergy_Install.bat", installer_bat())
    wbat("PK_ContextMenu_BloodEnergy_Remove.bat", remover_bat())
    wbat("PK_Open_PowerPanel.bat", ["@echo off", 'start "" control.exe powercfg.cpl'])

    print()
    print(f"Done. {len(PLANS) + 5} files created.")


if __name__ == "__main__":
    main()