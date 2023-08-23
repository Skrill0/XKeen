#!/bin/sh

# Проверки наличия необходимых пакетов
info_packages() {
    package_name="$1"
    if opkg list-installed | grep -q "$package_name"; then
        package_status="installed"
    else
        package_status="not_installed"
    fi
}

# Сохранение статусов
info_packages "lscpu"
INFO_PACKAGES_LSCPU=$package_status

info_packages "curl"
INFO_PACKAGES_CURL=$package_status

info_packages "jq"
INFO_PACKAGES_JQ=$package_status

info_packages "libc"
INFO_PACKAGES_LIBC=$package_status