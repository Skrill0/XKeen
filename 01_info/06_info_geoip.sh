#!/bin/sh

# Функция для проверки наличия и записи информации о базах geo
info_geoip() {
    if [ -e "$GEO_DIR/geoip_antifilter.dat" ]; then
        GEO_EXISTS_GEOIP_ANTIFILTER="installed"
    else
        GEO_EXISTS_GEOIP_ANTIFILTER="not_installed"
    fi

    if [ -e "$GEO_DIR/geoip_v2ray.dat" ]; then
        GEO_EXISTS_GEOIP_V2RAY="installed"
    else
        GEO_EXISTS_GEOIP_V2RAY="not_installed"
    fi
}

# Экспортирование переменных для использования в других скриптах
export GEO_EXISTS_GEOIP_ANTIFILTER
export GEO_EXISTS_GEOIP_V2RAY