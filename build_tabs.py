# #!/usr/bin/env python3
# # -*- coding: utf-8 -*-
# """
# build_tabs.py — универсальный генератор *_tabs.json для всех сборок.

# Что делает:
#   1. Сканирует папку tweaks/ по всем категориям.
#   2. Для каждой пары (категория × сборка) собирает Root и отмена.
#   3. Перед записью нового файла — делает backup старого.
#   4. Все файлы пишет в tweaks/.

# Структура на диске (два варианта):

# Вариант A — отмена в отдельной папке "отмена":
#     tweaks/Оптимизация/XOS-Tweaks/
#         ├── Файл1.bat
#         ├── Файл2.bat
#         └── отмена/
#               ├── Вернуть Файл1.bat
#               └── Вернуть Файл2.bat

# Вариант B — отмена через папку "Возврат" внутри подкатегории:
#     tweaks/Электропитание/XOS-Tweaks/
#         ├── xOS Power Plan/
#         │     ├── Импорт xOS Power Plan.bat
#         │     └── Возврат/                 ← это "отмена"
#         │           └── Удаление схемы.bat
#         └── Настройка USB/
#               ├── Отключение телеметрии USB.bat
#               └── Возврат/                 ← это "отмена"
#                     └── Включение телеметрии USB.bat

# Формат выходного файла:
#     {
#       "tabs": {
#         "Категория1": {
#           "Root":   ["Файл1.bat", "Подпапка\\Файл2.bat"],
#           "отмена": ["Вернуть Файл1.bat", "Подпапка\\Вернуть Файл2.bat"]
#         }
#       }
#     }

# Куда пишутся файлы:
#     tweaks/x_os_power_tabs.json       — новый файл
#     tweaks/x_os_power_tabs_2026-10-16_08-46_backup.json  — старый (если был)

# Бэкапы:
#     Перед перезаписью существующий файл копируется в tweaks/_backups/
#     с датой и суффиксом "_backup".

# Запуск из корня проекта:
#     python build_tabs.py
#     python build_tabs.py --only xos
#     python build_tabs.py --dry
# """

# import json
# import re
# import sys
# import shutil
# import argparse
# from pathlib import Path
# from datetime import datetime


# # ============================================================
# # НАСТРОЙКИ
# # ============================================================

# CATEGORIES = [
#     ("Оптимизация",    ""),
#     ("Приватность",    "_privacy"),
#     ("Безопасность",   "_security"),
#     ("Удобство",       "_comfort"),
#     ("Электропитание", "_power"),
#     ("Кастомизация",   "_customization"),
# ]

# VALID_EXT = {".bat", ".cmd", ".pow", ".ps1", ".reg", ".exe"}

# EXCLUDE_DIRS = {
#     ".git", "__pycache__", "node_modules", ".vscode", ".idea", "_backups",
# }

# # Папка для бэкапов внутри tweaks/
# BACKUP_DIR_NAME = "_backups"

# # Имена папок, которые означают "ОТМЕНА"
# CANCEL_DIR_NAMES = {
#     "отмена", "отмены", "отменить",
#     "возврат", "возвраты", "откат", "откаты",
#     "cancel", "revert", "undo",
# }


# def is_cancel_dir(name: str) -> bool:
#     return name.strip().lower() in CANCEL_DIR_NAMES


# def timestamp() -> str:
#     """2026-10-16_08-46-12"""
#     return datetime.now().strftime("%Y-%m-%d_%H-%M-%S")


# # ============================================================
# # УТИЛИТЫ
# # ============================================================

# def build_prefix(name: str) -> str:
#     """
#     XOS-Tweaks        -> x_os
#     ReviOS-Tweaks     -> revi_os
#     AtlasOS           -> atlas_os
#     SystemX-Tweaks    -> system_x
#     ImmortalOS-Tweaks -> immortal_os
#     MartyFiles-Tweaks -> marty_files
#     Igromanoff-Tweaks -> igromanoff
#     RapidOS-Tweaks    -> rapid_os
#     VainOS-Tweaks     -> vain_os
#     SynergyOS-Tweaks  -> synergy_os
#     """
#     s = re.sub(r"[-_]?Tweaks$", "", name, flags=re.IGNORECASE)
#     s = re.sub(r"([a-z])([A-Z])", r"\1_\2", s)
#     s = re.sub(r"([A-Z]+)([A-Z][a-z])", r"\1_\2", s)
#     s = s.lower()
#     s = re.sub(r"[^a-z0-9]+", "_", s).strip("_")
#     return s


