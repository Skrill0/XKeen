#!/bin/sh

# Функция для проверки установки Xray

info_xray() {
    if [ -e "$INSTALL_DIR/xray" ]; then
        XRAY_INSTALLED="installed"
    else
        XRAY_INSTALLED="not_installed"
    fi
}
