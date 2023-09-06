# Функция для удаления cron задач
delete_cron_task() {
    if [ "$chose_cancel_cron_select" != true ]; then
        if [ -f "$cron_dir/$cron_file" ]; then
            tmp_file="$cron_dir/${cron_file}.tmp"
            
            cp "$cron_dir/$cron_file" "$tmp_file"
            
            if [ "$chose_all_cron_select" = true ] || [ "$chose_delete_all_cron_select" = true ]; then
                grep -v "ugi" "$tmp_file" | grep -v "ugs" | grep -v "ux" | grep -v "uk" | sed '/^\s*$/d' > "$cron_dir/$cron_file"
            else
                if [ "$chose_xkeen_cron_select" = true ]; then
                    delete_cron_xkeen
                fi
                
                if [ "$chose_xray_cron_select" = true ]; then
                    delete_cron_xray
                fi
                
                if [ "$chose_geosite_cron_select" = true ]; then
                    delete_cron_geosite
                fi
                
                if [ "$chose_geoip_cron_select" = true ]; then
                    delete_cron_geoip
                fi
            fi
        fi
    fi
}

# Функция для удаления cron задач для xkeen
delete_cron_xkeen() {
    if [ -f "$cron_dir/$cron_file" ]; then
        tmp_file="$cron_dir/${cron_file}.tmp"
        
        cp "$cron_dir/$cron_file" "$tmp_file"
        
        grep -v "uk" "$tmp_file" | sed '/^\s*$/d' > "$cron_dir/$cron_file"
    fi
}

# Функция для удаления cron задач для xray
delete_cron_xray() {
    if [ -f "$cron_dir/$cron_file" ]; then
        tmp_file="$cron_dir/${cron_file}.tmp"
        
        cp "$cron_dir/$cron_file" "$tmp_file"
        
        grep -v "ux" "$tmp_file" | sed '/^\s*$/d' > "$cron_dir/$cron_file"
    fi
}

# Функция для удаления cron задач для geosite
delete_cron_geosite() {
    if [ -f "$cron_dir/$cron_file" ]; then
        tmp_file="$cron_dir/${cron_file}.tmp"
        
        cp "$cron_dir/$cron_file" "$tmp_file"
        
        grep -v "ugs" "$tmp_file" | sed '/^\s*$/d' > "$cron_dir/$cron_file"
    fi
}

# Функция для удаления cron задач для geoip
delete_cron_geoip() {
    if [ -f "$cron_dir/$cron_file" ]; then
        tmp_file="$cron_dir/${cron_file}.tmp"
        
        cp "$cron_dir/$cron_file" "$tmp_file"
        
        grep -v "ugi" "$tmp_file" | sed '/^\s*$/d' > "$cron_dir/$cron_file"
    fi
}
