logs_packages_info_xkeen() {
    local package_status_lscpu="[Info] Пакет lscpu не установлен"
    if [ "$INFO_PACKAGES_LSCPU" = "installed" ]; then
        package_status_lscpu="[Info] Пакет lscpu установлен"
    fi

    local package_status_curl="[Info] Пакет curl не установлен"
    if [ "$INFO_PACKAGES_CURL" = "installed" ]; then
        package_status_curl="[Info] Пакет curl установлен"
    fi

    local package_status_jq="[Info] Пакет jq не установлен"
    if [ "$INFO_PACKAGES_JQ" = "installed" ]; then
        package_status_jq="[Info] Пакет jq установлен"
    fi

    local package_status_libc="[Info] Пакет libc не установлен"
    if [ "$INFO_PACKAGES_LIBC" = "installed" ]; then
        package_status_libc="[Info] Пакет libc установлен"
    fi

    echo "" >> "$XKEEN_INFO_LOG"
    echo "[Start] Проверка наличия необходимых пакетов" >> "$XKEEN_INFO_LOG"
    echo "    $package_status_lscpu" >> "$XKEEN_INFO_LOG"
    echo "    $package_status_curl" >> "$XKEEN_INFO_LOG"
    echo "    $package_status_jq" >> "$XKEEN_INFO_LOG"
    echo "    $package_status_libc" >> "$XKEEN_INFO_LOG"
    echo "[End] Проверка наличия необходимых пакетов выполнена" >> "$XKEEN_INFO_LOG"
}


logs_cpu_xkeen() {
    echo "[Start] Проверка процессора" >> "$XKEEN_INFO_LOG"

	echo "	[Head] Процессор" >> "$XKEEN_INFO_LOG"
	
	if [ -n "$info_model" ]; then
		echo "		[Info] Модель: $info_model" >> "$XKEEN_INFO_LOG"
	else
		echo "		[Info] Модель: Не удалось определить" >> "$XKEEN_ERROR_LOG"
	fi
	
    if [ -n "$info_architecture" ]; then
		echo "		[Info] Архитектура: $info_architecture" >> "$XKEEN_INFO_LOG"
	else
		echo "		[Info] Архитектура: Не удалось определить" >> "$XKEEN_ERROR_LOG"
    fi
	
    if [ -z "$generated_keyword" ]; then
        echo "	[Result] Процессор не поддерживается xkeen" >> "$XKEEN_ERROR_LOG"
    else
        echo "	[Result] Процессор поддерживается xkeen" >> "$XKEEN_INFO_LOG"
    fi

echo "[End] Проверка процессора выполнена" >> "$XKEEN_INFO_LOG"
}


logs_cron_info_xkeen() {
    echo "" >> "$XKEEN_INFO_LOG"
    echo "[Start] Проверка наличия задач автоматического обновления в cron" >> "$XKEEN_INFO_LOG"
	
    if [ "$INFO_UPDATE_XRAY_CRON" = "installed" ]; then
        echo "	[Info] Задача update_xray_cron_silent установлена" >> "$XKEEN_INFO_LOG"
    else
        echo "	[Info] Задача update_xray_cron_silent не установлена" >> "$XKEEN_INFO_LOG"
    fi

    if [ "$INFO_UPDATE_XKEEN_CRON" = "installed" ]; then
        echo "	[Info] Задача update_xkeen_cron_silent установлена" >> "$XKEEN_INFO_LOG"
    else
        echo "	[Info] Задача update_xkeen_cron_silent не установлена" >> "$XKEEN_INFO_LOG"
    fi

    if [ "$INFO_UPDATE_GEO_CRON" = "installed" ]; then
        echo "	[Info] Задача update_geo_cron_silent установлена" >> "$XKEEN_INFO_LOG"
    else
        echo "	[Info] Задача update_geo_cron_silent не установлена" >> "$XKEEN_INFO_LOG"
    fi

    echo "[End] Проверка наличия задач автоматического обновления в cron выполнена" >> "$XKEEN_INFO_LOG"
}


logs_xray_info_xkeen() {
    echo "" >> "$XKEEN_INFO_LOG"
    echo "[Start] Проверка установки Xray" >> "$XKEEN_INFO_LOG"
    if [ "$XRAY_INSTALLED" = "installed" ]; then
        echo "	[Result] Xray установлен" >> "$XKEEN_INFO_LOG"
    fi
    if [ "$XRAY_INSTALLED" = "not_installed" ]; then
        echo "	[Result] Xray не установлен" >> "$XKEEN_INFO_LOG"
    fi
    echo "[End] Проверка установки Xray выполнена" >> "$XKEEN_INFO_LOG"
}


