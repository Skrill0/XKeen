# Регистрация xkeen

# Функция для создания файла xkeen.control
register_xkeen_control() {
    # Путь к файлу xkeen.control
    xkeen_control_file="$register_dir/xkeen.control"

    # Содержимое файла xkeen.control
    control_file_content="package: xkeen
version: $xkeen_current_version
depends: jq, curl, lscpu
source: skrill
sourcename: xkeen
section: net
sourcedateepoch: $source_date_epoch
maintainer: skrill
architecture: $status_architecture
installed-size: $installed_size
description: the platform that makes xray work.
"

    # Создание или обновление файла xkeen.control
    echo -e "$control_file_content" > "$xkeen_control_file"
}

register_xkeen_list() {

    # Переход в папку register_dir
    cd "$register_dir/" || exit

    touch xkeen.list
    cat >> xkeen.list << eof
if [ -e "/opt/sbin/.xkeen/01_info/00_info_import.sh" ]; then
    echo "/opt/sbin/.xkeen/01_info/00_info_import.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/01_info/01_info_variable.sh" ]; then
    echo "/opt/sbin/.xkeen/01_info/01_info_variable.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/01_info/02_info_packages.sh" ]; then
    echo "/opt/sbin/.xkeen/01_info/02_info_packages.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/01_info/03_info_cpu.sh" ]; then
    echo "/opt/sbin/.xkeen/01_info/03_info_cpu.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/01_info/04_info_xray.sh" ]; then
    echo "/opt/sbin/.xkeen/01_info/04_info_xray.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/01_info/05_info_geodata.sh" ]; then
    echo "/opt/sbin/.xkeen/01_info/05_info_geodata.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/01_info/06_info_geoip.sh" ]; then
    echo "/opt/sbin/.xkeen/01_info/06_info_geoip.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/01_info/07_info_cron.sh" ]; then
    echo "/opt/sbin/.xkeen/01_info/07_info_cron.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/xkeen" ]; then
    echo "/opt/sbin/xkeen" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/import.sh" ]; then
    echo "/opt/sbin/.xkeen/import.sh" >> xkeen.list
fi


if [ -e "/opt/sbin/.xkeen/01_info/08_info_version/00_version_import.sh" ]; then
    echo "/opt/sbin/.xkeen/01_info/08_info_version/00_version_import.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/01_info/08_info_version/01_version_xkeen.sh" ]; then
    echo "/opt/sbin/.xkeen/01_info/08_info_version/01_version_xkeen.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/01_info/08_info_version/02_version_xray.sh" ]; then
    echo "/opt/sbin/.xkeen/01_info/08_info_version/02_version_xray.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/01_info/08_info_version" ]; then
    echo "/opt/sbin/.xkeen/01_info/08_info_version" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/01_info/09_info_compare/00_compare_import.sh" ]; then
    echo "/opt/sbin/.xkeen/01_info/09_info_compare/00_compare_import.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/01_info/09_info_compare/01_compare_xkeen.sh" ]; then
    echo "/opt/sbin/.xkeen/01_info/09_info_compare/01_compare_xkeen.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/01_info/09_info_compare/02_compare_xray.sh" ]; then
    echo "/opt/sbin/.xkeen/01_info/09_info_compare/02_compare_xray.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/01_info/09_info_compare" ]; then
    echo "/opt/sbin/.xkeen/01_info/09_info_compare" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/01_info" ]; then
    echo "/opt/sbin/.xkeen/01_info" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/00_install_import.sh" ]; then
    echo "/opt/sbin/.xkeen/02_install/00_install_import.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/01_install_packages.sh" ]; then
    echo "/opt/sbin/.xkeen/02_install/01_install_packages.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/02_install_xray.sh" ]; then
    echo "/opt/sbin/.xkeen/02_install/02_install_xray.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/03_install_geodata.sh" ]; then
    echo "/opt/sbin/.xkeen/02_install/03_install_geodata.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/04_install_geoip.sh" ]; then
    echo "/opt/sbin/.xkeen/02_install/04_install_geoip.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/05_install_cron.sh" ]; then
    echo "/opt/sbin/.xkeen/02_install/05_install_cron.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/06_install_register/00_register_import.sh" ]; then
    echo "/opt/sbin/.xkeen/02_install/06_install_register/00_register_import.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/06_install_register/01_register_xray.sh" ]; then
    echo "/opt/sbin/.xkeen/02_install/06_install_register/01_register_xray.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/06_install_register/02_register_xkeen.sh" ]; then
    echo "/opt/sbin/.xkeen/02_install/06_install_register/02_register_xkeen.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/07_install_configs/00_configs_import.sh" ]; then
    echo "/opt/sbin/.xkeen/02_install/07_install_configs/00_configs_import.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/07_install_configs/01_configs_install.sh" ]; then
    echo "/opt/sbin/.xkeen/02_install/07_install_configs/01_configs_install.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/00_base.json" ]; then
    echo "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/00_base.json" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/01_log.json" ]; then
    echo "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/01_log.json" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/02_stats.json" ]; then
    echo "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/02_stats.json" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/03_dns.json" ]; then
    echo "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/03_dns.json" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/04_reverse.json" ]; then
    echo "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/04_reverse.json" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/05_fake-dns.json" ]; then
    echo "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/05_fake-dns.json" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/06_transport.json" ]; then
    echo "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/06_transport.json" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/07_inbounds.json" ]; then
    echo "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/07_inbounds.json" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/08_outbounds.json" ]; then
    echo "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/08_outbounds.json" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/09_policy.json" ]; then
    echo "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/09_policy.json" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/10_routing.json" ]; then
    echo "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/10_routing.json" >> xkeen.list
