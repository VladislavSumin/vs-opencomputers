#!/bin/bash

# Константа, указывающая целевую директорию
TARGET_DIR="/Applications/MultiMC.app/Data/instances/GT_New_Horizons_2.7.3_Java_17-21/.minecraft/saves/Test1/opencomputers/532f0ff4-4495-4cd3-8e49-f805d620bb7e"

# Проверка существования целевой директории. Если нет - выходим с ошибкой.
if [ ! -d "$TARGET_DIR" ]; then
  echo "Ошибка: Целевая директория '$TARGET_DIR' не существует."
  exit 1
fi

# Функция для копирования файлов с заменой
copy_files() {
  local source_dir="$1"
  local target_subdir="$2"

  if [ ! -d "$source_dir" ]; then
    echo "Ошибка: Исходная директория '$source_dir' не существует."
    return 1
  fi

  # Создаем поддиректорию в целевой директории, если ее нет.
  local target_path="$TARGET_DIR/$target_subdir"
  if [ ! -d "$target_path" ]; then
    echo "Ошибка: Поддиректория '$target_path' не существует."
    exit 1
  fi

  echo "Копирую файлы из '$source_dir' в '$target_path'..."
  cp -rf $source_dir/* $target_path/

  if [ $? -eq 0 ]; then
    echo "Файлы успешно скопированы."
    return 0
  else
    echo "Ошибка при копировании файлов."
    return 1
  fi
}


# Копируем файлы из bin
copy_files "bin" "home"

# Копируем файлы из lib
copy_files "lib" "lib"

echo "Скрипт завершен."
