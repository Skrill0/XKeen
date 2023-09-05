# Журнал работы xkeen

logs_packages_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ "$info_packages_lscpu" = "installed" ]; then
        info_content="${info_content}    [info] lscpu установлен\n"
    else
        error_content="${error_content}    [error] lscpu не установлен\n"
    fi

    if [ "$info_packages_curl" = "installed" ]; then
        info_content="${info_content}    [info] curl установлен\n"
    else
        error_content="${error_content}    [error] curl не установлен\n"
    fi

    if [ "$info_packages_jq" = "installed" ]; then
        info_content="${info_content}    [info] jq установлен\n"
    else
        error_content="${error_content}    [error] jq не установлен\n"
    fi

    if [ "$info_packages_libc" = "installed" ]; then
        info_content="${info_content}    [info] libc установлен\n"
    else
        error_content="${error_content}    [error] libc не установлен\n"
    fi

    if [ "$info_packages_libssp" = "installed" ]; then
        info_content="${info_content}    [info] libssp установлен\n"
    else
        error_content="${error_content}    [error] libssp не установлен\n"
    fi

    if [ "$info_packages_librt" = "installed" ]; then
        info_content="${info_content}    [info] librt установлен\n"
    else
        error_content="${error_content}    [error] librt не установлен\n"
    fi

    if [ "$info_packages_libpthread" = "installed" ]; then
        info_content="${info_content}    [info] libpthread установлен\n"
    else
        error_content="${error_content}    [error] libpthread не установлен\n"
    fi

    if [ "$info_packages_cabundle" = "installed" ]; then
        info_content="${info_content}    [info] ca-bundle установлен\n"
    else
        error_content="${error_content}    [error] ca-bundle не установлен\n"
    fi

    if [ -n "$info_content" ]; then
        echo "[start] Проверка наличия необходимых пакетов" >> "$xkeen_info_log"
        echo -e "$info_content" | sed '/^$/d' >> "$xkeen_info_log"
        echo "[end] Проверка наличия необходимых пакетов выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка наличия необходимых пакетов" >> "$xkeen_error_log"
        echo -e "$error_content" | sed '/^$/d' >> "$xkeen_error_log"
        echo "[end] Проверка наличия необходимых пакетов выполнена" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi
}

logs_cpu_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ -n "$info_model" ]; then
        info_content="    [info] Модель: $info_model\n"
    else
        error_content="    [error] Модель: Не удалось определить\n"
    fi

    if [ -n "$info_architecture" ]; then
        info_content="$info_content\t[info] Архитектура: $info_architecture\n"
    else
        error_content="$error_content\t[error] Архитектура: Не удалось определить\n"
    fi

    if [ -n "$generated_keyword" ]; then
        info_content="$info_content\t[info] Процессор поддерживается xkeen\n"
    else
        error_content="$error_content\t[error] Процессор не поддерживается xkeen\n"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка процессора" >> "$xkeen_error_log"
        echo -e "$error_content" | sed '/^$/d' >> "$xkeen_error_log"
        echo "[end] Проверка процессора выполнена" >> "$xkeen_error_log"
		echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка процессора" >> "$xkeen_info_log"
        echo "    [info] Процессор" >> "$xkeen_info_log"
        echo -e "$info_content" | sed '/^$/d' >> "$xkeen_info_log"
        echo "[end] Проверка процессора выполнена" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi
}


logs_xray_info_xkeen() {
    if [ "$xray_installed" = "installed" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка установки xray" >> "$xkeen_info_log"
        echo "    [info] xray установлен" >> "$xkeen_info_log"
        echo "[end] Проверка установки xray выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
    
    if [ "$xray_installed" = "not_installed" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка установки xray" >> "$xkeen_error_log"
        echo "    [error] xray не установлен" >> "$xkeen_error_log"
        echo "[end] Проверка установки xray выполнена" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi
}


logs_geosite_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ "$geo_exists_geosite_antizapret" = "installed" ]; then
        info_content="\t[info] База GeoSite AntiZapret установлена\n"
    else
        error_content="\n\t[error] База GeoSite AntiZapret не установлена\n"
    fi

    if [ "$geo_exists_geosite_antifilter" = "installed" ]; then
        info_content="${info_content}	[info] База GeoSite AntiFilter установлена\n"
    else
        error_content="${error_content}	[error] База GeoSite AntiFilter не установлена\n"
    fi

    if [ "$geo_exists_geosite_v2fly" = "installed" ]; then
        info_content="${info_content}	[info] База GeoSite v2fly установлена\n"
    else
        error_content="${error_content}	[error] База GeoSite v2fly не установлена\n"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка наличия баз данных GeoSite" >> "$xkeen_info_log"
        echo -e "$info_content" | sed '/^$/d' >> "$xkeen_info_log"
        echo "[end] Проверка наличия баз данных GeoSite выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка наличия баз данных GeoSite" >> "$xkeen_error_log"
        echo -e "$error_content" | sed '/^$/d' >> "$xkeen_error_log"
        echo "[end] Проверка наличия баз данных GeoSite выполнена" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi
}


logs_geoip_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ "$geo_exists_geoip_antifilter" = "installed" ]; then
        info_content="\t[info] База GeoIP AntiFilter установлена\n"
    else
        error_content="\n\t[error] База GeoIP AntiFilter не установлена\n"
    fi

    if [ "$geo_exists_geoip_v2fly" = "installed" ]; then
        info_content="${info_content}\t[info] База GeoIP v2fly установлена\n"
    else
        error_content="${error_content}\n\t[error] База GeoIP v2fly не установлена\n"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка наличия баз данных GeoIP" >> "$xkeen_error_log"
        echo -e "$error_content" | sed '/^$/d' >> "$xkeen_error_log"
        echo "[end] Проверка наличия баз данных GeoIP выполнена" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка наличия баз данных GeoIP" >> "$xkeen_info_log"
        echo -e "$info_content" | sed '/^$/d' >> "$xkeen_info_log"
        echo "[end] Проверка наличия баз данных GeoIP выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}


