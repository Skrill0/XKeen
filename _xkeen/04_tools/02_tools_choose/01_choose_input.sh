input_concordance() {
    local prompt_message="$1"
    local error_message="Пожалуйста, введите «yes» или «no»."
    
    while true; do
        echo 
        read -r -p "$prompt_message" user_input

        case "$user_input" in
            [Yy]|[Yy][Ee]|[Yy][Ee][Ss]|[Дд]|[Дд][Аа]|[Дд][Аа]) return 0 ;;
            [Nn]|[Nn][Oo]|[Нн]|[Нн][Ее]) return 1 ;;
            *)
                echo 
                echo "$error_message"
                continue
                ;;
        esac
    done
}

input_concordance_list() {
    local prompt_message="$1"
    local error_message="${YELLOW}Пожалуйста, выберите вариант, введя номер 0 (No) или 1 (Yes).${RESET}"

    echo
    echo -e "$prompt_message"
    echo "0. No"
    echo "1. Yes"

    while true; do
        echo
        read -r -p "Введите номер: " user_input

        case "$user_input" in
            0) return 1 ;;
            1) return 0 ;;
            *)
                echo
                echo -e "$error_message"
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
        input="${input//,/, }"
        if [[ "$input" =~ ^[0-9\ ,]+$ ]]; then
            echo 
            echo "$input"
            break
        else
            echo 
            echo -e "$error_message"
        fi
    done
}
