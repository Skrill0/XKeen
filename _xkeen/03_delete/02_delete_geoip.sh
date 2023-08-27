delete_geoip() {  
    if [ "$chose_delete_geoip_v2fly_select" == "true" ]; then
        if [ -f "$GEO_DIR/geoip_v2fly.dat" ]; then
            rm "$GEO_DIR/geoip_v2fly.dat"
        fi
    fi
    
    if [ "$chose_delete_geoip_antifilter_select" == "true" ]; then
        if [ -f "$GEO_DIR/geoip_antifilter.dat" ]; then
            rm "$GEO_DIR/geoip_antifilter.dat"
        fi
    fi
}

delete_geoip_key() {
	if [ -f "$GEO_DIR/geoip_antifilter.dat" ]; then
		rm "$GEO_DIR/geoip_antifilter.dat"
	fi	

	if [ -f "$GEO_DIR/geoip_v2fly.dat" ]; then
		rm "$GEO_DIR/geoip_v2fly.dat"
	fi
}