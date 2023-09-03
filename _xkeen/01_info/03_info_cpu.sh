# Проверка модели и архитектуры процессора
info_cpu() {
    # Получаем информацию об архитектуре и модели процессора
    info_architecture=$(lscpu | awk '/Architecture:/ { print $2 }')
    info_model=$(lscpu | awk '/Model name:/ { sub(/^Model name:\s*/, ""); print }')

    # Генерируем ключевое слово на основе архитектуры и модели
    generated_keyword=$(generate_keyword "$info_architecture" "$info_model")

    # Получаем существующее содержимое файла статуса
    existing_content=$(cat "$status_file")
    
    # Получаем архитектуру из файла статуса, если она уже существует
    status_architecture=$(echo "$existing_content" | grep -e "^Architecture:" | awk '{print $2}' | head -n 1)

    # Если архитектура уже есть в файле статуса, используем ее
    if [ -n "$status_architecture" ]; then
        architecture="$status_architecture"
    fi
}
