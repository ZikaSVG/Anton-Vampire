#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
build_removal_json.py

Сканирует tweaks/Удаление/ и генерирует tweaks/removal_tabs.json.

Структура JSON:
{
  "baseDir": "tweaks/Удаление",
  "files": [
    { "name": "Удалить OneDrive.bat", "title": "OneDrive", "category": "onedrive" },
    ...
  ]
}

Категории:
  defender | edge | onedrive | office | xbox | uwp | tools | other

Запуск:
    python build_removal_json.py
    python build_removal_json.py --dry
"""

import argparse
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).parent
REMOVAL_DIR = ROOT / "tweaks" / "Удаление"
OUTPUT_FILE = ROOT / "tweaks" / "removal_tabs.json"

# Расширения твиков-удалений
TWEAK_EXTS = {".bat", ".cmd", ".ps1", ".exe"}

# Категоризация по порядку приоритета
CATEGORY_RULES = [
    ("defender", re.compile(
        r"defender|защитн|antimalware|antivirus|антивирус|убить.?защитник|smart.?screen",
        re.IGNORECASE)),
    ("edge", re.compile(
        r"(?<![a-z])edge|эдж",
        re.IGNORECASE)),
    ("onedrive", re.compile(
        r"onedrive|вандрайв",
        re.IGNORECASE)),
    ("office", re.compile(
        r"office|офис",
        re.IGNORECASE)),
    ("xbox", re.compile(r"xbox", re.IGNORECASE)),
    ("tools", re.compile(
        r"update health|internet explorer|сексплорер",
        re.IGNORECASE)),
    ("uwp", re.compile(
        r"uwp|appx|metro|приложени|3d builder|paint 3d|print 3d|"
        r"cortana|кортана|groove|кино|тв|skype|скайп|почта|календарь|"
        r"камера|карты|люди|фотографии|записки|запись голоса|"
        r"калькулятор|будильники|часы|техническая помощь|советы|"
        r"центр отзывов|mobile plans|ваш телефон|heif|webp|"
        r"мультимедиа|расширение|начало|sway|onenote|средство 3d|"
        r"набросок|деньги|bing sport|associations|базовые",
        re.IGNORECASE)),
]

# Префиксы, которые надо убрать из имени файла для получения чистого title
TITLE_PREFIX_RE = re.compile(
    r"^(Удалить|Удаление|Отключить|Программа удаления)\s+",
    re.IGNORECASE,
)


def categorize(filename: str) -> str:
    for cat_id, rx in CATEGORY_RULES:
        if rx.search(filename):
            return cat_id
    return "other"


def extract_title(filename: str) -> str:
    stem = filename.rsplit(".", 1)[0]
    m = TITLE_PREFIX_RE.match(stem)
    if m:
        return stem[m.end():].strip()
    return stem


def is_tweak(name: str) -> bool:
    if name.startswith("_extreme_patch_"):
        return False
    return Path(name).suffix.lower() in TWEAK_EXTS


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry", action="store_true")
    args = ap.parse_args()

    if not REMOVAL_DIR.is_dir():
        print(f"❌ Нет папки: {REMOVAL_DIR}", file=sys.stderr)
        return 1

    files = sorted(
        [p.name for p in REMOVAL_DIR.iterdir()
         if p.is_file() and is_tweak(p.name)],
        key=lambda s: s.lower(),
    )

    items = []
    for name in files:
        items.append({
            "name": name,
            "title": extract_title(name),
            "category": categorize(name),
        })

    result = {
        "baseDir": "tweaks/Удаление",
        "files": items,
    }

    text = json.dumps(result, ensure_ascii=False, indent=2) + "\n"

    # статистика
    counts = {}
    for it in items:
        counts[it["category"]] = counts.get(it["category"], 0) + 1

    print(f"📂 {REMOVAL_DIR}\n")
    print(f"  Всего файлов: {len(items)}")
    print("  По категориям:")
    for cat in ["defender", "edge", "onedrive", "office", "xbox", "uwp", "tools", "other"]:
        if counts.get(cat):
            print(f"    {cat:10s} {counts[cat]:>3}")

    if args.dry:
        print("\n--- dry-run: removal_tabs.json ---\n")
        print(text)
        return 0

    OUTPUT_FILE.write_text(text, encoding="utf-8")
    print(f"\n✅ {OUTPUT_FILE}")
    return 0


if __name__ == "__main__":
    sys.exit(main())