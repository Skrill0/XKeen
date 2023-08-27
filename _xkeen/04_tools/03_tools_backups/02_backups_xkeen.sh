backup_xkeen() {
    backup_dir="$BACKUPS_DIR/xkeen_v$XKEEN_CURRENT_VERSION"
    
    # Создание директории для резервной копии
    mkdir -p "$backup_dir"
    
    # Копирование директории .xkeen и файла xkeen в директорию резервной копии
    cp -r "$INSTALL_DIR/.xkeen" "$INSTALL_DIR/xkeen" "$backup_dir/"
    
    # Переименование скопированной папки .xkeen в _xkeen
    mv "$backup_dir/.xkeen" "$backup_dir/_xkeen"
}

restore_backup_xkeen() {
    if [ "$XRAY_INSTALLED" = "installed" ]; then
        restore_script=$(mktemp)
        cat <<EOF > "$restore_script"
#!/bin/bash

if [ "\$XRAY_INSTALLED" = "installed" ]; then
    latest_backup_dir=\$(ls -t -d "$BACKUPS_DIR"/xkeen_v* | head -n 1)
    
    if [ -n "\$latest_backup_dir" ]; then
        cp -f "\$latest_backup_dir"/_xkeen "\$INSTALL_DIR/.xkeen"
        cp -f "\$latest_backup_dir"/xkeen "\$INSTALL_DIR/xkeen"
    fi
fi
EOF

        chmod +x "$restore_script"
        "$restore_script"
        rm "$restore_script"
    fi
}
