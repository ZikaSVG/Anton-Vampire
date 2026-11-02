#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
build_apps_json.py

Сканирует tweaks/Оптимизация/Apps/ и генерирует tweaks/apps_optimization_tabs.json.

Структура JSON (рекурсивная, как drivers_tabs.json):
{
  "browsers": {
    "label": "🌐 Браузеры",
    "baseDir": "tweaks/Оптимизация/Apps/Браузеры",
    "files": [],
    "cancels": [],
    "cancelDir": null,
    "subfolders": {
      "Brave": { ... },
      "Google Chrome": { ... }
    }
  },
  "games": { ... },
  "programs": { ... }
}

Запуск:
    python build_apps_json.py
    python build_apps_json.py --dry
"""

import argparse
import json
import sys
from pathlib import Path

ROOT = Path(__file__).parent
APPS_DIR = ROOT / "tweaks" / "Оптимизация" / "Apps"
OUTPUT_FILE = ROOT / "tweaks" / "apps_optimization_tabs.json"

TWEAK_EXTS = {".bat", ".cmd", ".exe", ".reg", ".pow", ".ps1"}

# Вспомогательные файлы, которые не надо считать твиками
EXCLUDE_FILES = {"ngen.ps1", "RunAsTI.reg", "SFTA.ps1"}

CANCEL_KEYS = (
    "отмена", "Отмена", "ОТМЕНА",
    "cancel", "Cancel", "CANCEL",
    "Возврат", "возврат", "ВОЗВРАТ",
    "Вернуть", "вернуть", "ВЕРНУТЬ",
    "Откат", "откат", "ОТКАТ",
    "Restore", "restore",
    "Revert", "revert",
)

# (section_id, имя_папки, label)
SECTION_MAP = [
    ("browsers", "Браузеры",   "🌐 Браузеры"),
    ("games",    "Игры",       "🎮 Игры"),
    ("programs", "Приложения", "📱 Приложения"),
]


def rel_to_root(folder: Path) -> str:
    try:
        return str(folder.relative_to(ROOT)).replace("\\", "/")
    except ValueError:
        return str(folder).replace("\\", "/")


def is_tweak(name: str) -> bool:
    if name.startswith("_extreme_patch_"):
        return False
    if name in EXCLUDE_FILES:
        return False
    return Path(name).suffix.lower() in TWEAK_EXTS


def list_files(folder: Path) -> list:
    if not folder.is_dir():
        return []
    return sorted(
        [p.name for p in folder.iterdir() if p.is_file() and is_tweak(p.name)],
        key=lambda s: s.lower(),
    )


def find_cancel_folder(folder: Path):
    if not folder.is_dir():
        return None, None
    for key in CANCEL_KEYS:
        candidate = folder / key
        if candidate.is_dir() and list_files(candidate):
            return key, candidate
    return None, None


def scan_folder(folder: Path) -> dict:
    if not folder.is_dir():
        return {
            "baseDir": rel_to_root(folder),
            "files": [], "cancels": [], "cancelDir": None, "subfolders": {},
        }

    flat = list_files(folder)
    cancel_name, cancel_folder = find_cancel_folder(folder)
    flat_cancels = list_files(cancel_folder) if cancel_folder else []

    subfolders = {}
    for child in sorted(folder.iterdir(), key=lambda p: p.name.lower()):
        if not child.is_dir() or child.name in CANCEL_KEYS:
            continue
        sub = scan_folder(child)
        if sub["files"] or sub["subfolders"]:
            subfolders[child.name] = sub

    return {
        "baseDir": rel_to_root(folder),
        "files": flat,
        "cancels": flat_cancels,
        "cancelDir": cancel_name,
        "subfolders": subfolders,
    }


def count_all(node: dict) -> int:
    n = len(node.get("files") or [])
    for sub in (node.get("subfolders") or {}).values():
        n += count_all(sub)
    return n


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry", action="store_true")
    args = ap.parse_args()

    if not APPS_DIR.is_dir():
        print(f"❌ Нет папки: {APPS_DIR}", file=sys.stderr)
        return 1

    result = {}

    print(f"📂 {APPS_DIR}\n")

    for sec_id, folder_name, label in SECTION_MAP:
        folder = APPS_DIR / folder_name
        data = scan_folder(folder)
        result[sec_id] = {
            "label": label,
            **data,
        }
        n_flat = len(data["files"])
        n_sub  = len(data["subfolders"])
        n_all  = count_all(data)
        print(f"  {sec_id:10s} {label:18s} "
              f"плоско={n_flat:<3} подпапок={n_sub}  всего={n_all}")

    text = json.dumps(result, ensure_ascii=False, indent=2) + "\n"

    if args.dry:
        print("\n--- dry-run: apps_optimization_tabs.json ---\n")
        print(text)
        return 0

    OUTPUT_FILE.write_text(text, encoding="utf-8")
    total = sum(count_all(n) for n in result.values())
    print(f"\n✅ {OUTPUT_FILE}")
    print(f"   Всего файлов: {total}")
    return 0


if __name__ == "__main__":
    sys.exit(main())