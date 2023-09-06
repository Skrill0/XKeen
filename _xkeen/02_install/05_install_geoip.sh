# Функция для установки и обновления GeoIP
install_geoip() {
    # Установка GeoIP AntiFilter
    if [ "$install_antifilter_geoip" = true ]; then
        curl -L -o "$geo_dir/geoip_antifilter.dat" "https://github.com/schebotar/antifilter/releases/latest/download/geoip.dat" > /dev/null 2>&1
        if [ $? -eq 0 ] && [ -s "$geo_dir/geoip_antifilter.dat" ]; then
            echo -e "  GeoIP AntiFilter ${green}успешно установлен${reset}"
        else
            echo -e "  ${red}Неизвестная ошибка${reset} при установке GeoIP AntiFilter"
        fi
    fi

    # Установка GeoIP V2Fly
    if [ "$install_v2fly_geoip" = true ]; then
        curl -L -o "$geo_dir/geoip_v2fly.dat" "https://github.com/loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat" > /dev/null 2>&1
        if [ $? -eq 0 ] && [ -s "$geo_dir/geoip_v2fly.dat" ]; then
            echo -e "  GeoIP V2Fly ${green}успешно установлен${reset}"
        else
            echo -e "  ${red}Неизвестная ошибка${reset} при установке GeoIP V2Fly"
        fi
    fi

    # Обновление GeoIP AntiFilter, если установлены и требуется обновление
    if [ "$update_antifilter_geoip" = true ] && [ -f "$geo_dir/geoip_antifilter.dat" ]; then
        curl -L -o "$geo_dir/geoip_antifilter.dat" "https://github.com/schebotar/antifilter/releases/latest/download/geoip.dat" > /dev/null 2>&1
        if [ $? -eq 0 ] && [ -s "$geo_dir/geoip_antifilter.dat" ]; then
            echo -e "  GeoIP AntiFilter ${green}успешно обновлен${reset}"
        else
            echo -e "  ${red}Неизвестная ошибка${reset} при обновлении GeoIP AntiFilter"
        fi
    fi

    # Обновление GeoIP V2Fly, если установлены и требуется обновление
    if [ "$update_v2fly_geoip" = true ] && [ -f "$geo_dir/geoip_v2fly.dat" ]; then
        curl -L -o "$geo_dir/geoip_v2fly.dat" "https://github.com/loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat" > /dev/null 2>&1
        if [ $? -eq 0 ] && [ -s "$geo_dir/geoip_v2fly.dat" ]; then
            echo -e "  GeoIP V2Fly ${green}успешно обновлен${reset}"
        else
            echo -e "  ${red}Неизвестная ошибка${reset} при обновлении GeoIP V2Fly"
        fi
    fi
}
