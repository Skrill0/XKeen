# Удаление регистрации xray
delete_register_xray() {
    # Удаляем соответствующие записи из файла статуса opkg
    sed -i -e '/package: xray/,/installed-time:/d' "/opt/lib/opkg/status"
    
    # Удаляем файлы регистрации, если они существуют
    if [ -f "$register_dir/xray.control" ] || [ -f "$register_dir/xray.list" ]; then
        rm -f "$register_dir/xray.control" "$register_dir/xray.list"
    fi
}

# Удаление регистрации xkeen
delete_register_xkeen() {
    # Удаляем соответствующие записи из файла статуса opkg
    sed -i -e '/package: xkeen/,/installed-time:/d' "/opt/lib/opkg/status"
    
    # Удаляем файлы регистрации, если они существуют
    if [ -f "$register_dir/xkeen.control" ] || [ -f "$register_dir/xkeen.list" ]; then
        rm -f "$register_dir/xkeen.control" "$register_dir/xkeen.list"
    fi
}
