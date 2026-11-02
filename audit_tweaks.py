#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
audit_tweaks.py

Проверяет целостность метаданных твиков:
  • Все ли файлы, упомянутые в JSON, реально существуют на диске
  • Есть ли на диске твики, которые НЕ упомянуты ни в одном JSON («сироты»)
  • Находит битые/нечитаемые JSON

Помогает, когда:
  • Скрипт build_* сгенерировал JSON, но файл потом переименовали/удалили
  • Кто-то копировал твики руками и забыл пересобрать JSON
  • В форке поломалась структура папок

Формат вывода:
  <человекочитаемый отчёт>
  ITEM|MISSING|<path>|<source_json>
  ITEM|ORPHAN|<path>|-
  END|checked=N|missing=N|orphans=N

Запуск:
    python audit_tweaks.py
    python audit_tweaks.py --json   # краткий JSON-отчёт
"""

import argparse
import json
import sys
from pathlib import Path

ROOT = Path(__file__).parent
TWEAKS_DIR = ROOT / "tweaks"

TWEAK_EXTS = {".bat", ".cmd", ".exe", ".ps1", ".reg", ".pow"}

STATIC_JSONS = [
    "drivers_tabs.json",
    "apps_optimization_tabs.json",
    "removal_tabs.json",
]

# Обратный маппинг slug → имя папки сборки
BUILD_MAP = {
    "x_os":            ["XOS-Tweaks", "xOS", "xos"],
    "atlas_os":        ["AtlasOS", "AtlasOS-Tweaks"],
    "revi_os":         ["ReviOS", "ReviOS-Tweaks"],
    "immortal_os":     ["ImmortalOS", "ImmortalOS-Tweaks"],
    "marty_files":     ["MartyFiles"],
    "rapid_os":        ["RapidOS", "RapidOS-Tweaks"],
    "synergy_os":      ["SynergyOS-Tweaks", "SynergyOS"],
    "system_x":        ["SystemX", "SystemX-Tweaks"],
    "vain_os":         ["VainOS-Tweaks", "VainOS"],
    "igromanoff":      ["Igromanoff", "Igromanoff-Tweaks"],
    "hardening_kitty": ["HardeningKitty"],
    "extreme_os":      ["ExtremeOS"],
    "drugoe":          ["Другое"],
    "plany_elektropitaniya": ["Планы электропитания"],
}

# (suffix, section_folder) — длинные суффиксы первыми
TABS_SUFFIXES = [
    ("_customization_tabs.json", "Кастомизация"),
    ("_security_tabs.json",      "Безопасность"),
    ("_privacy_tabs.json",       "Приватность"),
    ("_comfort_tabs.json",       "Удобство"),
    ("_power_tabs.json",         "Электропитание"),
    ("_tabs.json",               "Оптимизация"),   # последний
]


def is_tweak(s) -> bool:
    return isinstance(s, str) and Path(s).suffix.lower() in TWEAK_EXTS


def guess_base_dir(json_name: str) -> str:
    for suffix, section in TABS_SUFFIXES:
        if json_name.endswith(suffix):
            slug = json_name[:-len(suffix)]
            candidates = BUILD_MAP.get(slug, [slug])
            for cand in candidates:
                p = TWEAKS_DIR / section / cand
                if p.is_dir():
                    return f"tweaks/{section}/{cand}"
            return f"tweaks/{section}/{candidates[0]}" if candidates else ""
    return ""


def collect_drivers_like(node: dict, out: list):
    """Рекурсивно собирает пути из узлов drivers_tabs.json / apps_optimization_tabs.json."""
    if not isinstance(node, dict):
        return
    base = node.get("baseDir", "")
    for f in node.get("files") or []:
        if is_tweak(f) and base:
            out.append(f"{base}/{f}".replace("\\", "/"))
    cd = node.get("cancelDir")
    if cd:
        for f in node.get("cancels") or []:
            if is_tweak(f) and base:
                out.append(f"{base}/{cd}/{f}".replace("\\", "/"))
    for sub in (node.get("subfolders") or {}).values():
        collect_drivers_like(sub, out)


def audit() -> dict:
    if not TWEAKS_DIR.is_dir():
        return {"error": f"Нет папки: {TWEAKS_DIR}"}

    missing = []
    mentioned = set()  # abs.lower()
    checked = 0

    def check(rel: str, src: str):
        nonlocal checked
        checked += 1
        abs_p = (ROOT / rel).resolve()
        mentioned.add(str(abs_p).lower())
        if not abs_p.exists():
            missing.append((rel, src))

    # 1. Статические JSON
    for name in STATIC_JSONS:
        p = TWEAKS_DIR / name
        if not p.exists():
            continue
        try:
            data = json.loads(p.read_text(encoding="utf-8"))
        except Exception as e:
            missing.append((f"{name} — parse error: {e}", name))
            continue

        paths = []
        if name == "removal_tabs.json":
            base = data.get("baseDir", "")
            for it in data.get("files") or []:
                if isinstance(it, dict) and it.get("name"):
                    if is_tweak(it["name"]) and base:
                        paths.append(f"{base}/{it['name']}".replace("\\", "/"))
        else:
            for sec_data in data.values():
                if isinstance(sec_data, dict):
                    collect_drivers_like(sec_data, paths)

        for rel in paths:
            check(rel, name)

    # 2. Все *_tabs.json
    seen = set()
    for suffix, _ in TABS_SUFFIXES:
        for p in TWEAKS_DIR.glob(f"*{suffix}"):
            if p.name in seen:
                continue
            seen.add(p.name)
            if p.name in STATIC_JSONS:
                continue

            base_dir = guess_base_dir(p.name)
            if not base_dir:
                continue

            try:
                data = json.loads(p.read_text(encoding="utf-8"))
            except Exception as e:
                missing.append((f"{p.name} — parse error: {e}", p.name))
                continue

            tabs = data.get("tabs")
            if not isinstance(tabs, dict):
                continue

            # Плоский: tabs.Root
            if isinstance(tabs.get("Root"), list):
                for f in tabs["Root"]:
                    if is_tweak(f):
                        check(f"{base_dir}/{f}".replace("\\", "/"), p.name)
                for k, v in tabs.items():
                    if k == "Root" or not isinstance(v, list):
                        continue
                    for f in v:
                        if is_tweak(f):
                            check(f"{base_dir}/{k}/{f}".replace("\\", "/"), p.name)
                continue

            # Группированный: tabs.<cat>.{Root, отмена}
            for cat, payload in tabs.items():
                if not isinstance(payload, dict):
                    continue
                for key, files in payload.items():
                    if not isinstance(files, list):
                        continue
                    for f in files:
                        if is_tweak(f):
                            check(f"{base_dir}/{cat}/{key}/{f}".replace("\\", "/"), p.name)

    # 3. Сироты — файлы на диске, которых нет ни в одном JSON
    orphans = []
    for p in TWEAKS_DIR.rglob("*"):
        if not p.is_file():
            continue
        if p.suffix.lower() not in TWEAK_EXTS:
            continue
        if p.name.startswith("_extreme_patch_"):
            continue
        abs_p = p.resolve()
        if str(abs_p).lower() in mentioned:
            continue
        rel = p.relative_to(TWEAKS_DIR).as_posix()
        # Игнорируем заведомо служебные папки
        if rel.startswith("_backups/") or rel.startswith("tweaks/"):
            continue
        orphans.append(rel)

    return {
        "checked": checked,
        "missing": missing,
        "orphans": sorted(orphans),
    }


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--json", action="store_true")
    args = ap.parse_args()

    result = audit()

    if "error" in result:
        print(f"❌ {result['error']}", file=sys.stderr)
        return 1

    if args.json:
        print(json.dumps({
            "checked": result["checked"],
            "missing": [{"path": p, "source": s} for p, s in result["missing"]],
            "orphans": result["orphans"],
        }, ensure_ascii=False, indent=2))
        return 0 if not result["missing"] else 2

    print(f"🔍 Аудит твиков: {TWEAKS_DIR}\n")
    print(f"Проверено путей:      {result['checked']}")
    print(f"Отсутствует на диске: {len(result['missing'])}")
    print(f"Не упомянуто в JSON:  {len(result['orphans'])}\n")

    if result["missing"]:
        print("❌ ОТСУТСТВУЮТ (упомянуты в JSON, но файла нет):")
        for path, src in result["missing"][:50]:
            print(f"   MISSING | {path}")
            print(f"           ← {src}")
        if len(result["missing"]) > 50:
            print(f"   … и ещё {len(result['missing']) - 50}")
        print()

    if result["orphans"]:
        print("⚠ ФАЙЛЫ БЕЗ УПОМИНАНИЯ (возможно, забыл добавить):")
        for path in result["orphans"][:40]:
            print(f"   ORPHAN | {path}")
        if len(result["orphans"]) > 40:
            print(f"   … и ещё {len(result['orphans']) - 40}")
        print()

    for path, src in result["missing"]:
        print(f"ITEM|MISSING|{path}|{src}")
    for path in result["orphans"]:
        print(f"ITEM|ORPHAN|{path}|-")
    print(f"END|checked={result['checked']}|missing={len(result['missing'])}|orphans={len(result['orphans'])}")

    return 0 if not result["missing"] else 2


if __name__ == "__main__":
    sys.exit(main())