# def is_tweak_file(path: Path) -> bool:
#     if not path.is_file():
#         return False
#     if path.suffix.lower() not in VALID_EXT:
#         return False
#     if any(part in EXCLUDE_DIRS for part in path.parts):
#         return False
#     return True


# # ============================================================
# # СБОР ФАЙЛОВ
# # ============================================================

# def collect_category(build_dir: Path) -> dict:
#     """
#     Возвращает:
#       {
#         "Root":   [ ... пути относительно build_dir ... ],
#         "отмена": [ ... пути относительно build_dir, БЕЗ имени cancel-папки ... ]
#       }
#     """
#     root_files = []
#     cancel_files = []

#     if not build_dir.exists() or not build_dir.is_dir():
#         return {}

#     def walk(current: Path, rel_parts: list, in_cancel: bool):
#         try:
#             entries = sorted(current.iterdir(), key=lambda p: p.name.lower())
#         except (PermissionError, OSError):
#             return

#         for entry in entries:
#             # Папка отмены → заходим в неё как в cancel
#             if entry.is_dir() and is_cancel_dir(entry.name):
#                 walk(entry, rel_parts, True)
#                 continue

#             # Обычная папка → рекурсия
#             if entry.is_dir():
#                 if entry.name in EXCLUDE_DIRS:
#                     continue
#                 walk(entry, rel_parts + [entry.name], in_cancel)
#                 continue

#             # Файл
#             if is_tweak_file(entry):
#                 full_rel = rel_parts + [entry.name] if rel_parts else [entry.name]
#                 rel_str = "\\".join(full_rel)
#                 if in_cancel:
#                     cancel_files.append(rel_str)
#                 else:
#                     root_files.append(rel_str)

#     walk(build_dir, [], False)

#     def uniq(lst):
#         seen = set()
#         out = []
#         for x in lst:
#             if x in seen:
#                 continue
#             seen.add(x)
#             out.append(x)
#         return out

#     result = {}
#     if root_files:
#         result["Root"] = uniq(root_files)
#     if cancel_files:
#         result["отмена"] = uniq(cancel_files)
#     return result


# # ============================================================
# # БЭКАПЫ
# # ============================================================

# def backup_existing(out_path: Path, backups_dir: Path) -> str | None:
#     """
#     Если файл out_path существует — копирует его в backups_dir
#     с именем <stem>_<timestamp>_backup<suffix>.

#     Возвращает имя бэкапа или None, если бэкап не делался.
#     """
#     if not out_path.exists():
#         return None

#     backups_dir.mkdir(parents=True, exist_ok=True)

#     ts = timestamp()
#     backup_name = f"{out_path.stem}_{ts}_backup{out_path.suffix}"
#     backup_path = backups_dir / backup_name

#     try:
#         shutil.copy2(out_path, backup_path)
#         return backup_name
#     except (OSError, shutil.Error) as e:
#         print(f"    [!] Не удалось сделать бэкап {out_path.name}: {e}")
#         return None


# # ============================================================
# # ОСНОВНАЯ ЛОГИКА
# # ============================================================

# def build_all(project_root: Path, only: str = None, dry: bool = False) -> int:
#     tweaks_dir = project_root / "tweaks"
#     if not tweaks_dir.exists():
#         print(f"[!] Не найдена папка tweaks/ в {project_root}")
#         return 1

#     # Все *_tabs.json пишутся в tweaks/
#     out_dir = tweaks_dir
#     # Бэкапы — в tweaks/_backups/
#     backups_dir = tweaks_dir / BACKUP_DIR_NAME

#     created = 0
#     skipped = 0
#     backed_up = 0

#     print("=" * 60)
#     print("build_tabs.py")
#     print("=" * 60)
#     print(f"[*] Корень:  {project_root}")
#     print(f"[*] tweaks:  {tweaks_dir}")
#     print(f"[*] backup:  {backups_dir}")
#     if only:
#         print(f"[*] Только сборка: {only}")
#     if dry:
#         print(f"[*] Режим: DRY-RUN (файлы не пишутся, бэкапы не делаются)")
#     print()

#     for cat_name, suffix in CATEGORIES:
#         cat_dir = tweaks_dir / cat_name
#         if not cat_dir.exists() or not cat_dir.is_dir():
#             print(f"[!] Нет папки: tweaks/{cat_name}")
#             continue