logs_geoip_info_xkeen() {
    echo "" >> "$XKEEN_INFO_LOG"
    echo "[Start] Проверка наличия баз данных GeoIP" >> "$XKEEN_INFO_LOG"

    if [ "$GEO_EXISTS_GEOIP_ANTIFILTER" = "installed" ] && \
       [ "$GEO_EXISTS_GEOIP_V2RAY" = "installed" ]; then
        echo "	[Info] Все базы GeoIP установлены" >> "$XKEEN_INFO_LOG"
    elif [ "$GEO_EXISTS_GEOIP_ANTIFILTER" = "not_installed" ] && \
         [ "$GEO_EXISTS_GEOIP_V2RAY" = "not_installed" ]; then
        echo "	[Info] Ни одна из баз данных GeoIP не установлена" >> "$XKEEN_INFO_LOG"
    else
        if [ "$GEO_EXISTS_GEOIP_ANTIFILTER" = "installed" ]; then
            echo "	[Info] База GeoIP AntiFilter установлена" >> "$XKEEN_INFO_LOG"
        else
            echo "	[Info] База GeoIP AntiFilter не установлена" >> "$XKEEN_INFO_LOG"
        fi

        if [ "$GEO_EXISTS_GEOIP_V2RAY" = "installed" ]; then
            echo "	[Info] База GeoIP v2ray установлена" >> "$XKEEN_INFO_LOG"
        else
            echo "	[Info] База GeoIP v2ray не установлена" >> "$XKEEN_INFO_LOG"
        fi
    fi

    echo "[End] Проверка наличия баз данных GeoIP выполнена" >> "$XKEEN_INFO_LOG"
}


logs_geodata_info_xkeen() {
    echo "" >> "$XKEEN_INFO_LOG"
    echo "[Start] Проверка наличия баз данных GeoData" >> "$XKEEN_INFO_LOG"

    if [ "$GEO_EXISTS_GEODATA_ANTIZAPRET" = "installed" ]; then
        echo "	[Info] База GeoData AntiZapret установлена" >> "$XKEEN_INFO_LOG"
    else
        echo "	[Info] База GeoData AntiZapret не установлена" >> "$XKEEN_INFO_LOG"
    fi

    if [ "$GEO_EXISTS_GEODATA_ANTIFILTER" = "installed" ]; then
        echo "	[Info] База GeoData AntiFilter установлена" >> "$XKEEN_INFO_LOG"
    else
        echo "	[Info] База GeoData AntiFilter не установлена" >> "$XKEEN_INFO_LOG"
    fi

    if [ "$GEO_EXISTS_GEODATA_V2RAY" = "installed" ]; then
        echo "	[Info] База GeoData v2ray установлена" >> "$XKEEN_INFO_LOG"
    else
        echo "	[Info] База GeoData v2ray не установлена" >> "$XKEEN_INFO_LOG"
    fi

    if [ "$GEO_EXISTS_GEODATA_ANTIZAPRET" = "not_installed" ] && \
       [ "$GEO_EXISTS_GEODATA_ANTIFILTER" = "not_installed" ] && \
       [ "$GEO_EXISTS_GEODATA_V2RAY" = "not_installed" ]; then
       echo "	[Result] Ни одна из баз данных GeoData не установлена" >> "$XKEEN_INFO_LOG"
    elif [ "$GEO_EXISTS_GEODATA_ANTIZAPRET" = "installed" ] && \
         [ "$GEO_EXISTS_GEODATA_ANTIFILTER" = "installed" ] && \
         [ "$GEO_EXISTS_GEODATA_V2RAY" = "installed" ]; then
       echo "	[Result] Все базы GeoData установлены" >> "$XKEEN_INFO_LOG"
    fi

    echo "[End] Проверка наличия баз данных GeoData выполнена" >> "$XKEEN_INFO_LOG"
}


logs_version_xkeen_info_xkeen() {
	echo "" >> "$XKEEN_INFO_LOG"
    echo "[Start] Проверка версии Xkeen" >> "$XKEEN_INFO_LOG"

    if [ -n "$XKEEN_CURRENT_VERSION" ]; then
        echo "	[Info] Текущая версия Xkeen: $XKEEN_CURRENT_VERSION" >> "$XKEEN_INFO_LOG"
    fi

    if [ -n "$XKEEN_GITHUB_VERSION" ]; then
        echo "	[Info] Последняя версия Xkeen на GitHub: $XKEEN_GITHUB_VERSION" >> "$XKEEN_INFO_LOG"
    fi

    if [ -z "$XKEEN_CURRENT_VERSION" ] && [ -z "$XKEEN_GITHUB_VERSION" ]; then
        echo "	[Info] Информация о версии Xkeen не доступна" >> "$XKEEN_INFO_LOG"
    fi

    echo "[End] Проверка версии Xkeen выполнена" >> "$XKEEN_INFO_LOG"
}


