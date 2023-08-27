delete_geodata() {  

    if [ "$chose_delete_geodata_antifilter_select" == "true" ]; then
        if [ -f "$GEO_DIR/geodata_antifilter.dat" ]; then
            rm "$GEO_DIR/geodata_antifilter.dat"
        fi
    fi

    if [ "$chose_delete_geodata_antizapret_select" == "true" ]; then
        if [ -f "$GEO_DIR/geodata_antizapret.dat" ]; then
            rm "$GEO_DIR/geodata_antizapret.dat"
        fi
    fi

    if [ "$chose_delete_geodata_v2fly_select" == "true" ]; then
        if [ -f "$GEO_DIR/geodata_v2fly.dat" ]; then
            rm "$GEO_DIR/geodata_v2fly.dat"
        fi
    fi
}


delete_geodata_key() {  

        if [ -f "$GEO_DIR/geodata_antifilter.dat" ]; then
            rm "$GEO_DIR/geodata_antifilter.dat"
        fi

        if [ -f "$GEO_DIR/geodata_antizapret.dat" ]; then
            rm "$GEO_DIR/geodata_antizapret.dat"
        fi

        if [ -f "$GEO_DIR/geodata_v2fly.dat" ]; then
            rm "$GEO_DIR/geodata_v2fly.dat"
        fi
}
