# Журнал работы xkeen

logs_packages_info_xkeen() {
    local info_content=""
    local error_content=""
    
    if [ "$info_packages_lscpu" = "installed" ]; then
        info_content="$info_content\t[info] lscpu установлен\n"
    else
        error_content="$error_content\t[error] lscpu не установлен\n"
    fi
    
    if [ "$info_packages_curl" = "installed" ]; then
        info_content="$info_content\t[info] curl установлен\n"
    else
        error_content="$error_content\t[error] curl не установлен\n"
    fi
    
    if [ "$info_packages_jq" = "installed" ]; then
        info_content="$info_content\t[info] jq установлен\n"
    else
        error_content="$error_content\t[error] jq не установлен\n"
    fi
    
    if [ "$info_packages_libc" = "installed" ]; then
        info_content="$info_content\t[info] libc установлен\n"
    else
        error_content="$error_content\t[error] libc не установлен\n"
    fi
    
    if [ "$info_packages_libssp" = "installed" ]; then
        info_content="$info_content\t[info] libssp установлен\n"
    else
        error_content="$error_content\t[error] libssp не установлен\n"
    fi
    
    if [ "$info_packages_librt" = "installed" ]; then
        info_content="$info_content\t[info] librt установлен\n"
    else
        error_content="$error_content\t[error] librt не установлен\n"
    fi
    
    if [ "$info_packages_libpthread" = "installed" ]; then
        info_content="$info_content\t[info] libpthread установлен\n"
    else
        error_content="$error_content\t[error] libpthread не установлен\n"
    fi
    
    if [ "$info_packages_cabundle" = "installed" ]; then
        info_content="$info_content\t[info] ca-bundle установлен\n"
    else
        error_content="$error_content\t[error] ca-bundle не установлен\n"
    fi
    
    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка наличия необходимых пакетов" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Проверка наличия необходимых пакетов выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
    
    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка наличия необходимых пакетов" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Проверка наличия необходимых пакетов выполнена" >> "$xkeen_error_log"
		echo -e "$error_content" >> "$xkeen_error_log"
    fi
}


logs_cpu_info_xkeen() {
    local info_content=""
    local error_content=""
    local result_content=""
    
    echo "" >> "$xkeen_info_log"
    echo "[start] Проверка процессора" >> "$xkeen_info_log"
    echo "    [head] Процессор" >> "$xkeen_info_log"

    if [ -n "$info_model" ]; then
        info_content="        [info] Модель: $info_model\n"
    else
        error_content="\n        [info] Модель: Не удалось определить\n"
    fi

    if [ -n "$info_architecture" ]; then
        info_content="${info_content}        [info] Архитектура: $info_architecture\n"
    else
        error_content="${error_content}        [info] Архитектура: Не удалось определить\n"
    fi

    if [ -n "$generated_keyword" ]; then
        result_content="    [result] Процессор поддерживается xkeen\n"
    else
        result_content="    [result] Процессор не поддерживается xkeen\n"
    fi

    if [ -n "$info_content" ]; then
        echo -e "$info_content" >> "$xkeen_info_log"
		fi

    if [ -n "$result_content" ]; then
        echo -e "$result_content" >> "$xkeen_info_log"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка процессора" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Проверка процессора выполнена" >> "$xkeen_error_log"
    fi

    echo "[end] Проверка процессора выполнена" >> "$xkeen_info_log"
    echo "" >> "$xkeen_info_log"
}

logs_xray_info_xkeen() {
    if [ "$xray_installed" = "installed" ]; then
	    echo "" >> "$xkeen_info_log"
        echo "[start] Проверка установки xray" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
		echo "	[result] xray установлен" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
        echo "[end] Проверка установки xray выполнена" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi
    
    if [ "$xray_installed" = "not_installed" ]; then
		echo "" >> "$xkeen_error_log"
        echo "[start] Проверка установки xray" >> "$xkeen_error_log"
		echo "" >> "$xkeen_error_log"
        echo "	[result] xray не установлен" >> "$xkeen_error_log"
		echo "" >> "$xkeen_error_log"
        echo "[end] Проверка установки xray выполнена" >> "$xkeen_error_log"
		echo "" >> "$xkeen_error_log"
    fi
}

logs_geodata_info_xkeen() {
    local info_content=""
    local error_content=""
    local result_content=""

    if [ "$geo_exists_geodata_antizapret" = "installed" ]; then
        info_content="	[info] База GeoData AntiZapret установлена\n"
    else
        error_content="\n	[error] База GeoData AntiZapret не установлена\n"
    fi

    if [ "$geo_exists_geodata_antifilter" = "installed" ]; then
        info_content="${info_content}	[info] База GeoData AntiFilter установлена\n"
    else
        error_content="${error_content}	[error] База GeoData AntiFilter не установлена\n"
    fi

    if [ "$geo_exists_geodata_v2fly" = "installed" ]; then
        info_content="${info_content}	[info] База GeoData v2fly установлена\n"
    else
        error_content="${error_content}	[error] База GeoData v2fly не установлена\n"
    fi

    if [ "$geo_exists_geodata_antizapret" = "not_installed" ] && \
       [ "$geo_exists_geodata_antifilter" = "not_installed" ] && \
       [ "$geo_exists_geodata_v2fly" = "not_installed" ]; then
       result_content="\n	[result] Ни одна из баз данных GeoData не установлена\n"
    elif [ "$geo_exists_geodata_antizapret" = "installed" ] && \
         [ "$geo_exists_geodata_antifilter" = "installed" ] && \
         [ "$geo_exists_geodata_v2fly" = "installed" ]; then
       result_content="\n	[result] Все базы GeoData установлены\n"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка наличия баз данных GeoData" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Проверка наличия баз данных GeoData выполнена" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка наличия баз данных GeoData" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Проверка наличия баз данных GeoData выполнена" >> "$xkeen_error_log"
		echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$result_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка наличия баз данных GeoData" >> "$xkeen_info_log"
        echo -e "$result_content" >> "$xkeen_info_log"
        echo "[end] Проверка наличия баз данных GeoData выполнена" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi
}


