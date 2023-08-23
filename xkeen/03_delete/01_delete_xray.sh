delete_xray() {
    INSTALL_DIR="$1"
    
    # Проверяем, существует ли файл xray
    if [ -f "$INSTALL_DIR/xray" ]; then
        # Удаляем файл xray
        rm "$INSTALL_DIR/xray"
    fi
}
