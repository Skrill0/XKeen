#!/bin/sh

backup_xray() {
    if [ "$XRAY_INSTALLED" = "installed" ]; then
        backup_filename="xray_v$XRAY_CURRENT_VERSION"
        cp "$INSTALL_DIR/xray" "$BACKUPS_DIR/$backup_filename"
    fi
}
