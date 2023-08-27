install_geodata() {
    [ "$install_v2fly_geodata" = true ] && curl -L -o "$GEO_DIR/geodata_v2fly.dat" "https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat" > /dev/null 2>&1
    [ "$install_antifilter_geodata" = true ] && curl -L -o "$GEO_DIR/geodata_antifilter.dat" "https://github.com/schebotar/antifilter/releases/latest/download/antifilter.dat" > /dev/null 2>&1
    [ "$install_antizapret_geodata" = true ] && curl -L -o "$GEO_DIR/geodata_antizapret.dat" "https://github.com/warexify/antizapret-xray/releases/latest/download/antizapret.dat" > /dev/null 2>&1

    [ "$update_v2fly_geodata" = true ] && [ -f "$GEO_DIR/geodata_v2fly.dat" ] && curl -L -o "$GEO_DIR/geodata_v2fly.dat" "https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat" > /dev/null 2>&1
    [ "$update_antifilter_geodata" = true ] && [ -f "$GEO_DIR/geodata_antifilter.dat" ] && curl -L -o "$GEO_DIR/geodata_antifilter.dat" "https://github.com/schebotar/antifilter/releases/latest/download/antifilter.dat" > /dev/null 2>&1
    [ "$update_antizapret_geodata" = true ] && [ -f "$GEO_DIR/geodata_antizapret.dat" ] && curl -L -o "$GEO_DIR/geodata_antizapret.dat" "https://github.com/warexify/antizapret-xray/releases/latest/download/antizapret.dat" > /dev/null 2>&1
}