#         builds = []
#         for b in sorted(cat_dir.iterdir(), key=lambda p: p.name.lower()):
#             if not b.is_dir():
#                 continue
#             if b.name in EXCLUDE_DIRS:
#                 continue
#             if only and only.lower() not in b.name.lower():
#                 continue
#             builds.append(b)

#         if not builds:
#             print(f"[!] {cat_name}: нет сборок")
#             continue

#         print(f"[*] {cat_name}: {len(builds)} сборок")

#         for build_dir in builds:
#             build_name = build_dir.name
#             prefix = build_prefix(build_name)
#             out_name = f"{prefix}{suffix}_tabs.json"
#             out_path = out_dir / out_name

#             data = collect_category(build_dir)
#             if not data:
#                 skipped += 1
#                 print(f"    [--] {build_name}: пусто, пропуск")
#                 continue

#             root_n = len(data.get("Root", []))
#             cancel_n = len(data.get("отмена", []))
#             total_n = root_n + cancel_n

#             if dry:
#                 exists = " (перезапишет)" if out_path.exists() else " (новый)"
#                 print(f"    [dry] {out_name}{exists}  "
#                       f"(Root: {root_n}, отмена: {cancel_n}, total: {total_n})")
#             else:
#                 # 1. Бэкап старого файла
#                 backup_name = backup_existing(out_path, backups_dir)
#                 if backup_name:
#                     backed_up += 1
#                     print(f"    [bak] {backup_name}")

#                 # 2. Запись нового
#                 payload = {"tabs": {cat_name: data}}
#                 with open(out_path, "w", encoding="utf-8") as f:
#                     json.dump(payload, f, ensure_ascii=False, indent=2)

#                 print(f"    [ok]  tweaks/{out_name}  "
#                       f"(Root: {root_n}, отмена: {cancel_n})")
#             created += 1

#     print()
#     print("=" * 60)
#     print(f"[OK] Создано:    {created}")
#     print(f"[OK] Пропущено:  {skipped}")
#     print(f"[OK] Бэкапов:    {backed_up}")
#     print("=" * 60)
#     return 0


# # ============================================================
# # CLI
# # ============================================================

# def main():
#     parser = argparse.ArgumentParser(
#         description="Генератор *_tabs.json для всех сборок (с бэкапами)"
#     )
#     parser.add_argument("--root", type=str, default=None,
#                         help="Корень проекта (по умолчанию — папка со скриптом)")
#     parser.add_argument("--only", type=str, default=None,
#                         help="Обработать только сборки, содержащие подстроку")
#     parser.add_argument("--dry", action="store_true",
#                         help="Не писать файлы, только показать результат")

#     args = parser.parse_args()

#     project_root = Path(args.root).resolve() if args.root \
#         else Path(__file__).resolve().parent

#     return build_all(project_root, only=args.only, dry=args.dry)


# if __name__ == "__main__":
#     sys.exit(main())

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
build_tabs.py — универсальный генератор *_tabs.json для всех сборок.

Что делает:
  1. Сканирует папку tweaks/ по всем категориям.
  2. Для каждой пары (категория × сборка) собирает Root и отмена.
  3. Игнорирует определенные подпапки (Безопасность, Приватность и т.д.).
  4. Перед записью нового файла — делает backup старого.
  5. Все файлы пишет в tweaks/.

Запуск из корня проекта:
    python build_tabs.py
    python build_tabs.py --only xos
    python build_tabs.py --dry
