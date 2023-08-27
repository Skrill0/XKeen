delete_cron_task() {
    if [ -f "$CRON_DIR/$CRON_FILE" ]; then
        tmp_file="$CRON_DIR/${CRON_FILE}.tmp"
        
        cp "$CRON_DIR/$CRON_FILE" "$tmp_file"
        
        if [ "$chose_all_cron_select" = true ] || [ "$chose_delete_all_cron_select" = true ]; then
            grep -v "ugic" "$tmp_file" | grep -v "ugdc" | grep -v "uxc" | grep -v "ukc" | sed '/^\s*$/d' > "$CRON_DIR/$CRON_FILE"
        else
            if [ "$chose_xkeen_cron_select" = true ]; then
                delete_cron_xkeen
            fi
            
            if [ "$chose_xray_cron_select" = true ]; then
                delete_cron_xray
            fi
            
            if [ "$chose_geodata_cron_select" = true ]; then
                delete_cron_geodata
            fi
            
            if [ "$chose_geoip_cron_select" = true ]; then
                delete_cron_geoip
            fi
        fi
        
        rm "$tmp_file"
    fi
}

delete_cron_xkeen() {
	    if [ -f "$CRON_DIR/$CRON_FILE" ]; then
        tmp_file="$CRON_DIR/${CRON_FILE}.tmp"
        
        cp "$CRON_DIR/$CRON_FILE" "$tmp_file"
		
			grep -v "ukc" "$tmp_file" | sed '/^\s*$/d' > "$CRON_DIR/$CRON_FILE"
			
		fi
        
        rm "$tmp_file"
}

delete_cron_xray() {
	    if [ -f "$CRON_DIR/$CRON_FILE" ]; then
        tmp_file="$CRON_DIR/${CRON_FILE}.tmp"
        
        cp "$CRON_DIR/$CRON_FILE" "$tmp_file"
		
			grep -v "uxc" "$tmp_file" | sed '/^\s*$/d' > "$CRON_DIR/$CRON_FILE"
			
		fi
        
        rm "$tmp_file"
}

delete_cron_geodata() {
		if [ -f "$CRON_DIR/$CRON_FILE" ]; then
        tmp_file="$CRON_DIR/${CRON_FILE}.tmp"
        
        cp "$CRON_DIR/$CRON_FILE" "$tmp_file"
		
			grep -v "ugdc" "$tmp_file" | sed '/^\s*$/d' > "$CRON_DIR/$CRON_FILE"
			
		fi
        
        rm "$tmp_file"
}

delete_cron_geoip() {
		if [ -f "$CRON_DIR/$CRON_FILE" ]; then
        tmp_file="$CRON_DIR/${CRON_FILE}.tmp"
        
        cp "$CRON_DIR/$CRON_FILE" "$tmp_file"
		
			grep -v "ugic" "$tmp_file" | sed '/^\s*$/d' > "$CRON_DIR/$CRON_FILE"
			
		fi
        
        rm "$tmp_file"
}