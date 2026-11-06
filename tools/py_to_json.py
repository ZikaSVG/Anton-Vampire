# -*- coding: utf-8 -*-
"""
Конвертирует tabs_beta.py → tweaks/tabs.json.
Копирует ВСЕ словари tabs*.
"""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / 'tweaks' / 'tabs_beta.py'
DST = ROOT / 'tweaks' / 'tabs.json'

def main():
    if not SRC.exists():
        print(f'[py_to_json] НЕ НАЙДЕН: {SRC}', file=sys.stderr)
        return 1

    text = SRC.read_text(encoding='utf-8')

    # Исполняем как Python-модуль, но без __name__ == '__main__'
    ns = {'__name__': 'tabs_beta'}
    try:
        exec(compile(text, str(SRC), 'exec'), ns)
    except Exception as e:
        print(f'[py_to_json] exec failed: {e}', file=sys.stderr)
        return 1

    result = {}
    for k, v in ns.items():
        if k.startswith('tabs') and isinstance(v, dict):
            result[k] = v

    if not result:
        print('[py_to_json] ни одного словаря tabs* не найдено', file=sys.stderr)
        return 1

    DST.parent.mkdir(parents=True, exist_ok=True)
    DST.write_text(json.dumps(result, ensure_ascii=False, indent=2), encoding='utf-8')
    print(f'[py_to_json] OK → {DST} ({len(result)} ключей: {", ".join(result.keys())})')
    return 0

if __name__ == '__main__':
    sys.exit(main())