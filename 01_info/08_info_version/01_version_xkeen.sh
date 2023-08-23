#!/bin/sh

# Функция для получения информации о версии Xkeen
info_version_xkeen() {
    XKEEN_CURRENT_VERSION="$("$INSTALL_DIR/xkeen" -version 2>&1)"
    XKEEN_GITHUB_VERSION=$(call_api "$XKEEN_API_URL" | jq -r '.tag_name' 2>/dev/null)
}

# Экспортирование переменных для использования в других скриптах
export XKEEN_CURRENT_VERSION
export XKEEN_GITHUB_VERSION
