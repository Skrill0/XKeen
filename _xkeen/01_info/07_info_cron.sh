# Проверка наличия задач автоматического обновления в cron
info_cron() {
    # Получаем текущую crontab конфигурацию для пользователя root
    cron_output=$(crontab -l -u root 2>/dev/null)

    # Проверяем наличие задачи с ключевым словом "uxc" в crontab
    if echo "$cron_output" | grep -q "uxc"; then
        info_update_xray_cron="installed"
    else
        info_update_xray_cron="not_installed"
    fi

    # Проверяем наличие задачи с ключевым словом "ukc" в crontab
    if echo "$cron_output" | grep -q "ukc"; then
        info_update_xkeen_cron="installed"
    else
        info_update_xkeen_cron="not_installed"
    fi

    # Проверяем наличие задачи с ключевым словом "ugic" в crontab
    if echo "$cron_output" | grep -q "ugic"; then
        info_update_geoip_cron="installed"
    else
        info_update_geoip_cron="not_installed"
    fi
    
    # Проверяем наличие задачи с ключевым словом "ugdc" в crontab
    if echo "$cron_output" | grep -q "ugdc"; then
        info_update_geodata_cron="installed"
    else
        info_update_geodata_cron="not_installed"
    fi
}
