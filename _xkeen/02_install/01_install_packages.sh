# Функция для установки необходимых пакетов
install_packages() {
    local package_status="$1"
    local package_name="$2"

    # Проверяем, нужно ли устанавливать пакет
    if [ "$package_status" = "not_installed" ]; then
        # Устанавливаем пакет с использованием opkg
        opkg install "$package_name" &>/dev/null

        # Проверяем код завершения установки
        if [ $? -eq 0 ]; then
            # Если установка прошла успешно, обновляем статус
            package_status="installed_xkeen"
        fi
    fi
}

# Пример использования для конкретных пакетов
install_packages "$info_packages_curl" "curl"
install_packages "$info_packages_jq" "jq"
install_packages "$info_packages_libc" "libc"
install_packages "$info_packages_libssp" "libssp"
install_packages "$info_packages_librt" "librt"
install_packages "$info_packages_libpthread" "libpthread"

install_packages "$info_packages_cabundle" "ca-bundle"
info_packages_cabundle="$package_status"
install_packages "$info_packages_uname" "coreutils-uname"
info_packages_uname="$package_status"
