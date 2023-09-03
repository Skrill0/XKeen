# Обратная связь в консоль

logs_cpu_console() {
        echo "Процессор"
        echo "   Модель: $info_model"
		echo "   Архитектура: $info_architecture"
	
    if [ -z "$generated_keyword" ]; then
        echo -e "Процессор ${red}$не поддерживается${reset} xkeen"
    else
        echo -e "Процессор ${green}поддерживается${reset} xkeen"
    fi
}

