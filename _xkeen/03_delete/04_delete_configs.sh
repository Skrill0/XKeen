delete_configs() {
    # Удаляем все файлы .json из директории
    find "$INSTALL_CONF_DIR" -name "*.json" -type f -delete
}
