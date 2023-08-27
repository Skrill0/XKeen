#!/bin/sh

# Функция для проверки наличия задач автоматического обновления в cron
info_cron() {
    cron_output=$(crontab -l -u root 2>/dev/null)

    if echo "$cron_output" | grep -q "update_xray_cron_silent"; then
        INFO_UPDATE_XRAY_CRON="installed"
    else
        INFO_UPDATE_XRAY_CRON="not_installed"
    fi

    if echo "$cron_output" | grep -q "update_xkeen_cron_silent"; then
        INFO_UPDATE_XKEEN_CRON="installed"
    else
        INFO_UPDATE_XKEEN_CRON="not_installed"
    fi

    if echo "$cron_output" | grep -q "update_geoip_cron_silent"; then
        INFO_UPDATE_GEOIP_CRON="installed"
    else
        INFO_UPDATE_GEOIP_CRON="not_installed"
    fi
	
	if echo "$cron_output" | grep -q "update_geodata_cron_silent"; then
        INFO_UPDATE_GEODATA_CRON="installed"
    else
        INFO_UPDATE_GEODATA_CRON="not_installed"
    fi
}
