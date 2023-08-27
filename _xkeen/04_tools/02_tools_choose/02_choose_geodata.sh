choose_geodata() {
    # Проверка наличия установленных и отсутствующих GeoData
    local has_missing_geodata_bases=false
    local has_updatable_geodata_bases=false
    [ "$GEO_EXISTS_GEODATA_V2FLY" != "installed" ] && has_missing_geodata_bases=true
    [ "$GEO_EXISTS_GEODATA_ANTIFILTER" != "installed" ] && has_missing_geodata_bases=true
    [ "$GEO_EXISTS_GEODATA_ANTIZAPRET" != "installed" ] && has_missing_geodata_bases=true
    [ "$GEO_EXISTS_GEODATA_V2FLY" = "installed" ] || [ "$GEO_EXISTS_GEODATA_ANTIFILTER" = "installed" ] || [ "$GEO_EXISTS_GEODATA_ANTIZAPRET" = "installed" ] && has_updatable_geodata_bases=true

    while true; do
        # Вывод доступных действий
        echo 

        echo "Выберите номер или номера действий для GeoData:"
        echo 

        echo "0. Пропустить"

        [ "$has_missing_geodata_bases" = true ] && echo "1. Установить отсутствующие GeoData" || echo -e "1. ${DARK_GRAY}Все доступные GeoData установлены${RESET}"
        [ "$has_updatable_geodata_bases" = true ] && echo "2. Обновить установленные GeoData" || echo -e "2. ${DARK_GRAY}Нет доступных GeoData для обновления${RESET}"

        [ "$GEO_EXISTS_GEODATA_V2FLY" != "installed" ] && v2fly_choice="Установить" || v2fly_choice="Обновить"
        [ "$GEO_EXISTS_GEODATA_ANTIFILTER" != "installed" ] && antifilter_choice="Установить" || antifilter_choice="Обновить"
        [ "$GEO_EXISTS_GEODATA_ANTIZAPRET" != "installed" ] && antizapret_choice="Установить" || antizapret_choice="Обновить"

        echo "3. $v2fly_choice GeoData v2fly"
        echo "4. $antifilter_choice GeoData AntiFilter"
        echo "5. $antizapret_choice GeoData AntiZapret"

        [ "$has_updatable_geodata_bases" = true ] && echo "99. Удалить все GeoData" || echo -e "99. ${DARK_GRAY}Нет установленных GeoData для удаления${RESET}"
        echo
        
        local geodata_choices=$(input_digits "Ваш выбор:" "${RED}Некорректный номер действия.${RESET} Пожалуйста, выберите снова.")

        local invalid_choice=false
        for choice in $geodata_choices; do
            if ! [[ "$choice" =~ ^[0-9]+$ ]]; then
                echo -e "${RED}Некорректный номер действия.${RESET} Пожалуйста, выберите снова."
                invalid_choice=true
                break
            fi
        done
        
        for choice in $geodata_choices; do
            if [ "$choice" -eq 0 ]; then
                echo "Выполнен пропуск установки / обновления GeoData"
                return
            elif ([ "$choice" -eq 1 ] && [ "$has_missing_geodata_bases" = false ]); then
                echo -e "${YELLOW}Все GeoData уже установлены${RESET}."
                if input_concordance "Вы хотите обновить их?"; then
                    update_v2fly_geodata=false
                    update_antifilter_geodata=false
                    update_antizapret_geodata=false
                    install_v2fly_geodata=true
                    install_antifilter_geodata=true
                    install_antizapret_geodata=true
                    break
                else
                    echo "Выберите другой пункт."
                    invalid_choice=true
                    break
                fi
            elif [ "$choice" -eq 2 ] && [ "$has_updatable_geodata_bases" = false ]; then
                echo -e "${RED}Нет установленных GeoData${RESET} для обновления."
                if input_concordance "Вы хотите установить их?"; then
                    install_v2fly_geodata=true
                    install_antifilter_geodata=true
                    install_antizapret_geodata=true
                    update_v2fly_geodata=false
                    update_antifilter_geodata=false
                    update_antizapret_geodata=false
                    break
                else
                    echo "Выберите другой пункт."
                    invalid_choice=true
                    break
                fi
            elif [ "$choice" -eq 99 ] && [ "$has_updatable_geodata_bases" = false ]; then
                echo -e "${RED}Нет установленных GeoData для удаления${RESET}. Пожалуйста, выберите другой пункт."
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

            # Определение выбранных действий
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
                    [ "$GEO_EXISTS_GEODATA_V2FLY" != "installed" ] && install_v2fly_geodata=true || update_v2fly_geodata=true
                elif [ "$choice" -eq 4 ]; then
                    [ "$GEO_EXISTS_GEODATA_ANTIFILTER" != "installed" ] && install_antifilter_geodata=true || update_antifilter_geodata=true
                elif [ "$choice" -eq 5 ]; then
                    [ "$GEO_EXISTS_GEODATA_ANTIZAPRET" != "installed" ] && install_antizapret_geodata=true || update_antizapret_geodata=true
                elif [ "$choice" -eq 99 ]; then
                    chose_delete_geodata_v2fly_select=true
                    chose_delete_geodata_antifilter_select=true
                    chose_delete_geodata_antizapret_select=true
                fi
            done

            # Вывод выбранных действий
            install_list=""
            update_list=""
            delete_list=""

            [ "$install_v2fly_geodata" = true ] && install_list="$install_list ${YELLOW}v2fly${RESET},"
            [ "$install_antifilter_geodata" = true ] && install_list="$install_list ${YELLOW}AntiFilter${RESET},"
            [ "$install_antizapret_geodata" = true ] && install_list="$install_list ${YELLOW}AntiZapret${RESET},"
            [ "$update_v2fly_geodata" = true ] && update_list="$update_list ${YELLOW}v2fly${RESET},"
            [ "$update_antifilter_geodata" = true ] && update_list="$update_list ${YELLOW}AntiFilter${RESET},"
            [ "$update_antizapret_geodata" = true ] && update_list="$update_list ${YELLOW}AntiZapret${RESET},"
            [ "$chose_delete_geodata_v2fly_select" = true ] && delete_list="$delete_list ${YELLOW}v2fly${RESET},"
            [ "$chose_delete_geodata_antifilter_select" = true ] && delete_list="$delete_list ${YELLOW}AntiFilter${RESET},"
            [ "$chose_delete_geodata_antizapret_select" = true ] && delete_list="$delete_list ${YELLOW}AntiZapret${RESET},"

            if [ -n "$install_list" ]; then
                echo -e "Будут установлены следующие GeoData: ${install_list%,}"
            fi

            if [ -n "$update_list" ]; then
                echo -e "Будут обновлены следующие GeoData: ${update_list%,}"
            fi

            if [ -n "$delete_list" ]; then
                echo -e "Будут удалены следующие GeoData: ${delete_list%,}"
            fi

            # Сравнение переменных install и update
            [ "$install_v2fly_geodata" = "$update_v2fly_geodata" ] && chose_geodata_v2fly_select="$install_v2fly_geodata"
            [ "$install_antifilter_geodata" = "$update_antifilter_geodata" ] && chose_geodata_antifilter_select="$install_antifilter_geodata"
            [ "$install_antizapret_geodata" = "$update_antizapret_geodata" ] && chose_geodata_antizapret_select="$install_antizapret_geodata"

            # Экспорт переменных
            export chose_delete_geodata_v2fly_select
            export chose_delete_geodata_antifilter_select
            export chose_delete_geodata_antizapret_select

            break
        fi
    done
}
