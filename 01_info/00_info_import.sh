#!/bin/sh

# Модуль информации
. "$XINFO_DIR/01_info_variable.sh"
. "$XINFO_DIR/02_info_packages.sh"
. "$XINFO_DIR/03_info_cpu.sh"
. "$XINFO_DIR/04_info_xray.sh"
. "$XINFO_DIR/05_info_geodata.sh"
. "$XINFO_DIR/06_info_geoip.sh"
. "$XINFO_DIR/07_info_cron.sh"

# Подмодуль проверки версий
. "$XINFO_DIR/08_info_version/01_version_xkeen.sh"
. "$XINFO_DIR/08_info_version/02_version_xray.sh"

# Подмодуль сравнения версий
. "$XINFO_DIR/09_info_compare/01_compare_xkeen.sh"
. "$XINFO_DIR/09_info_compare/02_compare_xray.sh"