logs_geoip_info_xkeen() {
    local info_content=""
    local error_content=""
    local result_content=""

	if [ "$geo_exists_geoip_antifilter" = "installed" ]; then
		info_content="	[info] База GeoIP AntiFilter установлена\n"
	else
		error_content="\n	[error] База GeoIP AntiFilter не установлена\n"
	fi

	if [ "$geo_exists_geoip_v2fly" = "installed" ]; then
		info_content="${info_content}	[info] База GeoIP v2fly установлена\n"
	else
		error_content="${error_content}	[error] База GeoIP v2fly не установлена\n"
	fi

	if [ "$geo_exists_geoip_antifilter" = "not_installed" ] && \
	   [ "$geo_exists_geoip_v2fly" = "not_installed" ]; then
	   result_content="\n	[result] Ни одна из баз данных GeoIP не установлена\n"
	elif [ "$geo_exists_geoip_antifilter" = "installed" ] && \
		 [ "$geo_exists_geoip_v2fly" = "installed" ]; then
	   result_content="\n	[result] Все базы GeoIP установлены\n"
	fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка наличия баз данных GeoIP" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Проверка наличия баз данных GeoIP выполнена" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$result_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка наличия баз данных GeoIP" >> "$xkeen_info_log"
        echo -e "$result_content" >> "$xkeen_info_log"
        echo "[end] Проверка наличия баз данных GeoIP выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}


logs_cron_info_xkeen() {
    local info_content=""
    local error_content=""
    local result_content=""

    if [ "$info_update_xray_cron" = "installed" ]; then
        info_content="\n	[info] Задача автоматического обновления Xray включена\n"
    else
        error_content="\n	[error] Задача автоматического обновления Xray не включена\n"
    fi

    if [ "$info_update_xkeen_cron" = "installed" ]; then
        info_content="${info_content}	[info] Задача автоматического обновления Xkeen включена\n"
    else
        error_content="${error_content}	[error] Задача автоматического обновления Xkeen не включена\n"
    fi

    if [ "$info_update_geoip_cron" = "installed" ]; then
        info_content="${info_content}	[info] Задача автоматического обновления GeoIP включена\n"
    else
        error_content="${error_content}	[error] Задача автоматического обновления GeoIP не включена\n"
    fi

    if [ "$info_update_geodata_cron" = "installed" ]; then
        info_content="${info_content}	[info] Задача автоматического обновления GeoData включена\n"
    else
        error_content="${error_content}	[error] Задача автоматического обновления GeoData не включена\n"
    fi

    if [ "$info_update_xray_cron" = "not_installed" ] && \
       [ "$info_update_xkeen_cron" = "not_installed" ] && \
       [ "$info_update_geoip_cron" = "not_installed" ] && \
       [ "$info_update_geodata_cron" = "not_installed" ]; then
       result_content="\n	[result] Ни одна из задач автоматического обновления в cron не включена\n"
    elif [ "$info_update_xray_cron" = "installed" ] && \
         [ "$info_update_xkeen_cron" = "installed" ] && \
         [ "$info_update_geoip_cron" = "installed" ] && \
         [ "$info_update_geodata_cron" = "installed" ]; then
       result_content="\n	[result] Все задачи автоматического обновления в cron включены\n"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка наличия задач автоматического обновления в cron" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Проверка наличия задач автоматического обновления в cron выполнена" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$result_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка наличия задач автоматического обновления в cron" >> "$xkeen_info_log"
        echo -e "$result_content" >> "$xkeen_info_log"
        echo "[end] Проверка наличия задач автоматического обновления в cron выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}


logs_version_xkeen_info_xkeen() {
    local info_content=""
    local error_content=""
    local result_content=""

    info_content="\n	[info] Установленная версия xkeen: $xkeen_current_version\n	[info] GitHub версия xkeen: $xkeen_github_version\n"

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
        info_content="\n	[info] Текущая версия $xkeen_current_version xkeen актуальна\n"
    elif [ "$info_compare_xkeen" = "update" ]; then
        info_content="\n	info] Текущая версия xkeen $xkeen_current_version.\n"
        info_content="\n	[info] Доступно обновление на версию $xkeen_github_version\n"
    else
        info_content="\n	[info] Текущая версия xkeen $xkeen_current_version новее доступной на GitHub $xkeen_github_version\n"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Сравнение версий xkeen" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Сравнение версий xkeen выполнено" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Сравнение версий xkeen" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Сравнение версий xkeen выполнено" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi
}


logs_version_xray_info_xkeen() {
    local info_content=""
    local error_content=""
    local result_content=""

    info_content="\n	[info] Установленная версия xray: $xray_current_version\n	[info] GitHub версия xray: $xray_github_version\n"

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
    local result_content=""

    if [ "$info_compare_xray" = "actual" ]; then
        info_content="\n	[info] Текущая версия $xray_current_version xray актуальна\n"
    elif [ "$info_compare_xray" = "update" ]; then
        info_content="\n	[info] Текущая версия xray $xray_current_version.\n"
        info_content="\n	[info] Доступно обновление на версию $xray_github_version\n"
    else
        info_content="\n	[info] Текущая версия xray $xray_current_version новее доступной на github $xray_github_version\n"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Сравнение версий xray" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Сравнение версий xray выполнено" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Сравнение версий xray" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Сравнение версий xray выполнено" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi
}

logs_install_packages_xkeen() {
    local info_content=""
    local error_content=""
    
    if [ "$info_packages_lscpu" = "installed" ]; then
        info_content="$info_content\t[info] lscpu установлен\n"
    fi
    
    if [ "$info_packages_curl" = "installed" ]; then
        info_content="$info_content\t[info] curl установлен\n"
    fi
    
    if [ "$info_packages_jq" = "installed" ]; then
        info_content="$info_content\t[info] jq установлен\n"
    fi
    
    if [ "$info_packages_libc" = "installed" ]; then
        info_content="$info_content\t[info] libc установлен\n"
    fi
    
    if [ "$info_packages_libssp" = "installed" ]; then
        info_content="$info_content\t[info] libssp установлен\n"
    fi
    
    if [ "$info_packages_librt" = "installed" ]; then
        info_content="$info_content\t[info] librt установлен\n"
    fi
    
    if [ "$info_packages_libpthread" = "installed" ]; then
        info_content="$info_content\t[info] libpthread установлен\n"
    fi
    
    if [ "$info_packages_cabundle" = "installed" ]; then
        info_content="$info_content\t[info] ca-bundle установлен\n"
    fi
    
    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Проверка наличия необходимых пакетов" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Проверка наличия необходимых пакетов выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
    
    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Проверка наличия необходимых пакетов" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Проверка наличия необходимых пакетов выполнена" >> "$xkeen_error_log"
		echo -e "$error_content" >> "$xkeen_error_log"
    fi
}

logs_download_xray_info_xkeen() {
    local info_content=""
    local error_content=""
    local result_content=""

    if [ -n "$download_url" ]; then
        info_content="\n	[info] URL для скачивания Xray найден\n"
    else
        error_content="\n	[error] URL для скачивания Xray не найден\n"
    fi

    if [ -e "$tmp_dir/xray.ipk" ]; then
        if [ -s "$tmp_dir/xray.ipk" ]; then
            result_content="\t[result] xray успешно загружен\n"
        else
            error_content="\t[error] Загрузка Xray не удалась. Некорректная ссылка \n"
        fi
    else
        error_content="\t[error] Загрузка Xray не удалась. Архив не найден\n"
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
        echo -e "$info_content$result_content" >> "$xkeen_info_log"
        echo "[end] Загрузка Xray выполнена" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi
}

logs_download_xkeen_info_xkeen() {
    local info_content=""
    local error_content=""
    local result_content=""

    if [ -n "$download_url" ]; then
        info_content="\t[info] URL для скачивания Xkeen найден\n"
    else
        error_content="\t[error] URL для скачивания Xkeen не найден\n"
    fi

    local filename
    filename=$(basename "$download_url")
	
    if [ -e "$tmp_dir/$filename" ]; then
        if [ -s "$tmp_dir/$filename" ]; then
            local version_info
            version_info=$(echo "$filename" | grep -o 'xkeen_v[0-9.]\+')

            if [ -n "$version_info" ]; then
                result_content="\t[result] Xkeen версии $version_info успешно загружен\n"
            else
                result_content="\t[result] Xkeen успешно загружен\n"
            fi
        else
            error_content="\t[error] Загрузка Xkeen не удалась. Некорректная ссылка\n"
        fi
    else
        error_content="\t[error] Загрузка Xkeen не удалась. Архив не найден\n"
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
        echo -e "$info_content$result_content" >> "$xkeen_info_log"
        echo "[end] Загрузка Xkeen выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}


logs_choose_geoip_info_xkeen() {
    local info_content=""

    local has_missing_geoip_bases=false
    local has_updatable_geoip_bases=false
    [ "$geo_exists_geoip_antifilter" != "installed" ] && has_missing_geoip_bases=true
    [ "$geo_exists_geoip_v2fly" != "installed" ] && has_missing_geoip_bases=true
    [ "$geo_exists_geoip_antifilter" = "installed" ] || [ "$geo_exists_geoip_v2fly" = "installed" ] && has_updatable_geoip_bases=true

    if [ "$has_missing_geoip_bases" = true ]; then
        info_content="\n	[info] Отсутствующие geoip: "
        [ "$geo_exists_geoip_antifilter" != "installed" ] && info_content="${info_content}${yellow}antifilter${reset}, "
        [ "$geo_exists_geoip_v2fly" != "installed" ] && info_content="${info_content}${yellow}v2fly${reset}, "
        info_content="${info_content%, }"
        info_content="${info_content}\n"
    fi

    if [ "$has_updatable_geoip_bases" = true ]; then
        info_content="\n	[info] Возможные обновления geoip: "
        [ "$geo_exists_geoip_antifilter" = "installed" ] && info_content="${info_content}${yellow}antifilter${reset}, "
        [ "$geo_exists_geoip_v2fly" = "installed" ] && info_content="${info_content}${yellow}v2fly${reset}, "
        info_content="${info_content%, }"
        info_content="${info_content}\n"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Выбор geoip" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Выбор geoip выполнен" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi
}

logs_choose_geodata_info_xkeen() {
    local info_content=""

    local has_missing_geodata_bases=false
    local has_updatable_geodata_bases=false
    [ "$geo_exists_geodata_v2fly" != "installed" ] && has_missing_geodata_bases=true
    [ "$geo_exists_geodata_antifilter" != "installed" ] && has_missing_geodata_bases=true
    [ "$geo_exists_geodata_antizapret" != "installed" ] && has_missing_geodata_bases=true
    [ "$geo_exists_geodata_v2fly" = "installed" ] || [ "$geo_exists_geodata_antifilter" = "installed" ] || [ "$geo_exists_geodata_antizapret" = "installed" ] && has_updatable_geodata_bases=true

    if [ "$has_missing_geodata_bases" = true ]; then
        info_content="\n	[info] Отсутствующие geodata: "
        [ "$geo_exists_geodata_v2fly" != "installed" ] && info_content="${info_content}${yellow}v2fly${reset}, "
        [ "$geo_exists_geodata_antifilter" != "installed" ] && info_content="${info_content}${yellow}antifilter${reset}, "
        [ "$geo_exists_geodata_antizapret" != "installed" ] && info_content="${info_content}${yellow}antizapret${reset}, "
        info_content="${info_content%, }"
        info_content="${info_content}\n"
    fi

    if [ "$has_updatable_geodata_bases" = true ]; then
        info_content="\n	[info] Возможные обновления geodata: "
        [ "$geo_exists_geodata_v2fly" = "installed" ] && info_content="${info_content}${yellow}v2fly${reset}, "
        [ "$geo_exists_geodata_antifilter" = "installed" ] && info_content="${info_content}${yellow}antifilter${reset}, "
        [ "$geo_exists_geodata_antizapret" = "installed" ] && info_content="${info_content}${yellow}antizapret${reset}, "
        info_content="${info_content%, }"
        info_content="${info_content}\n"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Выбор geodata" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Выбор geodata выполнен" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi
}

logs_install_geoip_info_xkeen() {
    local info_content=""
    local error_content=""
    local result_content=""

    if [ "$install_antifilter_geoip" = true ]; then
        if [ -f "$geo_dir/geoip_antifilter.dat" ]; then
            info_content="${info_content}\t[info] GeoIP база AntiFilter установлена\n"
        else
            error_content="${error_content}\t[error] Не удалось установить GeoIP базу AntiFilter\n"
        fi
    fi

    if [ "$install_v2fly_geoip" = true ]; then
        if [ -f "$geo_dir/geoip_v2fly.dat" ]; then
            info_content="${info_content}\t[info] GeoIP база v2fly установлена\n"
        else
            error_content="${error_content}\t[error] Не удалось установить GeoIP базу v2fly\n"
        fi
    fi

    if [ "$update_antifilter_geoip" = true ]; then
        if [ -f "$geo_dir/geoip_antifilter.dat" ]; then
            info_content="${info_content}\t[info] GeoIP база AntiFilter обновлена\n"
        else
            error_content="${error_content}\t[error] GeoIP база AntiFilter  не установлена. Поэтому не может быть обновлена\n"
        fi
    fi

    if [ "$update_v2fly_geoip" = true ]; then
        if [ -f "$geo_dir/geoip_v2fly.dat" ]; then
            info_content="${info_content}\t[info] GeoIP база v2fly обновлена\n"
        else
            error_content="${error_content}\t[error] GeoIP база v2fly не установлена. Поэтому не может быть обновлена\n"
        fi
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Установка/обновление GeoIP баз" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Установка/обновление GeoIP баз выполнена" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Установка/обновление GeoIP баз" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Установка/обновление GeoIP баз выполнена" >> "$xkeen_error_log"
		echo "" >> "$xkeen_error_log"
    fi
}

logs_install_geodata_info_xkeen() {
    local info_content=""
    local error_content=""
    local result_content=""

    if [ "$install_v2fly_geodata" = true ]; then
        if [ -f "$geo_dir/geodata_v2fly.dat" ]; then
            info_content="${info_content}\t[info] GeoData база v2fly установлена\n"
        else
            error_content="${error_content}\t[error] GeoData база v2fly не установлена\n"
        fi
    fi

    if [ "$install_antifilter_geodata" = true ]; then
        if [ -f "$geo_dir/geodata_antifilter.dat" ]; then
            info_content="${info_content}\t[info] GeoData база AntiFilter установлена\n"
        else
            error_content="${error_content}\t[error] GeoData база AntiFilter не установлена\n"
        fi
    fi

    if [ "$install_antizapret_geodata" = true ]; then
        if [ -f "$geo_dir/geodata_antizapret.dat" ]; then
            info_content="${info_content}\t[info] GeoData база AntiZapret установлена\n"
        else
            error_content="${error_content}\t[error] GeoData база AntiZapret не установлена\n"
        fi
    fi

    if [ "$update_v2fly_geodata" = true ]; then
        if [ -f "$geo_dir/geodata_v2fly.dat" ]; then
            info_content="${info_content}\t[info] GeoData база v2fly обновлена\n"
        else
            error_content="${error_content}\t[error] GeoData база v2fly не установлена. Поэтому не может быть обновлена\n"
        fi
    fi

    if [ "$update_antifilter_geodata" = true ]; then
        if [ -f "$geo_dir/geodata_antifilter.dat" ]; then
            info_content="${info_content}\t[info] GeoData база AntiFilter обновлена\n"
        else
            error_content="${error_content}\t[error] GeoData база AntiFilter не установлена. Поэтому не может быть обновлена\n"
        fi
    fi

    if [ "$update_antizapret_geodata" = true ]; then
        if [ -f "$geo_dir/geodata_antizapret.dat" ]; then
            info_content="${info_content}\t[info] GeoData база AntiZapret обновлена\n"
        else
            error_content="${error_content}\t[error] GeoData база AntiZapret не установлена. Поэтому не может быть обновлена\n"
        fi
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Установка/обновление GeoData баз" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Установка/обновление GeoData баз выполнена" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Установка/обновление GeoData баз" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Установка/обновление GeoData баз выполнена" >> "$xkeen_error_log"
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
            info_content="\t[info] Выбрана опция замены следующих файлов:\n"
            for filename in $files_to_replace; do
                info_content="$info_content\t\t$filename\n"
            done
        fi

        if [ ! -z "$input_concordance_result" ]; then
            if [ "$input_concordance_result" = true ]; then
                info_content="$info_content\t[info] Пользователь согласился заменить файлы конфигурации\n"
            else
                info_content="$info_content\t[info] Пользователь отказался заменить файлы конфигурации\n"
            fi
        fi
    else
        error_content="\t[error] Директория $xkeen_conf_dir не найдена\n"
    fi

    if [ -n "$error_content" ] || [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Установка файлов конфигурации" >> "$xkeen_info_log"
        if [ -n "$error_content" ]; then
            echo -e "$error_content" >> "$xkeen_error_log"
        fi
        if [ -n "$info_content" ]; then
            echo -e "$info_content" >> "$xkeen_info_log"
        fi
        echo "[end] Установка файлов конфигурации завершена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}

logs_choose_update_cron_info_xkeen() {
    local info_content=""

    local has_missing_cron_tasks=false
    local has_updatable_cron_tasks=false

    [ "$info_update_xkeen_cron" != "installed" ] && has_missing_cron_tasks=true
    [ "$info_update_xray_cron" != "installed" ] && has_missing_cron_tasks=true
    [ "$info_update_geodata_cron" != "installed" ] && has_missing_cron_tasks=true
    [ "$info_update_geoip_cron" != "installed" ] && has_missing_cron_tasks=true

    [ "$info_update_xkeen_cron" = "installed" ] || [ "$info_update_xray_cron" = "installed" ] || [ "$info_update_geodata_cron" = "installed" ] || [ "$info_update_geoip_cron" = "installed" ] && has_updatable_cron_tasks=true

    if [ "$has_missing_cron_tasks" = true ]; then
        info_content="${info_content}\n\t[info] Будут включены отсутствующие задачи автоматического обновления:\n"
        [ "$info_update_xkeen_cron" != "installed" ] && info_content="${info_content}\t\t- xkeen\n"
        [ "$info_update_xray_cron" != "installed" ] && info_content="${info_content}\t\t- xray\n"
        [ "$info_update_geodata_cron" != "installed" ] && info_content="${info_content}\t\t- geodata\n"
        [ "$info_update_geoip_cron" != "installed" ] && info_content="${info_content}\t\t- geoip\n"
    fi

    if [ "$has_updatable_cron_tasks" = true ]; then
        info_content="${info_content}\n\t[info] Будут обновлены следующие задачи автоматического обновления:\n"
        [ "$info_update_xkeen_cron" = "installed" ] && info_content="${info_content}\t\t- xkeen\n"
        [ "$info_update_xray_cron" = "installed" ] && info_content="${info_content}\t\t- xray\n"
        [ "$info_update_geodata_cron" = "installed" ] && info_content="${info_content}\t\t- geodata\n"
        [ "$info_update_geoip_cron" = "installed" ] && info_content="${info_content}\t\t- geoip\n"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Определение статуса задач автоматического обновления" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Определение статуса задач автоматического обновления выполнено" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi
}

logs_choose_cron_time_info_xkeen() {
    local info_content=""
    local result_content=""

    for task in xkeen xray geodata geoip all; do
        task_var="chose_${task}_cron_select"
        time_var="chose_${task}_cron_time"

        if [ "$(eval echo \${$task_var})" = true ]; then
            if [ "$task" = "all" ]; then
                result_content="${result_content}\n[info] Выбранное время автоматического обновления для всех задач:"
            else
                result_content="${result_content}\n[info] Выбранное время автоматического обновления для $task:"
            fi

            cron_expression=$(eval echo \${$time_var})
            result_content="${result_content}\n$task в $cron_expression"
        fi
    done

    if [ -n "$result_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Определение времени для задач cron" >> "$xkeen_info_log"
        echo -e "$result_content" >> "$xkeen_info_log"
        echo "[end] Определение времени для задач cron выполнено" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi
}

logs_install_cron_info_xkeen() {
    local info_content=""
    local error_content=""
    
    cron_file_path="$cron_dir/$cron_file"
    
    if [ -f "$cron_file_path" ]; then
        if [ -n "$chose_all_cron_time" ]; then
            if grep -q "$xkeen_dir/xkeen.*-ugic" "$cron_file_path"; then
                info_content="$info_content\t[info] Добавлена запись для задачи автоматического обновления GeoIP:\n"
                info_content="$info_content$cron_entry\n"
            else
                error_content="$error_content\t[error] Запись для задачи автоматического обновления GeoIP не была добавлена в cron\n"
            fi
        fi

        if [ -n "$chose_geoip_cron_time" ]; then
            if grep -q "$xkeen_dir/xkeen.*-ugic" "$cron_file_path"; then
                info_content="$info_content\t[info] Добавлена запись для задачи автоматического обновления GeoIP:\n"
                info_content="$info_content$cron_entry\n"
            else
                error_content="$error_content\t[error] Запись для задачи автоматического обновления GeoIP не была добавлена в cron\n"
            fi
        fi

        if [ -n "$chose_geodata_cron_time" ]; then
            if grep -q "$xkeen_dir/xkeen.*-ugdc" "$cron_file_path"; then
                info_content="$info_content\t[info] Добавлена запись для задачи автоматического обновления GeoData:\n"
                info_content="$info_content$cron_entry\n"
            else
                error_content="$error_content\t[error] Запись для задачи автоматического обновления GeoData не была добавлена в cron\n"
            fi
        fi

        if [ -n "$chose_xkeen_cron_time" ]; then
            if grep -q "$xkeen_dir/xkeen.*-ukc" "$cron_file_path"; then
                info_content="$info_content\t[info] Добавлена запись для задачи автоматического обновления xkeen:\n"
                info_content="$info_content$cron_entry\n"
            else
                error_content="$error_content\t[error] Запись для задачи автоматического обновления xkeen не была добавлена в cron\n"
            fi
        fi

        if [ -n "$chose_xray_cron_time" ]; then
            if grep -q "$xkeen_dir/xkeen.*-uxc" "$cron_file_path"; then
                info_content="$info_content\t[info] Добавлена запись для задачи автоматического обновления xray:\n"
                info_content="$info_content$cron_entry\n"
            else
                error_content="$error_content\t[error] Запись для задачи автоматического обновления xray не была добавлена в cron\n"
            fi
        fi
    else
        error_content="$error_content\t[error] Файл cron не найден\n"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Установка записей в cron" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Установка записей в cron завершилась с ошибками" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Установка записей в cron" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Установка записей в cron выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}


logs_delete_geoip_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ "$chose_delete_geoip_v2fly_select" == "true" ]; then
        if [ -f "$geo_dir/geoip_v2fly.dat" ]; then
            info_content="\n	[info] Файл geoip_v2fly.dat удален\n"
        else
            error_content="\n	[error] Файл geoip_v2fly.dat не найден\n"
        fi
    fi

    if [ "$chose_delete_geoip_antifilter_select" == "true" ]; then
        if [ -f "$geo_dir/geoip_antifilter.dat" ]; then
            info_content="\t[info] Файл geoip_antifilter.dat удален\n"
        else
            error_content="\t[error] Файл geoip_antifilter.dat не найден\n"
        fi
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Удаление файлов GeoIP" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Удаление файлов GeoIP выполнено" >> "$xkeen_error_log"
		echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Удаление файлов GeoIP" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Удаление файлов GeoIP выполнено" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi
}

logs_delete_geoip_key_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ -f "$geo_dir/geoip_antifilter.dat" ]; then
        info_content="\t[info] Файл geoip_antifilter.dat удален\n"
    else
        error_content="\t[error] Файл geoip_antifilter.dat не найден\n"
    fi

    if [ -f "$geo_dir/geoip_v2fly.dat" ]; then
        info_content="\t[info] Файл geoip_v2fly.dat удален\n"
    else
        error_content="\t[error] Файл geoip_v2fly.dat не найден\n"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Удаление файлов GeoIP" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Удаление файлов GeoIP выполнено" >> "$xkeen_error_log"
		echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Удаление файлов GeoIP" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Удаление файлов GeoIP выполнено" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi
}

logs_delete_geodata_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ "$chose_delete_geodata_antifilter_select" == "true" ]; then
        if [ -f "$geo_dir/geodata_antifilter.dat" ]; then
            info_content="\n\t[info] Файл geodata_antifilter.dat удален\n"
        else
            error_content="\n\t[error] Файл geodata_antifilter.dat не найден\n"
        fi
    fi

    if [ "$chose_delete_geodata_antizapret_select" == "true" ]; then
        if [ -f "$geo_dir/geodata_antizapret.dat" ]; then
            info_content="${info_content}\t[info] Файл geodata_antizapret.dat удален\n"
        else
            error_content="${error_content}\t[error] Файл geodata_antizapret.dat не найден\n"
        fi
    fi

    if [ "$chose_delete_geodata_v2fly_select" == "true" ]; then
        if [ -f "$geo_dir/geodata_v2fly.dat" ]; then
            info_content="${info_content}\t[info] Файл geodata_v2fly.dat удален\n"
        else
            error_content="${error_content}\t[error] Файл geodata_v2fly.dat не найден\n"
        fi
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Удаление файлов GeoData" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Удаление файлов GeoData выполнено" >> "$xkeen_error_log"
		echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Удаление файлов GeoData" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Удаление файлов GeoData выполнено" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi
}

logs_delete_geodata_key_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ -f "$geo_dir/geodata_antifilter.dat" ]; then
        info_content="${info_content}\t[info] Файл geodata_antifilter.dat удален\n"
    else
        error_content="${error_content}\t[error] Файл geodata_antifilter.dat не найден\n"
    fi

    if [ -f "$geo_dir/geodata_antizapret.dat" ]; then
        info_content="${info_content}\t[info] Файл geodata_antizapret.dat удален\n"
    else
        error_content="${error_content}\t[error] Файл geodata_antizapret.dat не найден\n"
    fi

    if [ -f "$geo_dir/geodata_v2fly.dat" ]; then
        info_content="${info_content}\t[info] Файл geodata_v2fly.dat удален\n"
    else
        error_content="${error_content}\t[error] Файл geodata_v2fly.dat не найден\n"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Удаление файлов GeoData" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Удаление файлов GeoData выполнено" >> "$xkeen_error_log"
		echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Удаление файлов GeoData" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Удаление файлов GeoData выполнено" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi
}

