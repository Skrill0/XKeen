dowload_xkeen() {
    download_url=$(curl -s "$XKEEN_API_URL" | grep -o '"browser_download_url": "[^"]*' | grep -o 'https://[^"]*')
    
    if [ -n "$download_url" ]; then
        filename=$(basename "$download_url")
        extension="${filename##*.}"
        
        mkdir -p "$TMP_DIR"
        
        curl -s -L -o "/tmp/$filename" "$download_url"
        
        if [ -e "/tmp/$filename" ]; then
            mv "/tmp/$filename" "$TMP_DIR/xkeen.$extension"
        fi
    fi
}
