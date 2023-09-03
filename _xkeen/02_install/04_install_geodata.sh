# Функция для установки и обновления GeoData
install_geodata() {
    # Установка GeoData V2Fly
    if [ "$install_v2fly_geodata" = true ]; then
        curl -L -o "$geo_dir/geodata_v2fly.dat" "https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat" > /dev/null 2>&1
        if [ $? -eq 0 ] && [ -s "$geo_dir/geodata_v2fly.dat" ]; then
            echo -e "   GeoData V2Fly ${green}успешно установлен${reset}"
        else
            echo -e "  ${red}Неизвестная ошибка${reset} при установке GeoData V2Fly"
        fi
    fi

    # Установка GeoData AntiFilter
    if [ "$install_antifilter_geodata" = true ]; then
        curl -L -o "$geo_dir/geodata_antifilter.dat" "https://github.com/schebotar/antifilter/releases/latest/download/antifilter.dat" > /dev/null 2>&1
        if [ $? -eq 0 ] && [ -s "$geo_dir/geodata_antifilter.dat" ]; then
            echo -e "  GeoData AntiFilter ${green}успешно установлен${reset}"
        else
            echo -e "  ${red}Неизвестная ошибка${reset} при установке GeoData AntiFilter"
        fi
    fi

    # Установка GeoData AntiZapret
    if [ "$install_antizapret_geodata" = true ]; then
        curl -L -o "$geo_dir/geodata_antizapret.dat" "https://github.com/warexify/antizapret-xray/releases/latest/download/antizapret.dat" > /dev/null 2>&1
        if [ $? -eq 0 ] && [ -s "$geo_dir/geodata_antizapret.dat" ]; then
            echo -e "  GeoData AntiZapret ${green}успешно установлен${reset}"
        else
            echo -e "  ${red}Неизвестная ошибка${reset} при установке GeoData AntiZapret"
        fi
    fi

    # Обновление GeoData V2Fly, если установлены и требуется обновление
    if [ "$update_v2fly_geodata" = true ] && [ -f "$geo_dir/geodata_v2fly.dat" ]; then
        curl -L -o "$geo_dir/geodata_v2fly.dat" "https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat" > /dev/null 2>&1
        if [ $? -eq 0 ] && [ -s "$geo_dir/geodata_v2fly.dat" ]; then
            echo -e "  GeoData V2Fly ${green}успешно обновлен${reset}"
        else
            echo -e "  ${red}Неизвестная ошибка${reset} при обновлении GeoData V2Fly"
        fi
    fi

    # Обновление GeoData AntiFilter, если установлены и требуется обновление
    if [ "$update_antifilter_geodata" = true ] && [ -f "$geo_dir/geodata_antifilter.dat" ]; then
        curl -L -o "$geo_dir/geodata_antifilter.dat" "https://github.com/schebotar/antifilter/releases/latest/download/antifilter.dat" > /dev/null 2>&1
        if [ $? -eq 0 ] && [ -s "$geo_dir/geodata_antifilter.dat" ]; then
            echo -e "  GeoData AntiFilter ${green}успешно обновлен${reset}"
        else
            echo -e "  ${red}Неизвестная ошибка${reset} при обновлении GeoData AntiFilter"
        fi
    fi

    # Обновление GeoData AntiZapret, если установлены и требуется обновление
    if [ "$update_antizapret_geodata" = true ] && [ -f "$geo_dir/geodata_antizapret.dat" ]; then
        curl -L -o "$geo_dir/geodata_antizapret.dat" "https://github.com/warexify/antizapret-xray/releases/latest/download/antizapret.dat" > /dev/null 2>&1
        if [ $? -eq 0 ] && [ -s "$geo_dir/geodata_antizapret.dat" ]; then
            echo -e "  GeoData AntiZapret ${green}успешно обновлены${reset}"
        else
            echo -e "  ${red}Неизвестная ошибка${reset} при обновлении GeoData AntiZapret"
        fi
    fi
}
