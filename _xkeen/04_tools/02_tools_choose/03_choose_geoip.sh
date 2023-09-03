# Функция для выбора вариантов GeoIP (установка, обновление, удаление)
choose_geoip() {
    local has_missing_geoip_bases=false
    local has_updatable_geoip_bases=false

    # Проверяем наличие и обновляемость GeoIP баз
    [ "$geo_exists_geoip_antifilter" != "installed" ] && has_missing_geoip_bases=true
    [ "$geo_exists_geoip_v2fly" != "installed" ] && has_missing_geoip_bases=true
    [ "$geo_exists_geoip_antifilter" = "installed" ] || [ "$geo_exists_geoip_v2fly" = "installed" ] && has_updatable_geoip_bases=true

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

        echo "     3. $v2fly_choice v2fly"
        echo "     4. $antifilter_choice antifilter"

        [ "$has_updatable_geoip_bases" = true ] && echo "     99. Удалить все GeoIP" || echo -e "     99. ${dark_gray}Нет установленных GeoIP для удаления${reset}"
        echo
        
        local geoip_choices=$(input_digits "Ваш выбор: " "${red}Некорректный номер действия.${reset} Пожалуйста, выберите снова.")

        local invalid_choice=false
        for choice in $geoip_choices; do
            if ! [[ "$choice" =~ ^[0-9]+$ ]]; then
                echo -e "  ${red}Некорректный номер действия.${reset} Выберите снова"
                invalid_choice=true
                break
            fi
        done
        
        for choice in $geoip_choices; do
            if [ "$choice" -eq 0 ]; then
					echo "  Выполнен пропуск установки / обновления GeoIP"
					return
				elif ([ "$choice" -eq 1 ] && [ "$has_missing_geoip_bases" = false ]); then
					echo
					echo -e "  ${green}Все GeoIP уже установлены${reset}"
					if input_concordance_list "  Вы хотите обновить их?"; then
						update_antifilter_geoip=false
						update_v2fly_geoip=false
						install_antifilter_geoip=true
						install_v2fly_geoip=true
						break
					else
						invalid_choice=true
						break
					fi

            elif [ "$choice" -eq 2 ] && [ "$has_updatable_geoip_bases" = false ]; then
                echo -e "$  {red}Нет установленных GeoIP${reset} в директории ${yellow}«$geo_dir»${reset} для обновления"
                if input_concordance_list "  Вы хотите установить их?"; then
                    install_antifilter_geoip=true
                    install_v2fly_geoip=true
                    update_antifilter_geoip=false
                    update_v2fly_geoip=false
                    break
                else
                    invalid_choice=true
                    break
                fi
            elif [ "$choice" -eq 99 ] && [ "$has_updatable_geoip_bases" = false ]; then
                echo -e "  ${red}Нет установленных GeoIP для удаления${reset}. Выберите другой пункт"
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
                    [ "$geo_exists_geoip_v2fly" != "installed" ] && install_v2fly_geoip=true || update_v2fly_geoip=true
                elif [ "$choice" -eq 4 ]; then
                    [ "$geo_exists_geoip_antifilter" != "installed" ] && install_antifilter_geoip=true || update_antifilter_geoip=true
                elif [ "$choice" -eq 99 ]; then
                    chose_delete_geoip_antifilter_select=true
                    chose_delete_geoip_v2fly_select=true
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

            [ "$install_antifilter_geoip" = "$update_antifilter_geoip" ] && chose_geoip_antifilter_select="$install_antifilter_geoip"
            [ "$install_v2fly_geoip" = "$update_v2fly_geoip" ] && chose_geoip_v2fly_select="$install_v2fly_geoip"

            break
        fi
    done
}
