# Функция для установки и обновления GeoSite
install_geosite() {
    # Установка GeoSite V2Fly
    if [ "$install_v2fly_geosite" = true ]; then
        curl -L -o "$geo_dir/geosite_v2fly.dat" "https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat" > /dev/null 2>&1
        if [ $? -eq 0 ] && [ -s "$geo_dir/geosite_v2fly.dat" ]; then
            echo -e "  GeoSite V2Fly ${green}успешно установлен${reset}"
        else
            echo -e "  ${red}Неизвестная ошибка${reset} при установке GeoSite V2Fly"
        fi
    fi

    # Установка GeoSite AntiFilter
    if [ "$install_antifilter_geosite" = true ]; then
        curl -L -o "$geo_dir/geosite_antifilter.dat" "https://github.com/schebotar/antifilter-domain/releases/latest/download/geosite.dat" > /dev/null 2>&1
        if [ $? -eq 0 ] && [ -s "$geo_dir/geosite_antifilter.dat" ]; then
            echo -e "  GeoSite AntiFilter ${green}успешно установлен${reset}"
        else
            echo -e "  ${red}Неизвестная ошибка${reset} при установке GeoSite AntiFilter"
        fi
    fi

    # Установка GeoSite AntiZapret
    if [ "$install_antizapret_geosite" = true ]; then
        curl -L -o "$geo_dir/geosite_antizapret.dat" "https://github.com/warexify/antizapret-xray/releases/latest/download/antizapret.dat" > /dev/null 2>&1
        if [ $? -eq 0 ] && [ -s "$geo_dir/geosite_antizapret.dat" ]; then
            echo -e "  GeoSite AntiZapret ${green}успешно установлен${reset}"
        else
            echo -e "  ${red}Неизвестная ошибка${reset} при установке GeoSite AntiZapret"
        fi
    fi

    # Обновление GeoSite V2Fly, если установлены и требуется обновление
    if [ "$update_v2fly_geosite" = true ] && [ -f "$geo_dir/geosite_v2fly.dat" ]; then
        curl -L -o "$geo_dir/geosite_v2fly.dat" "https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat" > /dev/null 2>&1
        if [ $? -eq 0 ] && [ -s "$geo_dir/geosite_v2fly.dat" ]; then
            echo -e "  GeoSite V2Fly ${green}успешно обновлен${reset}"
        else
            echo -e "  ${red}Неизвестная ошибка${reset} при обновлении GeoSite V2Fly"
        fi
    fi

    # Обновление GeoSite AntiFilter, если установлены и требуется обновление
    if [ "$update_antifilter_geosite" = true ] && [ -f "$geo_dir/geosite_antifilter.dat" ]; then
        curl -L -o "$geo_dir/geosite_antifilter.dat" "https://github.com/schebotar/antifilter-domain/releases/latest/download/geosite.dat" > /dev/null 2>&1	
        if [ $? -eq 0 ] && [ -s "$geo_dir/geosite_antifilter.dat" ]; then
            echo -e "  GeoSite AntiFilter ${green}успешно обновлен${reset}"
        else
            echo -e "  ${red}Неизвестная ошибка${reset} при обновлении GeoSite AntiFilter"
        fi
    fi

    # Обновление GeoSite AntiZapret, если установлены и требуется обновление
    if [ "$update_antizapret_geosite" = true ] && [ -f "$geo_dir/geosite_antizapret.dat" ]; then
        curl -L -o "$geo_dir/geosite_antizapret.dat" "https://github.com/warexify/antizapret-xray/releases/latest/download/antizapret.dat" > /dev/null 2>&1
        if [ $? -eq 0 ] && [ -s "$geo_dir/geosite_antizapret.dat" ]; then
            echo -e "  GeoSite AntiZapret ${green}успешно обновлены${reset}"
        else
            echo -e "  ${red}Неизвестная ошибка${reset} при обновлении GeoSite AntiZapret"
        fi
    fi
}
