#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
build_hardening_json.py

Генерирует *_tabs.json для ВСЕХ сборок в секциях:
    tweaks/Безопасность/<Сборка>/
    tweaks/Приватность/<Сборка>/
    tweaks/Удобство/<Сборка>/

Имя выходного файла:
    tweaks/<build_slug>_<section_slug>_tabs.json

Примеры:
    tweaks/Безопасность/HardeningKitty/  → tweaks/hardening_kitty_security_tabs.json
    tweaks/Удобство/HardeningKitty/      → tweaks/hardening_kitty_comfort_tabs.json
    tweaks/Приватность/AtlasOS/          → tweaks/atlas_os_privacy_tabs.json
    tweaks/Приватность/XOS-Tweaks/       → tweaks/x_os_privacy_tabs.json
    tweaks/Приватность/ExtremeOS/        → tweaks/extreme_os_privacy_tabs.json

Формат JSON — определяется структурой папки сборки:
  • Файлы лежат ПРЯМО в <Сборка>/ (без подпапок-категорий) → ПЛОСКИЙ:
        { "tabs": { "Root": [...], "отмена": [...] } }
    (sources.js с flatCategories: true кладёт файлы прямо в baseDir)
  • Есть подпапки-категории → ГРУППИРОВАННЫЙ:
        { "tabs": { "Категория1": { "Root": [...], "отмена": [...] }, ... } }
    (sources.js без flatCategories кладёт файлы в baseDir/<категория>/)

Пары «твик ↔ отмена» — по подпапке отмена/Отмена/cancel.
Ключ отмены сохраняется фактическим (отмена / Отмена / cancel).

Запуск:
    python build_hardening_json.py                      # все секции, все сборки
    python build_hardening_json.py --dry                # показать, не писать
    python build_hardening_json.py --only security      # только Безопасность
    python build_hardening_json.py --only privacy
    python build_hardening_json.py --only comfort
    python build_hardening_json.py --section Приватность
    python build_hardening_json.py --build AtlasOS
