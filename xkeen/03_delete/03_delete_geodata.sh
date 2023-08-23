delete_geodata_antifilter() {
    GEO_DIR="$1"
    
    # Проверяем, существует ли файл geodata_antifilter.dat
    if [ -f "$GEO_DIR/geodata_antifilter.dat" ]; then
        # Удаляем файл geodata_antifilter.dat
        rm "$GEO_DIR/geodata_antifilter.dat"
    fi
}

delete_geodata_antizapret() {
    GEO_DIR="$1"
    
    # Проверяем, существует ли файл geodata_antizapret.dat
    if [ -f "$GEO_DIR/geodata_antizapret.dat" ]; then
        # Удаляем файл geodata_antizapret.dat
        rm "$GEO_DIR/geodata_antizapret.dat"
    fi
}

delete_geodata_v2ray() {
    GEO_DIR="$1"
    
    # Проверяем, существует ли файл geodata_v2ray.dat
    if [ -f "$GEO_DIR/geodata_v2ray.dat" ]; then
        # Удаляем файл geodata_v2ray.dat
        rm "$GEO_DIR/geodata_v2ray.dat"
    fi
}
