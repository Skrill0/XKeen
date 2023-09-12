# Регистрация xkeen

# Функция для создания файла xkeen.control
register_xkeen_control() {
    # Создание файла xkeen.control
    cat << EOF > "$register_dir/xkeen.control"
Package: xkeen
Version: $xkeen_current_version
Depends: jq, curl, lscpu, coreutils-uname
Source: Skrill
SourceName: xkeen
Section: net
SourceDateEpoch: $source_date_epoch
Maintainer: Skrill
Architecture: $status_architecture
Installed-Size: $installed_size
Description: The platform that makes Xray work.
EOF
}


register_xkeen_list() {
    cd "$register_dir/" || exit

    touch xkeen.list
    cat >> xkeen.list << EOF
/opt/sbin/xkeen

/opt/sbin/.xkeen/import.sh
/opt/sbin/.xkeen/author.sh

/opt/sbin/.xkeen/01_info/00_info_import.sh
/opt/sbin/.xkeen/01_info/01_info_variable.sh
/opt/sbin/.xkeen/01_info/02_info_packages.sh
/opt/sbin/.xkeen/01_info/03_info_cpu.sh
/opt/sbin/.xkeen/01_info/04_info_xray.sh
/opt/sbin/.xkeen/01_info/05_info_geosite.sh
/opt/sbin/.xkeen/01_info/06_info_geoip.sh
/opt/sbin/.xkeen/01_info/07_info_cron.sh

/opt/sbin/.xkeen/01_info/08_info_version/00_version_import.sh
/opt/sbin/.xkeen/01_info/08_info_version/01_version_xkeen.sh
/opt/sbin/.xkeen/01_info/08_info_version/02_version_xray.sh
/opt/sbin/.xkeen/01_info/08_info_version

/opt/sbin/.xkeen/01_info/09_info_compare/00_compare_import.sh
/opt/sbin/.xkeen/01_info/09_info_compare/01_compare_xkeen.sh
/opt/sbin/.xkeen/01_info/09_info_compare/02_compare_xray.sh
/opt/sbin/.xkeen/01_info/09_info_compare

/opt/sbin/.xkeen/01_info

/opt/sbin/.xkeen/02_install/00_install_import.sh
/opt/sbin/.xkeen/02_install/01_install_packages.sh
/opt/sbin/.xkeen/02_install/02_install_xray.sh
/opt/sbin/.xkeen/02_install/03_install_xkeen.sh
/opt/sbin/.xkeen/02_install/04_install_geosite.sh
/opt/sbin/.xkeen/02_install/05_install_geoip.sh
/opt/sbin/.xkeen/02_install/06_install_cron.sh

/opt/sbin/.xkeen/02_install/07_install_register/00_register_import.sh
/opt/sbin/.xkeen/02_install/07_install_register/01_register_xray.sh
/opt/sbin/.xkeen/02_install/07_install_register/02_register_xkeen.sh
/opt/sbin/.xkeen/02_install/07_install_register/03_register_cron.sh

/opt/sbin/.xkeen/02_install/08_install_configs/00_configs_import.sh
/opt/sbin/.xkeen/02_install/08_install_configs/01_configs_install.sh

/opt/sbin/.xkeen/02_install/08_install_configs/02_configs_dir/01_log.json
/opt/sbin/.xkeen/02_install/08_install_configs/02_configs_dir/02_stats.json
/opt/sbin/.xkeen/02_install/08_install_configs/02_configs_dir/03_dns.json
/opt/sbin/.xkeen/02_install/08_install_configs/02_configs_dir/04_reverse.json
/opt/sbin/.xkeen/02_install/08_install_configs/02_configs_dir/05_fake-dns.json
/opt/sbin/.xkeen/02_install/08_install_configs/02_configs_dir/06_transport.json
/opt/sbin/.xkeen/02_install/08_install_configs/02_configs_dir/07_inbounds.json
/opt/sbin/.xkeen/02_install/08_install_configs/02_configs_dir/08_outbounds.json
/opt/sbin/.xkeen/02_install/08_install_configs/02_configs_dir/09_policy.json
/opt/sbin/.xkeen/02_install/08_install_configs/02_configs_dir/10_routing.json

/opt/sbin/.xkeen/02_install/07_install_register
/opt/sbin/.xkeen/02_install/08_install_configs/02_configs_dir
/opt/sbin/.xkeen/02_install/08_install_configs
/opt/sbin/.xkeen/02_install

/opt/sbin/.xkeen/03_delete/00_delete_import.sh
/opt/sbin/.xkeen/03_delete/01_delete_geosite.sh
/opt/sbin/.xkeen/03_delete/02_delete_geoip.sh
/opt/sbin/.xkeen/03_delete/03_delete_cron.sh
/opt/sbin/.xkeen/03_delete/04_delete_configs.sh
/opt/sbin/.xkeen/03_delete/05_delete_register.sh
/opt/sbin/.xkeen/03_delete/06_delete_tmp.sh
/opt/sbin/.xkeen/03_delete

/opt/sbin/.xkeen/04_tools/01_tools_logs/00_logs_import.sh
/opt/sbin/.xkeen/04_tools/01_tools_logs/01_logs_clear.sh
/opt/sbin/.xkeen/04_tools/01_tools_logs/02_logs_console.sh
/opt/sbin/.xkeen/04_tools/01_tools_logs/03_logs_xkeen.sh
/opt/sbin/.xkeen/04_tools/01_tools_logs

/opt/sbin/.xkeen/04_tools/02_tools_choose/00_choose_import.sh
/opt/sbin/.xkeen/04_tools/02_tools_choose/01_choose_input.sh
/opt/sbin/.xkeen/04_tools/02_tools_choose/02_choose_geosite.sh
/opt/sbin/.xkeen/04_tools/02_tools_choose/03_choose_geoip.sh

/opt/sbin/.xkeen/04_tools/02_tools_choose/04_choose_cron/00_cron_import.sh
/opt/sbin/.xkeen/04_tools/02_tools_choose/04_choose_cron/01_cron_status.sh
/opt/sbin/.xkeen/04_tools/02_tools_choose/04_choose_cron/02_cron_time.sh
/opt/sbin/.xkeen/04_tools/02_tools_choose/04_choose_cron
/opt/sbin/.xkeen/04_tools/02_tools_choose

/opt/sbin/.xkeen/04_tools/03_tools_backups/00_backups_import.sh
/opt/sbin/.xkeen/04_tools/03_tools_backups/01_backups_xray.sh
/opt/sbin/.xkeen/04_tools/03_tools_backups/02_backups_configs.sh
/opt/sbin/.xkeen/04_tools/03_tools_backups/02_backups_xkeen.sh
/opt/sbin/.xkeen/04_tools/03_tools_backups

/opt/sbin/.xkeen/04_tools/04_tools_downloaders/00_downloaders_import.sh
/opt/sbin/.xkeen/04_tools/04_tools_downloaders/01_downloaders_xray.sh
/opt/sbin/.xkeen/04_tools/04_tools_downloaders/02_donwloaders_xkeen.sh
/opt/sbin/.xkeen/04_tools/04_tools_downloaders

/opt/sbin/.xkeen/04_tools/00_tools_import.sh
/opt/sbin/.xkeen/04_tools/05_tools_archive.sh
/opt/sbin/.xkeen/04_tools

/opt/sbin/.xkeen/05_tests/00_tests_import.sh
/opt/sbin/.xkeen/05_tests/01_tests_connected.sh
/opt/sbin/.xkeen/05_tests/02_tests_xports.sh
/opt/sbin/.xkeen/05_tests

/opt/sbin/.xkeen

/opt/var/log/xkeen/error.log
/opt/var/log/xkeen/info.log
/opt/var/log/xkeen
EOF

}

register_xkeen_status() {
    # Генерация новой записи
    new_entry="
	
Package: xkeen
Version: $xkeen_current_version
Depends: jq, curl, lscpu
Status: install user installed
Architecture: $status_architecture
Installed-Time: $(date +%s)"

    # Чтение существующего содержимого файла "status"
    existing_content=$(cat "$status_file")

    # Объединение существующего содержимого и новой записи
    new_content="$existing_content$new_entry"

    # Запись измененного содержимого обратно в файл "status"
    echo "$new_content" > "$status_file"
}