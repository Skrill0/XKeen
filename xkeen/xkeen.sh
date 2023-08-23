#!/bin/sh

# Определение директории, где находится xkeen.sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Импорт модулей
. "$SCRIPT_DIR/import.sh"

# Очищаем журнал перед работой
logs_clear

# Проверяем установку пакетов
info_packages
logs_packages_info_xkeen

# Собираем необходимую информацию о процессоре
info_cpu
logs_cpu_xkeen

# Проверяем статусы автоматических обновлений
info_cron
logs_cron_info_xkeen

# Проверяем установку Xray
info_xray
logs_xray_info_xkeen

# Проверяем установленные базы GeoIP
info_geoip
logs_geoip_info_xkeen

# Проверяем установленные базы GeoData
info_geodata
logs_geodata_info_xkeen

# Проверяем версию Xray
info_version_xray
logs_version_xray_info_xkeen

# Проверяем актуальность Xray
info_compare_xray
logs_compare_xray_info_xkeen

# Устанавливаем недостающие пакеты
install_packages
logs_packages_installed_xkeen

# Устанавливаем Xray, если не был установлен
if [ "$XRAY_INSTALLED" = "not_installed" ]; then
    dowload_xray
    install_xray
    XRAY_INSTALLED="installed"
fi

# Устанавливаем GeoIP
choose_geoip
install_geoip

# Устанавливаем GeoData
choose_geodata
install_geodata

# Обработка автоматчиеского обновления Cron
choose_update_cron
choose_cron_time

#delete_cron_task

install_cron