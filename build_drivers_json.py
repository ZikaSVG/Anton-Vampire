#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
build_drivers_json.py

Сканирует tweaks/Драйверы/ и генерирует tweaks/drivers_tabs.json.

Структура JSON — каждый узел:
  {
    "baseDir": "tweaks/Драйверы/<путь>",
    "files":   [...],
    "cancels": [...],       # файлы из папки отмены этого узла
    "cancelDir": "Возврат", # имя папки отмены (None если нет)
    "subfolders": {         # рекурсивно
       "<имя>": { ... }
    }
  }

Секции с label/color/icon — рендерятся в UI как чекбоксы.
Дропдауны (svchost/win32/services) — тоже узлы, но в UI рисуются
выпадающим списком.

Запуск:
    python build_drivers_json.py
    python build_drivers_json.py --dry
"""

import argparse
import json
import sys
from pathlib import Path

ROOT = Path(__file__).parent
DRIVERS_DIR = ROOT / "tweaks" / "Драйверы"
OUTPUT_FILE = ROOT / "tweaks" / "drivers_tabs.json"

TWEAK_EXTS = {".bat", ".cmd", ".exe", ".ps1", ".reg", ".pow"}

CANCEL_KEYS = (
    "отмена", "Отмена", "ОТМЕНА",
    "cancel", "Cancel", "CANCEL",
    "Возврат", "возврат", "ВОЗВРАТ",
    "Вернуть", "вернуть", "ВЕРНУТЬ",
    "Откат", "откат", "ОТКАТ",
    "Restore", "restore",
    "Revert", "revert",
)

# ────────────────────────────────────────────────────────────
# Секции-«чекбоксы» в порядке отображения
# (section_id, имя_папки, label, color, icon)
# DirectX / OpenGL — спец: берём из подпапок DirectX/
# ────────────────────────────────────────────────────────────
VENDOR_FOLDERS = [
    ("nvidia",   "Оптимизация Nvidia",  "NVIDIA",          "#76b900", "nvidia"),
    ("amd",      "Оптимизация Amd",     "AMD",             "#ed1c24", "amd"),
    ("intel",    "Оптимизация Intel",   "Intel",           "#0071c5", "intel"),
    ("directx",  "DirectX",             "DirectX",         "#4a9eff", "directx"),
    ("opengl",   "DirectX",             "OpenGL",          "#ffbd05", "opengl"),
    ("memory",   "Память",              "Память",          "#c16e00", None),
    ("sound",    "Звук",                "Звук",            "#ff6b35", None),
    ("keyboard", "Клавиатура",          "Клавиатура",      "#8e7cc3", None),
    ("mouse",    "Мышка",               "Мышка",           "#e91e63", None),
    ("hyperv",   "Hyper-V",             "Hyper-V",         "#5c2d91", None),
    ("tweaks",   "Твики",               "Твики",           "#607d8b", None),
    ("network",  "Сеть и интернет",     "Сеть и интернет", "#4ab5ff", None),
]

# DirectX / OpenGL — из какой подпапки DirectX/ брать файлы
DIRECTX_SUBFOLDERS = {
    "directx": "Оптимизация DirectX",
    "opengl":  "Оптимизация OpenGL",
}

# ────────────────────────────────────────────────────────────
# Дропдауны — в UI рисуются select-ом
# (section_id, имя_папки)
# ────────────────────────────────────────────────────────────
DROPDOWN_FOLDERS = [
    ("svchost",  "Порог разделения svchost"),
    ("win32",    "Разделение приоритетов Win32"),
    ("services", "Службы"),
]


def rel_to_root(folder: Path) -> str:
    try:
        return str(folder.relative_to(ROOT)).replace("\\", "/")
    except ValueError:
        return str(folder).replace("\\", "/")


def is_tweak(name: str) -> bool:
    if name.startswith("_extreme_patch_"):
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
    """Рекурсивно: файлы + их отмена + подпапки (кроме папок отмены)."""
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

    if not DRIVERS_DIR.is_dir():
        print(f"❌ Нет папки: {DRIVERS_DIR}", file=sys.stderr)
        return 1

    result = {}

    print(f"📂 {DRIVERS_DIR}\n")

    # ─── 1. Секции-чекбоксы ───
    print("── Секции чекбоксов ──")
    for sec_id, folder_name, label, color, icon in VENDOR_FOLDERS:
        if sec_id in DIRECTX_SUBFOLDERS:
            folder = DRIVERS_DIR / "DirectX" / DIRECTX_SUBFOLDERS[sec_id]
        else:
            folder = DRIVERS_DIR / folder_name

        data = scan_folder(folder)
        result[sec_id] = {
            "label":     label,
            "color":     color,
            "icon":      icon,
            **data,
        }

        n_flat = len(data["files"])
        n_sub  = len(data["subfolders"])
        n_all  = count_all(data)
        print(f"  {sec_id:10s} {label:18s} "
              f"плоско={n_flat:<3} подпапок={n_sub}  всего={n_all}")

    # ─── 2. Дропдауны ───
    print("\n── Дропдауны ──")
    for sec_id, folder_name in DROPDOWN_FOLDERS:
        folder = DRIVERS_DIR / folder_name
        files = list_files(folder)
        result[sec_id] = {
            "baseDir":    rel_to_root(folder),
            "files":      files,
            "cancels":    [],
            "cancelDir":  None,
            "subfolders": {},
        }
        print(f"  {sec_id:10s} {folder_name:30s} файлов={len(files)}")

    text = json.dumps(result, ensure_ascii=False, indent=2) + "\n"

    if args.dry:
        print("\n--- dry-run: drivers_tabs.json ---\n")
        print(text)
        return 0

    OUTPUT_FILE.write_text(text, encoding="utf-8")

    total = sum(count_all(node) for node in result.values())
    print(f"\n✅ {OUTPUT_FILE}")
    print(f"   Секций: {len(VENDOR_FOLDERS)}  +  дропдаунов: {len(DROPDOWN_FOLDERS)}")
    print(f"   Всего файлов в JSON: {total}")
    return 0


if __name__ == "__main__":
    sys.exit(main())