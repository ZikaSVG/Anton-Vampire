#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Генератор tabs.json для лаунчера твиков.

Сканирует указанную папку, находит все .bat/.cmd/.pow/.ps1/.reg файлы
и строит JSON со структурой вкладок:

{
    "tabs": {
        "Вкладка 1": {
            "Подкатегория": ["путь/файл.bat", ...],
            ...
        },
        ...
    }
}

Вкладка = папка первого уровня.
Подкатегория = папка второго/третьего уровня (если есть).
Файлы в корне вкладки попадают в ключ "Root".

Запуск:
    python generate_tabs_json.py [папка] [выходной_json]

По умолчанию:
    папка = текущая директория
    выходной_json = tabs.json
"""

import json
import sys
from pathlib import Path

# Расширения, которые включаем в JSON
VALID_EXTENSIONS = {".bat", ".cmd", ".pow", ".ps1", ".reg"}

# Исключения (папки/файлы, которые игнорируем)
EXCLUDE_DIRS = {".git", "__pycache__", "node_modules"}
EXCLUDE_FILE_PATTERNS = {
    "_MASTER",  # служебные мастер-скрипты
}


def should_exclude(path: Path) -> bool:
    """Проверить, надо ли исключить файл/папку."""
    for part in path.parts:
        if part in EXCLUDE_DIRS:
            return True
    name = path.name
    for pattern in EXCLUDE_FILE_PATTERNS:
        if pattern in name:
            return True
    return False


def collect_tab_files(root: Path, tab_dir: Path):
    """
    Собирает файлы внутри вкладки.
    Возвращает dict: {subcategory: [relative_paths]}.
    subcategory = "Root" для файлов в корне вкладки.
    """
    result = {}

    for entry in sorted(tab_dir.rglob("*")):
        if not entry.is_file():
            continue
        if entry.suffix.lower() not in VALID_EXTENSIONS:
            continue
        if should_exclude(entry):
            continue

        rel = entry.relative_to(tab_dir)

        # Определяем подкатегорию: путь внутри вкладки без имени файла
        if rel.parent == Path("."):
            subcategory = "Root"
        else:
            # Склеиваем все вложенные папки через "\\" для совместимости с твоим форматом
            subcategory = "\\".join(rel.parent.parts)

        result.setdefault(subcategory, []).append(str(rel))

    return result


def build_json(root: Path):
    """Строит итоговую структуру tabs."""
    if not root.exists():
        raise FileNotFoundError(f"Папка не найдена: {root}")

    tabs = {}

    # Вкладки = папки первого уровня
    for tab_dir in sorted(root.iterdir()):
        if not tab_dir.is_dir():
            continue
        if tab_dir.name in EXCLUDE_DIRS:
            continue

        tab_files = collect_tab_files(root, tab_dir)
        if not tab_files:
            continue

        tabs[tab_dir.name] = tab_files

    # Если в корне есть файлы — создаём вкладку "Root"
    root_files = []
    for entry in sorted(root.iterdir()):
        if entry.is_file() and entry.suffix.lower() in VALID_EXTENSIONS and not should_exclude(entry):
            root_files.append(entry.name)
    if root_files:
        tabs["Root"] = {"Root": root_files}

    return {"tabs": tabs}


def main():
    args = sys.argv[1:]

    if len(args) >= 1:
        root = Path(args[0]).resolve()
    else:
        root = Path.cwd()

    if len(args) >= 2:
        out_json = Path(args[1]).resolve()
    else:
        out_json = root / "tabs.json"

    print(f"[*] Сканирую: {root}")
    data = build_json(root)

    with open(out_json, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)

    total_tabs = len(data["tabs"])
    total_files = sum(
        len(files)
        for tab in data["tabs"].values()
        for files in tab.values()
    )

    print(f"[OK] Вкладок: {total_tabs}")
    print(f"[OK] Файлов: {total_tabs} вкладок, всего {total_files}")
    print(f"[OK] Сохранено: {out_json}")


if __name__ == "__main__":
    main()