"""

import json
import re
import sys
import shutil
import argparse
from pathlib import Path
from datetime import datetime


# ============================================================
# НАСТРОЙКИ
# ============================================================

CATEGORIES = [
    ("Оптимизация",    ""),
    ("Приватность",    "_privacy"),
    ("Безопасность",   "_security"),
    ("Удобство",       "_comfort"),
    ("Электропитание", "_power"),
    ("Кастомизация",   "_customization"),
]

VALID_EXT = {".bat", ".cmd", ".pow", ".ps1", ".reg", ".exe"}

EXCLUDE_DIRS = {
    ".git", "__pycache__", "node_modules", ".vscode", ".idea", "_backups",
}

# Папки внутри сборки, которые нужно ПОЛНОСТЬЮ ИГНОРИРОВАТЬ
EXCLUDED_SUBFOLDERS = {
    "Безопасность",
    "Приватность",
    "Кастомизация",
    "Контекстное меню",
    "Электропитание",
    "Удобство"  # Добавьте сюда другие папки, если их нужно пропустить
}

# Папка для бэкапов внутри tweaks/
BACKUP_DIR_NAME = "_backups"

# Имена папок, которые означают "ОТМЕНА"
CANCEL_DIR_NAMES = {
    "отмена", "отмены", "отменить",
    "возврат", "возвраты", "откат", "откаты",
    "cancel", "revert", "undo",
}


def is_cancel_dir(name: str) -> bool:
    return name.strip().lower() in CANCEL_DIR_NAMES


def timestamp() -> str:
    """2026-10-16_08-46-12"""
    return datetime.now().strftime("%Y-%m-%d_%H-%M-%S")


# ============================================================
# УТИЛИТЫ
# ============================================================

def build_prefix(name: str) -> str:
    """
    XOS-Tweaks        -> x_os
    ReviOS-Tweaks     -> revi_os
    AtlasOS           -> atlas_os
    SystemX-Tweaks    -> system_x
    ImmortalOS-Tweaks -> immortal_os
    MartyFiles-Tweaks -> marty_files
    Igromanoff-Tweaks -> igromanoff
    RapidOS-Tweaks    -> rapid_os
    VainOS-Tweaks     -> vain_os
    SynergyOS-Tweaks  -> synergy_os
    """
    s = re.sub(r"[-_]?Tweaks$", "", name, flags=re.IGNORECASE)
    s = re.sub(r"([a-z])([A-Z])", r"\1_\2", s)
    s = re.sub(r"([A-Z]+)([A-Z][a-z])", r"\1_\2", s)
    s = s.lower()
    s = re.sub(r"[^a-z0-9]+", "_", s).strip("_")
    return s


def is_tweak_file(path: Path) -> bool:
    if not path.is_file():
        return False
    if path.suffix.lower() not in VALID_EXT:
        return False
    if any(part in EXCLUDE_DIRS for part in path.parts):
        return False
    return True


# ============================================================
# СБОР ФАЙЛОВ
# ============================================================

def collect_category(build_dir: Path) -> dict:
    """
    Возвращает:
      {
        "Root":   [ ... пути относительно build_dir ... ],
        "отмена": [ ... пути относительно build_dir, БЕЗ имени cancel-папки ... ]
      }
    """
    root_files = []
    cancel_files = []

    if not build_dir.exists() or not build_dir.is_dir():
        return {}

    def walk(current: Path, rel_parts: list, in_cancel: bool):
        try:
            entries = sorted(current.iterdir(), key=lambda p: p.name.lower())
        except (PermissionError, OSError):
            return

        for entry in entries:
            # Папка отмены → заходим в неё как в cancel
            if entry.is_dir() and is_cancel_dir(entry.name):
                walk(entry, rel_parts, True)
                continue

            # Обычная папка → рекурсия
            if entry.is_dir():
                if entry.name in EXCLUDE_DIRS:
                    continue
                
                # ИГНОРИРУЕМ ПАПКИ ИЗ СПИСКА ИСКЛЮЧЕНИЙ
                if entry.name in EXCLUDED_SUBFOLDERS:
                    continue

                walk(entry, rel_parts + [entry.name], in_cancel)
                continue

            # Файл
            if is_tweak_file(entry):
                full_rel = rel_parts + [entry.name] if rel_parts else [entry.name]
                rel_str = "\\".join(full_rel)
                if in_cancel:
                    cancel_files.append(rel_str)
                else:
                    root_files.append(rel_str)

    walk(build_dir, [], False)

    def uniq(lst):
        seen = set()
        out = []
        for x in lst:
            if x in seen:
                continue
            seen.add(x)
            out.append(x)
        return out

    result = {}
    if root_files:
        result["Root"] = uniq(root_files)
    if cancel_files:
        result["отмена"] = uniq(cancel_files)
    return result


# ============================================================
# БЭКАПЫ
# ============================================================

def backup_existing(out_path: Path, backups_dir: Path) -> str | None:
    """
    Если файл out_path существует — копирует его в backups_dir
    с именем <stem>_<timestamp>_backup<suffix>.

    Возвращает имя бэкапа или None, если бэкап не делался.
    """
    if not out_path.exists():
        return None

    backups_dir.mkdir(parents=True, exist_ok=True)

    ts = timestamp()
    backup_name = f"{out_path.stem}_{ts}_backup{out_path.suffix}"
    backup_path = backups_dir / backup_name

    try:
        shutil.copy2(out_path, backup_path)
        return backup_name
    except (OSError, shutil.Error) as e:
        print(f"    [!] Не удалось сделать бэкап {out_path.name}: {e}")
        return None


# ============================================================
# ОСНОВНАЯ ЛОГИКА
# ============================================================

def build_all(project_root: Path, only: str = None, dry: bool = False) -> int:
    tweaks_dir = project_root / "tweaks"
    if not tweaks_dir.exists():
        print(f"[!] Не найдена папка tweaks/ в {project_root}")
        return 1

    # Все *_tabs.json пишутся в tweaks/
    out_dir = tweaks_dir
    # Бэкапы — в tweaks/_backups/
    backups_dir = tweaks_dir / BACKUP_DIR_NAME

    created = 0
    skipped = 0
    backed_up = 0

    print("=" * 60)
    print("build_tabs.py")
    print("=" * 60)
    print(f"[*] Корень:  {project_root}")
    print(f"[*] tweaks:  {tweaks_dir}")
    print(f"[*] backup:  {backups_dir}")
    if only:
        print(f"[*] Только сборка: {only}")
    if dry:
        print(f"[*] Режим: DRY-RUN (файлы не пишутся, бэкапы не делаются)")
    print()

    for cat_name, suffix in CATEGORIES:
        cat_dir = tweaks_dir / cat_name
        if not cat_dir.exists() or not cat_dir.is_dir():
            print(f"[!] Нет папки: tweaks/{cat_name}")
            continue

        builds = []
        for b in sorted(cat_dir.iterdir(), key=lambda p: p.name.lower()):
            if not b.is_dir():
                continue
            if b.name in EXCLUDE_DIRS:
                continue
            if only and only.lower() not in b.name.lower():
                continue
            builds.append(b)

        if not builds:
            print(f"[!] {cat_name}: нет сборок")
            continue

        print(f"[*] {cat_name}: {len(builds)} сборок")

        for build_dir in builds:
            build_name = build_dir.name
            prefix = build_prefix(build_name)
            out_name = f"{prefix}{suffix}_tabs.json"
            out_path = out_dir / out_name

            data = collect_category(build_dir)
            if not data:
                skipped += 1
                print(f"    [--] {build_name}: пусто, пропуск")
                continue

            root_n = len(data.get("Root", []))
            cancel_n = len(data.get("отмена", []))
            total_n = root_n + cancel_n

            if dry:
                exists = " (перезапишет)" if out_path.exists() else " (новый)"
                print(f"    [dry] {out_name}{exists}  "
                      f"(Root: {root_n}, отмена: {cancel_n}, total: {total_n})")
            else:
                # 1. Бэкап старого файла
                backup_name = backup_existing(out_path, backups_dir)
                if backup_name:
                    backed_up += 1
                    print(f"    [bak] {backup_name}")

                # 2. Запись нового
                payload = {"tabs": {cat_name: data}}
                with open(out_path, "w", encoding="utf-8") as f:
                    json.dump(payload, f, ensure_ascii=False, indent=2)

                print(f"    [ok]  tweaks/{out_name}  "
                      f"(Root: {root_n}, отмена: {cancel_n})")
            created += 1

    print()
    print("=" * 60)
    print(f"[OK] Создано:    {created}")
    print(f"[OK] Пропущено:  {skipped}")
    print(f"[OK] Бэкапов:    {backed_up}")
    print("=" * 60)
    return 0


# ============================================================
# CLI
# ============================================================

def main():
    parser = argparse.ArgumentParser(
        description="Генератор *_tabs.json для всех сборок (с бэкапами)"
    )
    parser.add_argument("--root", type=str, default=None,
                        help="Корень проекта (по умолчанию — папка со скриптом)")
    parser.add_argument("--only", type=str, default=None,
                        help="Обработать только сборки, содержащие подстроку")
    parser.add_argument("--dry", action="store_true",
                        help="Не писать файлы, только показать результат")

    args = parser.parse_args()

    project_root = Path(args.root).resolve() if args.root \
        else Path(__file__).resolve().parent

    return build_all(project_root, only=args.only, dry=args.dry)


if __name__ == "__main__":
    sys.exit(main())