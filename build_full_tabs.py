#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
build_hardening_json.py

Генерирует *_tabs.json для ВСЕХ сборок во ВСЕХ секциях:
    tweaks/<Секция>/<Сборка>/

Секции и суффикс выходного файла:
    Безопасность   → <build>_security_tabs.json
    Приватность    → <build>_privacy_tabs.json
    Удобство       → <build>_comfort_tabs.json
    Оптимизация    → <build>_tabs.json          (без суффикса секции!)
    Кастомизация   → <build>_customization_tabs.json
    Электропитание → <build>_power_tabs.json

Спец-случаи:
  • xOS (расширенная папка) → slug x_os_legacy
  • XOS-Tweaks             → slug x_os
    (иначе slugify дал бы одинаковый x_os, и файлы перезаписали бы друг друга)

Папки, которые НЕ генерируются (уже в tabs.json):
  • Оптимизация/Apps                 (подключено через tabs → «Оптимизация программ»)
  • Электропитание/Планы электропитания (подключено через tabs_2)
  • tweaks/tweaks/                    (внутренняя папка с обновлённой оптимизацией)

Запуск:
    python build_hardening_json.py
    python build_hardening_json.py --dry
    python build_hardening_json.py --only power
    python build_hardening_json.py --section Приватность
    python build_hardening_json.py --build XOS-Tweaks
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

# Секции: (имя_папки, слаг_для_--only, шаблон_выходного_файла)
SECTIONS = [
    ("Безопасность",   "security",      "{build}_security_tabs.json"),
    ("Приватность",    "privacy",       "{build}_privacy_tabs.json"),
    ("Удобство",       "comfort",       "{build}_comfort_tabs.json"),
    ("Оптимизация",    "optimization",  "{build}_tabs.json"),
    ("Кастомизация",   "customization", "{build}_customization_tabs.json"),
    ("Электропитание", "power",         "{build}_power_tabs.json"),
]

# Сборки, которые надо пропустить (уже подключены через tabs.json/tabs_2,
# отдельный *_tabs.json для них не нужен — было бы дублирование).
SKIP_BUILDS = {
    "Оптимизация":     {"Apps"},
    "Электропитание":  {"Планы электропитания"},
}

# Расширения файлов-твиков
TWEAK_EXTS = {".bat", ".cmd", ".exe", ".ps1", ".reg", ".pow"}

# Имена подпапок отмены
CANCEL_KEYS = (
    "отмена", "Отмена", "ОТМЕНА",
    "cancel", "Cancel", "CANCEL",
    "Возврат", "возврат", "ВОЗВРАТ",
    "Вернуть", "вернуть", "ВЕРНУТЬ",
    "Откат", "откат", "ОТКАТ",
    "Restore", "restore",
    "Revert", "revert",
)

# Точные имена → slug. Проверяются ПЕРВЫМИ, до lower().
EXACT_SLUGS = {
    "xOS": "x_os_legacy",   # расширенная папка, отдельная от XOS-Tweaks
}

# Lower-case имена → slug. Спец-случаи, где транслит дал бы неверный результат.
SPECIAL_SLUGS = {
    "xos-tweaks":        "x_os",
    "xos":               "x_os",
    "x_os":              "x_os",
    "atlasos-tweaks":    "atlas_os",
    "atlasos":           "atlas_os",
    "atlas_os":          "atlas_os",
    "revios-tweaks":     "revi_os",
    "revios":            "revi_os",
    "revi_os":           "revi_os",
    "immortalos-tweaks": "immortal_os",
    "immortalos":        "immortal_os",
    "immortal_os":       "immortal_os",
    "martyfiles":        "marty_files",
    "marty_files":       "marty_files",
    "rapidos-tweaks":    "rapid_os",
    "rapidos":           "rapid_os",
    "rapid_os":          "rapid_os",
    "synergyos-tweaks":  "synergy_os",
    "synergyos":         "synergy_os",
    "synergy_os":        "synergy_os",
    "systemx":           "system_x",
    "system_x":          "system_x",
    "vainos-tweaks":     "vain_os",
    "vainos":            "vain_os",
    "vain_os":           "vain_os",
    "igromanoff-tweaks": "igromanoff",
    "igromanoff":        "igromanoff",
    "hardeningkitty":    "hardening_kitty",
    "hardening_kitty":   "hardening_kitty",
    "extremeos":         "extreme_os",
    "extreme_os":        "extreme_os",
    "безопасность":      "security",
    "приватность":       "privacy",
    "удобство":          "comfort",
    "оптимизация":       "optimization",
    "кастомизация":      "customization",
    "электропитание":    "power",
}

_TRANSLIT = {
    'а':'a','б':'b','в':'v','г':'g','д':'d','е':'e','ё':'e','ж':'zh','з':'z',
    'и':'i','й':'y','к':'k','л':'l','м':'m','н':'n','о':'o','п':'p','р':'r',
    'с':'s','т':'t','у':'u','ф':'f','х':'kh','ц':'ts','ч':'ch','ш':'sh',
    'щ':'shch','ъ':'','ы':'y','ь':'','э':'e','ю':'yu','я':'ya',
}

