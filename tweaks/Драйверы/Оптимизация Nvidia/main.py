"""
batch_merger.py - Скрипт для объединения всех BAT и CMD файлов в один
Запуск: python batch_merger.py
"""

import os
import glob
import argparse
from pathlib import Path
from datetime import datetime

def get_file_header(filepath):
    """Получает заголовок из файла (первые непустые строки с @echo off, title, color и комментарии)"""
    header_lines = []
    try:
        with open(filepath, 'r', encoding='cp1251') as f:
            for line in f:
                line = line.rstrip()
                # Пропускаем пустые строки в начале
                if not line and not header_lines:
                    continue
                # Берем команды @echo off, title, color и комментарии
                if (line.lower().startswith('@echo off') or 
                    line.lower().startswith('title') or 
                    line.lower().startswith('color') or
                    line.startswith('::') or
                    line.startswith('rem')):
                    header_lines.append(line)
                else:
                    # Как только встречаем другую команду - прекращаем сбор заголовка
                    break
    except:
        pass
    return header_lines

def extract_description(filepath):
    """Извлекает описание из комментариев в начале файла"""
    description = []
    try:
        with open(filepath, 'r', encoding='cp1251') as f:
            for line in f:
                line = line.strip()
                if line.startswith('::') and '=' not in line and '---' not in line:
                    description.append(line[2:].strip())
                elif line.startswith('rem'):
                    description.append(line[3:].strip())
                elif line and not line.startswith('@') and not line.startswith('title') and not line.startswith('color'):
                    break
    except:
        pass
    return description

def merge_bat_files(input_dir, output_file=None, recursive=True, include_cmd=True):
    """
    Объединяет все BAT и CMD файлы из указанной директории
    
    Args:
        input_dir: директория с файлами
        output_file: имя выходного файла (если None, генерируется автоматически)
        recursive: искать в подпапках
        include_cmd: включать ли .cmd файлы
    """
    
    input_path = Path(input_dir)
    if not input_path.exists():
        print(f"Ошибка: директория {input_dir} не существует")
        return None
    
    # Собираем все .bat и .cmd файлы
    pattern = '**/*.bat' if recursive else '*.bat'
    bat_files = glob.glob(str(input_path / pattern), recursive=recursive)
    
    if include_cmd:
        cmd_pattern = '**/*.cmd' if recursive else '*.cmd'
        cmd_files = glob.glob(str(input_path / cmd_pattern), recursive=recursive)
        bat_files.extend(cmd_files)
    
    if not bat_files:
        print(f"В директории {input_dir} не найдено .bat или .cmd файлов")
        return None
    
    # Сортируем файлы для консистентности
    bat_files.sort()
    
    print(f"Найдено файлов для объединения: {len(bat_files)}")
    
    # Генерируем имя выходного файла
    if output_file is None:
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        output_file = input_path / f"merged_batch_{timestamp}.bat"
    else:
        output_file = Path(output_file)
    
    # Создаем объединенный файл
    with open(output_file, 'w', encoding='cp1251') as out_f:
        # Заголовок
        out_f.write("@echo off\n")
        out_f.write("title Объединенный пакетный файл\n")
        out_f.write("color 0F\n")
        out_f.write(":: ==================================================\n")
        out_f.write(f":: Объединенный файл создан: {datetime.now().strftime('%d.%m.%Y %H:%M:%S')}\n")
        out_f.write(f":: Исходная директория: {os.path.abspath(input_dir)}\n")
        out_f.write(f":: Всего файлов: {len(bat_files)}\n")
        out_f.write(":: ==================================================\n")
        out_f.write("chcp 1251 >nul\n")  # Устанавливаем кодировку
        out_f.write("setlocal enabledelayedexpansion\n")
        out_f.write("cls\n")
        out_f.write("echo.\n")
        out_f.write("echo ==================================================\n")
        out_f.write("echo ОБЪЕДИНЕННЫЙ ПАКЕТНЫЙ ФАЙЛ\n")
        out_f.write("echo ==================================================\n")
        out_f.write("echo.\n")
        out_f.write("echo Всего секций: " + str(len(bat_files)) + "\n")
        out_f.write("echo.\n")
        out_f.write("echo Выберите действие:\n")
        out_f.write("echo [1] Выполнить все секции подряд\n")
        out_f.write("echo [2] Выполнить секции с подтверждением\n")
        out_f.write("echo [3] Показать список секций\n")
        out_f.write("echo.\n")
        out_f.write("set /p mode=Введите номер (1/2/3): \n")
        out_f.write("echo.\n")
        out_f.write("if \"%mode%\"==\"3\" goto :show_list\n")
        out_f.write("if \"%mode%\"==\"2\" goto :confirm_mode\n")
        out_f.write("if \"%mode%\"==\"1\" goto :auto_mode\n")
        out_f.write("echo Неверный выбор, используется режим 1\n")
        out_f.write("goto :auto_mode\n")
        out_f.write("\n")
        
        # Режим показа списка
        out_f.write(":show_list\n")
        out_f.write("cls\n")
        out_f.write("echo ==================================================\n")
        out_f.write("echo СПИСОК СЕКЦИЙ\n")
        out_f.write("echo ==================================================\n")
        out_f.write("echo.\n")
        
        for i, filepath in enumerate(bat_files, 1):
            rel_path = os.path.relpath(filepath, input_dir)
            description = extract_description(filepath)
            desc_text = description[0] if description else "Без описания"
            out_f.write(f"echo [{i:03d}] {rel_path} - {desc_text}\n")
        
        out_f.write("echo.\n")
        out_f.write("pause\n")
        out_f.write("exit /b\n")
        out_f.write("\n")
        
        # Режим с подтверждением
        out_f.write(":confirm_mode\n")
        out_f.write("cls\n")
        out_f.write("echo ==================================================\n")
        out_f.write("echo РЕЖИМ С ПОДТВЕРЖДЕНИЕМ\n")
        out_f.write("echo ==================================================\n")
        out_f.write("echo.\n")
        
        for i, filepath in enumerate(bat_files, 1):
            rel_path = os.path.relpath(filepath, input_dir)
            description = extract_description(filepath)
            desc_text = description[0] if description else "Без описания"
            
            out_f.write(f"echo.\n")
            out_f.write(f"echo [{i:03d}] {rel_path}\n")
            out_f.write(f"echo Описание: {desc_text}\n")
            out_f.write("echo.\n")
            out_f.write("set /p confirm=Выполнить? (y/n/q): \n")
            out_f.write("if /i \"!confirm!\"==\"q\" goto :end\n")
            out_f.write("if /i \"!confirm!\"==\"y\" (\n")
            out_f.write("    echo.\n")
            out_f.write(f"    echo --- Выполняется: {rel_path} ---\n")
            out_f.write("    echo.\n")
            
            # Добавляем содержимое файла
            with open(filepath, 'r', encoding='cp1251') as in_f:
                for line in in_f:
                    # Пропускаем заголовочные команды
                    if not (line.lower().startswith('@echo off') or 
                           line.lower().startswith('title') or 
                           line.lower().startswith('color')):
                        out_f.write(line)
            
            out_f.write("    echo.\n")
            out_f.write("    echo --- Выполнено ---\n")
            out_f.write(")\n")
        
        out_f.write("goto :end\n")
        out_f.write("\n")
        
        # Автоматический режим
        out_f.write(":auto_mode\n")
        out_f.write("cls\n")
        out_f.write("echo ==================================================\n")
        out_f.write("echo АВТОМАТИЧЕСКИЙ РЕЖИМ\n")
        out_f.write("echo ==================================================\n")
        out_f.write("echo.\n")
        
        for i, filepath in enumerate(bat_files, 1):
            rel_path = os.path.relpath(filepath, input_dir)
            out_f.write(f"echo.\n")
            out_f.write(f"echo [{i:03d}] Выполняется: {rel_path}\n")
            out_f.write(f"echo --------------------------------------------\n")
            
            # Добавляем содержимое файла
            with open(filepath, 'r', encoding='cp1251') as in_f:
                for line in in_f:
                    # Пропускаем заголовочные команды
                    if not (line.lower().startswith('@echo off') or 
                           line.lower().startswith('title') or 
                           line.lower().startswith('color')):
                        out_f.write(line)
            
            out_f.write(f"echo --------------------------------------------\n")
            out_f.write(f"echo [OK] Секция {i} выполнена\n")
            out_f.write(f"echo.\n")
        
        # Конец
        out_f.write(":end\n")
        out_f.write("echo.\n")
        out_f.write("echo ==================================================\n")
        out_f.write("echo ВСЕ СЕКЦИИ ВЫПОЛНЕНЫ\n")
        out_f.write("echo ==================================================\n")
        out_f.write("pause\n")
    
    print(f"✅ Файл успешно создан: {output_file}")
    print(f"   Размер: {output_file.stat().st_size / 1024:.1f} KB")
    return output_file

