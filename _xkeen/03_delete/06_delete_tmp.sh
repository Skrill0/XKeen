delete_tmp() {
    
    # Проверяем, существует ли папка xkeen
    if [ -d "$TMP_DIR_GLOBAL/xkeen" ]; then
        # Удаляем папку xkeen и её содержимое рекурсивно
        rm -r "$TMP_DIR_GLOBAL/xkeen"
    fi
}
