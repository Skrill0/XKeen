#!/bin/sh

# Модуль установки
. "$XINSTALL_DIR/01_install_packages.sh"
. "$XINSTALL_DIR/02_install_xray.sh"
. "$XINSTALL_DIR/03_install_xkeen.sh"
. "$XINSTALL_DIR/04_install_geodata.sh"
. "$XINSTALL_DIR/05_install_geoip.sh"
. "$XINSTALL_DIR/06_install_cron.sh"

. "$XINSTALL_DIR/07_install_register/00_register_import.sh"
. "$XINSTALL_DIR/08_install_configs/00_configs_import.sh"