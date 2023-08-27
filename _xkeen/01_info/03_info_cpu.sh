#!/bin/sh

# Проверка модели и архитектуры процессора
info_cpu() {
    info_architecture=$(lscpu | awk '/Architecture:/ { print $2 }')
    info_model=$(lscpu | awk '/Model name:/ { sub(/^Model name:\s*/, ""); print }')

    generated_keyword=$(generate_keyword "$info_architecture" "$info_model")
	
	# Чтение существующего содержимого файла "status"
	existing_content=$(cat "$STATUS_FILE")

	# Используйте grep и awk для поиска строки с архитектурой пакета
	status_architecture=$(echo "$existing_content" | grep -E "^Architecture:" | awk '{print $2}' | head -n 1)

	# Если архитектура не пустая, используйте её
	if [ -n "$status_architecture" ]; then
		ARCHITECTURE="$status_architecture"
	fi
}