logs_delete_cron_task_info_xkeen() {
    local info_content=""
    
    if [ -f "$cron_dir/$cron_file" ]; then
        if [ "$chose_all_cron_select" = true ] || [ "$chose_delete_all_cron_select" = true ]; then
            grep -q "ugic\|ugdc\|uxc\|ukc" "$cron_dir/$cron_file"
            if [ $? -eq 1 ]; then
                info_content="\t[info] Все задачи автоматического обновления удалены из cron\n"
            fi
        else
            if [ "$chose_xkeen_cron_select" = true ]; then
                logs_delete_cron_xkeen_info_xkeen
            fi
            
            if [ "$chose_xray_cron_select" = true ]; then
                logs_delete_cron_xray_info_xkeen
            fi
            
            if [ "$chose_geodata_cron_select" = true ]; then
                logs_delete_cron_geodata_info_xkeen
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
            info_content="\t[info] Задача автоматического обновления для Xkeen удалена из cron\n"
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
            info_content="\t[info] Задача автоматического обновления для Xray удалена из cron\n"
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

logs_delete_cron_geodata_info_xkeen() {
    local info_content=""
    
    if [ -f "$cron_dir/$cron_file" ]; then
        grep -q "ugdc" "$cron_dir/$cron_file"
        if [ $? -eq 1 ]; then
            info_content="\t[info] Задача автоматического обновления для GeoData удалена из cron\n"
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
            info_content="\t[info] Задача автоматического обновления для GeoIP удалена из cron\n"
        fi
        
        if [ -n "$info_content" ]; then
            echo "" >> "$xkeen_info_log"
            echo "[start] Удаление задачи автоматического обновления для GeoIP из cron" >> "$xkeen_info_log"
            echo -e "$info_content" >> "$xkeen_info_log"
            echo "[end] УУдаление задачи автоматического обновления для GeoIP из cron выполнено" >> "$xkeen_info_log"
            echo "" >> "$xkeen_info_log"
        fi
    fi
}

logs_delete_configs_info_xkeen() {
    local info_content=""
    local error_content=""
    
   local deleted_files=$(find "$install_conf_dir" -name "*.json" -type f)
    
    if [ -n "$deleted_files" ]; then
        info_content="\n\t[info] Все конфигурационные файлы Xray успешно удалены\n"
    else
		error_content="\n\t[error] Не удалены следующие конфигурационные файлы:\n"
        error_content="${error_content}$deleted_files\n"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Удаление конфигурационных файлов Xray" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Удаление конфигурационных файлов Xray выполнено" >> "$xkeen_error_log"
		echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Удаление конфигурационных файлов Xray" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Удаление конфигурационных файлов Xray выполнено" >> "$xkeen_info_log"
		echo "" >> "$xkeen_info_log"
    fi
}

logs_register_xray_control_info_xkeen() {
    local info_content=""
    local error_content=""
    
    control_file_path="$register_dir/xray.control"
    
    if [ -f "$control_file_path" ]; then
        info_content="$info_content\t[info] Файл xray.control успешно создан\n"
    else
        error_content="$error_content\t[error] Не удалось создать файл xray.control\n"
    fi
    
    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Создание файла xray.control" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Создание файла xray.control завершилось с ошибками" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Создание файла xray.control" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Создание файла xray.control выполнено" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}

logs_register_xray_list_info_xkeen() {
    local info_content=""
    local error_content=""
    
    cd "$register_dir/" || exit

    if [ ! -f "xray.list" ]; then
        error_content="$error_content\t[error] Файл Xray.list не был создан\n"
    else
        info_content="$info_content\t[info] Файл Xray.list успешно создан\n"
    fi

    if [ ! -f "/opt/sbin/xray" ]; then
        error_content="$error_content\t[error] Файл Xray не найден\n"
    else
        info_content="$info_content\t[info] Файл Xray установлен и зарегистрирован\n"
    fi

    if [ ! -f "/opt/etc/dat/geodata_antifilter.dat" ]; then
        error_content="$error_content\t[error] Файл geodata_antifilter.dat не найден\n"
    else
        info_content="$info_content\t[info] Файл geodata_antifilter.dat установлен и зарегистрирован\n"
    fi

    if [ ! -f "/opt/etc/dat/geodata_antizapret.dat" ]; then
        error_content="$error_content\t[error] Файл geodata_antizapret.dat не найден\n"
    else
        info_content="$info_content\t[info] Файл geodata_antizapret.dat установлен и зарегистрирован\n"
    fi

    if [ ! -f "/opt/etc/dat/geodata_v2ray.dat" ]; then
        error_content="$error_content\t[error] Файл geodata_v2ray.dat не найден\n"
    else
        info_content="$info_content\t[info] Файл geodata_v2ray.dat установлен и зарегистрирован\n"
    fi

    if [ ! -f "/opt/etc/dat/geoip_antifilter.dat" ]; then
        error_content="$error_content\t[error] Файл geoip_antifilter.dat не найден\n"
    else
        info_content="$info_content\t[info] Файл geoip_antifilter.dat установлен и зарегистрирован\n"
    fi

    if [ ! -f "/opt/etc/dat/geoip_v2ray.dat" ]; then
        error_content="$error_content\t[error] Файл geoip_v2ray.dat не найден\n"
    else
        info_content="$info_content\t[info] Файл geoip_v2ray.dat установлен и зарегистрирован\n"
    fi

    if [ ! -d "/opt/etc/configs" ]; then
        error_content="$error_content\t[error] Директория /opt/etc/configs не найдена\n"
    else
        info_content="$info_content\t[info] Директория /opt/etc/configs найдена\n"
    fi
	
    if [ ! -f "/opt/etc/configs/00_base.json" ]; then
        error_content="$error_content\t[error] Файл 00_base.json не найден\n"
    else
        info_content="$info_content\t[info] Файл 00_base.json установлен и зарегистрирован\n"
    fi

    if [ ! -f "/opt/etc/configs/01_log.json" ]; then
        error_content="$error_content\t[error] Файл 01_log.json не найден\n"
    else
        info_content="$info_content\t[info] Файл 01_log.json установлен и зарегистрирован\n"
    fi
	
    if [ ! -f "/opt/etc/configs/02_stats.json" ]; then
        error_content="$error_content\t[error] Файл 02_stats.json не найден\n"
    else
        info_content="$info_content\t[info] Файл 02_stats.json установлен и зарегистрирован\n"
    fi
	
	if [ ! -f "/opt/etc/configs/03_dns.json" ]; then
        error_content="$error_content\t[error] Файл 03_dns.json не найден\n"
    else
        info_content="$info_content\t[info] Файл 03_dns.json установлен и зарегистрирован\n"
    fi
	
	if [ ! -f "/opt/etc/configs/04_reverse.json" ]; then
        error_content="$error_content\t[error] Файл 04_reverse.json не найден\n"
    else
        info_content="$info_content\t[info] Файл 04_reverse.json установлен и зарегистрирован\n"
    fi
	
	if [ ! -f "/opt/etc/configs/05_fake-dns.json" ]; then
        error_content="$error_content\t[error] Файл 05_fake-dns.json не найден\n"
    else
        info_content="$info_content\t[info] Файл 05_fake-dns.json установлен и зарегистрирован\n"
    fi
	
	if [ ! -f "/opt/etc/configs/06_transport.json" ]; then
        error_content="$error_content\t[error] Файл 06_transport.json не найден\n"
    else
        info_content="$info_content\t[info] Файл 06_transport.json установлен и зарегистрирован\n"
    fi
	
	if [ ! -f "/opt/etc/configs/07_inbounds.json" ]; then
        error_content="$error_content\t[error] Файл 07_inbounds.json не найден\n"
    else
        info_content="$info_content\t[info] Файл 07_inbounds.json установлен и зарегистрирован\n"
    fi
	
	if [ ! -f "/opt/etc/configs/08_outbounds.json" ]; then
        error_content="$error_content\t[error] Файл 08_outbounds.json не найден\n"
    else
        info_content="$info_content\t[info] Файл 08_outbounds.json установлен и зарегистрирован\n"
    fi
	
	if [ ! -f "/opt/etc/configs/09_policy.json" ]; then
        error_content="$error_content\t[error] Файл 09_policy.json не найден\n"
    else
        info_content="$info_content\t[info] Файл 09_policy.json установлен и зарегистрирован\n"
    fi
	
	if [ ! -f "/opt/etc/configs/10_routing.json" ]; then
        error_content="$error_content\t[error] Файл 10_routing.json не найден\n"
    else
        info_content="$info_content\t[info] Файл 10_routing.json установлен и зарегистрирован\n"
    fi

    if [ ! -d "/opt/etc/xray" ]; then
        error_content="$error_content\t[error] Директория /opt/etc/xray не найдена\n"
    else
        info_content="$info_content\t[info] Директория /opt/etc/xray найдена\n"
    fi

    if [ ! -d "/opt/etc/init.d" ]; then
        error_content="$error_content\t[error] Директория /opt/etc/init.d не найдена\n"
    else
        info_content="$info_content\t[info] Директория /opt/etc/init.d найдена\n"
    fi
	
	if [ ! -f "/opt/etc/init.d/s24xray" ]; then
        error_content="$error_content\t[error] Файл автоматического запуска init.d не найден\n"
    else
        info_content="$info_content\t[info] Файл автоматического запуска init.d найден и зарегистрирован\n"
    fi

    if [ ! -d "/opt/var/log/xray" ]; then
        error_content="$error_content\t[error] Директория /opt/var/log/xray не найдена\n"
    else
        info_content="$info_content\t[info] Директория /opt/var/log/xray найдена\n"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Регистрация файлов xray" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Регистрация файлов xray завершилась с ошибками" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Регистрация файлов xray" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Регистрация файлов xray выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}

logs_register_xray_status_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ -n "$existing_content" ]; then
        info_content="\n[info] Регистрация статуса xray выполнена успешно"
    else
        error_content="\n[error] Ошибка при регистрации статуса xray"
    fi
    
    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Регистрация статуса xray" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
        echo "[end] Регистрация статуса xray выполнена" >> "$xkeen_info_log"
    fi
    
    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Регистрация статуса xray" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
        echo "[end] Регистрация статуса xray завершилась с ошибками" >> "$xkeen_error_log"
    fi
}