logs_cron_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ "$info_update_xray_cron" = "installed" ]; then
        info_content="\t[info] Задача автоматического обновления Xray включена\n"
    else
        error_content="\t[error] Задача автоматического обновления Xray не включена\n"
    fi

    if [ "$info_update_xkeen_cron" = "installed" ]; then
        info_content="${info_content}\t[info] Задача автоматического обновления Xkeen включена\n"
    else
        error_content="${error_content}\t[error] Задача автоматического обновления Xkeen не включена\n"
    fi

    if [ "$info_update_geoip_cron" = "installed" ]; then
        info_content="${info_content}\t[info] Задача автоматического обновления GeoIP включена\n"
    else
        error_content="${error_content}\t[error] Задача автоматического обновления GeoIP не включена\n"
    fi

    if [ "$info_update_geosite_cron" = "installed" ]; then
        info_content="${info_content}\t[info] Задача автоматического обновления GeoData включена"
    else
        error_content="${error_content}\t[error] Задача автоматического обновления GeoData не включена"
    fi

    if [ -n "$error_content" ]; then
		echo "" >> "$xkeen_error_log"
        echo "[start] Проверка наличия задач автоматического обновления в cron" >> "$xkeen_error_log"
        echo -e "$error_content" | sed '/^$/d' >> "$xkeen_error_log"
        echo "[end] Проверка наличия задач автоматического обновления в cron выполнена" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
		echo "" >> "$xkeen_info_log"
        echo "[start] Проверка наличия задач автоматического обновления в cron" >> "$xkeen_info_log"
        echo -e "$info_content" | sed '/^$/d' >> "$xkeen_info_log"
        echo "[end] Проверка наличия задач автоматического обновления в cron выполнена" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi
}

logs_version_xkeen_info_xkeen() {
    local info_content=""
    local error_content=""
    local result_content=""

    info_content="\t[info] Установленная версия xkeen: $xkeen_current_version\n\t[info] GitHub версия xkeen: $xkeen_github_version"

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
		echo "[start] Проверка версии xkeen" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Проверка версии xkeen выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка версии xkeen" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Проверка версии xkeen выполнена" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi
}

logs_compare_xkeen_info_xkeen() {
    local info_content=""
    local error_content=""
    local result_content=""

    if [ "$info_compare_xkeen" = "actual" ]; then
        info_content="[info] Текущая версия $xkeen_current_version xkeen актуальна"
    elif [ "$info_compare_xkeen" = "update" ]; then
        info_content="[info] Текущая версия xkeen $xkeen_current_version."
        info_content="${info_content}\n[info] Доступно обновление на версию $xkeen_github_version"
    else
        info_content="[info] Текущая версия xkeen $xkeen_current_version новее доступной на GitHub $xkeen_github_version"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
		echo "[start] Сравнение версий xkeen" >> "$xkeen_info_log"
        echo -e "$info_content" | sed -e 's/^/\t/' >> "$xkeen_info_log"
        echo "[end] Сравнение версий xkeen выполнено" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Сравнение версий xkeen" >> "$xkeen_error_log"
        echo -e "$error_content" | sed -e 's/^/\t/' >> "$xkeen_error_log"
        echo "[end] Сравнение версий xkeen выполнено" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi
}

logs_version_xray_info_xkeen() {
    local info_content=""
    local error_content=""

    info_content="\t[info] Установленная версия xray: $xray_current_version\n\t[info] GitHub версия xray: $xray_github_version"

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
		echo "[start] Проверка версии xray" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Проверка версии xray выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка версии xray" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Проверка версии xray выполнена" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi
}

logs_compare_xray_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ "$info_compare_xray" = "actual" ]; then
        info_content="\t[info] Текущая версия $xray_current_version xray актуальна"
    elif [ "$info_compare_xray" = "update" ]; then
        info_content="\t[info] Текущая версия xray $xray_current_version."
        info_content="\t[info] Доступно обновление на версию $xray_github_version"
    else
        info_content="\t[info] Текущая версия xray $xray_current_version новее доступной на github $xray_github_version"
    fi

    if [ -n "$info_content" ]; then
	    echo "" >> "$xkeen_info_log"
        echo -e "[start] Сравнение версий xray\n$info_content" >> "$xkeen_info_log"
        echo "[end] Сравнение версий xray выполнено" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi

    if [ -n "$error_content" ]; then
		echo "" >> "$xkeen_error_log"
        echo -e "[start] Сравнение версий xray\n$error_content" >> "$xkeen_error_log"
        echo "[end] Сравнение версий xray выполнено" >> "$xkeen_error_log"
		echo "" >> "$xkeen_error_log"
    fi
}

