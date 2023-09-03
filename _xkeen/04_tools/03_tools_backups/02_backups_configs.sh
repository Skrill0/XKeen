# Работа с резервными копиями конфигураций

# Создание резервной копии конфигураций Xray
backup_configs() {
    local  backup_filename="${current_datetime}_configs"
    local backup_configs_dir="$backups_dir/$backup_filename"
    mkdir -p "$backup_configs_dir"

    # Копирование всех файлов конфигураций в резервную копию
    cp -r "$install_conf_dir"/* "$backup_configs_dir/"

    if [ $? -eq 0 ]; then
        echo -e "  Резервная копия конфигураций Xray создана: ${yellow}$backup_filename${reset}"
    else
        echo -e "  ${red}Ошибка при создании резервной копии конфигураций Xray${reset}"
    fi
}



restore_backup_configs() {
    # Найти самую последнюю резервную копию конфигураций
    local latest_backup=$(ls -t "$backups_dir" | grep "configs" | head -n 1)

    if [ -n "$latest_backup" ]; then
        backup_path="$backups_dir/$latest_backup"

        # Восстановление конфигураций из резервной копии в текущую директорию конфигураций
        cp -r "$backup_path"/* "$install_conf_dir/"

        echo "  Конфигурации ${green}успешно восстановлены${reset} из резервной копии."
    fi
}