logs_register_xray_initd_info_xkeen() {
    local info_content=""
    local error_content=""

    initd_file="$initd_dir/S24xray"

    if [ -f "$initd_file" ]; then
        info_content="\n[info] Файл init скрипта xray успешно создан или заменен"
    else
        error_content="\n[error] Ошибка при создании или замене файла init скрипта xray"
    fi
    
    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Создание или замена файла init скрипта xray" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
        echo "[end] Создание или замена файла init скрипта xray выполнено" >> "$xkeen_info_log"
    fi
    
    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Создание или замена файла init скрипта xray" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
        echo "[end] Создание или замена файла init скрипта xray завершилось с ошибками" >> "$xkeen_error_log"
    fi
}

logs_register_xkeen_list_info_xkeen() {
    local info_content=""
    local error_content=""
	
    cd "$register_dir/" || exit

    if [ ! -f "xkeen.list" ]; then
        error_content="$error_content\t[error] Файл xkeen.list не был создан\n"
    else
        info_content="$info_content\t[info] Файл xkeen.list успешно создан\n"
    fi

    if [ ! -f "/opt/sbin/xkeen" ]; then
        error_content="$error_content\t[error] Исполняемый файл xkeen не найден\n"
    else
        info_content="$info_content\t[info] Исполняемый файл xkeen найден и зарегистрирован\n"
    fi
	
	if [ ! -d "/opt/sbin/.xkeen" ]; then
        error_content="$error_content\t[error] Исполняемая директория .xkeen не найдена\n"
    else
        info_content="$info_content\t[info] Исполняемая директория .xkeen найдена и зарегистрирована\n"
    fi
	
    if [ ! -f "/opt/sbin/.xkeen/01_info/00_info_import.sh" ]; then
        error_content="$error_content\t[error] Исполняемый файл 00_info_import.sh модуля info не найден\n"
    else
        info_content="$info_content\t[info] Исполняемый файл 00_info_import.sh модуля info найден и зарегистрирован\n"
    fi
	
	if [ ! -f "/opt/sbin/.xkeen/01_info/01_info_variable.sh" ]; then
        error_content="$error_content\t[error] Исполняемый файл 01_info_variable.sh модуля info не найден\n"
    else
        info_content="$info_content\t[info] Исполняемый файл 01_info_variable.sh модуля info найден и зарегистрирован\n"
    fi
	
	if [ ! -f "/opt/sbin/.xkeen/01_info/02_info_packages.sh" ]; then
        error_content="$error_content\t[error] Исполняемый файл 02_info_packages.sh модуля info не найден\n"
    else
        info_content="$info_content\t[info] Исполняемый файл 02_info_packages.sh модуля info найден и зарегистрирован\n"
    fi
	
	if [ ! -f "/opt/sbin/.xkeen/01_info/03_info_cpu.sh" ]; then
        error_content="$error_content\t[error] Исполняемый файл 03_info_cpu.sh модуля info не найден\n"
    else
        info_content="$info_content\t[info] Исполняемый файл 03_info_cpu.sh модуля info найден и зарегистрирован\n"
    fi
	
	if [ ! -f "/opt/sbin/.xkeen/01_info/04_info_xray.sh" ]; then
        error_content="$error_content\t[error] Исполняемый файл 04_info_xray.sh модуля info не найден\n"
    else
        info_content="$info_content\t[info] Исполняемый файл 04_info_xray.sh модуля info найден и зарегистрирован\n"
    fi
	
	if [ ! -f "/opt/sbin/.xkeen/01_info/05_info_geodata.sh" ]; then
        error_content="$error_content\t[error] Исполняемый файл 05_info_geodata.sh модуля info не найден\n"
    else
        info_content="$info_content\t[info] Исполняемый файл 05_info_geodata.sh модуля info найден и зарегистрирован\n"
    fi
	
	if [ ! -f "/opt/sbin/.xkeen/01_info/06_info_geoip.sh" ]; then
        error_content="$error_content\t[error] Исполняемый файл 06_info_geoip.sh модуля info не найден\n"
    else
        info_content="$info_content\t[info] Исполняемый файл 06_info_geoip.sh модуля info найден и зарегистрирован\n"
    fi
	
	if [ ! -f "/opt/sbin/.xkeen/01_info/07_info_cron.sh" ]; then
        error_content="$error_content\t[error] Исполняемый файл 07_info_cron.sh модуля info не найден\n"
    else
        info_content="$info_content\t[info] Исполняемый файл 07_info_cron.sh модуля info найден и зарегистрирован\n"
    fi
	
	if [ ! -f "/opt/sbin/.xkeen/01_info/08_info_version/00_version_import.sh" ]; then
        error_content="$error_content\t[error] Исполняемый файл 00_version_import.sh модуля version не найден\n"
    else
        info_content="$info_content\t[info] Исполняемый файл 00_version_import.sh модуля version найден и зарегистрирован\n"
    fi
	
	if [ ! -f "/opt/sbin/.xkeen/01_info/08_info_version/01_version_xkeen.sh" ]; then
        error_content="$error_content\t[error] Исполняемый файл 01_version_xkeen.sh модуля version не найден\n"
    else
        info_content="$info_content\t[info] Исполняемый файл 01_version_xkeen.sh модуля version найден и зарегистрирован\n"
    fi
	
	if [ ! -f "/opt/sbin/.xkeen/01_info/08_info_version/02_version_xray.sh" ]; then
        error_content="$error_content\t[error] Исполняемый файл 02_version_xray.sh модуля version не найден\n"
    else
        info_content="$info_content\t[info] Исполняемый файл 02_version_xray.sh модуля version найден и зарегистрирован\n"
    fi

	if [ ! -d "/opt/sbin/.xkeen/01_info/08_info_version" ]; then
        error_content="$error_content\t[error] Директория модуля version не найдена\n"
    else
        info_content="$info_content\t[info] Директория модуля version найдена и зарегистрирована\n"
    fi
	
	if [ ! -f "/opt/sbin/.xkeen/01_info/09_info_compare/00_compare_import.sh" ]; then
        error_content="$error_content\t[error] Исполняемый файл 00_compare_import.sh модуля compare не найден\n"
    else
        info_content="$info_content\t[info] Исполняемый файл 00_compare_import.sh модуля compare найден и зарегистрирован\n"
    fi
	
	if [ ! -f "/opt/sbin/.xkeen/01_info/09_info_compare/01_compare_xkeen.sh" ]; then
        error_content="$error_content\t[error] Исполняемый файл 01_compare_xkeen.sh модуля compare не найден\n"
    else
        info_content="$info_content\t[info] Исполняемый файл 01_compare_xkeen.sh модуля compare найден и зарегистрирован\n"
    fi
	
	if [ ! -f "/opt/sbin/.xkeen/01_info/09_info_compare/02_compare_xray.sh" ]; then
        error_content="$error_content\t[error] Исполняемый файл 02_compare_xray.sh модуля compare не найден\n"
    else
        info_content="$info_content\t[info] Исполняемый файл 02_compare_xray.sh модуля compare найден и зарегистрирован\n"
    fi
	
	if [ ! -d "/opt/sbin/.xkeen/01_info/09_info_compare" ]; then
        error_content="$error_content\t[error] Директория модуля compare не найдена\n"
    else
        info_content="$info_content\t[info] Директория модуля compare найдена и зарегистрирована\n"
    fi
	
	if [ ! -d "/opt/sbin/.xkeen/01_info" ]; then
        error_content="$error_content\t[error] Директория модуля info не найдена\n"
    else
        info_content="$info_content\t[info] Директория модуля info найдена и зарегистрирована\n"
    fi
	
	if [ ! -f "/opt/sbin/.xkeen/02_install/00_install_import.sh" ]; then
    error_content="$error_content\t[error] Исполняемый файл 00_install_import.sh модуля install не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 00_install_import.sh модуля install найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/02_install/01_install_packages.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 01_install_packages.sh модуля install не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 01_install_packages.sh модуля install найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/02_install/02_install_xray.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 02_install_xray.sh модуля install не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 02_install_xray.sh модуля install найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/02_install/03_install_geodata.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 03_install_geodata.sh модуля install не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 03_install_geodata.sh модуля install найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/02_install/04_install_geoip.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 04_install_geoip.sh модуля install не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 04_install_geoip.sh модуля install найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/02_install/05_install_cron.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 05_install_cron.sh модуля install не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 05_install_cron.sh модуля install найден и зарегистрирован\n"
	fi
	
	if [ ! -f "/opt/sbin/.xkeen/02_install/06_install_register/00_register_import.sh" ]; then
    error_content="$error_content\t[error] Исполняемый файл 00_register_import.sh модуля install_register не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 00_register_import.sh модуля install_register найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/02_install/06_install_register/01_register_xray.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 01_register_xray.sh модуля install_register не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 01_register_xray.sh модуля install_register найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/02_install/06_install_register/02_register_xkeen.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 02_register_xkeen.sh модуля install_register не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 02_register_xkeen.sh модуля install_register найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/02_install/07_install_configs/00_configs_import.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 00_configs_import.sh модуля install_configs не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 00_configs_import.sh модуля install_configs найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/02_install/07_install_configs/01_configs_install.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 01_configs_install.sh модуля install_configs не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 01_configs_install.sh модуля install_configs найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/00_base.json" ]; then
		error_content="$error_content\t[error] Исполняемый файл 00_base.json модуля configs_dir не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 00_base.json модуля configs_dir найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/01_log.json" ]; then
		error_content="$error_content\t[error] Исполняемый файл 01_log.json модуля configs_dir не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 01_log.json модуля configs_dir найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/02_stats.json" ]; then
		error_content="$error_content\t[error] Исполняемый файл 02_stats.json модуля configs_dir не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 02_stats.json модуля configs_dir найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/03_dns.json" ]; then
		error_content="$error_content\t[error] Исполняемый файл 03_dns.json модуля configs_dir не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 03_dns.json модуля configs_dir найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/04_reverse.json" ]; then
		error_content="$error_content\t[error] Исполняемый файл 04_reverse.json модуля configs_dir не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 04_reverse.json модуля configs_dir найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/05_fake-dns.json" ]; then
		error_content="$error_content\t[error] Исполняемый файл 05_fake-dns.json модуля configs_dir не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 05_fake-dns.json модуля configs_dir найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/06_transport.json" ]; then
		error_content="$error_content\t[error] Исполняемый файл 06_transport.json модуля configs_dir не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 06_transport.json модуля configs_dir найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/07_inbounds.json" ]; then
		error_content="$error_content\t[error] Исполняемый файл 07_inbounds.json модуля configs_dir не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 07_inbounds.json модуля configs_dir найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/08_outbounds.json" ]; then
		error_content="$error_content\t[error] Исполняемый файл 08_outbounds.json модуля configs_dir не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 08_outbounds.json модуля configs_dir найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/09_policy.json" ]; then
		error_content="$error_content\t[error] Исполняемый файл 09_policy.json модуля configs_dir не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 09_policy.json модуля configs_dir найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir/10_routing.json" ]; then
		error_content="$error_content\t[error] Исполняемый файл 10_routing.json модуля configs_dir не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 10_routing.json модуля configs_dir найден и зарегистрирован\n"
	fi

	if [ ! -d "/opt/sbin/.xkeen/02_install/06_install_register" ]; then
		error_content="$error_content\t[error] Директория 06_install_register не найдена\n"
	else
		info_content="$info_content\t[info] Директория 06_install_register найдена и зарегистрирована\n"
	fi

	if [ ! -d "/opt/sbin/.xkeen/02_install/07_install_configs/02_configs_dir" ]; then
		error_content="$error_content\t[error] Директория 02_configs_dir не найдена\n"
	else
		info_content="$info_content\t[info] Директория 02_configs_dir найдена и зарегистрирована\n"
	fi

	if [ ! -d "/opt/sbin/.xkeen/02_install/07_install_configs" ]; then
		error_content="$error_content\t[error] Директория 07_install_configs не найдена\n"
	else
		info_content="$info_content\t[info] Директория 07_install_configs найдена и зарегистрирована\n"
	fi

	if [ ! -d "/opt/sbin/.xkeen/02_install" ]; then
		error_content="$error_content\t[error] Директория 02_install не найдена\n"
	else
		info_content="$info_content\t[info] Директория 02_install найдена и зарегистрирована\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/03_delete/00_delete_import.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 00_delete_import.sh модуля delete не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 00_delete_import.sh модуля delete найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/03_delete/01_delete_geodata.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 01_delete_geodata.sh модуля delete не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 01_delete_geodata.sh модуля delete найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/03_delete/02_delete_geoip.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 02_delete_geoip.sh модуля delete не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 02_delete_geoip.sh модуля delete найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/03_delete/03_delete_cron.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 03_delete_cron.sh модуля delete не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 03_delete_cron.sh модуля delete найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/03_delete/04_delete_configs.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 04_delete_configs.sh модуля delete не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 04_delete_configs.sh модуля delete найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/03_delete/05_delete_register.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 05_delete_register.sh модуля delete не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 05_delete_register.sh модуля delete найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/03_delete/06_delete_tmp.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 06_delete_tmp.sh модуля delete не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 06_delete_tmp.sh модуля delete найден и зарегистрирован\n"
	fi

	if [ ! -d "/opt/sbin/.xkeen/03_delete" ]; then
		error_content="$error_content\t[error] Директория 03_delete не найдена\n"
	else
		info_content="$info_content\t[info] Директория 03_delete найдена и зарегистрирована\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/04_tools/01_tools_logs/00_logs_import.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 00_logs_import.sh модуля tools_logs не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 00_logs_import.sh модуля tools_logs найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/04_tools/01_tools_logs/01_logs_clear.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 01_logs_clear.sh модуля tools_logs не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 01_logs_clear.sh модуля tools_logs найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/04_tools/01_tools_logs/02_logs_console.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 02_logs_console.sh модуля tools_logs не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 02_logs_console.sh модуля tools_logs найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/04_tools/01_tools_logs/03_logs_xkeen.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 03_logs_xkeen.sh модуля tools_logs не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 03_logs_xkeen.sh модуля tools_logs найден и зарегистрирован\n"
	fi

	if [ ! -d "/opt/sbin/.xkeen/04_tools/01_tools_logs" ]; then
		error_content="$error_content\t[error] Директория 01_tools_logs не найдена\n"
	else
		info_content="$info_content\t[info] Директория 01_tools_logs найдена и зарегистрирована\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/04_tools/02_tools_choose/00_choose_import.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 00_choose_import.sh модуля tools_choose не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 00_choose_import.sh модуля tools_choose найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/04_tools/02_tools_choose/01_choose_input.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 01_choose_input.sh модуля tools_choose не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 01_choose_input.sh модуля tools_choose найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/04_tools/02_tools_choose/02_choose_geodata.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 02_choose_geodata.sh модуля tools_choose не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 02_choose_geodata.sh модуля tools_choose найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/04_tools/02_tools_choose/03_choose_geoip.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 03_choose_geoip.sh модуля tools_choose не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 03_choose_geoip.sh модуля tools_choose найден и зарегистрирован\n"
	fi

	if [ ! -d "/opt/sbin/.xkeen/04_tools/02_tools_choose/04_choose_cron" ]; then
		error_content="$error_content\t[error] Директория 04_choose_cron не найдена\n"
	else
		info_content="$info_content\t[info] Директория 04_choose_cron найдена и зарегистрирована\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/04_tools/02_tools_choose/04_choose_cron/00_cron_import.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 00_cron_import.sh модуля 04_choose_cron не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 00_cron_import.sh модуля 04_choose_cron найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/04_tools/02_tools_choose/04_choose_cron/01_cron_status.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 01_cron_status.sh модуля 04_choose_cron не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 01_cron_status.sh модуля 04_choose_cron найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/04_tools/02_tools_choose/04_choose_cron/02_cron_time.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 02_cron_time.sh модуля 04_choose_cron не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 02_cron_time.sh модуля 04_choose_cron найден и зарегистрирован\n"
	fi

	if [ ! -d "/opt/sbin/.xkeen/04_tools/02_tools_choose" ]; then
		error_content="$error_content\t[error] Директория 02_tools_choose не найдена\n"
	else
		info_content="$info_content\t[info] Директория 02_tools_choose найдена и зарегистрирована\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/04_tools/03_tools_backups/00_backups_import.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 00_backups_import.sh модуля tools_backups не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 00_backups_import.sh модуля tools_backups найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/04_tools/03_tools_backups/01_backups_xray.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 01_backups_xray.sh модуля tools_backups не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 01_backups_xray.sh модуля tools_backups найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/04_tools/03_tools_backups/02_backups_configs.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 02_backups_configs.sh модуля tools_backups не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 02_backups_configs.sh модуля tools_backups найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/04_tools/03_tools_backups/02_backups_xkeen.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 02_backups_xkeen.sh модуля tools_backups не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 02_backups_xkeen.sh модуля tools_backups найден и зарегистрирован\n"
	fi

	if [ ! -d "/opt/sbin/.xkeen/04_tools/03_tools_backups" ]; then
		error_content="$error_content\t[error] Директория 03_tools_backups не найдена\n"
	else
		info_content="$info_content\t[info] Директория 03_tools_backups найдена и зарегистрирована\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/04_tools/04_tools_downloaders/00_downloaders_import.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 00_downloaders_import.sh модуля tools_downloaders не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 00_downloaders_import.sh модуля tools_downloaders найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/04_tools/04_tools_downloaders/01_downloaders_xray.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 01_downloaders_xray.sh модуля tools_downloaders не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 01_downloaders_xray.sh модуля tools_downloaders найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/04_tools/04_tools_downloaders/02_donwloaders_xkeen.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 02_donwloaders_xkeen.sh модуля tools_downloaders не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 02_donwloaders_xkeen.sh модуля tools_downloaders найден и зарегистрирован\n"
	fi

	if [ ! -d "/opt/sbin/.xkeen/04_tools/04_tools_downloaders" ]; then
		error_content="$error_content\t[error] Директория 04_tools_downloaders не найдена\n"
	else
		info_content="$info_content\t[info] Директория 04_tools_downloaders найдена и зарегистрирована\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/04_tools/00_tools_import.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 00_tools_import.sh модуля tools не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 00_tools_import.sh модуля tools найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/04_tools/05_tools_cpu-keyword.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 05_tools_cpu-keyword.sh модуля tools не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 05_tools_cpu-keyword.sh модуля tools найден и зарегистрирован\n"
	fi

	if [ ! -d "/opt/sbin/.xkeen/04_tools" ]; then
		error_content="$error_content\t[error] Директория 04_tools не найдена\n"
	else
		info_content="$info_content\t[info] Директория 04_tools найдена и зарегистрирована\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/05_tests/00_tests_import.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 00_tests_import.sh модуля tests не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 00_tests_import.sh модуля tests найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/05_tests/01_tests_connected.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 01_tests_connected.sh модуля tests не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 01_tests_connected.sh модуля tests найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/05_tests/02_tests_ports.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 02_tests_ports.sh модуля tests не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 02_tests_ports.sh модуля tests найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/05_tests/03_tests_xports.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 03_tests_xports.sh модуля tests не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 03_tests_xports.sh модуля tests найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/05_tests/04_tests_users.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 04_tests_users.sh модуля tests не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 04_tests_users.sh модуля tests найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/05_tests/05_tests_temperature.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 05_tests_temperature.sh модуля tests не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 05_tests_temperature.sh модуля tests найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/05_tests/06_tests_speed.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 06_tests_speed.sh модуля tests не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 06_tests_speed.sh модуля tests найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/05_tests/07_tests_socks5.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 07_tests_socks5.sh модуля tests не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 07_tests_socks5.sh модуля tests найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/sbin/.xkeen/05_tests/08_tests_reality.sh" ]; then
		error_content="$error_content\t[error] Исполняемый файл 08_tests_reality.sh модуля tests не найден\n"
	else
		info_content="$info_content\t[info] Исполняемый файл 08_tests_reality.sh модуля tests найден и зарегистрирован\n"
	fi

	if [ ! -d "/opt/sbin/.xkeen/05_tests" ]; then
		error_content="$error_content\t[error] Директория 05_tests не найдена\n"
	else
		info_content="$info_content\t[info] Директория 05_tests найдена и зарегистрирована\n"
	fi

    if [ ! -d "/opt/sbin/.xkeen" ]; then
    error_content="$error_content\t[error] Директория .xkeen не найдена\n"
	else
		info_content="$info_content\t[info] Директория .xkeen найдена и зарегистрирована\n"
	fi

	if [ ! -f "/opt/var/log/xkeen/error.log" ]; then
		error_content="$error_content\t[error] Лог-файл error.log не найден\n"
	else
		info_content="$info_content\t[info] Лог-файл error.log найден и зарегистрирован\n"
	fi

	if [ ! -f "/opt/var/log/xkeen/info.log" ]; then
		error_content="$error_content\t[error] Лог-файл info.log не найден\n"
	else
		info_content="$info_content\t[info] Лог-файл info.log найден и зарегистрирован\n"
	fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Регистрация файлов xkeen" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Регистрация файлов xkeen завершилась с ошибками" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Регистрация файлов xkeen" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Регистрация файлов xkeen выполнена" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}


