# Функция для установки Xkeen
install_xkeen() {
    # Путь к архиву с утилитой
    xkeen_archive="$tmp_dir/xkeen.tar"
    
    local info_content=""
    local error_content=""

    if [ -f "$xkeen_archive" ]; then
        info_content="\t[info] Архив xkeen найден\n"
    else
        error_content="\t[error] Архив xkeen не найден\n"
    fi

    # Временный скрипт для установки
    install_script=$(mktemp)
    cat <<EOF > "$install_script"
#!/bin/sh

# Распаковка архива
tar xf "$xkeen_archive" -C "$install_dir" xkeen _xkeen

# Проверка наличия _xkeen в install_dir
if [ -d "$install_dir/_xkeen" ]; then
    # Удаление текущей .xkeen и переименование _xkeen
    rm -rf "$install_dir/.xkeen"
    mv "$install_dir/_xkeen" "$install_dir/.xkeen"
    echo "  Установка xkeen завершена."
else
    echo "  Ошибка: _xkeen не была правильно перенесена."
fi

# Удаление архива
rm "$xkeen_archive"
EOF

    chmod +x "$install_script"
    "$install_script"
    if [ $? -eq 0 ]; then
        info_content="${info_content}\t[info] Установка xkeen успешно завершена"
    else
        error_content="${error_content}\t[error] Ошибка при установке xkeen"
    fi
    rm "$install_script"

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Установка xkeen" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Установка xkeen выполнена" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Установка xkeen" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Установка xkeen выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}
