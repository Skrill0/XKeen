logs_cpu_console() {
        echo "Процессор"
        echo "   Модель: $info_model"
		echo "   Архитектура: $info_architecture"
	
    if [ -z "$generated_keyword" ]; then
        echo -e "Процессор ${RED}$не поддерживается${RESET} Xkeen"
    else
        echo -e "Процессор ${GREEN}поддерживается${RESET} Xkeen"
    fi
}