logs_register_xkeen_control_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ -f "$register_dir/xkeen.control" ]; then
        info_content="\n[info] Файл xkeen.control успешно создан"
    else
        error_content="\n[error] Ошибка при создании файла xkeen.control"
    fi
    
    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Создание файла xkeen.control" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
        echo "[end] Создание файла xkeen.control выполнено" >> "$xkeen_info_log"
    fi
    
    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Создание файла xkeen.control" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
        echo "[end] Создание файла xkeen.control завершилось с ошибками" >> "$xkeen_error_log"
    fi
}


logs_register_xkeen_status_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ -n "$existing_content" ]; then
        info_content="\n[info] Регистрация статуса xkeen выполнена успешно"
    else
        error_content="\n[error] Ошибка при регистрации статуса xkeen"
    fi
    
    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Регистрация статуса xkeen" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
        echo "[end] Регистрация статуса xkeen выполнена" >> "$xkeen_info_log"
    fi
    
    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Регистрация статуса xkeen" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
        echo "[end] Регистрация статуса xkeen завершилась с ошибками" >> "$xkeen_error_log"
    fi
}

logs_delete_configs_info_xkeen() {
    local info_content=""
    local error_content=""

    # Переход в папку install_conf_dir
    cd "$install_conf_dir/" || exit

    # Проверка наличия .json файлов
    if [ -n "$(find . -name "*.json" -type f)" ]; then
        error_content="$error_content\t[error] Некоторые .json файлы не были удалены\n"
    else
        info_content="$info_content\t[info] Все файлы .json успешно удалены\n"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Удаление файлов .json" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Удаление файлов .json завершилось с ошибками" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Удаление файлов .json" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Удаление файлов .json выполнено" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}

