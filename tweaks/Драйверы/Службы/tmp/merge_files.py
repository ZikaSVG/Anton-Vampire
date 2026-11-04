import os
import sys

def merge_files(root_dir, output_file='merged_output.txt'):
    """
    Рекурсивно обходит root_dir, находит файлы с расширениями html, css, js, ps1
    и объединяет их содержимое в один файл с указанием путей.
    """
    
    # Список целевых расширений (в нижнем регистре)
    target_extensions = {'.html', '.css', '.js', '.bat'}
    
    collected_files = []

    # 1. Сбор списка файлов
    for dirpath, dirnames, filenames in os.walk(root_dir):
        for filename in filenames:
            # Получаем расширение файла и приводим к нижнему регистру
            _, ext = os.path.splitext(filename)
            if ext.lower() in target_extensions:
                full_path = os.path.join(dirpath, filename)
                collected_files.append(full_path)

    # 2. Сортировка файлов по полному пути для порядка
    collected_files.sort()

    if not collected_files:
        print("Файлы с указанными расширениями не найдены.")
        return

    print(f"Найдено файлов: {len(collected_files)}")
    print(f"Запись в файл: {output_file}")

    # 3. Запись в итоговый файл
    try:
        with open(output_file, 'w', encoding='utf-8') as outfile:
            
            for file_path in collected_files:
                # Формируем заголовок
                header = f"\n{'='*10}\n{file_path}\n{'='*10}\n"
                outfile.write(header)
                
                # Читаем содержимое файла
                try:
                    # Пробуем UTF-8
                    with open(file_path, 'r', encoding='utf-8') as infile:
                        content = infile.read()
                except UnicodeDecodeError:
                    try:
                        # Если не вышло, пробуем Windows-1251 (часто встречается в старых проектах или PS1)
                        with open(file_path, 'r', encoding='cp1251') as infile:
                            content = infile.read()
                    except Exception as e:
                        content = f"[Ошибка чтения файла: {e}]"
                except Exception as e:
                    content = f"[Ошибка открытия файла: {e}]"
                
                outfile.write(content)
                # Добавляем перенос строки после каждого файла для чистоты
                if not content.endswith('\n'):
                    outfile.write('\n')

        print("Готово!")

    except IOError as e:
        print(f"Ошибка при записи итогового файла: {e}")

if __name__ == '__main__':
    # Если аргумент командной строки передан, используем его как путь
    # Иначе используем текущую директорию
    if len(sys.argv) > 1:
        directory = sys.argv[1]
    else:
        directory = '.' 
    
    # Опционально: можно задать имя выходного файла вторым аргументом
    out_name = sys.argv[2] if len(sys.argv) > 2 else 'merged_project.txt'

    if os.path.isdir(directory):
        merge_files(directory, out_name)
    else:
        print(f"Указанный путь '{directory}' не является директорией.")