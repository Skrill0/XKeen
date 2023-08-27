install_cron() {
    cron_entry=""

    if [ -n "$chose_all_cron_time" ]; then
        cron_entry="$cron_entry\n$chose_all_cron_time $XKEEN_DIR/xkeen -ugic"
        cron_entry="$cron_entry\n$chose_all_cron_time $XKEEN_DIR/xkeen -ugdc"
        cron_entry="$cron_entry\n$chose_all_cron_time $XKEEN_DIR/xkeen -ukc"
        cron_entry="$cron_entry\n$chose_all_cron_time $XKEEN_DIR/xkeen -uxc"
    fi

    if [ -n "$chose_geoip_cron_time" ]; then
        cron_entry="$cron_entry\n$chose_geoip_cron_time $XKEEN_DIR/xkeen -ugic"
    fi

    if [ -n "$chose_geodata_cron_time" ]; then
        cron_entry="$cron_entry\n$chose_geodata_cron_time $XKEEN_DIR/xkeen -ugdc"
    fi

    if [ -n "$chose_xkeen_cron_time" ]; then
        cron_entry="$cron_entry\n$chose_xkeen_cron_time $XKEEN_DIR/xkeen -ukc"
    fi

    if [ -n "$chose_xray_cron_time" ]; then
        cron_entry="$cron_entry\n$chose_xray_cron_time $XKEEN_DIR/xkeen -uxc"
    fi

    if [ -n "$cron_entry" ]; then
        cron_file_path="$CRON_DIR/$CRON_FILE"

        if [ -n "$chose_all_cron_select" ] || [ -n "$chose_delete_all_cron_select" ]; then
            sed -i "/$XKEEN_DIR\/xkeen.*-ugic/d" "$cron_file_path" 2>/dev/null
            sed -i "/$XKEEN_DIR\/xkeen.*-ugdc/d" "$cron_file_path" 2>/dev/null
            sed -i "/$XKEEN_DIR\/xkeen.*-ukc/d" "$cron_file_path" 2>/dev/null
            sed -i "/$XKEEN_DIR\/xkeen.*-uxc/d" "$cron_file_path" 2>/dev/null
        fi

        touch "$cron_file_path"
        chmod +x "$cron_file_path"
        echo -e "$cron_entry" >> "$cron_file_path"
    fi
}
