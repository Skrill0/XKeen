choose_cron_time() {
    for task in xkeen xray geodata geoip all; do
        task_var="chose_${task}_cron_select"
        time_var="chose_${task}_cron_time"

        if [ "$(eval echo \${$task_var})" = true ]; then
            echo
            if [ "$task" = "all" ]; then
                echo "Время для автоматического обновления для всех задач:"
            else
                echo "Время для автоматического обновления $task:"
            fi
            echo
            echo "Выберите день:"
            echo "0. Отмена"
            echo "1. Понедельник"
            echo "2. Вторник"
            echo "3. Среда"
            echo "4. Четверг"
            echo "5. Пятница"
            echo "6. Суббота"
            echo "7. Воскресенье"
            echo "8. Ежедневно"

            local day_choice
            while true; do
                read -p "Выберите день: " day_choice
                if [[ "$day_choice" =~ ^[0-8]$ ]]; then
                    break
                else
                    echo "Некорректный ввод. Пожалуйста, выберите снова."
                fi
            done

            if [ "$day_choice" -eq 0 ]; then
                echo "Включение автоматического обновления $task отменено."
            else
                if [ "$day_choice" -eq 8 ]; then
                    echo "Выбрано ежедневное обновление."
                    echo
                    read -p "Выберите час (0-23): " hour
                    while ! [[ "$hour" =~ ^[0-9]+$ && "$hour" -ge 0 && "$hour" -le 23 ]]; do
                        echo "Некорректный ввод."
                        read -p "Введите значение от 0 до 23: " hour
                    done

                    read -p "Выберите минуту (0-59): " minute
                    while ! [[ "$minute" =~ ^[0-9]+$ && "$minute" -ge 0 && "$minute" -le 59 ]]; do
                        echo "Некорректный ввод."
                        read -p "Введите значение от 0 до 59: " minute
                    done

                    cron_expression="$minute $hour * * *"
                    cron_display="$minute $hour * * *"
                else
                    echo
                    read -p "Выберите час (0-23): " hour
                    while ! [[ "$hour" =~ ^[0-9]+$ && "$hour" -ge 0 && "$hour" -le 23 ]]; do
                        echo "Некорректный ввод."
                        read -p "Введите значение от 0 до 23: " hour
                    done

                    read -p "Выберите минуту (0-59): " minute
                    while ! [[ "$minute" =~ ^[0-9]+$ && "$minute" -ge 0 && "$minute" -le 59 ]]; do
                        echo "Некорректный ввод."
                        read -p "Введите значение от 0 до 59: " minute
                    done

                    case "$day_choice" in
                        1) day_of_week="1" ;;
                        2) day_of_week="2" ;;
                        3) day_of_week="3" ;;
                        4) day_of_week="4" ;;
                        5) day_of_week="5" ;;
                        6) day_of_week="6" ;;
                        7) day_of_week="0" ;;
                    esac

                    cron_expression="$minute $hour * * $day_of_week"
                    cron_display="$minute $hour * * $day_of_week"
                fi

                formatted_hour=$(printf "%02d" "$hour")
                formatted_minute=$(printf "%02d" "$minute")

                day_name=""
                case "$day_choice" in
                    0) day_name="Отмена" ;;
                    1) day_name="Понедельник" ;;
                    2) day_name="Вторник" ;;
                    3) day_name="Среда" ;;
                    4) day_name="Четверг" ;;
                    5) day_name="Пятница" ;;
                    6) day_name="Суббота" ;;
                    7) day_name="Воскресенье" ;;
                    8) day_name="Ежедневно" ;;
                esac

                if [ "$task" = "all" ]; then
                    echo "Выбранное время автоматического обновления для всех задач: $day_name в $formatted_hour:$formatted_minute"
                else
                    echo "Выбранное время автоматического обновления $task: $day_name в $formatted_hour:$formatted_minute"
                fi

                eval "${time_var}='$cron_expression'"
            fi
        fi
    done

    export chose_xkeen_cron_time
    export chose_xray_cron_time
    export chose_geodata_cron_time
    export chose_geoip_cron_time
    export chose_all_cron_time
}
