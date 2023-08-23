#!/bin/sh

# Модуль логирования
. "$XTOOLS_DIR/01_tools_logs/00_logs_import.sh"

# Модуль выбора
. "$XTOOLS_DIR/02_tools_choose/00_choose_import.sh"

# Модуль резервного копирования
. "$XTOOLS_DIR/03_tools_backups/00_backups_import.sh"

# Модуль загрузок
. "$XTOOLS_DIR/04_tools_downloaders/00_downloaders_import.sh"

# Дополнительные инструменты
. "$XTOOLS_DIR/05_tools_cpu-keyword.sh"
