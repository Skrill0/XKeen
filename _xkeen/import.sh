#!/bin/sh

# Определение директории, где находится xkeen.sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
XINFO_DIR="$SCRIPT_DIR/.xkeen/01_info"
XINSTALL_DIR="$SCRIPT_DIR/.xkeen/02_install"
XDELETE_DIR="$SCRIPT_DIR/.xkeen/03_delete"
XTOOLS_DIR="$SCRIPT_DIR/.xkeen/04_tools"
XTESTS_DIR="$SCRIPT_DIR/.xkeen/05_tests"

# Модуль информации
. "$XINFO_DIR/00_info_import.sh"

# Модуль установки
. "$XINSTALL_DIR/00_install_import.sh"

# Модуль удаления
. "$XDELETE_DIR/00_delete_import.sh"

# Модуль инструментария
. "$XTOOLS_DIR/00_tools_import.sh"

# Модуль тестирования
. "$XTESTS_DIR/00_tests_import.sh"
