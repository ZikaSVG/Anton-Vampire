#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
nvidia_extract.py - Вытаскивает все секции из BIOS Nvidia.bat
"""

import re
from pathlib import Path

def extract_sections(content):
    """Находит все секции в файле"""
    sections = []
    
    # Разбиваем на строки
    lines = content.split('\n')
    
    i = 0
    while i < len(lines):
        line = lines[i].strip()
        
        # Ищем начало секции с номером
        if line.startswith('echo [') and ']' in line:
            # Извлекаем имя файла
            # Пример: "echo [001] BIOS Nvidia.bat"
            parts = line.split(']', 1)
            if len(parts) > 1:
                filename = parts[1].strip()
                # Убираем " - Описание" если есть
                if ' - ' in filename:
                    filename = filename.split(' - ')[0]
                
                print(f"  Нашел секцию: {filename}")
                
                # Собираем содержимое секции
                content_lines = []
                i += 1
                
                # Пропускаем строки с вопросом и переходом к следующей секции
                while i < len(lines):
                    current = lines[i].strip()
                    
                    # Конец секции
                    if current == 'echo.' or current == 'echo --- Выполнено ---' or current.startswith('goto :'):
                        break
                    
                    # Пропускаем строки с подтверждением
                    if not current.startswith('set /p confirm=') and not 'if /i "!confirm!"' in current:
                        content_lines.append(lines[i])
                    
                    i += 1
                
                if content_lines:
                    sections.append({
                        'filename': filename,
                        'content': '\n'.join(content_lines)
                    })
        else:
            i += 1
    
    return sections

def main():
    print("=" * 50)
    print("ИЗВЛЕКАТЕЛЬ СЕКЦИЙ ИЗ BIOS Nvidia.bat")
    print("=" * 50)
    
    # Проверяем наличие файла
    input_file = Path("BIOS Nvidia.bat")
    if not input_file.exists():
        print("\n❌ Файл BIOS Nvidia.bat не найден!")
        print("Убедитесь, что скрипт находится в той же папке")
        return
    
    print(f"\n✅ Найден файл: {input_file}")
    
    # Читаем файл
    with open(input_file, 'r', encoding='cp1251', errors='ignore') as f:
        content = f.read()
    
    # Извлекаем секции
    sections = extract_sections(content)
    
    if not sections:
        print("\n❌ Не найдено ни одной секции!")
        return
    
    print(f"\n✅ Найдено секций: {len(sections)}")
    
    # Создаем папку для результатов
    output_dir = Path("NVIDIA_Tweaks")
    output_dir.mkdir(exist_ok=True)
    
    print(f"\n📁 Создаю файлы в папке {output_dir}/")
    print("-" * 50)
    
    # Сохраняем каждую секцию в отдельный файл
    for i, section in enumerate(sections, 1):
        # Очищаем имя файла от недопустимых символов
        filename = section['filename'].replace('\\', '_').replace('/', '_')
        if not filename.endswith('.bat'):
            filename += '.bat'
        
        filepath = output_dir / f"{i:03d}_{filename}"
        
        with open(filepath, 'w', encoding='cp1251', errors='ignore') as f:
            f.write("@echo off\n")
            f.write("chcp 1251 >nul\n")
            f.write("title " + section['filename'] + "\n")
            f.write("color 0A\n")
            f.write("echo ========================================\n")
            f.write("echo " + section['filename'] + "\n")
            f.write("echo ========================================\n")
            f.write("echo.\n")
            f.write(":: Проверка прав администратора\n")
            f.write("net session >nul 2>&1\n")
            f.write("if %errorlevel% neq 0 (\n")
            f.write("    echo ОШИБКА: Требуются права администратора!\n")
            f.write("    echo Запустите файл от имени администратора\n")
            f.write("    pause\n")
            f.write("    exit /b 1\n")
            f.write(")\n")
            f.write("echo.\n")
            f.write("echo Применение настроек...\n")
            f.write("echo.\n")
            f.write(section['content'] + "\n")
            f.write("echo.\n")
            f.write("if %errorlevel% equ 0 (\n")
            f.write("    echo [OK] Настройки успешно применены\n")
            f.write(") else (\n")
            f.write("    echo [ОШИБКА] Не удалось применить настройки\n")
            f.write(")\n")
            f.write("echo.\n")
            f.write("pause\n")
        
        print(f"  {i:02d}. {filename}")
    
    print("-" * 50)
    print(f"\n✅ ГОТОВО! {len(sections)} файлов создано в папке {output_dir}/")
    
    # Создаем общий файл для запуска всего сразу
    all_file = output_dir / "000_ВСЕ_СРАЗУ.bat"
    with open(all_file, 'w', encoding='cp1251', errors='ignore') as f:
        f.write("@echo off\n")
        f.write("title ВСЕ НАСТРОЙКИ NVIDIA\n")
        f.write("color 0C\n")
        f.write("chcp 1251 >nul\n")
        f.write("echo ========================================\n")
        f.write("echo ВСЕ НАСТРОЙКИ NVIDIA\n")
        f.write("echo ========================================\n")
        f.write(f"echo Всего настроек: {len(sections)}\n")
        f.write("echo.\n")
        f.write(":: Проверка прав администратора\n")
        f.write("net session >nul 2>&1\n")
        f.write("if %errorlevel% neq 0 (\n")
        f.write("    echo ОШИБКА: Требуются права администратора!\n")
        f.write("    pause\n")
        f.write("    exit /b 1\n")
        f.write(")\n")
        f.write("echo.\n")
        f.write("echo ВНИМАНИЕ: Будут применены ВСЕ настройки!\n")
        f.write("echo.\n")
        f.write("pause\n")
        f.write("cls\n")
        
        for i, section in enumerate(sections, 1):
            f.write(f"echo [{i}/{len(sections)}] {section['filename']}\n")
            f.write(section['content'] + "\n")
            f.write(f"if %errorlevel% equ 0 (echo   [OK]) else (echo   [ОШИБКА])\n")
            f.write("echo.\n")
        
        f.write("echo ========================================\n")
        f.write("echo [OK] Все настройки применены\n")
        f.write("pause\n")
    
    print(f"  📄 Создан общий файл: 000_ВСЕ_СРАЗУ.bat")
    
    # Открываем папку
    try:
        import os
        os.startfile(output_dir)
    except:
        pass

if __name__ == "__main__":
    main()