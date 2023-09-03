# Функция для получения информации о версии Xray
info_version_xray() {
    xray_current_version=""

    # Проверяем, установлен ли Xray
    if [ "$xray_installed" = "installed" ]; then
        # Если Xray установлен, получаем текущую версию
        xray_current_version=$("$install_dir/xray" -version 2>&1 | grep -o -E 'Xray [0-9]+\.[0-9]+\.[0-9]+' | cut -d ' ' -f 2)
    fi

    # Получаем версию Xray из удаленного источника (предположительно API)
    xray_github_version=$(call_api "$xray_api_url" | jq -r '.tag_name' 2>/dev/null | sed 's/^v//')
}
