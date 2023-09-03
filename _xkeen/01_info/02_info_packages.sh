# Проверяет наличие необходимых пакетов

info_packages() {
    package_name="$1"
    
    # Проверяем, установлен ли пакет
    if opkg list-installed | grep -q "$package_name"; then
        package_status="установлен"
    else
        package_status="не установлен"
    fi
}

info_packages "lscpu"
info_packages_lscpu=$package_status

info_packages "curl"
info_packages_curl=$package_status

info_packages "jq"
info_packages_jq=$package_status

info_packages "libc"
info_packages_libc=$package_status

info_packages "libssp"
info_packages_libssp=$package_status

info_packages "librt"
info_packages_librt=$package_status

info_packages "libpthread"
info_packages_libpthread=$package_status

info_packages "ca-bundle"
info_packages_cabundle=$package_status