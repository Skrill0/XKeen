#!/bin/sh

# Функция для получения информации о версии Xkeen
info_version_xkeen() {
    XKEEN_GITHUB_VERSION=$(call_api "$XKEEN_API_URL" | jq -r '.tag_name' 2>/dev/null)
}
