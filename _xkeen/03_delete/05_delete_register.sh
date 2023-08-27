delete_register_xray() {
    
    # Используем sed для удаления записей пакетов
    sed -i -e '/Package: xray/,/Installed-Time:/d' "/opt/lib/opkg/status"
    
    # Удаляем файлы xkeen.control, xkeen.list, xray.control, xray.list
    if [ -f "$REGISTER_DIR/xray.control" ] || [ -f "$REGISTER_DIR/xray.list" ]; then
        rm -f "$REGISTER_DIR/xray.control" "$REGISTER_DIR/xray.list"
    fi
}

delete_register_xkeen() {
	
	# Используем sed для удаления записей пакетов
    sed -i -e '/Package: xkeen/,/Installed-Time:/d' "/opt/lib/opkg/status"
    
    # Удаляем файлы xkeen.control, xkeen.list, xray.control, xray.list
    if [ -f "$REGISTER_DIR/xkeen.control" ] || [ -f "$REGISTER_DIR/xkeen.list" ]; then
        rm -f "$REGISTER_DIR/xkeen.control" "$REGISTER_DIR/xkeen.list"
    fi
}
