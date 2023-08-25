delete_geoip_antifilter() {
    GEO_DIR="$1"
    
    # Проверяем, существует ли файл geoip_antifilter.dat
    if [ -f "$GEO_DIR/geoip_antifilter.dat" ]; then
        # Удаляем файл geoip_antifilter.dat
        rm "$GEO_DIR/geoip_antifilter.dat"
    fi
}

delete_geoip_v2ray() {
    GEO_DIR="$1"
    
    # Проверяем, существует ли файл geoip_v2ray.dat
    if [ -f "$GEO_DIR/geoip_v2ray.dat" ]; then
        # Удаляем файл geoip_v2ray.dat
        rm "$GEO_DIR/geoip_v2ray.dat"
    fi
}