def slugify(name: str) -> str:
    if name in EXACT_SLUGS:
        return EXACT_SLUGS[name]
    low = name.strip().lower()
    if low in SPECIAL_SLUGS:
        return SPECIAL_SLUGS[low]
    s = ''.join(_TRANSLIT.get(ch, ch) for ch in low)
    s = re.sub(r'[^a-z0-9]+', '_', s)
    s = s.strip('_')
    return s or "unnamed"


# ------------------------------------------------------------------
# Утилиты
# ------------------------------------------------------------------
def is_tweak_file(name: str) -> bool:
    return Path(name).suffix.lower() in TWEAK_EXTS


def list_flat_files(folder: Path) -> list[str]:
    if not folder.is_dir():
        return []
    files = [p.name for p in folder.iterdir()
             if p.is_file() and is_tweak_file(p.name)]
    files.sort(key=lambda s: s.lower())
    return files


def list_cancel_files(folder: Path) -> tuple[str | None, list[str]]:
    if not folder.is_dir():
        return None, []
    for key in CANCEL_KEYS:
        candidate = folder / key
        if candidate.is_dir():
            files = list_flat_files(candidate)
            if files:
                return key, files
    return None, []


def has_category_subdirs(folder: Path) -> bool:
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
    root_files = list_flat_files(folder)
    if not root_files:
        return None
    cancel_key, cancel_files = list_cancel_files(folder)
    payload = {"Root": root_files}
    if cancel_files and cancel_key:
        payload[cancel_key] = cancel_files
    else:
        payload["отмена"] = []
    return {"tabs": payload}


def build_grouped_json(folder: Path) -> dict | None:
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
        if cancel_files and cancel_key:
            payload[cancel_key] = cancel_files
        else:
            payload["отмена"] = []
        tabs[child.name] = payload
    if not tabs:
        return None
    return {"tabs": tabs}


def build_json_for(folder: Path) -> tuple[dict | None, str]:
    if has_category_subdirs(folder):
        data = build_grouped_json(folder)
        if data:
            return data, "grouped"
    data = build_flat_json(folder)
    if data:
        return data, "flat"
    return None, "empty"


def count_tweaks(data: dict, kind: str) -> int:
    if kind == "flat":
        return len(data["tabs"].get("Root", []))
    return sum(len(v.get("Root", [])) for v in data["tabs"].values())


def write_json(path: Path, data: dict, dry: bool, kind: str) -> None:
    text = json.dumps(data, ensure_ascii=False, indent=2) + "\n"
    if dry:
        print(f"\n--- {path} ({kind}, dry-run) ---")
        print(text)
        return
    path.write_text(text, encoding="utf-8")
    count = count_tweaks(data, kind)
    print(f"   ✅ {path.name}  ({kind}, {count} твиков)")


# ------------------------------------------------------------------
# main
# ------------------------------------------------------------------
def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry", action="store_true")
    ap.add_argument("--only",
                    choices=["security", "privacy", "comfort",
                             "optimization", "customization", "power", "all"],
                    default="all")
    ap.add_argument("--section")
    ap.add_argument("--build")
    ap.add_argument("--skip-build", action="append", default=[])
    args = ap.parse_args()

    if not TWEAKS_DIR.is_dir():
        print(f"❌ Папка не найдена: {TWEAKS_DIR}", file=sys.stderr)
        return 1

    total_written = 0
    total_skipped = 0
    seen_outputs: set[str] = set()

    for section_name, section_slug, output_template in SECTIONS:
        if args.only != "all" and args.only != section_slug:
            continue
        if args.section and args.section != section_name:
            continue

        section_dir = TWEAKS_DIR / section_name
        if not section_dir.is_dir():
            print(f"\n⏭  Нет папки секции: {section_name}")
            continue

        print(f"\n📂 {section_name}")
        builds = [d for d in sorted(section_dir.iterdir(), key=lambda p: p.name.lower())
                  if d.is_dir() and d.name not in CANCEL_KEYS]
        skip_here = SKIP_BUILDS.get(section_name, set()) | set(args.skip_build)

        for build_dir in builds:
            if args.build and args.build != build_dir.name:
                continue
            if build_dir.name in skip_here:
                print(f"   ⏭  {build_dir.name} — пропущен (в tabs.json или --skip-build)")
                total_skipped += 1
                continue

            data, kind = build_json_for(build_dir)
            if not data:
                print(f"   ⏭  {build_dir.name} — нет твиков")
                total_skipped += 1
                continue

            build_slug = slugify(build_dir.name)
            out_name = output_template.format(build=build_slug)

            if out_name in seen_outputs:
                print(f"   ⚠  {build_dir.name} — пропущен: {out_name} уже создан")
                total_skipped += 1
                continue
            seen_outputs.add(out_name)

            write_json(TWEAKS_DIR / out_name, data, args.dry, kind)
            total_written += 1

    print(f"\n{'=' * 55}")
    print(f"Записано файлов: {total_written}" + (" (dry-run)" if args.dry else ""))
    print(f"Пропущено:      {total_skipped}")
    return 0


if __name__ == "__main__":
    sys.exit(main())