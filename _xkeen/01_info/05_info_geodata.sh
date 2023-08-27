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

    if [ -e "$GEO_DIR/geodata_v2fly.dat" ]; then
        GEO_EXISTS_GEODATA_V2FLY="installed"
    else
        GEO_EXISTS_GEODATA_V2FLY="not_installed"
    fi
}
