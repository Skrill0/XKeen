#!/bin/sh

dowload_xray() {
    download_url=$(curl -s "$XRAY_API_URL" | jq -r --arg keyword "$generated_keyword" '.assets[] | select(.browser_download_url | contains($keyword)) | .browser_download_url')

    if [ -n "$download_url" ]; then
        filename=$(basename "$download_url")
        extension="${filename##*.}"
        
        mkdir -p "$TMP_DIR"
        
        curl -s -L -o "$TMP_DIR/$filename" "$download_url" &>/dev/null
        
        if [ -e "$TMP_DIR/$filename" ]; then
            mv "$TMP_DIR/$filename" "$TMP_DIR/xray.$extension"
        fi
    fi
}