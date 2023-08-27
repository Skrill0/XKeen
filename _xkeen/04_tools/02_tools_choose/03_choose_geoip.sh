choose_geoip() {
    # Проверка наличия установленных и отсутствующих GeoIP
    local has_missing_geoip_bases=false
    local has_updatable_geoip_bases=false

    [ "$GEO_EXISTS_GEOIP_ANTIFILTER" != "installed" ] && has_missing_geoip_bases=true
    [ "$GEO_EXISTS_GEOIP_V2FLY" != "installed" ] && has_missing_geoip_bases=true
    [ "$GEO_EXISTS_GEOIP_ANTIFILTER" = "installed" ] || [ "$GEO_EXISTS_GEOIP_V2FLY" = "installed" ] && has_updatable_geoip_bases=true

    while true; do
        # Вывод доступных действий
        echo -e "\nВыберите номер или номера действий для GeoIP:\n"
        echo "0. Пропустить"
        
        if [ "$has_missing_geoip_bases" = true ]; then
            echo "1. Установить отсутствующие GeoIP"
        else
            echo -e "1. ${DARK_GRAY}Все доступные GeoIP установлены${RESET}"
        fi
        
        if [ "$has_updatable_geoip_bases" = true ]; then
            echo "2. Обновить установленные GeoIP"
        else
            echo -e "2. ${DARK_GRAY}Нет доступных GeoIP для обновления${RESET}"
        fi
        
        [ "$GEO_EXISTS_GEOIP_ANTIFILTER" != "installed" ] && antifilter_choice="Установить" || antifilter_choice="Обновить"
        [ "$GEO_EXISTS_GEOIP_V2FLY" != "installed" ] && v2fly_choice="Установить" || v2fly_choice="Обновить"
        
        echo "3. $v2fly_choice GeoIP v2fly"
        echo "4. $antifilter_choice GeoIP AntiFilter"
        
        if [ "$has_updatable_geoip_bases" = true ]; then
            echo "99. Удалить все GeoIP"
        else
            echo -e "99. ${DARK_GRAY}Нет установленных GeoIP для удаления${RESET}"
        fi
        
        local geoip_choices=$(input_digits "Ваш выбор:" "${RED}Некорректный номер действия.${RESET} Пожалуйста, выберите снова.")
        local invalid_choice=false
        
        for choice in $geoip_choices; do
            if ! [[ "$choice" =~ ^[0-9]+$ ]]; then
                echo -e "${RED}Некорректный номер действия.${RESET} Пожалуйста, выберите снова."
                invalid_choice=true
                break
            fi
        done
        
        for choice in $geoip_choices; do
            if [ "$choice" -eq 0 ]; then
                echo "Выполнен пропуск установки / обновления GeoIP"
                return
            elif ([ "$choice" -eq 1 ] && [ "$has_missing_geoip_bases" = false ]); then
                echo -e "Все GeoIP ${GREEN}уже установлены${RESET}."
                
                if input_concordance "Вы хотите обновить их?"; then
                    update_antifilter_geoip=false
                    update_v2fly_geoip=false
                    install_antifilter_geoip=true
                    install_v2fly_geoip=true
                    break
                else
                    echo "Выберите другой пункт."
                    invalid_choice=true
                    break
                fi
            elif [ "$choice" -eq 2 ] && [ "$has_updatable_geoip_bases" = false ]; then
                echo -e "Нет установленных GeoIP в директории ${YELLOW}«$GEO_DIR»${RESET} для обновления."
                
                if input_concordance "Вы хотите установить их?"; then
                    install_antifilter_geoip=true
                    install_v2fly_geoip=true
                    update_antifilter_geoip=false
                    update_v2fly_geoip=false
                    break
                else
                    echo "Выберите другой пункт."
                    invalid_choice=true
                    break
                fi
            elif [ "$choice" -eq 99 ] && [ "$has_updatable_geoip_bases" = false ]; then
                echo -e "Нет установленных GeoIP для удаления. Пожалуйста, выберите другой пункт."
                invalid_choice=true
                break
            fi
        done
        
        if [ "$invalid_choice" = false ]; then
            install_antifilter_geoip=false
            install_v2fly_geoip=false
            update_antifilter_geoip=false
            update_v2fly_geoip=false
            chose_delete_geoip_antifilter_select=false
            chose_delete_geoip_v2fly_select=false
            
            # Определение выбранных действий
            for choice in $geoip_choices; do
                if [ "$choice" -eq 1 ]; then
                    if [ "$has_missing_geoip_bases" = true ]; then
                        install_antifilter_geoip=true
                        install_v2fly_geoip=true
                    else
                        update_antifilter_geoip=true
                        update_v2fly_geoip=true
                    fi
                elif [ "$choice" -eq 2 ]; then
                    install_antifilter_geoip=false
                    install_v2fly_geoip=false
                    update_antifilter_geoip=true
                    update_v2fly_geoip=true
                elif [ "$choice" -eq 3 ]; then
                    [ "$GEO_EXISTS_GEOIP_V2FLY" != "installed" ] && install_v2fly_geoip=true || update_v2fly_geoip=true
                elif [ "$choice" -eq 4 ]; then
                    [ "$GEO_EXISTS_GEOIP_ANTIFILTER" != "installed" ] && install_antifilter_geoip=true || update_antifilter_geoip=true
                elif [ "$choice" -eq 99 ]; then
                    chose_delete_geoip_antifilter_select=true
                    chose_delete_geoip_v2fly_select=true
                fi
            done
            
            # Вывод выбранных действий
            install_list=""
            update_list=""
            delete_list=""
            
            [ "$install_antifilter_geoip" = true ] && install_list="$install_list ${YELLOW}AntiFilter${RESET},"
            [ "$install_v2fly_geoip" = true ] && install_list="$install_list ${YELLOW}v2fly${RESET},"
            [ "$update_antifilter_geoip" = true ] && update_list="$update_list ${YELLOW}AntiFilter${RESET},"
            [ "$update_v2fly_geoip" = true ] && update_list="$update_list ${YELLOW}v2fly${RESET},"
            [ "$chose_delete_geoip_antifilter_select" = true ] && delete_list="$delete_list ${YELLOW}AntiFilter${RESET},"
            [ "$chose_delete_geoip_v2fly_select" = true ] && delete_list="$delete_list ${YELLOW}v2fly${RESET},"
            
            if [ -n "$install_list" ]; then
                echo -e "Будут установлены следующие GeoIP: ${install_list%,}"
            fi
            
            if [ -n "$update_list" ]; then
                echo -e "Будут обновлены следующие GeoIP: ${update_list%,}"
            fi
            
            if [ -n "$delete_list" ]; then
                echo -e "Будут удалены следующие GeoIP: ${delete_list%,}"
            fi
            
            # Сравнение переменных install и update
            [ "$install_antifilter_geoip" = "$update_antifilter_geoip" ] && chose_geoip_antifilter_select="$install_antifilter_geoip"
            [ "$install_v2fly_geoip" = "$update_v2fly_geoip" ] && chose_geoip_v2fly_select="$install_v2fly_geoip"
            
            break
        fi
    done
}