logs_compare_xkeen_info_xkeen() {
	echo "" >> "$XKEEN_INFO_LOG"
    echo "[Start] Сравнение версий Xkeen" >> "$XKEEN_INFO_LOG"

    if [ "$INFO_COMPARE_XKEEN" = "actual" ]; then
        echo "	[Info] Ваша версия $XKEEN_CURRENT_VERSION Xkeen актуальна" >> "$XKEEN_INFO_LOG"
    elif [ "$INFO_COMPARE_XKEEN" = "update" ]; then
        echo "	[Info] Ваша текущая версия Xkeen $XKEEN_CURRENT_VERSION." >> "$XKEEN_INFO_LOG"
		echo "	[Info] Доступно обновление на версию $XKEEN_GITHUB_VERSION" >> "$XKEEN_INFO_LOG"
    else
        echo "	[Info] Текущая версия Xkeen $XKEEN_CURRENT_VERSION новее доступной на GitHub $XKEEN_GITHUB_VERSION" >> "$XKEEN_INFO_LOG"
    fi

    echo "[End] Сравнение версий Xkeen выполнено" >> "$XKEEN_INFO_LOG"
}


logs_version_xray_info_xkeen() {
	echo "" >> "$XKEEN_INFO_LOG"
    echo "[Start] Проверка версии Xray" >> "$XKEEN_INFO_LOG"

    if [ "$XRAY_INSTALLED" = "installed" ]; then
        echo "	[Info] Текущая версия Xray: $XRAY_CURRENT_VERSION" >> "$XKEEN_INFO_LOG"
    fi

    if [ -n "$XRAY_GITHUB_VERSION" ]; then
        echo "	[Info] Последняя версия Xray на GitHub: $XRAY_GITHUB_VERSION" >> "$XKEEN_INFO_LOG"
    fi

    if [ "$XRAY_INSTALLED" = "not_installed" ] && [ -z "$XRAY_GITHUB_VERSION" ]; then
        echo "	[Info] Xray не установлен, и информация о последней версии не доступна" >> "$XKEEN_INFO_LOG"
    fi

    echo "[End] Проверка версии Xray выполнена" >> "$XKEEN_INFO_LOG"
}


logs_compare_xray_info_xkeen() {
	echo "" >> "$XKEEN_INFO_LOG"
    echo "[Start] Сравнение версий Xray" >> "$XKEEN_INFO_LOG"

    if [ "$XRAY_INSTALLED" = "not_installed" ]; then
        echo "	[Info] Xray $XRAY_GITHUB_VERSION доступен для установки" >> "$XKEEN_INFO_LOG"
		
    elif [ "$INFO_COMPARE_XRAY" = "actual" ]; then
        echo "	[Info] Ваша версия $XRAY_CURRENT_VERSION Xray актуальна" >> "$XKEEN_INFO_LOG"
		
    elif [ "$INFO_COMPARE_XRAY" = "update" ]; then
        echo "	[Info] Ваша текущая версия Xray $XRAY_CURRENT_VERSION." >> "$XKEEN_INFO_LOG"
		echo "	[Info] Доступно обновление на версию $XRAY_GITHUB_VERSION" >> "$XKEEN_INFO_LOG"
		
    else
        echo "	[Info] Текущая версия Xray $XRAY_CURRENT_VERSION новее доступной на GitHub $XRAY_GITHUB_VERSION" >> "$XKEEN_INFO_LOG"
    fi

    echo "[End] Сравнение версий Xray выполнено" >> "$XKEEN_INFO_LOG"
}


logs_packages_installed_xkeen() {
    local has_installed_packages=0

    if [ "$lscpu_STATUS" = "installed_xkeen" ] || \
       [ "$curl_STATUS" = "installed_xkeen" ] || \
       [ "$jq_STATUS" = "installed_xkeen" ] || \
       [ "$libc_STATUS" = "installed_xkeen" ]; then
        has_installed_packages=1
    fi

    if [ $has_installed_packages -eq 1 ]; then
        echo "" >> "$XKEEN_INFO_LOG"
        echo "[Start] Установка необходимых пакетов" >> "$XKEEN_INFO_LOG"

        if [ "$lscpu_STATUS" = "installed_xkeen" ]; then
            echo "[Info] Пакет lscpu установлен" >> "$XKEEN_INFO_LOG"
        fi

        if [ "$curl_STATUS" = "installed_xkeen" ]; then
            echo "[Info] Пакет curl установлен" >> "$XKEEN_INFO_LOG"
        fi

        if [ "$jq_STATUS" = "installed_xkeen" ]; then
            echo "[Info] Пакет jq установлен" >> "$XKEEN_INFO_LOG"
        fi

        if [ "$libc_STATUS" = "installed_xkeen" ]; then
            echo "[Info] Пакет libc установлен" >> "$XKEEN_INFO_LOG"
        fi

        echo "[End] Установка необходимых пакетов выполнена" >> "$XKEEN_INFO_LOG"
    fi
}