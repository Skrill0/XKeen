# Функция для установки Xray
install_xray() {
    xray_archive="$tmp_dir/xray.zip"
    info_content=""
    error_content=""

    if [ -f "$xray_archive" ]; then
        info_content="[info] Архив xray найден\n"

        if [ -f "/opt/sbin/xray" ]; then
            backup_xray
        fi

        unzip -q "$xray_archive" -d "$tmp_dir/xray"
        if [ $? -eq 0 ]; then
            info_content="${info_content}[info] Распаковка архива xray выполнена\n"
            
            mv "$tmp_dir/xray/xray" /opt/sbin/
            if [ $? -eq 0 ]; then
                info_content="${info_content}[info] Xray успешно установлен в /opt/sbin/\n"
                chmod +x /opt/sbin/xray
                if [ $? -eq 0 ]; then
                    info_content="${info_content}[info] Установлены исполняемые права для Xray\n"
                else
                    error_content="${error_content}[error] Ошибка при установке исполняемых прав для Xray\n"
                fi
            else
                error_content="${error_content}[error] Ошибка при перемещении Xray\n"
            fi
        else
            error_content="${error_content}[error] Ошибка при распаковке архива xray\n"
        fi

        rm "$xray_archive"
        if [ $? -eq 0 ]; then
            info_content="${info_content}[info] Архив xray удален\n"
        else
            error_content="${error_content}[error] Ошибка при удалении архива xray\n"
        fi

        # Удаляем временные файлы
        rm -rf "$tmp_dir/xray"
        if [ $? -eq 0 ]; then
            info_content="${info_content}[info] Временные файлы удалены\n"
        else
            error_content="${error_content}[error] Ошибка при удалении временных файлов\n"
        fi

    else
        error_content="[error] Архив xray не найден\n"
    fi

    if [ -n "$info_content" ]; then
        echo -e "$info_content" >> "$xkeen_info_log"
    fi

    if [ -n "$error_content" ]; then
        echo -e "$error_content" >> "$xkeen_error_log"
    fi
}
