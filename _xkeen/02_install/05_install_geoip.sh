install_geoip() {
    [ "$install_antifilter_geoip" = true ] && curl -L -o "$GEO_DIR/geoip_antifilter.dat" "https://github.com/schebotar/antifilter-domain/releases/latest/download/antifilter-domain.dat" > /dev/null 2>&1
    [ "$install_v2fly_geoip" = true ] && curl -L -o "$GEO_DIR/geoip_v2fly.dat" "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat" > /dev/null 2>&1

    [ "$update_antifilter_geoip" = true ] && [ -f "$GEO_DIR/geoip_antifilter.dat" ] && curl -L -o "$GEO_DIR/geoip_antifilter.dat" "https://github.com/schebotar/antifilter-domain/releases/latest/download/antifilter-domain.dat" > /dev/null 2>&1
    [ "$update_v2fly_geoip" = true ] && [ -f "$GEO_DIR/geoip_v2fly.dat" ] && curl -L -o "$GEO_DIR/geoip_v2fly.dat" "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat" > /dev/null 2>&1
}