logs_install_packages_xkeen() {
    local info_content=""
    local error_content=""
    
    if [ "$info_packages_lscpu" = "installed" ]; then
        info_content="${info_content}\t[info] lscpu установлен"
    fi
    
    if [ "$info_packages_curl" = "installed" ]; then
        if [ -n "$info_content" ]; then
            info_content="${info_content}\n"
        fi
        info_content="${info_content}\t[info] curl установлен"
    fi
    
    if [ "$info_packages_jq" = "installed" ]; then
        if [ -n "$info_content" ]; then
            info_content="${info_content}\n"
        fi
        info_content="${info_content}\t[info] jq установлен"
    fi
    
    if [ "$info_packages_libc" = "installed" ]; then
        if [ -n "$info_content" ]; then
            info_content="${info_content}\n"
        fi
        info_content="${info_content}\t[info] libc установлен"
    fi
    
    if [ "$info_packages_libssp" = "installed" ]; then
        if [ -n "$info_content" ]; then
            info_content="${info_content}\n"
        fi
        info_content="${info_content}\t[info] libssp установлен"
    fi
    
    if [ "$info_packages_librt" = "installed" ]; then
        if [ -n "$info_content" ]; then
            info_content="${info_content}\n"
        fi
        info_content="${info_content}\t[info] librt установлен"
    fi
    
    if [ "$info_packages_libpthread" = "installed" ]; then
        if [ -n "$info_content" ]; then
            info_content="${info_content}\n"
        fi
        info_content="${info_content}\t[info] libpthread установлен"
    fi
    
    if [ "$info_packages_cabundle" = "installed" ]; then
        if [ -n "$info_content" ]; then
            info_content="${info_content}\n"
        fi
        info_content="${info_content}\t[info] ca-bundle установлен"
    fi
    
    if [ -n "$info_content" ]; then
	    echo "" >> "$xkeen_info_log"
        echo "[start] Проверка наличия необходимых пакетов" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Проверка наличия необходимых пакетов выполнена" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi
    
    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка наличия необходимых пакетов" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Проверка наличия необходимых пакетов выполнена" >> "$xkeen_error_log"
		echo "" >> "$xkeen_error_log"
    fi
}

logs_download_xray_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ -n "$download_url" ]; then
        info_content="    [info] URL для скачивания Xray найден"
    else
        error_content="    [error] URL для скачивания Xray не найден"
    fi

    if [ -e "$tmp_dir/xray.ipk" ]; then
        if [ -s "$tmp_dir/xray.ipk" ]; then
            result_content="    [info] xray успешно загружен"
        else
            error_content="    [error] Загрузка Xray не удалась. Некорректная ссылка"
        fi
    else
        error_content="    [error] Загрузка Xray не удалась. Архив не найден"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Загрузка xray" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Загрузка Xray выполнена" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ] || [ -n "$result_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Загрузка Xray" >> "$xkeen_info_log"
		echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Загрузка Xray выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}


logs_download_xkeen_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ -n "$download_url" ]; then
        info_content="\t[info] URL для скачивания Xkeen найден"
    else
        error_content="\t[error] URL для скачивания Xkeen не найден"
    fi

    local filename
    filename=$(basename "$download_url")
	
    if [ -e "$tmp_dir/$filename" ]; then
        if [ -s "$tmp_dir/$filename" ]; then
            local version_info
            version_info=$(echo "$filename" | grep -o 'xkeen_v[0-9.]\+')

            if [ -n "$version_info" ]; then
                result_content="\t[result] Xkeen версии $version_info успешно загружен"
            else
                result_content="\t[result] Xkeen успешно загружен"
            fi
        else
            error_content="\t[error] Загрузка Xkeen не удалась. Некорректная ссылка"
        fi
    else
        error_content="\t[error] Загрузка Xkeen не удалась. Архив не найден"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Загрузка Xkeen" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Загрузка Xkeen выполнена" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ] || [ -n "$result_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Загрузка Xkeen" >> "$xkeen_info_log"
        echo -e "$info_content\n$result_content" >> "$xkeen_info_log"
        echo "[end] Загрузка Xkeen выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}

logs_choose_geoip_info_xkeen() {
    local info_content=""

    if [ "$update_antifilter_geoip" = true ]; then
        if [ -n "$info_content" ]; then
            info_content="${info_content}\n"
        fi
        info_content="${info_content}    [info] Обновить: AntiFilter"
    fi

    if [ "$install_antifilter_geoip" = true ]; then
        if [ -n "$info_content" ]; then
            info_content="${info_content}\n"
        fi
        info_content="${info_content}    [info] Установить: AntiFilter"
    fi

    if [ "$install_v2fly_geoip" = true ]; then
        if [ -n "$info_content" ]; then
            info_content="${info_content}\n"
        fi
        info_content="${info_content}    [info] Установить: v2fly"
    fi

    if [ "$update_v2fly_geoip" = true ]; then
        if [ -n "$info_content" ]; then
            info_content="${info_content}\n"
        fi
        info_content="${info_content}    [info] Обновить: v2fly"
    fi

    if [ "$chose_delete_geoip_antifilter_select" = true ]; then
        if [ -n "$info_content" ]; then
            info_content="${info_content}\n"
        fi
        info_content="${info_content}    [info] Удаление: AntiFilter"
    fi

    if [ "$chose_delete_geoip_v2fly_select" = true ]; then
        if [ -n "$info_content" ]; then
            info_content="${info_content}\n"
        fi
        info_content="${info_content}    [info] Удаление: v2fly"
    fi

    if [ -n "$info_content" ]; then
		echo "" >> "$xkeen_info_log"
        echo "[start] Выбор пользователя в секции GeoIP" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Выбор пользователя в секции GeoIP выполнен" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi
}

logs_choose_geosite_info_xkeen() {
    local info_content=""

    if [ "$update_antizapret_geosite" = true ]; then
        if [ -n "$info_content" ]; then
            info_content="${info_content}\n"
        fi
        info_content="${info_content}    [info] Обновить: AntiZapret"
    fi

    if [ "$install_antizapret_geosite" = true ]; then
        if [ -n "$info_content" ]; then
            info_content="${info_content}\n"
        fi
        info_content="${info_content}    [info] Установить: AntiZapret"
    fi

    if [ "$update_antifilter_geosite" = true ]; then
        if [ -n "$info_content" ]; then
            info_content="${info_content}\n"
        fi
        info_content="${info_content}    [info] Обновить: AntiFilter"
    fi

    if [ "$install_antifilter_geosite" = true ]; then
        if [ -n "$info_content" ]; then
            info_content="${info_content}\n"
        fi
        info_content="${info_content}    [info] Установить: AntiFilter"
    fi

    if [ "$install_v2fly_geosite" = true ]; then
        if [ -n "$info_content" ]; then
            info_content="${info_content}\n"
        fi
        info_content="${info_content}    [info] Установить: v2fly"
    fi

    if [ "$update_v2fly_geosite" = true ]; then
        if [ -n "$info_content" ]; then
            info_content="${info_content}\n"
        fi
        info_content="${info_content}    [info] Обновить: v2fly"
    fi

    if [ "$chose_delete_geosite_antifilter_select" = true ]; then
        if [ -n "$info_content" ]; then
            info_content="${info_content}\n"
        fi
        info_content="${info_content}    [info] Удаление: AntiFilter"
    fi

    if [ "$chose_delete_geosite_v2fly_select" = true ]; then
        if [ -n "$info_content" ]; then
            info_content="${info_content}\n"
        fi
        info_content="${info_content}    [info] Удаление: v2fly"
    fi

    if [ -n "$info_content" ]; then
	    echo "" >> "$xkeen_info_log"
        echo "[start] Выбор пользователя в секции GeoSite" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Выбор пользователя в секции GeoSite выполнен" >> "$xkeen_info_log"	
		echo "" >> "$xkeen_info_log"
    fi
}

logs_install_geoip_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ "$install_antifilter_geoip" = true ]; then
        if [ -f "$geo_dir/geoip_antifilter.dat" ]; then
            info_content="${info_content}\n\t[info] GeoIP AntiFilter установлена"
        else
            error_content="${error_content}\n\t[error] Не удалось установить GeoIP базу AntiFilter"
        fi
    fi

    if [ "$install_v2fly_geoip" = true ]; then
        if [ -f "$geo_dir/geoip_v2fly.dat" ]; then
            info_content="${info_content}\n\t[info] GeoIP v2fly установлена"
        else
            error_content="${error_content}\n\t[error] Не удалось установить GeoIP базу v2fly"
        fi
    fi

    if [ "$update_antifilter_geoip" = true ]; then
        if [ -f "$geo_dir/geoip_antifilter.dat" ]; then
            info_content="${info_content}\n\t[info] GeoIP AntiFilter обновлена"
        else
            error_content="${error_content}\n\t[error] GeoIP AntiFilter  не установлена. Поэтому не может быть обновлена"
        fi
    fi

    if [ "$update_v2fly_geoip" = true ]; then
        if [ -f "$geo_dir/geoip_v2fly.dat" ]; then
            info_content="${info_content}\n\t[info] GeoIP v2fly обновлена"
        else
            error_content="${error_content}\n\t[error] GeoIP v2fly не установлена. Поэтому не может быть обновлена"
        fi
    fi

    if [ -n "$info_content" ]; then
	    echo "" >> "$xkeen_info_log"
        echo -e "[start] Установка или обновление GeoIP $info_content" >> "$xkeen_info_log"
        echo "[end] Установка или обновление GeoIP выполнена" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi

    if [ -n "$error_content" ]; then
		echo "" >> "$xkeen_error_log"
        echo -e "[start] Установка или обновление GeoIP $error_content" >> "$xkeen_error_log"
        echo "[end] Установка или обновление GeoIP выполнена" >> "$xkeen_error_log"
		echo "" >> "$xkeen_error_log"
    fi
}

