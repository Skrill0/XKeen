#!/bin/sh

# Функция для получения информации о версии Xray
info_version_xray() {
    XRAY_CURRENT_VERSION=""
    if [ "$XRAY_INSTALLED" = "installed" ]; then
        XRAY_CURRENT_VERSION=$("$INSTALL_DIR/xray" -version 2>&1 | grep -o -E 'Xray [0-9]+\.[0-9]+\.[0-9]+' | cut -d ' ' -f 2)
    fi

    XRAY_GITHUB_VERSION=$(call_api "$XRAY_API_URL" | jq -r '.tag_name' 2>/dev/null | sed 's/^v//') 
}
