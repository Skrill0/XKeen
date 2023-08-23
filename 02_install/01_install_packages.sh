#!/bin/sh

# Установка пакета по заданной переменной
install_packages() {
    if [ "$1" = "not_installed" ]; then
        opkg install "$2" &>/dev/null
        if [ $? -eq 0 ]; then
            eval "$2_STATUS=installed_xkeen"
        fi
    fi
}

install_packages "$INFO_PACKAGES_LSCPU" "lscpu"
install_packages "$INFO_PACKAGES_CURL" "curl"
install_packages "$INFO_PACKAGES_JQ" "jq"
install_packages "$INFO_PACKAGES_LIBC" "libc"
