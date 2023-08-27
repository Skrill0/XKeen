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