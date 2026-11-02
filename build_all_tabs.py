#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
build_all_tabs.py

Оркестратор всех *_tabs.json-генераторов.
Запускает последовательно:
  build_tabs.py           → tabs.json (секции ОС-сборок)
  build_hardening_json.py → *_security/_privacy/_comfort/... _tabs.json
  build_apps_json.py      → apps_optimization_tabs.json
  build_drivers_json.py   → drivers_tabs.json
  build_removal_json.py   → removal_tabs.json

Один скрипт — всё пересобрано. Идеально для форка:
форкнул → поправил твики → `python build_all_tabs.py` → приложение работает.

Запуск:
    python build_all_tabs.py
    python build_all_tabs.py --dry
    python build_all_tabs.py --skip tabs
    python build_all_tabs.py --only drivers
"""

import argparse
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).parent

STEPS = [
    {
        "id": "full_tabs",
        "name": "build_full_tabs.py",
        "desc": "tabs.json — твики оптимизации + планы питания + твики исправлений",
    },
    {
        "id": "tabs",
        "name": "build_tabs.py",
        "desc": "tabs.json — секции ОС-сборок (Оптимизация, Электропитание, Кастомизация, …)",
    },
    {
        "id": "hardening",
        "name": "build_hardening_json.py",
        "desc": "Все *_tabs.json для секций Безопасность / Приватность / Удобство / Оптимизация / Кастомизация / Электропитание",
    },
    {
        "id": "apps",
        "name": "build_apps_json.py",
        "desc": "apps_optimization_tabs.json — твики для Браузеры / Игры / Приложения",
    },
    {
        "id": "drivers",
        "name": "build_drivers_json.py",
        "desc": "drivers_tabs.json — NVIDIA / AMD / Intel / DirectX / OpenGL / Память / Звук / …",
    },
    {
        "id": "removal",
        "name": "build_removal_json.py",
        "desc": "removal_tabs.json — батники удаления (Defender, Edge, OneDrive, …)",
    },
]


def find_python():
    for cand in ["python", "python3", "py"]:
        try:
            r = subprocess.run([cand, "--version"], capture_output=True, timeout=5)
            if r.returncode == 0:
                return cand
        except Exception:
            continue
    return None


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry", action="store_true",
                    help="Передать --dry во все скрипты (ничего не пишется)")
    ap.add_argument("--skip", action="append", default=[],
                    help="ID шагов, которые надо пропустить")
    ap.add_argument("--only", action="append", default=[],
                    help="Запустить только эти ID")
    args = ap.parse_args()

    python_exe = find_python()
    if not python_exe:
        print("❌ Python не найден в PATH (python / python3 / py)", file=sys.stderr)
        return 1

    print(f"🐍 Python: {python_exe}")
    print(f"📂 Корень проекта: {ROOT}\n")

    steps = []
    for step in STEPS:
        script = ROOT / step["name"]
        if not script.exists():
            print(f"⏭  {step['name']} — файла нет, пропускаем")
            continue
        if step["id"] in args.skip:
            print(f"⏭  {step['name']} — пропущен (--skip)")
            continue
        if args.only and step["id"] not in args.only:
            continue
        steps.append((step, script))

    if not steps:
        print("\n⚠ Нечего запускать")
        return 0

    failed = []
    t0 = time.time()

    for i, (step, script) in enumerate(steps, 1):
        print(f"\n[{i}/{len(steps)}] ▶ {step['name']}")
        print(f"    {step['desc']}")
        print(f"    {'─' * 62}")

        cmd = [python_exe, str(script)]
        if args.dry:
            cmd.append("--dry")

        try:
            r = subprocess.run(cmd, cwd=str(ROOT), timeout=600)
            if r.returncode != 0:
                failed.append(step["name"])
                print(f"    ❌ exit code: {r.returncode}")
            else:
                print(f"    ✅ OK")
        except subprocess.TimeoutExpired:
            failed.append(step["name"])
            print(f"    ❌ timeout (>10 мин)")
        except Exception as e:
            failed.append(step["name"])
            print(f"    ❌ {e}")

    dt = time.time() - t0
    print(f"\n{'═' * 62}")
    ok = len(steps) - len(failed)
    print(f"✅ Успешно: {ok} / {len(steps)}  ·  время: {dt:.1f}с")
    if failed:
        print(f"❌ Ошибки в: {', '.join(failed)}")
        return 1
    print("✨ Все скрипты выполнены")
    return 0


if __name__ == "__main__":
    sys.exit(main())