fi


if [ -e "/opt/sbin/.xkeen/02_install/06_install_register" ]; then
    echo "/opt/sbin/.xkeen/02_install/06_install_register" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir" ]; then
    echo "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install/07_install_configs" ]; then
    echo "/opt/sbin/.xkeen/02_install/07_install_configs" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/02_install" ]; then
    echo "/opt/sbin/.xkeen/02_install" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/03_delete/00_delete_import.sh" ]; then
    echo "/opt/sbin/.xkeen/03_delete/00_delete_import.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/03_delete/01_delete_geodata.sh" ]; then
    echo "/opt/sbin/.xkeen/03_delete/01_delete_geodata.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/03_delete/02_delete_geoip.sh" ]; then
    echo "/opt/sbin/.xkeen/03_delete/02_delete_geoip.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/03_delete/03_delete_cron.sh" ]; then
    echo "/opt/sbin/.xkeen/03_delete/03_delete_cron.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/03_delete/04_delete_configs.sh" ]; then
    echo "/opt/sbin/.xkeen/03_delete/04_delete_configs.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/03_delete/05_delete_register.sh" ]; then
    echo "/opt/sbin/.xkeen/03_delete/05_delete_register.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/03_delete/06_delete_tmp.sh" ]; then
    echo "/opt/sbin/.xkeen/03_delete/06_delete_tmp.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/03_delete" ]; then
    echo "/opt/sbin/.xkeen/03_delete" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/01_tools_logs/00_logs_import.sh" ]; then
    echo "/opt/sbin/.xkeen/04_tools/01_tools_logs/00_logs_import.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/01_tools_logs/01_logs_clear.sh" ]; then
    echo "/opt/sbin/.xkeen/04_tools/01_tools_logs/01_logs_clear.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/01_tools_logs/02_logs_console.sh" ]; then
    echo "/opt/sbin/.xkeen/04_tools/01_tools_logs/02_logs_console.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/01_tools_logs/03_logs_xkeen.sh" ]; then
    echo "/opt/sbin/.xkeen/04_tools/01_tools_logs/03_logs_xkeen.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/01_tools_logs" ]; then
    echo "/opt/sbin/.xkeen/04_tools/01_tools_logs" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/02_tools_choose/00_choose_import.sh" ]; then
    echo "/opt/sbin/.xkeen/04_tools/02_tools_choose/00_choose_import.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/02_tools_choose/01_choose_input.sh" ]; then
    echo "/opt/sbin/.xkeen/04_tools/02_tools_choose/01_choose_input.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/02_tools_choose/02_choose_geodata.sh" ]; then
    echo "/opt/sbin/.xkeen/04_tools/02_tools_choose/02_choose_geodata.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/02_tools_choose/03_choose_geoip.sh" ]; then
    echo "/opt/sbin/.xkeen/04_tools/02_tools_choose/03_choose_geoip.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/02_tools_choose/04_choose_cron/00_cron_import.sh" ]; then
    echo "/opt/sbin/.xkeen/04_tools/02_tools_choose/04_choose_cron/00_cron_import.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/02_tools_choose/04_choose_cron/01_cron_status.sh" ]; then
    echo "/opt/sbin/.xkeen/04_tools/02_tools_choose/04_choose_cron/01_cron_status.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/02_tools_choose/04_choose_cron/02_cron_time.sh" ]; then
    echo "/opt/sbin/.xkeen/04_tools/02_tools_choose/04_choose_cron/02_cron_time.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/02_tools_choose/04_choose_cron" ]; then
    echo "/opt/sbin/.xkeen/04_tools/02_tools_choose/04_choose_cron" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/02_tools_choose" ]; then
    echo "/opt/sbin/.xkeen/04_tools/02_tools_choose" >> xkeen.list
