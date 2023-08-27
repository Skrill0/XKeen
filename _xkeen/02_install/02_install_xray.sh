#!/bin/sh

install_xray() {
    xray_archive="$TMP_DIR/xray.ipk"
    
    if [ -f "$xray_archive" ]; then
        mkdir -p "$TMP_DIR/xray"
        
        tar -xzf "$xray_archive" -C "$TMP_DIR/xray"
        tar -xzf "$TMP_DIR/xray/data.tar.gz" -C "$TMP_DIR/xray"
        
        mv "$TMP_DIR/xray/usr/bin/xray" "$INSTALL_DIR/"
        
        rm -rf "$TMP_DIR/xray"
        rm "$xray_archive"
    fi
}