logs_install_geosite_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ "$install_antizapret_geosite" = true ]; then
        if [ -f "$geo_dir/geosite_antizapret.dat" ]; then
            info_content="${info_content}\n\t[info] GeoSite AntiZapret установлена"
        else
            error_content="${error_content}\n\t[error] Не удалось установить GeoSite базу AntiZapret"
        fi
    fi

    if [ "$install_antifilter_geosite" = true ]; then
        if [ -f "$geo_dir/geosite_antifilter.dat" ]; then
            info_content="${info_content}\n\t[info] GeoSite AntiFilter установлена"
        else
            error_content="${error_content}\n\t[error] Не удалось установить GeoSite базу AntiFilter"
        fi
    fi

    if [ "$install_v2fly_geosite" = true ]; then
        if [ -f "$geo_dir/geosite_v2fly.dat" ]; then
            info_content="${info_content}\n\t[info] GeoSite v2fly установлена"
        else
            error_content="${error_content}\n\t[error] Не удалось установить GeoSite базу v2fly"
        fi
    fi

    if [ "$update_antizap_geosite" = true ]; then
        if [ -f "$geo_dir/geosite_antifilter.dat" ]; then
            info_content="${info_content}\n\t[info] GeoSite AntiFilter обновлена"
        else
            error_content="${error_content}\n\t[error] GeoSite AntiFilter  не установлена. Поэтому не может быть обновлена"
        fi
    fi

    if [ "$update_antifilter_geosite" = true ]; then
        if [ -f "$geo_dir/geosite_antifilter.dat" ]; then
            info_content="${info_content}\n\t[info] GeoSite AntiFilter обновлена"
        else
            error_content="${error_content}\n\t[error] GeoSite AntiFilter  не установлена. Поэтому не может быть обновлена"
        fi
    fi

    if [ "$update_v2fly_geosite" = true ]; then
        if [ -f "$geo_dir/geosite_v2fly.dat" ]; then
            info_content="${info_content}\n\t[info] GeoSite v2fly обновлена"
        else
            error_content="${error_content}\n\t[error] GeoSite v2fly не установлена. Поэтому не может быть обновлена"
        fi
    fi

    if [ -n "$info_content" ]; then
	    echo "" >> "$xkeen_info_log"
        echo -e "[start] Установка или обновление GeoSite $info_content" >> "$xkeen_info_log"
        echo "[end] Установка или обновление GeoSite выполнена" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi

    if [ -n "$error_content" ]; then
		echo "" >> "$xkeen_error_log"
        echo -e "[start] Установка или обновление GeoSite $error_content" >> "$xkeen_error_log"
        echo "[end] Установка или обновление GeoSite выполнена" >> "$xkeen_error_log"
		echo "" >> "$xkeen_error_log"
    fi
}


