generate_xkeen_control() {
    # Определение текущей даты в формате Unix Epoch
    SOURCE_DATE_EPOCH=$(date +%s)
	
    # Определение размера установленного пакета (например, используя команду "du")
    INSTALLED_SIZE=$(du -s "$INSTALL_DIR" | cut -f1)

    # Создание файла xkeen.control
    cat << EOF > "$REGISTER_DIR/xkeen.control"
Package: xkeen
Version: $XKEEN_CURRENT_VERSION
Depends: libc, libssp, librt, libpthread, ca-bundle
Source: Skrill
SourceName: xkeen
Section: net
SourceDateEpoch: $SOURCE_DATE_EPOCH
Maintainer: Skrill
Architecture: $info_architecture
Installed-Size: $INSTALLED_SIZE
Description: The platform that makes Xray work.
EOF

}


generate_xray_list() {
    # Создание файла xkeen.list
    cat << EOF > "$REGISTER_DIR/xkeen.list"
/opt/sbin/xkeen
/opt/var/log/xkeen
EOF
}


generate_xray_control() {
    # Определение текущей даты в формате Unix Epoch
    SOURCE_DATE_EPOCH=$(date +%s)

    # Определение размера установленного пакета (например, используя команду "du")
    INSTALLED_SIZE=$(du -s "$INSTALL_DIR" | cut -f1)

    # Создание файла xray.control
    cat << EOF > "$REGISTER_DIR/xray.control"
Package: xray
Version: $XRAY_CURRENT_VERSION
Depends: libc, libssp, librt, libpthread, ca-bundle
Source: XTLS Team
SourceName: xray
Section: net
SourceDateEpoch: $SOURCE_DATE_EPOCH
Maintainer: Skrill
Architecture: $info_architecture
Installed-Size: $INSTALLED_SIZE
Description: A unified platform for anti-censorship.
EOF

}


generate_xray_list() {
    # Создание файла xray.list
    cat << EOF > "$REGISTER_DIR/xray.list"
/opt/sbin/xray
/opt/etc/xray
/opt/var/log/xray
/opt/etc/init.d/S24xray
EOF
}