logs_delete_register_xray_info_xkeen() {
    local info_content=""
    local error_content=""

    cd "$register_dir/" || exit

    if [ ! -f "xray.list" ]; then
        info_content="$info_content\t[info] Файл xray.list успешно удален\n"
    else
        error_content="$error_content\t[error] Файл xray.list не удален\n"
    fi

    if [ ! -f "xray.control" ]; then
        info_content="$info_content\t[info] Файл xray.control успешно удален\n"
    else
        error_content="$error_content\t[error] Файл xray.control не удален\n"
    fi

    if ! grep -q 'package: xray' "/opt/lib/opkg/status"; then
        info_content="$info_content\t[info] Пакет xray успешно удален из status\n"
    else
        error_content="$error_content\t[error] Пакет xray не удалось удалить из status\n"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Удаление xray из реестра" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Удаление xray из реестра завершилось с ошибками" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Удаление xray из реестра" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Удаление xray из реестра выполнено" >> "$xkeen_info_log"
        echo "" >> "$xkeen_info_log"
    fi
}

logs_delete_register_xkeen_info_xkeen() {
    local info_content=""
    local error_content=""

    if [ ! -f "$register_dir/xkeen.list" ]; then
        info_content="$info_content\t[info] Файл xkeen.list успешно удален\n"
    else
        error_content="$error_content\t[error] Файл xkeen.list не удален\n"
    fi

    if [ ! -f "$register_dir/xkeen.control" ]; then
        info_content="$info_content\t[info] Файл xkeen.control успешно удален\n"
    else
        error_content="$error_content\t[error] Файл xkeen.control не удален\n"
    fi

    if ! grep -q 'package: xkeen' "/opt/lib/opkg/status"; then
        info_content="$info_content\t[info] Пакет xkeen успешно удален из status\n"
    else
        error_content="$error_content\t[error] Пакет xkeen не удалось удалить из status\n"
    fi

    if [ -n "$error_content" ]; then
        echo "" >> "$xkeen_error_log"
        echo "[start] Удаление xkeen из реестра" >> "$xkeen_error_log"
        echo -e "$error_content" >> "$xkeen_error_log"
        echo "[end] Удаление xkeen из реестра завершилось с ошибками" >> "$xkeen_error_log"
        echo "" >> "$xkeen_error_log"
    fi

    if [ -n "$info_content" ]; then
        echo "" >> "$xkeen_info_log"
        echo "[start] Удаление xkeen из реестра" >> "$xkeen_info_log"
        echo -e "$info_content" >> "$xkeen_info_log"
        echo "[end] Удаление xkeen из реестра выполнено" >> "$xkeen_info_log"
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
