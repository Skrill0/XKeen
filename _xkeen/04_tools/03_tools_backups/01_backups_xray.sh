backup_xray() {
    if [ "$XRAY_INSTALLED" = "installed" ]; then
        backup_filename="xray_v$XRAY_CURRENT_VERSION"
        cp "$INSTALL_DIR/xray" "$BACKUPS_DIR/$backup_filename"
    fi
}

restore_backup_xray() {
    if [ "$XRAY_INSTALLED" = "installed" ]; then
        latest_backup=$(ls -t "$BACKUPS_DIR" | grep "xray_v" | head -n 1)
        
        if [ -n "$latest_backup" ]; then
            new_filename="xray"
            cp -f "$BACKUPS_DIR/$latest_backup" "$INSTALL_DIR/$new_filename"
        fi
    fi
}
