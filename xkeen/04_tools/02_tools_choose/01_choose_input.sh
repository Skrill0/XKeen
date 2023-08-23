input_concordance() {
    local prompt_message="$1 (yes/no): "
    local error_message="Пожалуйста, введите «yes» или «no»."
    
    while true; do
		echo 
        read -r -p "$prompt_message" user_input

        case "$user_input" in
            [Yy]|[Yy][Ee]|[Yy][Ee][Ss]|[Нн]|[Нн][Уу]|[Нн][Уу][Ыы]) return 0 ;;
            [Nn]|[Nn][Oo]|[Тт]|[Тт][Щщ]) return 1 ;;
            *)
				echo 
                echo "$error_message"
                continue
                ;;
        esac
    done
}

input_concordance_list() {
    local prompt_message="$1 (Выберите вариант): "
    local error_message="Пожалуйста, выберите вариант, введя номер 0 или 1."

    echo
    echo "$prompt_message"
    echo "0. No"
    echo "1. Yes"

    while true; do
        read -r -p "Ваш выбор: " user_input

        case "$user_input" in
            0) return 1 ;;
            1) return 0 ;;
            *)
                echo
                echo "$error_message"
                continue
                ;;
        esac
    done
}

input_letters() {
    local prompt_message="${1:-Введите буквы: }"
    local error_message="${2:-${RED}Некорректный ввод.${RESET} Цифровые выражения не принимаются, ${YELLOW}используйте буквы${RESET}.}"
    
    while true; do
        read -r -p "$prompt_message" input
        if [[ "$input" =~ ^[a-zA-Z]+$ ]]; then
			echo 
            echo "$input"
            break
        else
			echo 
            echo -e "$error_message"
        fi
    done
}

input_digits() {
    local prompt_message="${1:-Введите числа: }"
    local error_message="${2:-${RED}Некорректный ввод.${RESET} Буквенные выражения не принимаются, ${YELLOW}используйте цифры${RESET}.}"

    while true; do
        read -r -p "$prompt_message" input
        input="${input//,/, }" # Добавляем пробелы после запятых
        if [[ "$input" =~ ^[0-9\ ,]+$ ]]; then # Поддерживаем цифры, запятые и пробелы
            echo 
            echo "$input"
            break
        else
            echo 
            echo -e "$error_message"
        fi
    done
}
