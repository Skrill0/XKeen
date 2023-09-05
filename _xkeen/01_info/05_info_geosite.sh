# Функция для проверки наличия и записи информации о базах geo
info_geosite() {
    # Проверяем наличие файла geosite_antizapret.dat
    if [ -e "$geo_dir/geosite_antizapret.dat" ]; then
        geo_exists_geosite_antizapret="installed"
    else
        geo_exists_geosite_antizapret="not_installed"
    fi

    # Проверяем наличие файла geosite_antifilter.dat
    if [ -e "$geo_dir/geosite_antifilter.dat" ]; then
        geo_exists_geosite_antifilter="installed"
    else
        geo_exists_geosite_antifilter="not_installed"
    fi

    # Проверяем наличие файла geosite_v2fly.dat
    if [ -e "$geo_dir/geosite_v2fly.dat" ]; then
        geo_exists_geosite_v2fly="installed"
    else
        geo_exists_geosite_v2fly="not_installed"
    fi
}
