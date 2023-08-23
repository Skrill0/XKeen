delete_cron_task() {
    # Проверяем, существует ли файл cron
    if [ -f "$CRON_DIR/$CRON_FILE" ]; then
        # Создаем временный файл для записи изменений
        tmp_file="$CRON_DIR/${CRON_FILE}.tmp"
        
        # Очищаем временный файл (если существует) перед началом записи
        : > "$tmp_file"
        
        # Читаем файл cron по строкам
        while IFS= read -r line; do
            # Проверяем, содержит ли строка указанные значения задач
            if ! echo "$line" | grep -q "update_xkeen_cron_silent" && \
               ! echo "$line" | grep -q "update_geoip_cron_silent" && \
               ! echo "$line" | grep -q "update_geodata_cron_silent" && \
               ! echo "$line" | grep -q "update_xray_cron_silent"; then
                # Если не содержит, записываем строку во временный файл
                echo "$line" >> "$tmp_file"
            fi
        done < "$CRON_DIR/$CRON_FILE"
        
        # Переименовываем временный файл в оригинальное имя
        mv "$tmp_file" "$CRON_DIR/$CRON_FILE"
        
    fi
}
