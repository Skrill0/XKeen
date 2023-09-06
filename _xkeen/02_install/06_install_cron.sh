# Функция для установки задач Cron
install_cron() {
    cron_entry=""

    # Создание записей для всех выбранных задач Cron
    if [ -n "$chose_all_cron_time" ]; then
        cron_entry="$cron_entry\n$chose_all_cron_time $install_dir/xkeen -ugi"
        cron_entry="$cron_entry\n$chose_all_cron_time $install_dir/xkeen -ugs"
        cron_entry="$cron_entry\n$chose_all_cron_time $install_dir/xkeen -uk"
        cron_entry="$cron_entry\n$chose_all_cron_time $install_dir/xkeen -ux"
    fi

    # Добавление задачи Cron для обновления GeoIP
    if [ -n "$chose_geoip_cron_time" ]; then
        cron_entry="$cron_entry\n$chose_geoip_cron_time $install_dir/xkeen -ugi"
    fi

    # Добавление задачи Cron для обновления GeoSite
    if [ -n "$chose_geosite_cron_time" ]; then
        cron_entry="$cron_entry\n$chose_geosite_cron_time $install_dir/xkeen -ugs"
    fi

    # Добавление задачи Cron для обновления Xkeen
    if [ -n "$chose_xkeen_cron_time" ]; then
        cron_entry="$cron_entry\n$chose_xkeen_cron_time $install_dir/xkeen -uk"
    fi

    # Добавление задачи Cron для обновления Xray
    if [ -n "$chose_xray_cron_time" ]; then
        cron_entry="$cron_entry\n$chose_xray_cron_time $install_dir/xkeen -ux"
    fi

    # Если есть записи для задач Cron, то сохраняем их
    if [ -n "$cron_entry" ]; then
        cron_file_path="$cron_dir/$cron_file"

        # Удаляем существующие записи, если выбрано перезаписать или удалить
        if [ -n "$chose_all_cron_select" ] || [ -n "$chose_delete_all_cron_select" ]; then
            sed -i "/$install_dir\/xkeen.*-ugi/d" "$cron_file_path" 2>/dev/null
            sed -i "/$install_dir\/xkeen.*-ugs/d" "$cron_file_path" 2>/dev/null
            sed -i "/$install_dir\/xkeen.*-uk/d" "$cron_file_path" 2>/dev/null
            sed -i "/$install_dir\/xkeen.*-ux/d" "$cron_file_path" 2>/dev/null
        fi

        touch "$cron_file_path"
        chmod +x "$cron_file_path"
        echo -e "$cron_entry" >> "$cron_file_path"
    fi
}
