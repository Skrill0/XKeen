delete_xkeen_folder() {
    TMP_DIR_GLOBAL="$1"
    
    # Удаляем папку xkeen и ее содержимое рекурсивно
    rm -r "$TMP_DIR_GLOBAL/xkeen"
}
