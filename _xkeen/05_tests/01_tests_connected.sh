check_internet_connection() {
    local result=1
    
    # Проверка соединения с google.com
    if ping -c 4 google.com > /dev/null 2>&1; then
        result=0
    else
        echo "  Ошибка: Не удалось пинговать google.com."
    fi

    # Проверка соединения с yandex.ru
    if ping -c 4 yandex.ru > /dev/null 2>&1; then
        result=0
    else
        echo "  Ошибка: Не удалось пинговать yandex.ru."
    fi

    # Проверяем код завершения функции и выводим сообщение
    if [ $result -eq 0 ]; then
        echo "  Интернет-соединение работает."
    else
        echo "  Отсутствует интернет-соединение."
    fi
}
