# Функция для установки Xray
install_xray() {
    xray_archive="$tmp_dir/xray.ipk"
    
    local info_content=""
    local error_content=""

    if [ -f "$xray_archive" ]; then
        info_content="\n\t[info] Архив xray найден\n"
    else
        error_content="\n\t[error] Архив xray не найден\n"
    fi

    mkdir -p "$tmp_dir/xray"
    tar -xzf "$xray_archive" -C "$tmp_dir/xray"
    if [ $? -eq 0 ]; then
        info_content="${info_content}\t[info] Распаковка архива xray выполнена\n"
    else
        error_content="${error_content}\t[error] Ошибка при распаковке архива xray\n"
    fi

    tar -xzf "$tmp_dir/xray/data.tar.gz" -C "$tmp_dir/xray"
    if [ $? -eq 0 ]; then
        info_content="${info_content}\t[info] Распаковка data.tar.gz выполнена\n"
    else
        error_content="${error_content}\t[error] Ошибка при распаковке data.tar.gz\n"
    fi

    mv "$tmp_dir/xray/usr/bin/xray" "$install_dir/"
    if [ $? -eq 0 ]; then
        info_content="${info_content}\t[info] xray успешно установлен\n"
    else
        error_content="${error_content}\t[error] Ошибка при перемещении xray\n"
    fi

    rm -rf "$tmp_dir/xray"
    if [ $? -eq 0 ]; then
        info_content="${info_content}\t[info] Временные файлы удалены"
    else
        error_content="${error_content}\t[error] Ошибка при удалении временных файлов"
    fi

    rm "$xray_archive"
    if [ $? -eq 0 ]; then
        info_content="${info_content}\t[info] Архив xray удален"
    else
        error_content="${error_content}\t[error] Ошибка при удалении архива xray"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Установка xray" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo -n "[end] Установка xray выполнена" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Установка xray" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo -n "[end] Установка xray выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}