logs_install_configs_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ -d "$xkeen_conf_dir" ]; then
        xkeen_files="$xkeen_conf_dir"/*.json
        
        files_to_replace=""
        
        for file in $xkeen_files; do
            filename=$(basename "$file" .json)
            if [ -f "$install_conf_dir/$filename.json" ]; then
                files_to_replace="$files_to_replace $filename"
            fi
        done

        if [ -n "$files_to_replace" ]; then
            info_content="\t[info] Файлы находящиеся в директории конфигураций Xray:\n"
            for filename in $files_to_replace; do
                info_content="$info_content\t\t[info] $filename\n"
            done
        fi
    else
        error_content="\t[error] Директория $xkeen_conf_dir не найдена\n"
    fi

    if [ -n "$error_content" ] || [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка файлов конфигурации Xray" >> "$xkeen_info_log"
        if [ -n "$error_content" ]; then
            echo -e "$error_content" | sed '/^$/d' >> "$xkeen_error_log"
        fi
        if [ -n "$info_content" ]; then
            echo -e "$info_content" | sed '/^$/d' >> "$xkeen_info_log"
        fi
        echo "[end] Проверка файлов конфигурации Xray завершена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}


logs_choose_update_cron_info_xkeen() {
    local info_content=""

    local has_missing_cron_tasks=false
    local has_updatable_cron_tasks=false

    [ "$chose_xkeen_cron_select" != true ] && has_missing_cron_tasks=true
    [ "$chose_xray_cron_select" != true ] && has_missing_cron_tasks=true
    [ "$chose_geosite_cron_select" != true ] && has_missing_cron_tasks=true
    [ "$chose_geoip_cron_select" != true ] && has_missing_cron_tasks=true

    [ "$chose_xkeen_cron_select" = true ] || [ "$chose_xray_cron_select" = true ] || [ "$chose_geosite_cron_select" = true ] || [ "$chose_geoip_cron_select" = true ] && has_updatable_cron_tasks=true

    if [ "$has_missing_cron_tasks" = true ]; then
        info_content="${info_content}\n\t[info] Будут включены следующие задачи автоматического обновления:\n"
        [ "$chose_xkeen_cron_select" != true ] && info_content="${info_content}\t\t[info] Xkeen\n"
        [ "$chose_xray_cron_select" != true ] && info_content="${info_content}\t\t[info] Xray\n"
        [ "$chose_geosite_cron_select" != true ] && info_content="${info_content}\t\t[info] GeoSite\n"
        [ "$chose_geoip_cron_select" != true ] && info_content="${info_content}\t\t[info] GeoIP\n"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Определение статуса задач автоматического обновления" >> "$xkeen_info_log"
        echo -e "$info_content" | sed '/^$/d' >> "$xkeen_info_log"
        echo "[end] Определение статуса задач автоматического обновления выполнено" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi
}

logs_choose_cron_time_info_xkeen() {
    local info_content=""
    local result_content=""

    for task in xkeen xray geosite geoip all; do
        task_var="chose_${task}_cron_select"
        time_var="chose_${task}_cron_time"

        case $task in
            all) task_name="всех";;
            xkeen) task_name="Xkeen";;
            xray) task_name="Xray";;
            geosite) task_name="GeoSite";;
            geoip) task_name="GeoIP";;
        esac

        if [ "$(eval echo \${$task_var})" = true ]; then
            if [ "$task" = "all" ]; then
                result_content="${result_content}\n[info] Выбранное время автоматического обновления для $task_name задач:"
            else
                result_content="${result_content}\n[info] Выбранное время автоматического обновления для $task_name:"
            fi

            cron_expression=$(eval echo \${$time_var})

            cron_day=$(echo "$cron_expression" | cut -d ' ' -f 5)
            cron_hour=$(echo "$cron_expression" | cut -d ' ' -f 2)
            cron_minute=$(echo "$cron_expression" | cut -d ' ' -f 1)

            case $cron_day in
                0) day="Воскресенье";;
                1) day="Понедельник";;
                2) day="Вторник";;
                3) day="Среда";;
                4) day="Четверг";;
                5) day="Пятница";;
                6) day="Суббота";;
                *) day="Ежедневно";;
            esac

            result_content="${result_content}\n\t[info] $day, в ${cron_hour}:${cron_minute}"
        fi
    done

    if [ -n "$result_content" ]; then
		echo "" >> "$xkeen_info_log"
        echo -n "[start] Определение времени для задач cron" >> "$xkeen_info_log"
        echo -e "$result_content" | sed 's/^/\t/' >> "$xkeen_info_log"
        echo "[end] Определение времени для задач cron выполнено" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi
}

logs_install_cron_info_xkeen() {
    local info_content=""
    local error_content=""
    local last_line=""

    cron_file_path="$cron_dir/$cron_file"
    
    if [ -f "$cron_file_path" ]; then
        if [ -n "$chose_all_cron_time" ] || [ -n "$chose_xkeen_cron_time" ] || [ -n "$chose_xray_cron_time" ] || [ -n "$chose_geosite_cron_time" ] || [ -n "$chose_geoip_cron_time" ]; then
            if [ -n "$chose_all_cron_time" ] || [ -n "$chose_geoip_cron_time" ]; then
                if grep -q "$install_dir/xkeen.*-ugic" "$cron_file_path"; then
                    task="GeoIP"
                    cron_entry=$(grep "$install_dir/xkeen.*-ugic" "$cron_file_path")
                    info_content="$info_content\t[info] Запись для задачи автоматического обновления $task существует\n"
                    info_content="$info_content\t\t[info] $cron_entry\n"
                    last_line="$cron_entry"
                else
                    error_content="$error_content\t[error] Запись для задачи автоматического обновления GeoIP не существует в cron файле\n"
                fi
            fi

            if [ -n "$chose_all_cron_time" ] || [ -n "$chose_geosite_cron_time" ]; then
                if grep -q "$install_dir/xkeen.*-ugsc" "$cron_file_path"; then
                    task="GeoSite"
                    cron_entry=$(grep "$install_dir/xkeen.*-ugsc" "$cron_file_path")
                    info_content="$info_content\t[info] Запись для задачи автоматического обновления $task существует\n"
                    info_content="$info_content\t\t[info] $cron_entry\n"
                    last_line="$cron_entry"
                else
                    error_content="$error_content\t[error] Запись для задачи автоматического обновления GeoSite не существует в cron файле\n"
                fi
            fi

            if [ -n "$chose_all_cron_time" ] || [ -n "$chose_xkeen_cron_time" ]; then
                if grep -q "$install_dir/xkeen.*-ukc" "$cron_file_path"; then
                    task="Xkeen"
                    cron_entry=$(grep "$install_dir/xkeen.*-ukc" "$cron_file_path")
                    info_content="$info_content\t[info] Запись для задачи автоматического обновления $task существует\n"
                    info_content="$info_content\t\t[info] $cron_entry\n"
                    last_line="$cron_entry"
                else
                    error_content="$error_content\t[error] Запись для задачи автоматического обновления Xkeen не существует в cron файле\n"
                fi
            fi

            if [ -n "$chose_all_cron_time" ] || [ -n "$chose_xray_cron_time" ]; then
                if grep -q "$install_dir/xkeen.*-uxc" "$cron_file_path"; then
                    task="Xray"
                    cron_entry=$(grep "$install_dir/xkeen.*-uxc" "$cron_file_path")
                    info_content="$info_content\t[info] Запись для задачи автоматического обновления $task существует\n"
                    info_content="$info_content\t\t[info] $cron_entry\n"
                    last_line="$cron_entry"
                else
                    error_content="$error_content\t[error] Запись для задачи автоматического обновления Xray не существует в cron файле\n"
                fi
            fi
        fi
    else
        error_content="$error_content\t[error] Файл cron не найден\n"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка внесенных записей в Cron" >> "$xkeen_error_log"
        echo -e "$error_content" | sed 's/^/\t/' >> "$xkeen_error_log"
        if [ -n "$last_line" ]; then
            echo "[end] Проверка внесенных записей в Cron завершилась с ошибками" >> "$xkeen_error_log"
        else
            echo -n "[end] Проверка внесенных записей в Cron завершилась с ошибками" >> "$xkeen_error_log"
        fi
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка внесенных записей в Cron" >> "$xkeen_info_log"
        echo -e "$info_content" | sed 's/^/\t/' >> "$xkeen_info_log"
        if [ -n "$last_line" ]; then
            echo "[end] Проверка внесенных записей в Cron выполнена" >> "$xkeen_info_log"
        else
            echo -n "[end] Проверка внесенных записей в Cron выполнена" >> "$xkeen_info_log"
        fi
        echo "" >> "$xkeen_info_log"
    fi
}


logs_delete_geoip_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ -f "$geo_dir/geoip_antifilter.dat" ]; then
        info_content="${info_content}\t[info] Файл geoip_antifilter.dat отсутствует в директории «$geo_dir»\n"
    else
        error_content="${error_content}\t[error] Файл geoip_antifilter.dat не удален\n"
    fi

    if [ -f "$geo_dir/geoip_v2fly.dat" ]; then
        info_content="${info_content}\t[info] Файл geoip_v2fly.dat отсутствует в директории «$geo_dir»"
    else
        error_content="${error_content}\t[error] Файл geoip_v2fly.dat не удален"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка файлов GeoSite" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Проверка файлов GeoSite выполнена" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка файлов GeoSite" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Проверка файлов GeoSite выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}

logs_delete_geosite_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ -f "$geo_dir/geosite_antifilter.dat" ]; then
        info_content="${info_content}\t[info] Файл geosite_antifilter.dat отсутствует в директории «$geo_dir»\n"
    else
        error_content="${error_content}\t[error] Файл geosite_antifilter.dat не удален\n"
    fi

    if [ -f "$geo_dir/geosite_antizapret.dat" ]; then
		info_content="${info_content}\t[info] Файл geosite_antizapret.dat отсутствует в директории «$geo_dir»\n"
    else
        error_content="${error_content}\t[error] Файл geosite_antizapret.dat не удален\n"
    fi

    if [ -f "$geo_dir/geosite_v2fly.dat" ]; then
		info_content="${info_content}\t[info] Файл geosite_v2fly.dat отсутствует в директории «$geo_dir»"	
    else
		error_content="${error_content}\t[error] Файл geosite_v2fly.dat не удален\n"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка файлов GeoSite" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Проверка файлов GeoSite выполнена" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка файлов GeoSite" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Проверка файлов GeoSite выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}

logs_delete_cron_task_info_xkeen() {
    local info_content=""
    
    if [ -f "$cron_dir/$cron_file" ]; then
        if [ "$chose_all_cron_select" = true ] || [ "$chose_delete_all_cron_select" = true ]; then
            grep -q "ugic\|ugdc\|uxc\|ukc" "$cron_dir/$cron_file"
            if [ $? -eq 1 ]; then
                info_content="\t[info] Все задачи автоматического обновления удалены из cron"
            fi
        else
            if [ "$chose_xkeen_cron_select" = true ]; then
                logs_delete_cron_xkeen_info_xkeen
            fi
            
            if [ "$chose_xray_cron_select" = true ]; then
                logs_delete_cron_xray_info_xkeen
            fi
            
            if [ "$chose_geosite_cron_select" = true ]; then
                logs_delete_cron_geosite_info_xkeen
            fi
            
            if [ "$chose_geoip_cron_select" = true ]; then
                logs_delete_cron_geoip_info_xkeen
            fi
        fi

        if [ -n "$info_content" ]; then
            echo "" >> "$xkeen_info_log"
            echo "[start] Удаление cron задач" >> "$xkeen_info_log"
            echo -e "$info_content" >> "$xkeen_info_log"
            echo "[end] Удаление cron задач выполнено" >> "$xkeen_info_log"
            echo "" >> "$xkeen_info_log"
        fi
    fi
}

logs_delete_cron_xkeen_info_xkeen() {
    local info_content=""
    
    if [ -f "$cron_dir/$cron_file" ]; then
        grep -q "ukc" "$cron_dir/$cron_file"
        if [ $? -eq 1 ]; then
            info_content="\t[info] Задача автоматического обновления для Xkeen удалена из cron"
        fi
        
        if [ -n "$info_content" ]; then
            echo "" >> "$xkeen_info_log"
            echo "[start] Удаление задачи автоматического обновления Xkeen из cron" >> "$xkeen_info_log"
            echo -e "$info_content" >> "$xkeen_info_log"
            echo "[end] Удаление задачи автоматического обновления Xkeen из cron выполнено" >> "$xkeen_info_log"
            echo "" >> "$xkeen_info_log"
        fi
    fi
}

logs_delete_cron_xray_info_xkeen() {
    local info_content=""
    
    if [ -f "$cron_dir/$cron_file" ]; then
        grep -q "uxc" "$cron_dir/$cron_file"
        if [ $? -eq 1 ]; then
            info_content="\t[info] Задача автоматического обновления для Xray удалена из cron"
        fi
        
        if [ -n "$info_content" ]; then
            echo "" >> "$xkeen_info_log"
            echo "[start] Удаление задачи автоматического обновления Xray из cron" >> "$xkeen_info_log"
            echo -e "$info_content" >> "$xkeen_info_log"
            echo "[end] Удаление задачи автоматического обновления Xray из cron выполнено" >> "$xkeen_info_log"
            echo "" >> "$xkeen_info_log"
        fi
    fi
}

logs_delete_cron_geosite_info_xkeen() {
    local info_content=""
    
    if [ -f "$cron_dir/$cron_file" ]; then
        grep -q "ugdc" "$cron_dir/$cron_file"
        if [ $? -eq 1 ]; then
            info_content="\t[info] Задача автоматического обновления для GeoData удалена из cron"
        fi
        
        if [ -n "$info_content" ]; then
            echo "" >> "$xkeen_info_log"
            echo "[start] Удаление задачи автоматического обновления GeoData из cron" >> "$xkeen_info_log"
            echo -e "$info_content" >> "$xkeen_info_log"
            echo "[end] Удаление задачи автоматического обновления GeoData из cron выполнено" >> "$xkeen_info_log"
            echo "" >> "$xkeen_info_log"
        fi
    fi
}

logs_delete_cron_geoip_info_xkeen() {
    local info_content=""
    
    if [ -f "$cron_dir/$cron_file" ]; then
        grep -q "ugic" "$cron_dir/$cron_file"
        if [ $? -eq 1 ]; then
            info_content="\t[info] Задача автоматического обновления для GeoIP удалена из cron"
        fi
        
        if [ -n "$info_content" ]; then
            echo "" >> "$xkeen_info_log"
            echo "[start] Удаление задачи автоматического обновления для GeoIP из cron" >> "$xkeen_info_log"
            echo -e "$info_content" >> "$xkeen_info_log"
            echo "[end] Удаление задачи автоматического обновления для GeoIP из cron выполнено" >> "$xkeen_info_log"
            echo "" >> "$xkeen_info_log"
        fi
    fi
}

logs_delete_configs_info_xkeen() {
    local info_content=""
    local error_content=""
    
    local deleted_files=$(find "$install_conf_dir" -name "*.json" -type f)
    
    if [ -z "$deleted_files" ]; then
        info_content="\t[info] Все конфигурационные файлы Xray успешно удалены"
    else
        error_content="\t[error] Не удалены следующие конфигурационные файлы:\n"
        error_content="${error_content}$deleted_files\n"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка удаления конфигурационных файлов Xray" >> "$xkeen_error_log"
        echo -e "$error_content" | sed 's/^/\t/' >> "$xkeen_error_log"
        echo "[end] Проверка удаления конфигурационных файлов Xray выполнена" >> "$xkeen_error_log"
		echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка удаления конфигурационных файлов Xray" >> "$xkeen_info_log"
        echo -e "$info_content" | sed 's/^/\t/' >> "$xkeen_info_log"
        echo "[end] Проверка удаления конфигурационных файлов Xray выполнена" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi
}


logs_register_xray_control_info_xkeen() {
    local info_content=""
    local error_content=""
    
    control_file_path="$register_dir/xray.control"
    
    if [ -f "$control_file_path" ]; then
        info_content="$info_content\t[info] Файл xray.control найден в директории «$register_dir/»"
    else
        error_content="$error_content\t[error] Файл xray.control не найден в директории «$register_dir/»"
    fi
    
    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка файла xray.control" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Проверка файла xray.control завершилось с ошибками" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка файла xray.control" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Проверка файла xray.control выполнено" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}

logs_register_xray_list_info_xkeen() {
    local info_content=""
    local error_content=""
    
    cd "$register_dir/" || exit

    if [ ! -f "xray.list" ]; then
        error_content="$error_content\t[error] Файл xray.list не найден в директории «$register_dir/»"
    else
        info_content="$info_content\t[info] Файл xray.list найден в директории «$register_dir/»"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка файла с путями xray" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Проверка файла с путями xray не выполнено" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка файла с путями xray" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Проверка файла с путями xray выполнено" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}

logs_register_xray_status_info_xkeen() {
    local info_content=""
    local error_content=""

    if grep -q "Package: xray" "$status_file"; then
        info_content="\t[info] Запись Xray найдена в «$status_file»"
    else
        error_content="\t[error] Запись Xray не найдена в «$status_file»"
    fi
    
    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка регистрации Xray в Status" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Проверка регистрации Xray в Status выполнена" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi
    
    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка регистрации Xray в Status" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Проверка регистрации Xray в Status выполнена" >> "$xkeen_error_log"
		echo "" >> "$xkeen_error_log"
    fi
}


logs_register_xray_initd_info_xkeen() {
    local info_content=""
    local error_content=""

    initd_file="$initd_dir/S24xray"

    if [ -f "$initd_file" ]; then
        info_content="\t[info] init скрипт Xray найден в директории «$initd_dir/»"
    else
        error_content="\t[error] init скрипт Xray не найден в директории «$initd_dir/»"
    fi
    
    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка наличия init скрипта Xray" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Проверка наличия init xray выполнена" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi
    
    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Создание или замена файла init скрипта xray" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Создание или замена файла init скрипта xray завершилось с ошибками" >> "$xkeen_error_log"
		echo "" >> "$xkeen_error_log"
    fi
}

logs_register_xkeen_list_info_xkeen() {
    local info_content=""
    local error_content=""
	
    cd "$register_dir/" || exit

    if [ ! -f "xkeen.list" ]; then
        error_content="$error_content\t[error] Файл xkeen.list не найден в директории «$register_dir/»"
    else
        info_content="$info_content\t[info] Файл xkeen.list не найден в директории «$register_dir/»\n"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка файла xkeen.list" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Проверка файла xkeen.list выполнена" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка файла xkeen.list" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Проверка файла xkeen.list выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}


logs_register_xkeen_control_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ -f "$register_dir/xkeen.control" ]; then
        info_content="\n[info] Файл xkeen.control найден в директории «$register_dir/»"
    else
        error_content="\n[error] Файл xkeen.control найден в директории «$register_dir/»"
    fi
    
    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка файла xkeen.control" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo -n "[end] Проверка файла xkeen.control выполнено" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
    
    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка файла xkeen.control" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo -n "[end] Проверка файла xkeen.control завершилось с ошибками" >> "$xkeen_error_log"
		echo "" >> "$xkeen_error_log"
    fi
}


logs_register_xkeen_status_info_xkeen() {
    local info_content=""
    local error_content=""

    if grep -q "Package: xkeen" "$status_file"; then
        info_content="\t[info] Запись Xkeen найдена в «$status_file»"
    else
        error_content="\t[error] Запись Xkeen не найдена в «$status_file»"
    fi
    
    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка регистрации Xkeen в Status" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Проверка регистрации Xkeen в Status выполнена" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi
    
    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка регистрации Xkeen в Status" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Проверка регистрации Xkeen в Status выполнена" >> "$xkeen_error_log"
		echo "" >> "$xkeen_error_log"
    fi
}

logs_delete_register_xray_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ ! -f "$register_dir/xray.list" ]; then
        info_content="$info_content\t[info] Файл xray.list не найден в директории «$register_dir/»\n"
    else
        error_content="$error_content\t[error] Файл xray.list найден в директории «$register_dir/»\n"
    fi

    if [ ! -f "$register_dir/xray.control" ]; then
        info_content="$info_content\t[info] Файл xray.control не найден в директории «$register_dir/»\n"
    else
        error_content="$error_content\t[error] Файл xray.control найден в директории «$register_dir/»\n"
    fi

    if ! grep -q 'Package: xray' "$status_file"; then
        info_content="$info_content\t[info] Регистрация пакета xray не обнаружена в «$status_file»"
    else
        error_content="$error_content\t[error] Регистрация пакета xray обнаружена в «$status_file»"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка удаления регистрации Xray" >> "$xkeen_error_log"
        echo -e "$error_content" | sed 's/^/\t/' >> "$xkeen_error_log"
        echo "[end] Проверка удаления регистрации Xray выполнена" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка удаления регистрации Xray" >> "$xkeen_info_log"
        echo -e "$info_content" | sed 's/^/\t/' >> "$xkeen_info_log"
        echo "[end] Проверка удаления регистрации Xray выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}

logs_delete_register_xkeen_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ ! -f "$register_dir/xkeen.list" ]; then
        info_content="$info_content\t[info] Файл xkeen.list не найден в директории «$register_dir/»\n"
    else
        error_content="$error_content\t[error] Файл xkeen.list найден в директории «$register_dir/»\n"
    fi

    if [ ! -f "$register_dir/xkeen.control" ]; then
        info_content="$info_content\t[info] Файл xkeen.control не найден в директории «$register_dir/»\n"
    else
        error_content="$error_content\t[error] Файл xkeen.control найден в директории «$register_dir/»\n"
    fi

    if ! grep -q 'Package: xkeen' "$status_file"; then
        info_content="$info_content\t[info] Регистрация пакета xkeen не обнаружена в «$status_file»"
    else
        error_content="$error_content\t[error] Регистрация пакета xkeen обнаружена в «$status_file»"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка удаления регистрации Xkeen" >> "$xkeen_error_log"
        echo -e "$error_content" | sed 's/^/\t/' >> "$xkeen_error_log"
        echo "[end] Проверка удаления регистрации Xkeen выполнена" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка удаления регистрации Xkeen" >> "$xkeen_info_log"
        echo -e "$info_content" | sed 's/^/\t/' >> "$xkeen_info_log"
        echo "[end] Проверка удаления регистрации Xkeen выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}

logs_delete_tmp_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ ! -d "$tmp_dir_global/xkeen" ]; then
        info_content="$info_content\t[info] Временная директория $tmp_dir_global/xkeen успешно удалена\n"
    else
        error_content="$error_content\t[error] Временная директория $tmp_dir_global/xkeen не удалена\n"
    fi
	
	if [ ! -f "$cron_dir/root.tmp" ]; then
        info_content="$info_content\t[info] Временный файл $cron_dir/root.tmp успешно удален"
    else
        error_content="$error_content\t[error] Временный файл $cron_dir/root.tmp не удален"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Удаление временной директории" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Удаление временной директории завершилось с ошибками" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Удаление временной директории" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Удаление временной директории выполнено" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}