fi
if [ -e "/opt/sbin/.xkeen/04_tools/03_tools_backups/00_backups_import.sh" ]; then
    echo "/opt/sbin/.xkeen/04_tools/03_tools_backups/00_backups_import.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/03_tools_backups/01_backups_xray.sh" ]; then
    echo "/opt/sbin/.xkeen/04_tools/03_tools_backups/01_backups_xray.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/03_tools_backups/02_backups_configs.sh" ]; then
    echo "/opt/sbin/.xkeen/04_tools/03_tools_backups/02_backups_configs.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/03_tools_backups/02_backups_xkeen.sh" ]; then
    echo "/opt/sbin/.xkeen/04_tools/03_tools_backups/02_backups_xkeen.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/03_tools_backups" ]; then
    echo "/opt/sbin/.xkeen/04_tools/03_tools_backups" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/04_tools_downloaders/00_downloaders_import.sh" ]; then
    echo "/opt/sbin/.xkeen/04_tools/04_tools_downloaders/00_downloaders_import.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/04_tools_downloaders/01_downloaders_xray.sh" ]; then
    echo "/opt/sbin/.xkeen/04_tools/04_tools_downloaders/01_downloaders_xray.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/04_tools_downloaders/02_donwloaders_xkeen.sh" ]; then
    echo "/opt/sbin/.xkeen/04_tools/04_tools_downloaders/02_donwloaders_xkeen.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/04_tools_downloaders" ]; then
    echo "/opt/sbin/.xkeen/04_tools/04_tools_downloaders" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/00_tools_import.sh" ]; then
    echo "/opt/sbin/.xkeen/04_tools/00_tools_import.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools/05_tools_cpu-keyword.sh" ]; then
    echo "/opt/sbin/.xkeen/04_tools/05_tools_cpu-keyword.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/04_tools" ]; then
    echo "/opt/sbin/.xkeen/04_tools" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/05_tests/00_tests_import.sh" ]; then
    echo "/opt/sbin/.xkeen/05_tests/00_tests_import.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/05_tests/01_tests_connected.sh" ]; then
    echo "/opt/sbin/.xkeen/05_tests/01_tests_connected.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/05_tests/02_tests_ports.sh" ]; then
    echo "/opt/sbin/.xkeen/05_tests/02_tests_ports.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/05_tests/03_tests_xports.sh" ]; then
    echo "/opt/sbin/.xkeen/05_tests/03_tests_xports.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/05_tests/04_tests_users.sh" ]; then
    echo "/opt/sbin/.xkeen/05_tests/04_tests_users.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/05_tests/05_tests_temperature.sh" ]; then
    echo "/opt/sbin/.xkeen/05_tests/05_tests_temperature.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/05_tests/06_tests_speed.sh" ]; then
    echo "/opt/sbin/.xkeen/05_tests/06_tests_speed.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/05_tests/07_tests_socks5.sh" ]; then
    echo "/opt/sbin/.xkeen/05_tests/07_tests_socks5.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/05_tests/08_tests_reality.sh" ]; then
    echo "/opt/sbin/.xkeen/05_tests/08_tests_reality.sh" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen/05_tests" ]; then
    echo "/opt/sbin/.xkeen/05_tests" >> xkeen.list
fi

if [ -e "/opt/sbin/.xkeen" ]; then
    echo "/opt/sbin/.xkeen" >> xkeen.list
fi

if [ -e "/opt/var/log/xkeen/error.log" ]; then
    echo "/opt/var/log/xkeen/error.log" >> xkeen.list
fi

if [ -e "/opt/var/log/xkeen/info.log" ]; then
    echo "/opt/var/log/xkeen/info.log" >> xkeen.list
fi

if [ -e "/opt/var/log/xkeen" ]; then
    echo "/opt/var/log/xkeen" >> xkeen.list
fi

eof

}

# Функция для обновления файла статуса пакета xkeen
register_xkeen_status() {
    # Создание новой записи для файла статуса
    new_entry="

package: xkeen
version: $xkeen_current_version
depends: jq, curl, lscpu
status: install user installed
architecture: $status_architecture
installed-time: $(date +%s)"

    # Получение текущего содержимого файла статуса
    existing_content=$(cat "$status_file")

    # Объединение текущего содержимого и новой записи
    new_content="$existing_content$new_entry"

    # Запись обновленного содержимого в файл статуса
    echo "$new_content" > "$status_file"
}
