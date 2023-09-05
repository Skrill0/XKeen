# Определение статуса для задач cron

choose_update_cron() {
    local has_missing_cron_tasks=false
    local has_updatable_cron_tasks=false

    [ "$info_update_xkeen_cron" != "installed" ] && has_missing_cron_tasks=true
    [ "$info_update_xray_cron" != "installed" ] && has_missing_cron_tasks=true
    [ "$info_update_geosite_cron" != "installed" ] && has_missing_cron_tasks=true
    [ "$info_update_geoip_cron" != "installed" ] && has_missing_cron_tasks=true

    [ "$info_update_xkeen_cron" = "installed" ] || [ "$info_update_xray_cron" = "installed" ] || [ "$info_update_geosite_cron" = "installed" ] || [ "$info_update_geoip_cron" = "installed" ] && has_updatable_cron_tasks=true

    echo
    echo

    echo -e "  Выберите номер или номера действий для ${yellow}автоматических обновлений${reset}"
    echo
    echo "     0. Пропустить"

    if [ "$has_missing_cron_tasks" = true ]; then
        echo "     1. Включить отсутствующие задачи автоматического обновления"
    else
        echo -e "     1. ${dark_gray}Все задачи автоматического обновления включены${reset}"
    fi

    if [ "$has_updatable_cron_tasks" = true ]; then
        echo "     2. Обновить включенные задачи автоматического обновления"
    else
        echo -e "     2. ${dark_gray}Нет включенных задач автоматического обновления${reset}"
    fi

    [ "$info_update_xkeen_cron" != "installed" ] && xkeen_choice="Включить" || xkeen_choice="Обновить"
    [ "$info_update_xray_cron" != "installed" ] && xray_choice="Включить" || xray_choice="Обновить"
    [ "$info_update_geosite_cron" != "installed" ] && geosite_choice="Включить" || geosite_choice="Обновить"
    [ "$info_update_geoip_cron" != "installed" ] && geoip_choice="Включить" || geoip_choice="Обновить"

    echo "     3. $xkeen_choice Xkeen"
    echo "     4. $xray_choice Xray"
    echo "     5. $geosite_choice GeoSite"
    echo "     6. $geoip_choice GeoIP"

    if [ "$has_updatable_cron_tasks" = true ]; then
        echo "     99. Выключить все"
    else
        echo -e "     99. ${dark_gray}Нет включенных задач для выключения${reset}"
    fi

    echo

    local update_choices=$(input_digits "Ваш выбор: " "${red}Некорректный номер действия. ${reset}Пожалуйста, выберите снова")

    local invalid_choice=false
    for choice in $update_choices; do
        if ! [[ "$choice" =~ ^[0-9]+$ ]]; then
            echo -e "  ${red}Некорректный номер действия.${reset} Пожалуйста, выберите снова"
            invalid_choice=true
            break
        fi
    done

    for choice in $update_choices; do
        case "$choice" in
            0)
                chose_canel_cron_select=true
                ;;
            1)
                if [ "$has_missing_cron_tasks" = true ]; then
                    if [ "$info_update_xkeen_cron" = "not_installed" ]; then
                        chose_xkeen_cron_select=true
                    fi

                    if [ "$info_update_xray_cron" = "not_installed" ]; then
                        chose_xray_cron_select=true
                    fi

                    if [ "$info_update_geosite_cron" = "not_installed" ]; then
                        chose_geosite_cron_select=true
                    fi

                    if [ "$info_update_geoip_cron" = "not_installed" ]; then
                        chose_geoip_cron_select=true
                    fi

                    if input_concordance_list "Хотите установить единое время для ${yellow}всех${reset} обновлений?"; then
                        chose_all_cron_select=true
                        chose_xkeen_cron_select=false
                        chose_xray_cron_select=false
                        chose_geosite_cron_select=false
                        chose_geoip_cron_select=false
                    else
                        chose_all_cron_select=false
                    fi
                else
                    if [ "$has_updatable_cron_tasks" = true ]; then
                        echo "  Все задачи автоматического обновления уже включены"
                        if input_concordance_list "Хотите обновить задачи?"; then
                            if input_concordance_list "Хотите установить единое время для ${yellow}всех${reset} обновлений?"; then
                                chose_all_cron_select=true
                                chose_xkeen_cron_select=false
                                chose_xray_cron_select=false
                                chose_geosite_cron_select=false
                                chose_geoip_cron_select=false
                            else
                                chose_all_cron_select=false
                                chose_xkeen_cron_select=true
                                chose_xray_cron_select=true
                                chose_geosite_cron_select=true
                                chose_geoip_cron_select=true
                            fi
                        else
                            choose_update_cron
                        fi
                    fi
                fi
                ;;
            2)
                if [ "$has_updatable_cron_tasks" = true ]; then
                    if [ "$info_update_xkeen_cron" = "installed" ]; then
                        chose_xkeen_cron_select=true
                    fi

                    if [ "$info_update_xray_cron" = "installed" ]; then
                        chose_xray_cron_select=true
                    fi

                    if [ "$info_update_geosite_cron" = "installed" ]; then
                        chose_geosite_cron_select=true
                    fi

                    if [ "$info_update_geoip_cron" = "installed" ]; then
                        chose_geoip_cron_select=true
                    fi

                    if input_concordance_list "Хотите установить единое время для ${yellow}всех${reset} обновлений?"; then
                        chose_all_cron_select=true
                        chose_xkeen_cron_select=false
                        chose_xray_cron_select=false
                        chose_geosite_cron_select=false
                        chose_geoip_cron_select=false
                    else
                        chose_all_cron_select=false
                    fi

                    echo -e "  Будут обновлены ${green}включенные${reset} задачи автоматического обновления"
                else
                    echo -e "  У Вас ${yellow}нет включенных${reset} задач автоматического обновления"
                    if input_concordance_list "Хотите включить все задачи автоматического обновления?"; then
                        if input_concordance_list "Хотите установить единое время для всех задач?"; then
                            chose_all_cron_select=true
                        else
                            chose_all_cron_select=false
                        fi
                    else
                        choose_update_cron
                    fi
                fi
                ;;
            3)
                if [ "$info_update_xkeen_cron" = "installed" ]; then
                    chose_xkeen_cron_select=true
                    echo -e "  Будет выполнено обновление задачи ${yellow}xkeen${reset}"
                else
                    chose_xkeen_cron_select=true
                    echo -e "  Будет выполнено включение задачи ${yellow}xkeen${reset}"
                fi
                ;;
            4)
                if [ "$info_update_xray_cron" = "installed" ]; then
                    chose_xray_cron_select=true
                    echo -e "  Будет выполнено обновление задачи ${yellow}xray${reset}"
                else
                    chose_xray_cron_select=true
                    echo -e "  Будет выполнено включение задачи ${yellow}xray${reset}"
                fi
                ;;
            5)
                if [ "$info_update_geosite_cron" = "installed" ]; then
                    chose_geosite_cron_select=true
                    echo -e "  Будет выполнено обновление задачи ${yellow}GeoSite${reset}"
                else
                    chose_geosite_cron_select=true
                    echo -e "  Будет выполнено включение задачи ${yellow}GeoSite${reset}"
                fi
                ;;
            6)
                if [ "$info_update_geoip_cron" = "installed" ]; then
                    chose_geoip_cron_select=true
                    echo -e "  Будет выполнено обновление задачи ${yellow}GeoIP${reset}"
                else
                    chose_geoip_cron_select=true
                    echo -e "  Будет выполнено включение задачи ${yellow}GeoIP${reset}"
                fi
                ;;
            99)
                if [ "$has_updatable_cron_tasks" = true ]; then
                    chose_delete_all_cron_select=true
                    echo "  Будут выключены все задачи автоматического обновления"
                else
                    echo -e "  У Вас  ${yellow}нет включенных задач ${reset} для выключения"
                fi
                ;;
            *)
                echo -e "  ${red}Некорректный номер действия.${reset} Пожалуйста, выберите снова"
                ;;
        esac
    done
}
