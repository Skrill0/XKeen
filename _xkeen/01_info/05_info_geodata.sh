# Функция для проверки наличия и записи информации о базах geo
info_geodata() {
    # Проверяем наличие файла geodata_antizapret.dat
    if [ -e "$geo_dir/geodata_antizapret.dat" ]; then
        geo_exists_geodata_antizapret="installed"
    else
        geo_exists_geodata_antizapret="not_installed"
    fi

    # Проверяем наличие файла geodata_antifilter.dat
    if [ -e "$geo_dir/geodata_antifilter.dat" ]; then
        geo_exists_geodata_antifilter="installed"
    else
        geo_exists_geodata_antifilter="not_installed"
    fi

    # Проверяем наличие файла geodata_v2fly.dat
    if [ -e "$geo_dir/geodata_v2fly.dat" ]; then
        geo_exists_geodata_v2fly="installed"
    else
        geo_exists_geodata_v2fly="not_installed"
    fi
}
