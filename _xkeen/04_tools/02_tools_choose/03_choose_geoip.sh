# Функция для выбора вариантов GeoIP
choose_geoip() {
    local has_missing_geoip_bases=false
    local has_updatable_geoip_bases=false

    # Проверяем наличие и обновляемость GeoIP баз
    [ "$geo_exists_geoip_antifilter" != "installed" ] && has_missing_geoip_bases=true
    [ "$geo_exists_geoip_v2fly" != "installed" ] && has_missing_geoip_bases=true
    ([ "$geo_exists_geoip_antifilter" = "installed" ] || [ "$geo_exists_geoip_v2fly" = "installed" ]) && has_updatable_geoip_bases=true

    while true; do
        echo 
        echo 
        echo -e "  Выберите номер или номера действий для ${yellow}GeoIP${reset}"
        echo 
        echo "     0. Пропустить"
        [ "$has_missing_geoip_bases" = true ] && echo "     1. Установить отсутствующие GeoIP" || echo -e "     1. ${dark_gray}Все доступные GeoIP установлены${reset}"
        [ "$has_updatable_geoip_bases" = true ] && echo "     2. Обновить установленные GeoIP" || echo -e "     2. ${dark_gray}Нет доступных GeoIP для обновления${reset}"

        [ "$geo_exists_geoip_antifilter" != "installed" ] && antifilter_choice="Установить" || antifilter_choice="Обновить"
        [ "$geo_exists_geoip_v2fly" != "installed" ] && v2fly_choice="Установить" || v2fly_choice="Обновить"

        echo "     3. $antifilter_choice AntiFilter"
        echo "     4. $v2fly_choice v2fly"

        [ "$has_updatable_geoip_bases" = true ] && echo "     99. Удалить все GeoIP" || echo -e "     99. ${dark_gray}Нет установленных GeoIP для удаления${reset}"
        echo
        
        local geoip_choices=$(input_digits "Ваш выбор: " "${red}Некорректный номер действия.${reset} Пожалуйста, выберите снова")

        local invalid_choice=false
        for choice in $geoip_choices; do
            if ! [[ "$choice" =~ ^[0-9]+$ ]]; then
                echo -e "  ${red}Некорректный номер действия.${reset} Пожалуйста, выберите снова"
                invalid_choice=true
                break
            fi
        done
        
        for choice in $geoip_choices; do
            if [ "$choice" -eq 0 ]; then
                echo "  Выполнен пропуск установки / обновления GeoIP"
                return
            elif [ "$choice" -eq 1 ]; then
                if [ "$has_missing_geoip_bases" = false ]; then
                    echo -e "  Все GeoIP ${green}уже установлены${reset}"
                    if input_concordance_list "Вы хотите обновить их?"; then
                        install_antifilter_geoip=true
                        install_v2fly_geoip=true
                        break
                    else
                        invalid_choice=true
                        break
                    fi
                else
                    if [ "$geo_exists_geoip_antifilter" != "installed" ]; then
                        install_antifilter_geoip=true
                    fi
                    if [ "$geo_exists_geoip_v2fly" != "installed" ]; then
                        install_v2fly_geoip=true
                    fi
                fi
            elif [ "$choice" -eq 2 ]; then
                if [ "$has_updatable_geoip_bases" = false ]; then
                    echo -e "  ${red}Нет установленных GeoIP${reset} для обновления"
                    if input_concordance_list "Вы хотите установить их?"; then
                        install_antifilter_geoip=true
                        install_v2fly_geoip=true
                        break
                    else
                        invalid_choice=true
                        break
                    fi
                else
                    if [ "$geo_exists_geoip_antifilter" = "installed" ]; then
                        update_antifilter_geoip=true
                    fi
                    if [ "$geo_exists_geoip_v2fly" = "installed" ]; then
                        update_v2fly_geoip=true
                    fi
                fi
            elif [ "$choice" -eq 99 ]; then
                if [ "$has_updatable_geoip_bases" = false ]; then
                    echo -e "  ${red}Нет установленных GeoIP для удаления${reset}. Выберите другой пункт"
                    invalid_choice=true
                    break
                else
                    chose_delete_geoip_antifilter_select=true
                    chose_delete_geoip_v2fly_select=true
                fi
			elif [ "$choice" -eq 3 ]; then
                [ "$geo_exists_geoip_antifilter" != "installed" ] && install_antifilter_geoip=true || update_antifilter_geoip=true
            elif [ "$choice" -eq 4 ]; then
                [ "$geo_exists_geoip_v2fly" != "installed" ] && install_v2fly_geoip=true || update_v2fly_geoip=true
            fi
        done

        install_list=""
        update_list=""
        delete_list=""

        [ "$install_antifilter_geoip" = true ] && install_list="$install_list ${yellow}AntiFilter${reset},"
        [ "$install_v2fly_geoip" = true ] && install_list="$install_list ${yellow}v2fly${reset},"
        [ "$update_antifilter_geoip" = true ] && update_list="$update_list ${yellow}AntiFilter${reset},"
        [ "$update_v2fly_geoip" = true ] && update_list="$update_list ${yellow}v2fly${reset},"
        [ "$chose_delete_geoip_antifilter_select" = true ] && delete_list="$delete_list ${yellow}AntiFilter${reset},"
        [ "$chose_delete_geoip_v2fly_select" = true ] && delete_list="$delete_list ${yellow}v2fly${reset},"

        if [ -n "$install_list" ]; then
            echo -e "  Устанавливаются следующие GeoIP: ${install_list%,}"
        fi

        if [ -n "$update_list" ]; then
            echo -e "  Обновляются следующие GeoIP: ${update_list%,}"
        fi

        if [ -n "$delete_list" ]; then
            echo -e "  Удаляются следующие GeoIP: ${delete_list%,}"
        fi
        break
    done
}
