choose_update_cron() {
    # Проверка наличия задач автоматического обновления
    local has_missing_cron_tasks=false
    local has_updatable_cron_tasks=false
    [ "$INFO_UPDATE_XKEEN_CRON" != "installed" ] && has_missing_cron_tasks=true
    [ "$INFO_UPDATE_XRAY_CRON" != "installed" ] && has_missing_cron_tasks=true
    [ "$INFO_UPDATE_GEODATA_CRON" != "installed" ] && has_missing_cron_tasks=true
    [ "$INFO_UPDATE_GEOIP_CRON" != "installed" ] && has_missing_cron_tasks=true
    [ "$INFO_UPDATE_XKEEN_CRON" = "installed" ] || [ "$INFO_UPDATE_XRAY_CRON" = "installed" ] || [ "$INFO_UPDATE_GEODATA_CRON" = "installed" ] || [ "$INFO_UPDATE_GEOIP_CRON" = "installed" ] && has_updatable_cron_tasks=true

    while true; do
        echo
        echo

        # Вывод доступных действий
        echo "Выберите номер или номера действий для автоматического обновления:"
        echo
        echo "0. Пропустить"
        [ "$has_missing_cron_tasks" = true ] && echo "1. Включить отсутствующие задачи автоматического обновления" || echo -e "1. ${DARK_GRAY}Все задачи автоматического обновления включены${RESET}"
        [ "$has_updatable_cron_tasks" = true ] && echo "2. Обновить включенные задачи автоматического обновления" || echo -e "2. ${DARK_GRAY}Нет включенных задач автоматического обновления${RESET}"
        [ "$INFO_UPDATE_XKEEN_CRON" != "installed" ] && xkeen_choice="Включить" || xkeen_choice="Обновить"
        [ "$INFO_UPDATE_XRAY_CRON" != "installed" ] && xray_choice="Включить" || xray_choice="Обновить"
        [ "$INFO_UPDATE_GEODATA_CRON" != "installed" ] && geodata_choice="Включить" || geodata_choice="Обновить"
        [ "$INFO_UPDATE_GEOIP_CRON" != "installed" ] && geoip_choice="Включить" || geoip_choice="Обновить"
        echo "3. $xkeen_choice автоматическое обновление Xkeen"
        echo "4. $xray_choice автоматическое обновление Xray"
        echo "5. $geodata_choice автоматическое обновление GeoData"
        echo "6. $geoip_choice автоматическое обновление GeoIP"
        [ "$has_updatable_cron_tasks" = true ] && echo "99. Выключить все" || echo -e "99. ${DARK_GRAY}Нет включенных задач для выключения${RESET}"

        echo

        local update_choices=$(input_digits "Ваш выбор:" "${RED}Некорректный номер действия.${RESET} Пожалуйста, выберите снова.")

        local invalid_choice=false
        for choice in $update_choices; do
            if ! [[ "$choice" =~ ^[0-9]+$ ]]; then
                echo -e "${RED}Некорректный номер действия.${RESET} Пожалуйста, выберите снова."
                invalid_choice=true
                break
            fi
        done

        for choice in $update_choices; do
            if [ "$choice" -eq 0 ]; then
                echo "Пропустить"
                return
            elif ([ "$choice" -eq 1 ] && [ "$has_missing_cron_tasks" = false ]); then
                echo -e "${YELLOW}Все задачи автоматического обновления уже включены${RESET}."
                if input_concordance_list "Вы хотите обновить их?"; then
                    chose_xkeen_cron_select=false
                    chose_xray_cron_select=false
                    chose_geodata_cron_select=false
                    chose_geoip_cron_select=false
                    chose_all_cron_select=false
                    break
                else
                    echo "Выберите другой пункт."
                    invalid_choice=true
                    break
                fi
            elif [ "$choice" -eq 2 ] && [ "$has_updatable_cron_tasks" = false ]; then
                echo -e "${RED}Нет включенных задач автоматического обновления${RESET}."
                if input_concordance_list "Вы хотите включить их?"; then
                    chose_xkeen_cron_select=true
                    chose_xray_cron_select=true
                    chose_geodata_cron_select=true
                    chose_geoip_cron_select=true
                    chose_all_cron_select=false
                    break
                else
                    echo "Выберите другой пункт."
                    invalid_choice=true
                    break
                fi
            elif [ "$choice" -eq 99 ] && [ "$has_updatable_cron_tasks" = false ]; then
                echo -e "${RED}Нет включенных задач для выключения${RESET}. Пожалуйста, выберите другой пункт."
                invalid_choice=true
                break
            elif [ "$choice" -eq 99 ] && [ "$has_updatable_cron_tasks" = true ]; then
                echo -e "Следующие задачи автоматического обновления будут выключены:"
                [ "$INFO_UPDATE_XKEEN_CRON" = "installed" ] && echo -e "${YELLOW}Xkeen${RESET}"
                [ "$INFO_UPDATE_XRAY_CRON" = "installed" ] && echo -e "${YELLOW}Xray${RESET}"
                [ "$INFO_UPDATE_GEODATA_CRON" = "installed" ] && echo -e "${YELLOW}GeoData${RESET}"
                [ "$INFO_UPDATE_GEOIP_CRON" = "installed" ] && echo -e "${YELLOW}GeoIP${RESET}"

                chose_delete_all_cron_select=true
                chose_all_cron_select=false

                break
            fi
        done

        if [ "$invalid_choice" = false ]; then
            chose_xkeen_cron_select=false
            chose_xray_cron_select=false
            chose_geodata_cron_select=false
            chose_geoip_cron_select=false
            chose_all_cron_select=false

            # Определение выбранных действий
            for choice in $update_choices; do
                if [ "$choice" -eq 1 ]; then
                    if [ "$has_missing_cron_tasks" = true ]; then
                        chose_xkeen_cron_select=true
                        chose_xray_cron_select=true
                        chose_geodata_cron_select=true
                        chose_geoip_cron_select=true
                        chose_all_cron_select=true

                        # Спрашиваем пользователя о едином времени для всех задач
                        if input_concordance_list "Хотите использовать единое время для всех задач?"; then
                            chose_all_cron_select=true
                            chose_xkeen_cron_select=false
                            chose_xray_cron_select=false
                            chose_geodata_cron_select=false
                            chose_geoip_cron_select=false
                        fi
                    fi
                elif [ "$choice" -eq 2 ]; then
                    chose_xkeen_cron_select=true
                    chose_xray_cron_select=true
                    chose_geodata_cron_select=true
                    chose_geoip_cron_select=true
                    chose_all_cron_select=false
                elif [ "$choice" -eq 3 ]; then
                    [ "$INFO_UPDATE_XKEEN_CRON" != "installed" ] && chose_xkeen_cron_select=true
                elif [ "$choice" -eq 4 ]; then
                    [ "$INFO_UPDATE_XRAY_CRON" != "installed" ] && chose_xray_cron_select=true
                elif [ "$choice" -eq 5 ]; then
                    [ "$INFO_UPDATE_GEODATA_CRON" != "installed" ] && chose_geodata_cron_select=true
                elif [ "$choice" -eq 6 ]; then
                    [ "$INFO_UPDATE_GEOIP_CRON" != "installed" ] && chose_geoip_cron_select=true
                elif [ "$choice" -eq 99 ]; then
                    chose_delete_all_cron_select=true
                    chose_all_cron_select=false
                fi
            done

            # Вывод выбранных действий
            selected_actions=""

            [ "$chose_xkeen_cron_select" = true ] && selected_actions="$selected_actions ${YELLOW}Xkeen${RESET},"
            [ "$chose_xray_cron_select" = true ] && selected_actions="$selected_actions ${YELLOW}Xray${RESET},"
            [ "$chose_geodata_cron_select" = true ] && selected_actions="$selected_actions ${YELLOW}GeoData${RESET},"
            [ "$chose_geoip_cron_select" = true ] && selected_actions="$selected_actions ${YELLOW}GeoIP${RESET},"

            if [ -n "$selected_actions" ]; then
                if [ "$has_missing_cron_tasks" = true ]; then
                    echo -e "Будут включены следующие задачи автоматического обновления:  $(echo ${selected_actions%,})"
                else
                    echo -e "Будут обновлены следующие задачи автоматического обновления: $(echo ${selected_actions%,})"
                fi
            fi

            # Экспорт переменных
            export chose_xkeen_cron_select
            export chose_xray_cron_select
            export chose_geodata_cron_select
            export chose_geoip_cron_select
            export chose_all_cron_select
            export chose_delete_all_cron_select

            break
        fi
    done
}
