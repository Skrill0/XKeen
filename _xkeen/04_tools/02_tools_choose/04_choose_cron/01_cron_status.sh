choose_update_cron() {
    local has_missing_cron_tasks=false
    local has_updatable_cron_tasks=false

    [ "$INFO_UPDATE_XKEEN_CRON" != "installed" ] && has_missing_cron_tasks=true
    [ "$INFO_UPDATE_XRAY_CRON" != "installed" ] && has_missing_cron_tasks=true
    [ "$INFO_UPDATE_GEODATA_CRON" != "installed" ] && has_missing_cron_tasks=true
    [ "$INFO_UPDATE_GEOIP_CRON" != "installed" ] && has_missing_cron_tasks=true

    [ "$INFO_UPDATE_XKEEN_CRON" = "installed" ] || [ "$INFO_UPDATE_XRAY_CRON" = "installed" ] || [ "$INFO_UPDATE_GEODATA_CRON" = "installed" ] || [ "$INFO_UPDATE_GEOIP_CRON" = "installed" ] && has_updatable_cron_tasks=true

    echo
    echo

    echo "Выберите номер или номера действий для автоматического обновления:"
    echo
    echo "0. Пропустить"

    if [ "$has_missing_cron_tasks" = true ]; then
        echo "1. Включить отсутствующие задачи автоматического обновления"
    else
        echo -e "1. ${DARK_GRAY}Все задачи автоматического обновления включены${RESET}"
    fi

    if [ "$has_updatable_cron_tasks" = true ]; then
        echo "2. Обновить включенные задачи автоматического обновления"
    else
        echo -e "2. ${DARK_GRAY}Нет включенных задач автоматического обновления${RESET}"
    fi

    [ "$INFO_UPDATE_XKEEN_CRON" != "installed" ] && xkeen_choice="Включить" || xkeen_choice="Обновить"
    [ "$INFO_UPDATE_XRAY_CRON" != "installed" ] && xray_choice="Включить" || xray_choice="Обновить"
    [ "$INFO_UPDATE_GEODATA_CRON" != "installed" ] && geodata_choice="Включить" || geodata_choice="Обновить"
    [ "$INFO_UPDATE_GEOIP_CRON" != "installed" ] && geoip_choice="Включить" || geoip_choice="Обновить"

    echo "3. $xkeen_choice автоматическое обновление Xkeen"
    echo "4. $xray_choice автоматическое обновление Xray"
    echo "5. $geodata_choice автоматическое обновление GeoData"
    echo "6. $geoip_choice автоматическое обновление GeoIP"

    if [ "$has_updatable_cron_tasks" = true ]; then
        echo "99. Выключить все"
    else
        echo -e "99. ${DARK_GRAY}Нет включенных задач для выключения${RESET}"
    fi

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
        case "$choice" in
            0)
                ;;
            1)
                if [ "$has_missing_cron_tasks" = true ]; then
                    chose_xkeen_cron_select=true
                    chose_xray_cron_select=true
                    chose_geodata_cron_select=true
                    chose_geoip_cron_select=true

                    if input_concordance_list "Хотите установить единое время для всех обновлений?"; then
                        chose_all_cron_select=true
                    else
                        chose_all_cron_select=false
                    fi
                else
                    chose_xkeen_cron_select=true
                    chose_xray_cron_select=true
                    chose_geodata_cron_select=true
                    chose_geoip_cron_select=true

                    if [ "$INFO_UPDATE_XKEEN_CRON" = "installed" ]; then
                        INFO_UPDATE_XKEEN_CRON="not_installed"
                    fi

                    if [ "$INFO_UPDATE_XRAY_CRON" = "installed" ]; then
                        INFO_UPDATE_XRAY_CRON="not_installed"
                    fi

                    if [ "$INFO_UPDATE_GEODATA_CRON" = "installed" ]; then
                        INFO_UPDATE_GEODATA_CRON="not_installed"
                    fi

                    if [ "$INFO_UPDATE_GEOIP_CRON" = "installed" ]; then
                        INFO_UPDATE_GEOIP_CRON="not_installed"
                    fi

                    echo "Выбрано: Все задачи автоматического обновления включены."
                    echo "Задачи включены:"

                    if [ "$INFO_UPDATE_XKEEN_CRON" = "installed" ]; then
                        echo "- Xkeen"
                    fi

                    if [ "$INFO_UPDATE_XRAY_CRON" = "installed" ]; then
                        echo "- Xray"
                    fi

                    if [ "$INFO_UPDATE_GEODATA_CRON" = "installed" ]; then
                        echo "- GeoData"
                    fi

                    if [ "$INFO_UPDATE_GEOIP_CRON" = "installed" ]; then
                        echo "- GeoIP"
                    fi

                    if input_concordance_list "Хотите обновить задачи?"; then
                        chose_all_cron_select=true
                    else
                        choose_update_cron
                    fi
                fi
                ;;
            2)
                if [ "$has_updatable_cron_tasks" = true ]; then
                    if [ "$INFO_UPDATE_XKEEN_CRON" = "installed" ]; then
                        chose_xkeen_cron_select=true
                    fi

                    if [ "$INFO_UPDATE_XRAY_CRON" = "installed" ]; then
                        chose_xray_cron_select=true
                    fi

                    if [ "$INFO_UPDATE_GEODATA_CRON" = "installed" ]; then
                        chose_geodata_cron_select=true
                    fi

                    if [ "$INFO_UPDATE_GEOIP_CRON" = "installed" ]; then
                        chose_geoip_cron_select=true
                    fi

                    echo "Выбрано: Обновить включенные задачи автоматического обновления."
                else
                    echo "Выбрано: Нет включенных задач автоматического обновления."
                    if input_concordance_list "Хотите включить все задачи автоматического обновления?"; then
                        if input_concordance_list "Хотите установить единое время для всех задач?"; then
                            chose_all_cron_select=true
                        else
                            chose_xkeen_cron_select=true
                            chose_xray_cron_select=true
                            chose_geodata_cron_select=true
                            chose_geoip_cron_select=true
                        fi
                    else
                        choose_update_cron
                    fi
                fi
                ;;
            3)
                chose_xkeen_cron_select=true
                echo "Выбрано: Включить/обновить автоматическое обновление Xkeen."
                ;;
            4)
                chose_xray_cron_select=true
                echo "Выбрано: Включить/обновить автоматическое обновление Xray."
                ;;
            5)
                chose_geodata_cron_select=true
                echo "Выбрано: Включить/обновить автоматическое обновление GeoData."
                ;;
            6)
                chose_geoip_cron_select=true
                echo "Выбрано: Включить/обновить автоматическое обновление GeoIP."
                ;;
            99)
                if [ "$has_updatable_cron_tasks" = true ]; then
                    chose_delete_all_cron_select=true
                    echo "Выбрано: Выключить все задачи автоматического обновления."
                else
                    echo "Выбрано: Нет включенных задач для выключения."
                fi
                ;;
            *)
                echo -e "${RED}Некорректный номер действия.${RESET} Пожалуйста, выберите снова."
                ;;
        esac
    done
}
