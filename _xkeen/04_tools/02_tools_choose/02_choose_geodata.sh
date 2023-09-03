# Функция для выбора вариантов GeoData
choose_geodata() {
    local has_missing_geodata_bases=false
    local has_updatable_geodata_bases=false

    # Проверяем наличие и обновляемости GeoData баз
    [ "$geo_exists_geodata_v2fly" != "installed" ] && has_missing_geodata_bases=true
    [ "$geo_exists_geodata_antifilter" != "installed" ] && has_missing_geodata_bases=true
    [ "$geo_exists_geodata_antizapret" != "installed" ] && has_missing_geodata_bases=true
    [ "$geo_exists_geodata_v2fly" = "installed" ] || [ "$geo_exists_geodata_antifilter" = "installed" ] || [ "$geo_exists_geodata_antizapret" = "installed" ] && has_updatable_geodata_bases=true

    while true; do
        echo 
        echo 
        echo -e "  Выберите номер или номера действий для ${yellow}GeoData${reset}"
        echo 
        echo "     0. Пропустить"
        [ "$has_missing_geodata_bases" = true ] && echo "     1. Установить отсутствующие GeoData" || echo -e "     1. ${dark_gray}Все доступные GeoData установлены${reset}"
        [ "$has_updatable_geodata_bases" = true ] && echo "     2. Обновить установленные GeoData" || echo -e "     2. ${dark_gray}Нет доступных GeoData для обновления${reset}"

        [ "$geo_exists_geodata_v2fly" != "installed" ] && v2fly_choice="Установить" || v2fly_choice="Обновить"
        [ "$geo_exists_geodata_antifilter" != "installed" ] && antifilter_choice="Установить" || antifilter_choice="Обновить"
        [ "$geo_exists_geodata_antizapret" != "installed" ] && antizapret_choice="Установить" || antizapret_choice="Обновить"

        echo "     3. $v2fly_choice v2fly"
        echo "     4. $antifilter_choice AntiFilter"
        echo "     5. $antizapret_choice AntiZapret"

        [ "$has_updatable_geodata_bases" = true ] && echo "     99. Удалить все GeoData" || echo -e "     99. ${dark_gray}Нет установленных GeoData для удаления${reset}"
        echo
        
        local geodata_choices=$(input_digits "Ваш выбор: " "${red}Некорректный номер действия.${reset} Пожалуйста, выберите снова")

        local invalid_choice=false
        for choice in $geodata_choices; do
            if ! [[ "$choice" =~ ^[0-9]+$ ]]; then
                echo -e "  ${red}Некорректный номер действия.${reset} Пожалуйста, выберите снова"
                invalid_choice=true
                break
            fi
        done
        
        for choice in $geodata_choices; do
            if [ "$choice" -eq 0 ]; then
                echo "  Выполнен пропуск установки / обновления GeoData"
                return
            elif ([ "$choice" -eq 1 ] && [ "$has_missing_geodata_bases" = false ]); then
                echo -e "  ${green}Все GeoData уже установлены${reset}"
                if input_concordance_list "  Вы хотите обновить их?"; then
                    install_v2fly_geodata=false
                    install_antifilter_geodata=false
                    install_antizapret_geodata=false
                    update_v2fly_geodata=true
                    update_antifilter_geodata=true
                    update_antizapret_geodata=true
                    break
                else
                    invalid_choice=true
                    break
                fi
            elif [ "$choice" -eq 2 ] && [ "$has_updatable_geodata_bases" = false ]; then
                echo -e "  ${red}Нет установленных GeoData${reset} для обновления"
                if input_concordance_list "  Вы хотите установить их?"; then
                    install_v2fly_geodata=true
                    install_antifilter_geodata=true
                    install_antizapret_geodata=true
                    update_v2fly_geodata=false
                    update_antifilter_geodata=false
                    update_antizapret_geodata=false
                    break
                else
                    invalid_choice=true
                    break
                fi
            elif [ "$choice" -eq 99 ] && [ "$has_updatable_geodata_bases" = false ]; then
                echo -e "  ${red}Нет установленных GeoData для удаления${reset}. Выберите другой пункт"
                invalid_choice=true
                break
            fi
        done

        if [ "$invalid_choice" = false ]; then
            install_v2fly_geodata=false
            install_antifilter_geodata=false
            install_antizapret_geodata=false
            update_v2fly_geodata=false
            update_antifilter_geodata=false
            update_antizapret_geodata=false
            chose_delete_geodata_v2fly_select=false
            chose_delete_geodata_antifilter_select=false
            chose_delete_geodata_antizapret_select=false

            for choice in $geodata_choices; do
                if [ "$choice" -eq 1 ]; then
                    if [ "$has_missing_geodata_bases" = true ]; then
                        install_v2fly_geodata=true
                        install_antifilter_geodata=true
                        install_antizapret_geodata=true
                    else
                        update_v2fly_geodata=true
                        update_antifilter_geodata=true
                        update_antizapret_geodata=true
                    fi
                elif [ "$choice" -eq 2 ]; then
                    install_v2fly_geodata=false
                    install_antifilter_geodata=false
                    install_antizapret_geodata=false
                    update_v2fly_geodata=true
                    update_antifilter_geodata=true
                    update_antizapret_geodata=true
                elif [ "$choice" -eq 3 ]; then
                    [ "$geo_exists_geodata_v2fly" != "installed" ] && install_v2fly_geodata=true || update_v2fly_geodata=true
                elif [ "$choice" -eq 4 ]; then
                    [ "$geo_exists_geodata_antifilter" != "installed" ] && install_antifilter_geodata=true || update_antifilter_geodata=true
                elif [ "$choice" -eq 5 ]; then
                    [ "$geo_exists_geodata_antizapret" != "installed" ] && install_antizapret_geodata=true || update_antizapret_geodata=true
                elif [ "$choice" -eq 99 ]; then
                    chose_delete_geodata_v2fly_select=true
                    chose_delete_geodata_antifilter_select=true
                    chose_delete_geodata_antizapret_select=true
                fi
            done

            install_list=""
            update_list=""
            delete_list=""

            [ "$install_v2fly_geodata" = true ] && install_list="$install_list ${yellow}v2fly${reset},"
            [ "$install_antifilter_geodata" = true ] && install_list="$install_list ${yellow}AntiFilter${reset},"
            [ "$install_antizapret_geodata" = true ] && install_list="$install_list ${yellow}AntiZapret${reset},"
            [ "$update_v2fly_geodata" = true ] && update_list="$update_list ${yellow}v2fly${reset},"
            [ "$update_antifilter_geodata" = true ] && update_list="$update_list ${yellow}AntiFilter${reset},"
            [ "$update_antizapret_geodata" = true ] && update_list="$update_list ${yellow}AntiZapret${reset},"
            [ "$chose_delete_geodata_v2fly_select" = true ] && delete_list="$delete_list ${yellow}v2fly${reset},"
            [ "$chose_delete_geodata_antifilter_select" = true ] && delete_list="$delete_list ${yellow}AntiFilter${reset},"
            [ "$chose_delete_geodata_antizapret_select" = true ] && delete_list="$delete_list ${yellow}AntiZapret${reset},"

            if [ -n "$install_list" ]; then
                echo -e "  Устанавливаются следующие GeoData: ${install_list%,}"
            fi

            if [ -n "$update_list" ]; then
                echo -e "  Обновляются следующие GeoData: ${update_list%,}"
            fi

            if [ -n "$delete_list" ]; then
                echo -e "  Удаляются следующие GeoData: ${delete_list%,}"
            fi

            [ "$install_v2fly_geodata" = "$update_v2fly_geodata" ] && chose_geodata_v2fly_select="$install_v2fly_geodata"
            [ "$install_antifilter_geodata" = "$update_antifilter_geodata" ] && chose_geodata_antifilter_select="$install_antifilter_geodata"
            [ "$install_antizapret_geodata" = "$update_antizapret_geodata" ] && chose_geodata_antizapret_select="$install_antizapret_geodata"

            export chose_delete_geodata_v2fly_select
            export chose_delete_geodata_antifilter_select
            export chose_delete_geodata_antizapret_select

            break
        fi
    done
}
