#!/bin/sh

backup_xkeen() {
    backup_dir="$BACKUPS_DIR/xkeen_v$XKEEN_CURRENT_VERSION"
    
    # Создание директории для резервной копии
    mkdir -p "$backup_dir"
    
    # Копирование директории .xkeen и файла xkeen в директорию резервной копии
    cp -r "$INSTALL_DIR/.xkeen" "$INSTALL_DIR/xkeen" "$backup_dir/"
    
    # Переименование скопированной папки .xkeen в _xkeen
    mv "$backup_dir/.xkeen" "$backup_dir/_xkeen"
}