"""

import argparse
import json
import re
import sys
from pathlib import Path

# ------------------------------------------------------------------
# Конфиг
# ------------------------------------------------------------------
TWEAKS_DIR = Path(__file__).parent / "tweaks"

# Секции: (имя_папки, слаг_для_имени_json)
SECTIONS = [
    ("Безопасность", "security"),
    ("Приватность",  "privacy"),
    ("Удобство",     "comfort"),
]

# Расширения файлов-твиков
TWEAK_EXTS  = {".bat", ".cmd", ".exe", ".ps1", ".reg", ".pow"}

# Имена подпапок отмены
CANCEL_KEYS = ("отмена", "Отмена", "ОТМЕНА", "cancel", "Cancel")

# Соответствие --only → имя секции
ONLY_MAP = {
    "security": "Безопасность",
    "comfort":  "Удобство",
    "privacy":  "Приватность",
}


# ------------------------------------------------------------------
# Слагификация имён папок → латиница + подчёркивания
# ------------------------------------------------------------------
_TRANSLIT = {
    'а':'a','б':'b','в':'v','г':'g','д':'d','е':'e','ё':'e','ж':'zh','з':'z',
    'и':'i','й':'y','к':'k','л':'l','м':'m','н':'n','о':'o','п':'p','р':'r',
    'с':'s','т':'t','у':'u','ф':'f','х':'kh','ц':'ts','ч':'ch','ш':'sh',
    'щ':'shch','ъ':'','ы':'y','ь':'','э':'e','ю':'yu','я':'ya',
}

def slugify(name: str) -> str:
    """'XOS-Tweaks' → 'x_os'; 'AtlasOS' → 'atlas_os'; 'Приватность' → 'privacy'."""
    # Частные случаи, чтобы имена совпадали с тем, что уже есть в проекте
    special = {
        "xos-tweaks":    "x_os",
        "xos":           "x_os",
        "atlasos":       "atlas_os",
        "extremeos":     "extreme_os",
        "revios-tweaks": "revi_os",
        "revios":        "revi_os",
        "immortalos":    "immortal_os",
        "martyfiles":    "marty_files",
        "rapidos":       "rapid_os",
        "synergyos":     "synergy_os",
        "systemx":       "system_x",
        "vainos-tweaks": "vain_os",
        "vainos":        "vain_os",
        "igromanoff-tweaks": "igromanoff",
        "hardeningkitty": "hardening_kitty",
        "безопасность":  "security",
        "приватность":   "privacy",
        "удобство":      "comfort",
    }
    low = name.strip().lower()
    if low in special:
        return special[low]

    # Транслит
    s = ''.join(_TRANSLIT.get(ch, ch) for ch in low)
    # Всё не-буквенно-цифровое → _
    s = re.sub(r'[^a-z0-9]+', '_', s)
    s = s.strip('_')
    return s or "unnamed"


# ------------------------------------------------------------------
# Утилиты
# ------------------------------------------------------------------
def is_tweak_file(name: str) -> bool:
    return Path(name).suffix.lower() in TWEAK_EXTS


def list_flat_files(folder: Path) -> list[str]:
    """Отсортированный список файлов-твиков в папке (без рекурсии)."""
    if not folder.is_dir():
        return []
    files = [
        p.name
        for p in folder.iterdir()
        if p.is_file() and is_tweak_file(p.name)
    ]
    files.sort(key=lambda s: s.lower())
    return files


def list_cancel_files(folder: Path) -> tuple[str | None, list[str]]:
    """Ищет подпапку отмены (отмена / Отмена / cancel / ...)."""
    if not folder.is_dir():
        return None, []
    for child in folder.iterdir():
        if child.is_dir() and child.name in CANCEL_KEYS:
            files = list_flat_files(child)
            if files:
                return child.name, files
    return None, []


def has_category_subdirs(folder: Path) -> bool:
    """
    True, если в папке есть подпапки-категории с твиками
    (кроме подпапок отмены).
    """
    if not folder.is_dir():
        return False
    for child in folder.iterdir():
        if not child.is_dir():
            continue
        if child.name in CANCEL_KEYS:
            continue
        if list_flat_files(child):
            return True
    return False


def build_flat_json(folder: Path) -> dict | None:
    """Плоский формат: файлы прямо в folder."""
    root_files = list_flat_files(folder)
    if not root_files:
        return None

    cancel_key, cancel_files = list_cancel_files(folder)

    payload = {"Root": root_files}
    if cancel_files:
        payload[cancel_key] = cancel_files
    else:
        payload["отмена"] = []

    return {"tabs": payload}


def build_grouped_json(folder: Path) -> dict | None:
    """
    Группированный формат: подпапки folder = категории.
    Для каждой категории — свой { Root: [...], отмена: [...] }.
    """
    if not folder.is_dir():
        return None

    tabs = {}
    for child in sorted(folder.iterdir(), key=lambda p: p.name.lower()):
        if not child.is_dir():
            continue
        if child.name in CANCEL_KEYS:
            continue
        files = list_flat_files(child)
        if not files:
            continue

        cancel_key, cancel_files = list_cancel_files(child)

        payload = {"Root": files}
        if cancel_files:
            payload[cancel_key] = cancel_files
        else:
            payload["отмена"] = []

        tabs[child.name] = payload

    if not tabs:
        return None
    return {"tabs": tabs}


def build_json_for(folder: Path) -> tuple[dict | None, str]:
    """
    Определяет формат по структуре папки и возвращает (data, kind),
    где kind = 'flat' | 'grouped' | 'empty'.
    """
    if has_category_subdirs(folder):
        data = build_grouped_json(folder)
        if data:
            return data, "grouped"

    data = build_flat_json(folder)
    if data:
        return data, "flat"

    return None, "empty"


def write_json(path: Path, data: dict, dry: bool, kind: str) -> None:
    text = json.dumps(data, ensure_ascii=False, indent=2) + "\n"
    if dry:
        print(f"\n--- {path} ({kind}, dry-run) ---")
        print(text)
        return
    path.write_text(text, encoding="utf-8")
    if kind == "flat":
        count = len(data["tabs"].get("Root", []))
    else:
        count = sum(len(v.get("Root", [])) for v in data["tabs"].values())
    print(f"✅ Записан: {path}  ({kind}, {count} твиков)")


# ------------------------------------------------------------------
# main
# ------------------------------------------------------------------
def main() -> int:
    ap = argparse.ArgumentParser(
        description="Генератор *_tabs.json для всех сборок в секциях "
                    "Безопасность / Приватность / Удобство"
    )
    ap.add_argument("--dry", action="store_true",
                    help="Не писать файлы, только показать")
    ap.add_argument("--only", choices=["security", "comfort", "privacy", "all"],
                    default="all", help="Какая секция")
    ap.add_argument("--section",
                    help="Имя папки секции (например, Приватность)")
    ap.add_argument("--build",
                    help="Имя папки сборки (например, AtlasOS)")
    args = ap.parse_args()

    if not TWEAKS_DIR.is_dir():
        print(f"❌ Папка не найдена: {TWEAKS_DIR}", file=sys.stderr)
        return 1

    total = 0
    for section_name, section_slug in SECTIONS:
        if args.only != "all":
            if ONLY_MAP.get(args.only) != section_name:
                continue
        if args.section and args.section != section_name:
            continue

        section_dir = TWEAKS_DIR / section_name
        if not section_dir.is_dir():
            print(f"⏭  Нет папки секции: {section_dir}")
            continue

        # Каждая подпапка = сборка
        for build_dir in sorted(section_dir.iterdir(), key=lambda p: p.name.lower()):
            if not build_dir.is_dir():
                continue
            if build_dir.name in CANCEL_KEYS:
                continue
            if args.build and args.build != build_dir.name:
                continue

            data, kind = build_json_for(build_dir)
            if not data:
                print(f"⏭  Пропуск (нет твиков): {build_dir}")
                continue

            build_slug = slugify(build_dir.name)
            out_name = f"{build_slug}_{section_slug}_tabs.json"
            out_path = TWEAKS_DIR / out_name

            write_json(out_path, data, args.dry, kind)
            total += 1

    print(f"\nИтого обработано наборов: {total}")
    return 0


if __name__ == "__main__":
    sys.exit(main())