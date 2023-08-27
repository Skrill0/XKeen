install_xkeen() {
    # Путь к архиву с утилитой
    XKEEN_ARCHIVE="$TMP_DIR/xkeen.tar"

    # Временный скрипт для установки
    install_script=$(mktemp)
    cat <<EOF > "$install_script"
#!/bin/sh

# Распаковка архива
tar xf "$XKEEN_ARCHIVE" -C "$INSTALL_DIR" xkeen

# Проверка наличия _xkeen перед удалением .xkeen
if [ -d "$INSTALL_DIR/_xkeen" ]; then
    rm -rf "$INSTALL_DIR/.xkeen"
    mv "$INSTALL_DIR/_xkeen" "$INSTALL_DIR/.xkeen"
fi

# Удаление архива
rm "$XKEEN_ARCHIVE"

echo "Установка XKEEN завершена."
EOF

    chmod +x "$install_script"
    "$install_script"
    #rm "$install_script"
}