def create_merge_all_bat(target_dir):
    """
    Создает .bat файл, который объединит все файлы при запуске
    """
    merge_script = Path(target_dir) / "merge_all.bat"
    
    with open(merge_script, 'w', encoding='cp1251') as f:
        f.write("@echo off\n")
        f.write("title Объединение всех BAT/CMD файлов\n")
        f.write("color 0A\n")
        f.write("echo ==================================================\n")
        f.write("echo ОБЪЕДИНЕНИЕ ВСЕХ ПАКЕТНЫХ ФАЙЛОВ\n")
        f.write("echo ==================================================\n")
        f.write("echo.\n")
        f.write("echo Будет создан объединенный файл со всеми .bat и .cmd\n")
        f.write("echo.\n")
        f.write("set /p name=Введите имя выходного файла (Enter для auto): \n")
        f.write("echo.\n")
        f.write("if \"%name%\"==\"\" (\n")
        f.write("    python batch_merger.py \"%cd%\"\n")
        f.write(") else (\n")
        f.write("    python batch_merger.py \"%cd%\" -o \"%name%\"\n")
        f.write(")\n")
        f.write("echo.\n")
        f.write("pause\n")
    
    print(f"✅ Создан скрипт для объединения: {merge_script}")

def main():
    parser = argparse.ArgumentParser(description='Объединение всех BAT и CMD файлов в один')
    parser.add_argument('input_dir', nargs='?', default='.', 
                       help='Директория с файлами (по умолчанию текущая)')
    parser.add_argument('-o', '--output', help='Имя выходного файла')
    parser.add_argument('--no-recursive', action='store_true', 
                       help='Не искать в подпапках')
    parser.add_argument('--no-cmd', action='store_true', 
                       help='Не включать .cmd файлы')
    parser.add_argument('--create-merge-script', action='store_true',
                       help='Создать .bat скрипт для объединения')
    
    args = parser.parse_args()
    
    # Проверяем аргументы
    input_dir = args.input_dir
    
    if args.create_merge_script:
        create_merge_all_bat(input_dir)
    else:
        # Объединяем файлы
        merge_bat_files(
            input_dir=input_dir,
            output_file=args.output,
            recursive=not args.no_recursive,
            include_cmd=not args.no_cmd
        )

if __name__ == "__main__":
    main()