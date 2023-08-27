#!/bin/sh

backup_configs() {
    DATE=$(date +%d-%m-%Y) # Изменим формат даты без дефисов и символа подчеркивания
    BACKUP_CONFIGS_DIR="$BACKUPS_DIR/${DATE}_configs" # Используем фигурные скобки для явного указания имени переменной

    # Создаем директорию BACKUP_CONFIGS_DIR
    mkdir -p "$BACKUP_CONFIGS_DIR"

    # Переносим содержимое INSTALL_CONF_DIR в BACKUP_CONFIGS_DIR
    mv "$INSTALL_CONF_DIR"/* "$BACKUP_CONFIGS_DIR/"

    # Создаем новую директорию INSTALL_CONF_DIR после переноса
    mkdir -p "$INSTALL_CONF_DIR"
}

restore_backup_configs() {
    if [ "$XRAY_INSTALLED" = "installed" ]; then
        latest_backup_dir=$(ls -t -d "$BACKUPS_DIR"/*_configs | head -n 1)
        
        if [ -n "$latest_backup_dir" ]; then
            cp -f "$latest_backup_dir"/* "$INSTALL_CONF_DIR/"
        fi
    fi
}
