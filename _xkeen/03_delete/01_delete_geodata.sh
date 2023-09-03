# Функция для удаления файлов GeoData
delete_geodata() {  
    if [ "$chose_delete_geodata_antifilter_select" == "true" ]; then
        if [ -f "$geo_dir/geodata_antifilter.dat" ]; then
            rm "$geo_dir/geodata_antifilter.dat"
        fi
    fi

    if [ "$chose_delete_geodata_antizapret_select" == "true" ]; then
        if [ -f "$geo_dir/geodata_antizapret.dat" ]; then
            rm "$geo_dir/geodata_antizapret.dat"
        fi
    fi

    if [ "$chose_delete_geodata_v2fly_select" == "true" ]; then
        if [ -f "$geo_dir/geodata_v2fly.dat" ]; then
            rm "$geo_dir/geodata_v2fly.dat"
        fi
    fi
}

# Функция для удаления всех файлов GeoData
delete_geodata_key() {  
    if [ -f "$geo_dir/geodata_antifilter.dat" ]; then
        rm "$geo_dir/geodata_antifilter.dat"
    fi

    if [ -f "$geo_dir/geodata_antizapret.dat" ]; then
        rm "$geo_dir/geodata_antizapret.dat"
    fi

    if [ -f "$geo_dir/geodata_v2fly.dat" ]; then
        rm "$geo_dir/geodata_v2fly.dat"
    fi
}
