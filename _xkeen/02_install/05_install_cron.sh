#!/bin/sh

install_cron() {
    if [ -n "$chose_all_cron_time" ]; then
        cron_entry="$chose_all_cron_time $XKEEN_DIR/xkeen.sh update_geoip_cron_silent"
        cron_entry="$cron_entry\n$chose_all_cron_time $XKEEN_DIR/xkeen.sh update_geodata_cron_silent"
        cron_entry="$cron_entry\n$chose_all_cron_time $XKEEN_DIR/xkeen.sh update_xkeen_cron_silent"
        cron_entry="$cron_entry\n$chose_all_cron_time $XKEEN_DIR/xkeen.sh update_xray_cron_silent"
    else
        if [ -n "$chose_geoip_cron_time" ]; then
            cron_entry="$chose_geoip_cron_time $XKEEN_DIR/xkeen.sh update_geoip_cron_silent"
        fi

        if [ -n "$chose_geodata_cron_time" ]; then
            cron_entry="$cron_entry\n$chose_geodata_cron_time $XKEEN_DIR/xkeen.sh update_geodata_cron_silent"
        fi

        if [ -n "$chose_xkeen_cron_time" ]; then
            cron_entry="$cron_entry\n$chose_xkeen_cron_time $XKEEN_DIR/xkeen.sh update_xkeen_cron_silent"
        fi

        if [ -n "$chose_xray_cron_time" ]; then
            cron_entry="$cron_entry\n$chose_xray_cron_time $XKEEN_DIR/xkeen.sh update_xray_cron_silent"
        fi
    fi

    if [ -n "$cron_entry" ]; then
        cron_file_path="$CRON_DIR/$CRON_FILE"
        touch "$cron_file_path"
        chmod +x "$cron_file_path"
        echo -e "$cron_entry" >> "$cron_file_path"
    fi
}