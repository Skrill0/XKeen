# Функция для установки необходимых пакетов
install_packages() {
	
    # Проверяем, нужно ли устанавливать пакет
    if [ "$1" = "not_installed" ]; then
	
        # Устанавливаем пакет с использованием opkg
        opkg install "$2" &>/dev/null
		
        # Проверяем код завершения установки
        if [ $? -eq 0 ]; then
		
            # Если установка прошла успешно, обновляем статус пакета
            eval "$2_status=installed_xkeen"
        fi
    fi
}


install_packages "$info_packages_lscpu" "lscpu"
install_packages "$info_packages_curl" "curl"
install_packages "$info_packages_jq" "jq"
install_packages "$info_packages_libc" "libc"
install_packages "$info_packages_libssp" "libssp"
install_packages "$info_packages_librt" "librt"
install_packages "$info_packages_libpthread" "libpthread"
install_packages "$info_packages_cabundle" "ca-bundle"