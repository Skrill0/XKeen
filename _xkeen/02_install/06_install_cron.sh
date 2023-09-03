# Функция для установки задач Cron
install_cron() {
    cron_entry=""

    # Создание записей для всех выбранных задач Cron
    if [ -n "$chose_all_cron_time" ]; then
        cron_entry="$cron_entry\n$chose_all_cron_time $xkeen_dir/xkeen -ugic"
        cron_entry="$cron_entry\n$chose_all_cron_time $xkeen_dir/xkeen -ugdc"
        cron_entry="$cron_entry\n$chose_all_cron_time $xkeen_dir/xkeen -ukc"
        cron_entry="$cron_entry\n$chose_all_cron_time $xkeen_dir/xkeen -uxc"
    fi

    # Добавление задачи Cron для обновления GeoIP
    if [ -n "$chose_geoip_cron_time" ]; then
        cron_entry="$cron_entry\n$chose_geoip_cron_time $xkeen_dir/xkeen -ugic"
    fi

    # Добавление задачи Cron для обновления GeoData
    if [ -n "$chose_geodata_cron_time" ]; then
        cron_entry="$cron_entry\n$chose_geodata_cron_time $xkeen_dir/xkeen -ugdc"
    fi

    # Добавление задачи Cron для обновления Xkeen
    if [ -n "$chose_xkeen_cron_time" ]; then
        cron_entry="$cron_entry\n$chose_xkeen_cron_time $xkeen_dir/xkeen -ukc"
    fi

    # Добавление задачи Cron для обновления Xray
    if [ -n "$chose_xray_cron_time" ]; then
        cron_entry="$cron_entry\n$chose_xray_cron_time $xkeen_dir/xkeen -uxc"
    fi

    # Если есть записи для задач Cron, то сохраняем их
    if [ -n "$cron_entry" ]; then
        cron_file_path="$cron_dir/$cron_file"

        # Удаляем существующие записи, если выбрано перезаписать или удалить
        if [ -n "$chose_all_cron_select" ] || [ -n "$chose_delete_all_cron_select" ]; then
            sed -i "/$xkeen_dir\/xkeen.*-ugic/d" "$cron_file_path" 2>/dev/null
            sed -i "/$xkeen_dir\/xkeen.*-ugdc/d" "$cron_file_path" 2>/dev/null
            sed -i "/$xkeen_dir\/xkeen.*-ukc/d" "$cron_file_path" 2>/dev/null
            sed -i "/$xkeen_dir\/xkeen.*-uxc/d" "$cron_file_path" 2>/dev/null
        fi

        touch "$cron_file_path"
        chmod +x "$cron_file_path"
        echo -e "$cron_entry" >> "$cron_file_path"
    fi
}
