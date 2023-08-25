#!/bin/sh

backup_xkeen() {
    backup_filename="xkeen_v$XKEEN_CURRENT_VERSION"
    cp "$INSTALL_DIR/xkeen" "$BACKUPS_DIR/$backup_filename"
}