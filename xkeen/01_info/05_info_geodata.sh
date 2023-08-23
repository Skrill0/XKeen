#!/bin/sh

# Функция для проверки наличия и записи информации о базах geo
info_geodata() {
    if [ -e "$GEO_DIR/geodata_antizapret.dat" ]; then
        GEO_EXISTS_GEODATA_ANTIZAPRET="installed"
    else
        GEO_EXISTS_GEODATA_ANTIZAPRET="not_installed"
    fi

    if [ -e "$GEO_DIR/geodata_antifilter.dat" ]; then
        GEO_EXISTS_GEODATA_ANTIFILTER="installed"
    else
        GEO_EXISTS_GEODATA_ANTIFILTER="not_installed"
    fi

    if [ -e "$GEO_DIR/geodata_v2ray.dat" ]; then
        GEO_EXISTS_GEODATA_V2RAY="installed"
    else
        GEO_EXISTS_GEODATA_V2RAY="not_installed"
    fi
}

# Экспортирование переменных для использования в других скриптах
export GEO_EXISTS_GEODATA_ANTIZAPRET
export GEO_EXISTS_GEODATA_ANTIFILTER
export GEO_EXISTS_GEODATA_V2RAY